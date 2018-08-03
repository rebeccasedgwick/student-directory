require 'csv'
@students = []
DEFAULT_FILENAME = "students.csv"
CENTERING_SIZE = 50

def input_new_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp

  while !name.empty?
    puts "Now please enter the student's cohort"
    cohort = STDIN.gets.chomp
    if cohort.empty?
      cohort = "Cohort unknown"
    end

    add_student(name, cohort)

    puts "Now we have #{pluralize(@students.count, "student")}"

    puts "Please enter the name of the student"
    name = STDIN.gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  print "You entered #{selection}: "
  case selection
    when "1"
      puts "Input the students"
      input_new_students
    when "2"
      puts "Show the students."
      show_students
    when "3"
      puts "Save the list. Please enter the file to save to:"
      get_filename("save")
    when "4"
      puts "Load the list. Please enter the file to load:"
      get_filename("load")
    when "9"
      puts "Exit"
      exit
    else
      puts "Please enter a valid selection"
  end
end

def get_filename(function)
  filename = STDIN.gets.chomp
  filename = DEFAULT_FILENAME if filename.empty?
  case function
  when "save" then save_students(filename)
  when "load" then load_students(filename)
  end
end

def print_header
  puts "The Students of Demo Academy".center(CENTERING_SIZE)
  puts "-" * 50
end

def print_student_list
  @students.each_with_index do |student, i|
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(CENTERING_SIZE, " ")
  end
end

def print_footer
  puts "Overall, we have #{pluralize(@students.count, "great student")}".center(CENTERING_SIZE, "-")
end

def save_students(filename)
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
end

def load_students(filename)
  @students.clear
  if File.exist?(filename)
    CSV.foreach(filename) do |row|
      add_student(row[0], row[1])
    end
  end
  puts "Loaded #{@students.count} from #{filename}"
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    File.write(DEFAULT_FILENAME, "")
    load_students(DEFAULT_FILENAME)
    return
  elsif File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort}
end

def pluralize(number, string)
  number == 1 ? string : "#{string}s"
end

try_load_students
interactive_menu
