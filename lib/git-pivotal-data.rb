module GitPivotalData
  require 'yaml/store'
  GIT_PIVOTAL_FILENAME = ".git-pivotal.yml"

  class LocalConfig
    def self.pivotal_api_token
      get('pivotal_api_token')
    end

    def self.set_pivotal_api_token(api_token)
      set('pivotal_api_token', api_token)
    end

    def self.pivotal_project_id
      get('pivotal_project_id')
    end

    def self.set_pivotal_project_id(project_id)
      set('pivotal_project_id', project_id)
    end

    def self.pivotal_full_name
      get('pivotal_full_name')
    end

    def self.set_pivotal_full_name(name)
      set('pivotal_full_name', name)
    end

    def self.pivotal_remote
      get('pivotal_remote')
    end

    def self.set_pivotal_remote(remote)
      set('pivotal_remote', remote)
    end

    def self.pivotal_use_ssl
      get('pivotal_use_ssl')
    end

    def self.set_pivotal_use_ssl(use_ssl)
      set('pivotal_use_ssl', use_ssl)
    end

    def self.pivotal_verbose
      get('pivotal_verbose')
    end

    def self.set_pivotal_verbose(verbose)
      set('pivotal_verbose', verbose)
    end

    def self.get(key)
      store = YAML::Store.new GIT_PIVOTAL_FILENAME
      store.transaction do
        return "" if store['config'].nil?
        store['config'][key]
      end
    end

    def self.set(key, value)
      store = YAML::Store.new GIT_PIVOTAL_FILENAME
      store.transaction do
        store['config'] ||= {}
        store['config'][key] = value
      end
    end
  end

  class BranchMapping
    attr_accessor :pivotal_project_id, :pivotal_story_id, :branch_name

    def initialize(branch_name, pivotal_story_id, pivotal_project_id)
      @branch_name = branch_name
      @pivotal_story_id = pivotal_story_id
      @pivotal_project_id = pivotal_project_id
    end

    def to_hash
      {
        :branch_name => @branch_name,
        :pivotal_story_id => @pivotal_story_id,
        :pivotal_project_id => @pivotal_project_id
      }
    end

    def self.find_by_branch_name(branch_name)
      store = YAML::Store.new GIT_PIVOTAL_FILENAME
      store.transaction { store['mappings'][branch_name] }
    end

    def self.find_by_story_id(story_id)
      raise "not implemented yet why are you using this"
    end

    def self.create_mapping(branch_name, pivotal_story_id, pivotal_project_id)
      store = YAML::Store.new GIT_PIVOTAL_FILENAME
      bm = BranchMapping.new(branch_name, pivotal_story_id, pivotal_project_id)

      store.transaction do
        store['mappings'] ||= {}
        store['mappings'][bm.branch_name] = bm
      end
      bm
    end
  end
end