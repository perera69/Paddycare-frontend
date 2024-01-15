import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RemediesPage extends StatelessWidget {
  final String? predictedClass;

  RemediesPage({Key? key, this.predictedClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> remedies = getRemedies(predictedClass);

    return Scaffold(
      appBar: AppBar(
        title: Text('Remedies for $predictedClass'),
        backgroundColor: Color.fromARGB(255, 20, 119, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remedies:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (remedies.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: remedies.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          remedies[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Center(
                child: Text(
                  'No remedies available',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            SizedBox(height: 20),
            if (remedies.isNotEmpty && predictedClass != null)
              ElevatedButton(
                onPressed: () {
                  launch(getMoreInfoUrl(predictedClass!));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 20, 119, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'More Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<String> getRemedies(String? predictedClass) {
    switch (predictedClass?.toLowerCase()) {
      case 'bacterial leaf blight':
        return [
          'Conditions that favour the disease:',
          '- It can occur in both irrigated and rainfed lowland areas.',
          '- Favors temperatures at 25−34°C.',
          '- It is commonly observed when strong winds and continuous heavy rains occur.',
          '- High humidity.',
          '- Excessive application of nitrogen fertilizer.',
          'Disease Management:',
          'Within the crop season:',
          '- Application of urea in recommended dosages or application of urea based on leaf colour chart.',
          '- Ensure good drainage of fields.',
          '- Immediately after the disease is observed, stop water supply, and let the field dry.',
          '- When total removal of water is not possible, try to out-flow water through drainage ditches or water courses (wakkada).',
          '- Water drained from the fields infected with disease should not be diverted through disease-free fields as much as possible.',
          '- Once the disease is observed, application of potassium fertilizer could manage further spread of the disease.'
        ];
      case 'blast':
        return [
          'Conditions that favour the disease:',
          '- Low temperature during the night (17-20°C).',
          '- High humidity.',
          '- Excessive application of nitrogen fertilizer.',
          '- Foggy and dark climatic conditions.',
          '- High densities of plants in the field.',
          '- Susceptible varieties (Bg 358, Bg 357, Bg 360, Bw 367, At 373, Bg 94/1).',
          'Disease Management:',
          'Within the crop season:',
          '- Application of urea in recommended dosages or application of urea based on leaf colour chart.',
          '- Weed management.',
          'If the disease spreads fast, following fungicides could be applied:',
          '- Tebuconazole 250g/l EC – dissolve 10 ml in 16 l of water (8-10 tanks per acre).',
          '- Isoprothiolane 400g/l EC – dissolve 20 ml in 16 l of water (8-10 tanks per acre).',
          '- Carbendazim 50% WP/WG – dissolve 11 g/ 11 ml in 16 l of water (8-10 tanks per acre).',
          '- Tricyclazole 75 %WP – dissolve 10 g in 16 l of water (8-10 tanks per acre).',
          'If the crop is infected, following management options should be applied for the next season:',
          '- Use of resistant varieties (Bg 403, Bg 406, Bg 366, Bg 359, Bw 361, Bg 250).',
          '- Use of certified seed paddy free from the disease.',
          '- Addition of burnt paddy husk (250 kg per acre) to the soil during land preparation.',
          '- Abstain addition of disease-infected straw.'
        ];
      case 'brownspot':
        return [
          'Conditions that favour the disease:',
          '- Environmental temperatures within 16-36°C.',
          '- High humidity (86-100%).',
          '- Soils with a low level of required nutrients or problem soils (high salinity, Iron toxicity).',
          '- Drought.',
          'Disease Management:',
          'Within the crop season:',
          '- Application of urea in recommended dosages or application of urea based on the leaf colour chart.',
          '- Weed management.',
          'If the crop is infected, following management options should be applied for the next season:',
          '- Application of organic fertilizer will increase the soil quality.',
          '- Use of certified seed paddy free from the disease.',
          '- Addition of burnt paddy husk (250 kg per acre) to the soil during land preparation.',
          '- Abstain addition of disease-infected straw.',
          '- Treatment of seed paddy by dipping in hot water (53-54°C) for 10-12 minutes.',
          '- Treatment of seeds with a seed-protectant fungicide.',
          '- Crop rotation.',
          '- Proper land leveling.'
        ];
      default:
        return [];
    }
  }

  String getMoreInfoUrl(String predictedClass) {
    switch (predictedClass.toLowerCase()) {
      case 'bacterial leaf blight':
        return 'https://doa.gov.lk/rrdi_ricediseases_bacterialleafblight/';
      case 'blast':
        return 'https://doa.gov.lk/rrdi_ricediseases_riceblast/';
      case 'brownspot':
        return 'https://doa.gov.lk/rrdi_ricediseases_brownspot/';
      default:
        return 'https://doa.gov.lk/rrdi_ricediseases/';
    }
  }
}
