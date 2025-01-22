-- Hàm hiển thị menu
function displayMenu()
    print("=== MENU ===")
    print("1. Thực hiện tác vụ 1")
    print("2. Thực hiện tác vụ 2")
    print("3. Thoát")
    print("Nhập số để chọn tác vụ:")
end

-- Hàm thực hiện tác vụ 1
function task1()
    print("Bạn đã chọn thực hiện tác vụ 1!")
end

-- Hàm thực hiện tác vụ 2
function task2()
    print("Bạn đã chọn thực hiện tác vụ 2!")
end

-- Hàm xử lý lựa chọn người dùng
function handleChoice(choice)
    if choice == 1 then
        task1()
    elseif choice == 2 then
        task2()
    elseif choice == 3 then
        print("Thoát chương trình...")
        os.exit()
    else
        print("Lựa chọn không hợp lệ! Vui lòng thử lại.")
    end
end

-- Chương trình chính
while true do
    displayMenu()
    local choice = tonumber(io.read()) -- Đọc lựa chọn từ người dùng
    handleChoice(choice)
end
