# students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []

  name = gets.chomp

  while !name.empty?
    puts "Now please enter the student's cohort"
    cohort = gets.chomp
      if cohort.empty?
        cohort = "Cohort unknown"
      end

    students << {name: name, cohort: cohort}
      if students.count > 1
        puts "Now we have #{students.count} students"
      else
        puts "Now we have #{students.count} student"
      end

    puts "Please enter the names of the students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Demo Academy"
  puts "--------------"
end

def print(students)
  students.each_with_index() do |student, i|
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50, " ")
  end
end

def print_footer(students)
  if students.count > 1
    puts "Overall, we have #{students.count} great students".center(50, "-")
  else
    puts "Overall, we have #{students.count} great student".center(50, "-")
  end
end
