@students = []

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
  case selection
    when "1"
      puts "You entered #{selection}: Input the students"
      input_new_students
    when "2"
      puts "You entered #{selection}: Show the students."
      show_students
    when "3"
      puts "You entered #{selection}: Save the list. Please enter the file to save to:"
      filename = STDIN.gets.chomp
      filename.empty? ? save_students("students.csv") : save_students(filename)
    when "4"
      puts "You entered #{selection}: Load the list. Please enter the file to load:"
      filename = STDIN.gets.chomp
      filename.empty? ? load_students("students.csv") : load_students(filename)
    when "9"
      puts "You entered #{selection}: Exit"
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

def save_students(filename)
  file = File.open(filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename)
  @students.clear 
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_students(name, cohort)
  end
  puts "Loaded #{@students.count} from #{filename}"
  file.close
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students("students.csv")
    return
  elsif File.exists?(filename)
    load_students(filename)
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
