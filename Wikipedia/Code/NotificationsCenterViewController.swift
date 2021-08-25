import UIKit

@objc
final class NotificationsCenterViewController: ViewController {

	// MARK: - Properties

	var notificationsView: NotificationsCenterView {
		return view as! NotificationsCenterView
	}

	let viewModel: NotificationsCenterViewModel

	// MARK: - Lifecycle

	@objc
	init(theme: Theme, viewModel: NotificationsCenterViewModel) {
		self.viewModel = viewModel
		super.init(theme: theme)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = NotificationsCenterView(frame: .zero)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		notificationsView.apply(theme: theme)

		title = CommonStrings.notificationsCenterTitle
		edgesForExtendedLayout = .all

		setupBarButtons()
		bind()
	}

	// MARK: - Configuration

	fileprivate func setupBarButtons() {
		enableToolbar()
		setToolbarHidden(false, animated: false)

		let editButton = UIBarButtonItem(title: WMFLocalizedString("notifications-center-edit-button", value: "Edit", comment: "Title for navigation bar button to toggle mode for editing notification read status"), style: .plain, target: nil, action: nil)
		navigationItem.rightBarButtonItem = editButton
	}

	func bind() {
		notificationsView.collectionView.dataSource = self
		notificationsView.collectionView.delegate = self
	}

	// MARK: - Public

}

extension NotificationsCenterViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoticeCollectionViewCell.reuseIdentifier, for: indexPath) as! NoticeCollectionViewCell

		cell.apply(theme: theme)
		return cell
	}

}
