import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ApiService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var sizes=["Small","Medium","Large"];
  var values=["256x256","512x512","1024x1024"];
  String? dropValue;
  TextEditingController textController=TextEditingController();
  bool isLoaded=false;
  String image='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('AI Image generator',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Expanded(
          child: Column(children: [
            Row(children: [
              Expanded(child:
              Container(
                height:40,
                  decoration: BoxDecoration(
                      color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                  child:TextField(
                    // maxLines: null,
                    controller: textController,
                decoration: InputDecoration(hintText: "e.g. birds in sky",
                border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.5, 5.0, 10.0),
                ),
              )
              )
                ),
              SizedBox(width: 12,),
              Container(height: 44,
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child:DropdownButtonHideUnderline(child:
                  DropdownButton(icon:Icon(Icons.expand_more,color: Colors.grey,),
                    value: dropValue,
                    hint: Text("Select Size"),
                    items: List.generate(sizes.length, (index) => 
                    DropdownMenuItem(child: Text(sizes[index]),value: values[index],)
                    ),
                    onChanged:(value){
                    setState(() {
                      dropValue=value.toString();
                    });
                    },
                  )
                  )
              )
            ],
            ),
            SizedBox(height: 20,),
            SizedBox(width:300,
            height:40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.deepPurple,
                shape: StadiumBorder()
                ),
                onPressed: ()async{
                  if(textController.text.isNotEmpty && dropValue!.isNotEmpty) {
                    var img = await Api.generateImage(textController.text,dropValue!);
                    setState(() {
                      image=img;
                      isLoaded=true;
                    });
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Select prompt and size'),
                    ));
                  }
                },
                child: Text('Generate'),)
            )
          ],),
        ),
          Expanded(flex: 3,
              child:
              isLoaded?
              Image.network(image):
              Container(
            color: Colors.amber,
          )
          )
      ],)
      ),
    );
  }
}
