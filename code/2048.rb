class  Game
  def initialize
    @array = 4.times.map { [ nil ] * 4 }   #初始化一个内嵌数组 
    2.times { rand_array } #生成两个初始随机数
  end
  #生成一个随机数2或者4
  def rand_array
    row, col = rand(4), rand(4)
    return rand_array if @array[row][col] #如果当前位置的元素不为nil，则重新寻找位置
    @array[row][col] =2 + 2*rand(2)    # 在此nil位置上随机加入2或4
  end
  def move(derection)
    @array = @array.transpose if %w[w s].include?(derection) #将内嵌数组看成矩阵，行列互调进行转置
    @array.each(&:reverse!) if %w[ d s].include?(derection) #数组中内嵌的每一个数组元素倒序排列
    4.times do |i|
      temp_array = @array[i].compact #去除空元素(nil)
      3.times { |x| temp_array[x],temp_array[x+1] = temp_array[x] * 2, nil if temp_array[x].to_i == temp_array[x+1]   }         #实现数组中内嵌的每一个数组相邻的相等数字相加，只加一次
      @array[i] = temp_array.compact.concat( [ nil ] * 4)[0..3] #若不够四个元素则用nil进行填补
    end
    @array.each(&:reverse!) if %w[ d s].include?(derection)#逆顺数组元素
    @array = @array.transpose if %w[w s].include?(derection)
  end
  def start
    puts @array.map { |line| "[%5s] " * 4 % line } #以矩阵形式打印当前数组内的所有元素
    key = gets.chomp  #获取方向输入 
    exit() if key== 'q' #如果输入q，则退出游戏
    move(key)
    rand_array && start if @array.flatten.include?(nil) #当矩阵（数组）还有nil时，随机生成一个2或4并继续游戏
  end
end
Game.new.start
