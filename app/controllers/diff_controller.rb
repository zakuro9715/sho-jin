class DiffController < ApplicationController
  before_action :set_params
  def index
    @problems_first = get_solved_problems_id(@first_user)
    @problems_second = get_solved_problems_id(@second_user)
  end

  private
    def set_params
      @first_user = params[:first]
      @second_user = params[:second]
      @xor = true if params[:xor] else false
    end

    def get_solved_problems_id(username)
      begin
        d = open("http://judge.u-aizu.ac.jp/onlinejudge/webservice/solved_record?user_id=#{username}").read
        problems = Hash.from_xml(d)['solved_record_list']['solved']
        if problems == nil
          return []
        end
        if problems.length == 1
          problems['problem_id']
        else
          problems.map{ |p| p['problem_id'] }
        end
      rescue OpenURI::HTTPError
        []
      end
    end
end
