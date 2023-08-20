//
//  ViewController.swift
//  Amazon
//
//  Created by ozlemkumtas on 17.08.2023.
//

import UIKit
struct TextCellViewModel{
    let text: String
    let font: UIFont
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    enum SectionType {
        case productPhoto(images: [UIImage])
        case productInfo(viewModels: [TextCellViewModel])
        case relatedProducts(viewModels: [RelatedProductTableViewCellViewModel])

        var title: String?{
            switch self{
            case .relatedProducts:
                return "Related Products"
            default:
               return nil
            }
        }
    }


    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PhotoCarouselTableViewCell.self, forCellReuseIdentifier: PhotoCarouselTableViewCell.identifier)
        table.register(RelatedProductTableViewCell.self, forCellReuseIdentifier: RelatedProductTableViewCell.identifier)


        return table
    }()

    private var sections = [SectionType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        title = "FIIO Sports Water Bottle"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func configureSections(){
        sections.append(.productPhoto(images: [
            UIImage(named: "photo1"),
            UIImage(named: "photo2"),
            UIImage(named: "photo3"),
          

        ].compactMap({ $0 })))
        sections.append(.productInfo(viewModels: [
            TextCellViewModel(text: "Our water bottle 1 litre is designed for reminding you to drink more and stay hydrated! It holds 32oz of water, you won't be wasting your time re-filling your water bottle. The wide-mouth opening makes it easy for you to clean, add Fruit or ice. Our plastic is BPA free, so you will always be drinking clean water.", font: .systemFont(ofSize: 18)
            ),
            TextCellViewModel(text: "Price: $11.99", font: .systemFont(ofSize: 22)
            )
        ]))
        sections.append(.relatedProducts(viewModels: [
       RelatedProductTableViewCellViewModel(image: UIImage(named: "related1"), title: "32oz, Simple Water Bottle "),
       RelatedProductTableViewCellViewModel(image: UIImage(named: "related2"), title: "BUZIO 40oz Water Bottle"),
       RelatedProductTableViewCellViewModel(image: UIImage(named: "related3"), title: "chunmo 64oz, Glass Water Bolttle")
        ]))
    }
    //table

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .productPhoto:
          return 1
        case .productInfo(let viewModels):
            return viewModels.count
        case .relatedProducts(let viewModels):
            return viewModels.count

        }

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        return sectionType.title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case.productPhoto(let images):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCarouselTableViewCell.identifier, for: indexPath) as? PhotoCarouselTableViewCell else {
                fatalError()
            }

            cell.configure(with: images)
            return cell

        case .productInfo(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case .relatedProducts(let viewModels):

            guard let cell = tableView.dequeueReusableCell(withIdentifier: RelatedProductTableViewCell.identifier, for: indexPath) as? RelatedProductTableViewCell else {
                fatalError()
            }

            cell.configure(with: viewModels[indexPath.row])
            return cell

        }



    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case.productPhoto:
            return view.frame.size.width
        case .relatedProducts:
            return 150
        case .productInfo:
            return UITableView.automaticDimension
        }
    }

}

extension UITableViewCell{
    func configure(with viewModel: TextCellViewModel){
        textLabel?.text = viewModel.text
        textLabel?.numberOfLines = 0
        textLabel?.font = viewModel.font
    }
}
