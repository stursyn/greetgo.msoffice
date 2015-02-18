package kz.greepto.gpen.views.gpen.figurebox

import kz.greepto.gpen.editors.gpen.GpenEditor
import org.eclipse.jface.viewers.ISelection
import org.eclipse.swt.widgets.Composite
import org.eclipse.ui.ISelectionListener
import org.eclipse.ui.IWorkbenchPart
import org.eclipse.ui.part.ViewPart

class FigureBoxView extends ViewPart {

  override setFocus() {}

  GpenEditor gpenEditor = null
  FigureBoxUI ui = null

  override createPartControl(Composite parent) {
    site.workbenchWindow.selectionService.addSelectionListener(listener)

    ui = new FigureBoxUI(parent)

    ui.selectHandlerList.add [ FigureMediator fm |
      if (fm.state === State.DOWN) {
        ui.figureMediatorList.filter[it != fm].forEach[state = State.UP]
        if (gpenEditor !== null) {
          gpenEditor.startCreateFigure(fm.createFigure);
        }
      } else {
        ui.figureMediatorList.forEach[state = State.UP]
      }
    ]
  }

  val ISelectionListener listener = [ IWorkbenchPart part, ISelection selection |
    if (part instanceof GpenEditor) {
      gpenEditor = (part as GpenEditor)
    } else {
      gpenEditor = null
    }
    updateUI
  ]

  def updateUI() {
    ui.figureMediatorList.forEach[state = if(gpenEditor === null) State.DISABLE else  State.UP]
  }

  override dispose() {
    site.workbenchWindow.selectionService.removeSelectionListener(listener)
    if(ui !== null) ui.dispose
    super.dispose()
  }
}