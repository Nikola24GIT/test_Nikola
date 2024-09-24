object StringProcessor {
  def processStrings(strings: List[String]): List[String] = {
    //вместо описания шагов(цикл, условие) добавлены функции filter, map
    strings.filter(_.length > 3).map(_.toUpperCase)   
  }

  def main(args: Array[String]): Unit = {
    val strings = List("apple", "cat", "banana", "dog", "elephant")
    val processedStrings = processStrings(strings)
    println(s"Processed strings: $processedStrings")
  }
}