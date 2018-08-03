@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = STDIN.gets.chomp

  while !name.empty?
    puts "Now please enter the student's cohort"
    cohort = STDIN.gets.chomp
      if cohort.empty?
        cohort = "Cohort unknown"
      end

    # @students << {name: name, cohort: cohort}
    add_students(name, cohort)
      if @students.count > 1
        puts "Now we have #{@students.count} students"
      else
        puts "Now we have #{@students.count} student"
      end

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
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "Please enter a valid selection"
  end
end

def print_header
  puts "The Students of Demo Academy".center(50)
  puts "-".center(50, "-")
end

def print_student_list
  @students.each_with_index() do |student, i|
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50, " ")
  end
end

def print_footer
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students".center(50, "-")
  else
    puts "Overall, we have #{@students.count} great student".center(50, "-")
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  @students.clear # prevent data being added to array in duplicate each time method runs
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_students(name, cohort)
    # @students << {name: name, cohort: cohort}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    filename = "students.csv"
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
    return
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort}
end

try_load_students
interactive_menu
