require "rspec"

require_relative "list"
require_relative "task"

describe List do
  # Your specs here
  let(:title) {"Task List"}
  let(:task3) {"new_task3"}
  let(:task2) {Task.new("new_task2")}
  let(:task1)	{Task.new("new_task1")}
  let(:list) {List.new(title, [task1, task2])}


  	describe "#initialize" do

  		it "takes title for its first argument" do
  			expect(List.new("title")).to be_instance_of(List)
  		end

  		it "requires one argument" do
  			expect{List.new}.to raise_error(ArgumentError)
  		end

  		it "input only accept string for title" do
  			expect{List.new}.to raise_error(ArgumentError)
  		end

  		it "raise error when create invalide task" do
  			expect{List.new}.to raise_error(ArgumentError)
  		end

  	end

  	describe "#add_task" do

  		it "raise error when there is no argument input when adding a task" do
  		  expect{list.add_task}.to raise_error(ArgumentError)
  		end

      it "new input to add task" do
        expect(list.add_task(task3)).to include(task3) #to insert new task in tasks = []
      end

  	end

    describe "#complete_task" do

      it "return true when a task is completed" do
        list.add_task(task1)
        expect(list.complete_task(0)).to be(true)
      end

    end

    describe "#delete_task" do

      it "delete a task" do
        expect { list.delete_task(1) }.to change{ list.tasks.size }.by -1
      end

      it "requires one argument" do
        expect{ list.delete_task }.to raise_error(ArgumentError)
      end

    end

    describe "#completed_tasks" do

      it "show list of completed tasks" do        
        task1.complete!
        expect( list.completed_tasks ).to include( task1 )
      end

    end

    describe "#incomplete_tasks" do
      
      it "do not show list of incomplete tasks" do
        expect{ list.add_task(Task.new("new_task3")) }.not_to change{ list.completed_tasks.size } 
        #when adding a new task as task3 will not change the completed list size
        expect( list.completed_tasks ).not_to include( task3 )
      end
    
    end

end