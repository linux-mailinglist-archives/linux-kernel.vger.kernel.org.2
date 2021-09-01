Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE73FDDB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbhIAOSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244902AbhIAOSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:18:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F6961074;
        Wed,  1 Sep 2021 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630505867;
        bh=5HY+qUX+mPgxbz13bboTdXtCq6Xrpv8YMYPhTI3H2hs=;
        h=Date:From:To:Cc:Subject:From;
        b=wKYFGXown6FuuB79AwdD97a/7x7CQ99Tcx+oQcXHA6mFpe8T1KhmjzKvf4RUaAlCf
         L2cm1kwy8Qol4PEznJEx1TdfBTbsR6enr7irfPmeqVcVAU9CYZ762jf+Yn/maD6YbY
         giaffMpVh7PuULd8soCHckadzHbSxtHn745WQ90I=
Date:   Wed, 1 Sep 2021 16:17:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt changes for 5.15-rc1
Message-ID: <YS+LiD1qkhHDCeHe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc1

for you to fetch changes up to 9c1587d99f9305aa4f10b47fcf1981012aa5381f:

  usb: isp1760: otg control register access (2021-08-27 16:11:39 +0200)

----------------------------------------------------------------
USB/Thunderbolt patches for 5.15-rc1

Here is the big set of USB and Thunderbolt patches for 5.15-rc1.

Nothing huge in here, just lots of constant forward progress on a number
of different drivers and hardware support:
	- more USB 4/Thunderbolt support added
	- dwc3 driver updates and additions
	- usb gadget fixes and addtions for new types
	- udc gadget driver updates
	- host controller updates
	- removal of obsolete drivers
	- other minor driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Anirudh Rayabharam (2):
      usbip: give back URBs for unsent unlink requests during cleanup
      usbip: clean up code in vhci_device_unlink_cleanup

Argishti Aleksanyan (1):
      usb: dwc2: gadget: implement udc_set_speed()

Biju Das (3):
      dt-bindings: usb: generic-ehci: Document dr_mode property
      dt-bindings: usb: generic-ohci: Document dr_mode property
      dt-bindings: usb: renesas,usbhs: Document RZ/G2L bindings

Cai Huoqing (2):
      usb: gadget: mass_storage: Remove repeated verbose license text
      usb: gadget: aspeed: Remove repeated verbose license text

Christophe JAILLET (2):
      usb: bdc: Fix an error handling path in 'bdc_probe()' when no suitable DMA config is available
      usb: bdc: Fix a resource leak in the error handling path of 'bdc_probe()'

Chunfeng Yun (35):
      dt-bindings: usb: mtu3: remove support VBUS detection of extcon
      dt-bindings: usb: mtu3: add optional property to disable usb2 ports
      dt-bindings: usb: mtu3: add support property role-switch-default-mode
      dt-bindings: usb: mtu3: add wakeup interrupt
      usb: common: add helper to get role-switch-default-mode
      usb: dwc3: drd: use helper to get role-switch-default-mode
      usb: mtu3: support property role-switch-default-mode
      usb: mtu3: support option to disable usb2 ports
      usb: mtu3: add new helpers for host suspend/resume
      usb: mtu3: support runtime PM for host mode
      usb: mtu3: add helper to power on/down device
      usb: mtu3: support suspend/resume for device mode
      usb: mtu3: support suspend/resume for dual-role mode
      usb: mtu3: restore HS function when set SS/SSP
      usb: mtu3: use @mult for HS isoc or intr
      usb: mtu3: fix the wrong HS mult value
      usb: cdnsp: fix the wrong mult value for HS isoc or intr
      usb: gadget: tegra-xudc: fix the wrong mult value for HS isoc or intr
      usb: gadget: bdc: remove unnecessary AND operation when get ep maxp
      usb: gadget: remove unnecessary AND operation when get ep maxp
      Revert "usb: xhci-mtk: relax TT periodic bandwidth allocation"
      Revert "usb: xhci-mtk: Do not use xhci's virt_dev in drop_endpoint"
      dt-bindings: usb: mtk-xhci: add optional property to disable usb2 ports
      dt-bindings: usb: mtk-xhci: add compatible for mt8195
      usb: xhci-mtk: fix use-after-free of mtk->hcd
      usb: xhci-mtk: support option to disable usb2 ports
      usb: xhci-mtk: fix issue of out-of-bounds array access
      usb: xhci-mtk: update fs bus bandwidth by bw_budget_table
      usb: xhci-mtk: check boundary before check tt
      usb: xhci-mtk: add a member of num_esit
      usb: xhci-mtk: modify the SOF/ITP interval for mt8195
      usb: xhci-mtk: Do not use xhci's virt_dev in drop_endpoint
      usb: mtu3: return successful suspend status
      usb: mtu3: fix random remote wakeup
      usb: xhci-mtk: allow bandwidth table rollover

Colin Ian King (4):
      usb: gadget: f_uac2: remove redundant assignments to pointer i_feature
      usb: renesas_usbhs: Fix spelling mistake "faile" -> "failed"
      usb: dwc2: Fix spelling mistake "was't" -> "wasn't"
      usb: typec: tcpm: Fix spelling mistake "atleast" -> "at least"

Evgeny Novikov (2):
      USB: EHCI: ehci-mv: improve error handling in mv_ehci_enable()
      usb: ehci-orion: Handle errors of clk_prepare_enable() in probe

Geert Uytterhoeven (1):
      usb: gadget: udc: renesas_usb3: Fix soc_device_match() abuse

Greg Kroah-Hartman (6):
      Merge v5.14-rc3 into usb-next
      Merge 5.14-rc5 into usb-next
      Merge 5.14-rc6 into usb-next
      Merge 5.14-rc7 into usb-next
      Merge tag 'thunderbolt-for-v5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-v5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next

Hu Haowen (1):
      docs: usb: fix malformed table

Ikjoon Jang (2):
      usb: xhci-mtk: Do not use xhci's virt_dev in drop_endpoint
      usb: xhci-mtk: relax TT periodic bandwidth allocation

Jack Pham (2):
      usb: gadget: composite: Allow bMaxPower=0 if self-powered
      usb: dwc3: Decouple USB 2.0 L1 & L2 events

Kees Cook (2):
      USB: EHCI: Add register array bounds to HCS ports
      USB: EHCI: Add alias for Broadcom INSNREG

Kelly Devilliv (3):
      Revert "usb: host: fotg210: Use dma_pool_zalloc"
      usb: host: fotg210: fix the endpoint's transactional opportunities calculation
      usb: host: fotg210: fix the actual_length of an iso packet

Konrad Dybcio (1):
      drivers: usb: dwc3-qcom: Add sdm660 compatible

Kyle Tso (2):
      dt-bindings: connector: Add pd-disable property
      usb: typec: tcpm: Support non-PD mode

Li Jun (1):
      usb: chipidea: host: fix port index underflow and UBSAN complains

Linus Walleij (1):
      usb: isp1301-omap: Fix the GPIO include

Lukas Bulwahn (3):
      usb: host: remove dead EHCI support for on-chip PMC MSP71xx USB controller
      usb: host: remove line for obsolete config USB_HWA_HCD
      usb: remove reference to deleted config STB03xxx

Maciej Żenczykowski (6):
      usb: gadget: f_ncm: remove timer_force_tx field
      usb: gadget: f_ncm: remove spurious boolean timer_stopping
      usb: gadget: f_ncm: remove check for NULL skb_tx_data in timer function
      usb: gadget: f_ncm: remove spurious if statement
      usb: gadget: f_ncm: ncm_wrap_ntb - move var definitions into if statement
      usb: gadget: u_ether: fix a potential null pointer dereference

Mathias Nyman (6):
      xhci: fix unsafe memory usage in xhci tracing
      xhci: fix even more unsafe memory usage in xhci tracing
      xhci: Fix failure to give back some cached cancelled URBs.
      Revert "USB: xhci: fix U1/U2 handling for hardware with XHCI_INTEL_HOST quirk set"
      xhci: Add additional dynamic debug to follow URBs in cancel and error cases.
      xhci: Add bus number to some debug messages

Maxim Devaev (1):
      usb: gadget: f_hid: optional SETUP/SET_REPORT mode

Maxime Ripard (2):
      dt-bindings: usb: ehci: Add Allwinner A83t compatible
      dt-bindings: usb: ohci: Add Allwinner A83t compatible

Michael Grzeschik (5):
      usb: dwc3: gadget: set gadgets parent to the right controller
      usb: gadget: uvc: make uvc_num_requests depend on gadget speed
      usb: gadget: uvc: set v4l2_dev->dev in f_uvc
      usb: gadget: uvc: add scatter gather support
      usb: gadget: uvc: decrease the interrupt load to a quarter

Minas Harutyunyan (1):
      usb: dwc2: gadget: Add endpoint wedge support

Moritz Fischer (2):
      usb: xhci-renesas: Minor coding style cleanup
      usb: renesas-xhci: Remove renesas_xhci_pci_exit()

Nadezda Lutovinova (3):
      usb: gadget: mv_u3d: request_irq() after initializing UDC
      usb: dwc3: imx8mp: request irq after initializing dwc3
      usb: musb: musb_dsps: request_irq() after initializing musb

Nehal Bakulchandra Shah (1):
      usb: dwc3: pci: add support for AMD's newer generation platform.

Pavel Hofman (1):
      usb: gadget: f_uac1: fixing inconsistent indenting

Rajat Jain (1):
      thunderbolt: Add authorized value to the KOBJ_CHANGE uevent

Rikard Falkeborn (1):
      usb: gadget: pxa25x_udc: Constify static struct pxa25x_ep_ops

Rui Miguel Silva (13):
      usb: isp1760: remove debug message as error
      usb: isp1760: do not sleep in field register poll
      usb: isp1760: rework cache initialization error handling
      usb: isp1760: ignore return value for bus change pattern
      usb: isp1760: check maxpacketsize before using it
      usb: isp1760: do not reset retval
      usb: isp1760: do not shift in uninitialized slot
      usb: isp1760: clean never read udc_enabled warning
      usb: isp1760: fix memory pool initialization
      usb: isp1760: fix qtd fill length
      usb: isp1760: write to status and address register
      usb: isp1760: use the right irq status bit
      usb: isp1760: otg control register access

Ruslan Bilovol (4):
      usb: audio-v2: add ability to define feature unit descriptor
      usb: gadget: u_audio: add bi-directional volume and mute support
      usb: gadget: f_uac2: add volume and mute support
      usb: gadget: f_uac1: add volume and mute support

Salah Triki (2):
      usb: gadget: remove useless cast
      usb: misc: adutux: use swap()

Sandeep Maheswaram (3):
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SC7280
      arm64: dts: qcom: sc7280: Add USB related nodes
      arm64: dts: qcom: sc7280: Add USB nodes for IDP board

Sanjay R Mehta (4):
      thunderbolt: Add vendor specific NHI quirk for auto-clearing interrupt status
      thunderbolt: Handle ring interrupt by reading interrupt status register
      thunderbolt: Do not read control adapter config space
      thunderbolt: Fix port linking by checking all adapters

Sergey Shtylyov (10):
      usb: host: ohci-spear: simplify calling usb_add_hcd()
      usb: dwc3: meson-g12a: add IRQ check
      usb: dwc3: qcom: add IRQ check
      usb: gadget: udc: at91: add IRQ check
      usb: gadget: udc: s3c2410: add IRQ check
      usb: misc: brcmstb-usb-pinmap: add IRQ check
      usb: phy: fsl-usb: add IRQ check
      usb: phy: twl6030: add IRQ checks
      usb: host: ohci-tmio: add IRQ check
      usb: phy: tahvo: add IRQ check

Shuah Khan (1):
      usbip:vhci_hcd USB port can get stuck in the disabled state

Sungbo Eo (1):
      dt-bindings: usb: mtk-musb: add MT7623 compatible

Wei Ming Chen (2):
      usb: gadget: Fix inconsistent indent
      usb: gadget: Add description for module parameter

Wesley Cheng (7):
      usb: gadget: udc: core: Introduce check_config to verify USB configuration
      usb: gadget: configfs: Check USB configuration before adding
      usb: dwc3: Resize TX FIFOs to meet EP bursting requirements
      of: Add stub for of_add_property()
      usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default
      dt-bindings: usb: dwc3: Update dwc3 TX fifo properties
      usb: dwc3: dwc3-qcom: Fix typo in the dwc3 vbus override API

Yoshihiro Shimoda (1):
      usb: host: xhci-rcar: Don't reload firmware after the completion

 Documentation/ABI/testing/configfs-usb-gadget-uac1 |  10 +
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |  10 +
 .../bindings/connector/usb-connector.yaml          |   4 +
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |   1 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |   6 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |   6 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |   6 +
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |  47 +-
 .../devicetree/bindings/usb/mediatek,musb.yaml     |   1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |  26 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  15 +-
 Documentation/usb/gadget-testing.rst               |  64 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |  39 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 164 +++++
 drivers/of/base.c                                  |   1 +
 drivers/thunderbolt/nhi.c                          |  46 +-
 drivers/thunderbolt/switch.c                       |  28 +-
 drivers/usb/Kconfig                                |   2 +-
 drivers/usb/Makefile                               |   1 -
 drivers/usb/cdns3/cdnsp-mem.c                      |   2 +-
 drivers/usb/chipidea/host.c                        |  14 +-
 drivers/usb/common/common.c                        |  20 +
 drivers/usb/dwc2/core.c                            |   2 +-
 drivers/usb/dwc2/core.h                            |   2 +
 drivers/usb/dwc2/gadget.c                          |  51 +-
 drivers/usb/dwc3/core.c                            |  24 +
 drivers/usb/dwc3/core.h                            |  21 +-
 drivers/usb/dwc3/drd.c                             |   8 +-
 drivers/usb/dwc3/dwc3-imx8mp.c                     |  14 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   2 +
 drivers/usb/dwc3/dwc3-pci.c                        |  17 +
 drivers/usb/dwc3/dwc3-qcom.c                       |  28 +-
 drivers/usb/dwc3/ep0.c                             |   2 +
 drivers/usb/dwc3/gadget.c                          | 234 ++++++-
 drivers/usb/gadget/Kconfig                         |   1 +
 drivers/usb/gadget/composite.c                     |   8 +-
 drivers/usb/gadget/configfs.c                      |  12 +-
 drivers/usb/gadget/function/f_fs.c                 |   4 +-
 drivers/usb/gadget/function/f_hid.c                | 220 ++++++-
 drivers/usb/gadget/function/f_mass_storage.c       |  30 -
 drivers/usb/gadget/function/f_ncm.c                |  50 +-
 drivers/usb/gadget/function/f_uac1.c               | 674 ++++++++++++++++++++-
 drivers/usb/gadget/function/f_uac2.c               | 652 ++++++++++++++++++--
 drivers/usb/gadget/function/f_uvc.c                |   1 +
 drivers/usb/gadget/function/u_audio.c              | 369 ++++++++++-
 drivers/usb/gadget/function/u_audio.h              |  22 +
 drivers/usb/gadget/function/u_ether.c              |   5 +-
 drivers/usb/gadget/function/u_hid.h                |   1 +
 drivers/usb/gadget/function/u_uac1.h               |  20 +
 drivers/usb/gadget/function/u_uac2.h               |  23 +-
 drivers/usb/gadget/function/uvc.h                  |  15 +-
 drivers/usb/gadget/function/uvc_queue.c            |  28 +-
 drivers/usb/gadget/function/uvc_queue.h            |   7 +-
 drivers/usb/gadget/function/uvc_video.c            | 155 ++++-
 drivers/usb/gadget/function/uvc_video.h            |   2 +
 drivers/usb/gadget/legacy/Kconfig                  |   1 +
 drivers/usb/gadget/legacy/inode.c                  |   4 +-
 drivers/usb/gadget/legacy/printer.c                |   1 +
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |   5 -
 drivers/usb/gadget/udc/aspeed-vhub/dev.c           |   5 -
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c           |   5 -
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |   5 -
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |   5 -
 drivers/usb/gadget/udc/at91_udc.c                  |   4 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.c               |   1 -
 drivers/usb/gadget/udc/bdc/bdc_core.c              |  30 +-
 drivers/usb/gadget/udc/core.c                      |  19 +
 drivers/usb/gadget/udc/mv_u3d_core.c               |  19 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |  17 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |   4 +
 drivers/usb/gadget/udc/tegra-xudc.c                |   4 +-
 drivers/usb/host/Kconfig                           |   9 -
 drivers/usb/host/ehci-brcm.c                       |  11 +-
 drivers/usb/host/ehci-hcd.c                        |   5 -
 drivers/usb/host/ehci-mv.c                         |  23 +-
 drivers/usb/host/ehci-orion.c                      |   8 +-
 drivers/usb/host/ehci-pmcmsp.c                     | 328 ----------
 drivers/usb/host/fotg210-hcd.c                     |  48 +-
 drivers/usb/host/fotg210.h                         |   5 -
 drivers/usb/host/ohci-spear.c                      |   2 +-
 drivers/usb/host/ohci-tmio.c                       |   3 +
 drivers/usb/host/xhci-debugfs.c                    |  14 +-
 drivers/usb/host/xhci-hub.c                        |   6 +-
 drivers/usb/host/xhci-mtk-sch.c                    | 180 +++---
 drivers/usb/host/xhci-mtk.c                        |  79 ++-
 drivers/usb/host/xhci-mtk.h                        |  17 +-
 drivers/usb/host/xhci-pci-renesas.c                |   7 +-
 drivers/usb/host/xhci-pci.c                        |   2 -
 drivers/usb/host/xhci-pci.h                        |   3 -
 drivers/usb/host/xhci-rcar.c                       |   7 +
 drivers/usb/host/xhci-ring.c                       |  76 ++-
 drivers/usb/host/xhci-trace.h                      |  26 +-
 drivers/usb/host/xhci.c                            |  30 +-
 drivers/usb/host/xhci.h                            |  73 ++-
 drivers/usb/isp1760/isp1760-core.c                 |  54 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |  87 +--
 drivers/usb/isp1760/isp1760-regs.h                 |  16 +
 drivers/usb/isp1760/isp1760-udc.c                  |  12 +-
 drivers/usb/misc/adutux.c                          |   5 +-
 drivers/usb/misc/brcmstb-usb-pinmap.c              |   2 +
 drivers/usb/mtu3/mtu3.h                            |   8 +
 drivers/usb/mtu3/mtu3_core.c                       | 119 +++-
 drivers/usb/mtu3/mtu3_dr.c                         |  26 +-
 drivers/usb/mtu3/mtu3_dr.h                         |  30 +-
 drivers/usb/mtu3/mtu3_gadget.c                     |  11 +-
 drivers/usb/mtu3/mtu3_host.c                       | 108 +++-
 drivers/usb/mtu3/mtu3_plat.c                       | 170 +++++-
 drivers/usb/musb/musb_dsps.c                       |  13 +-
 drivers/usb/phy/phy-fsl-usb.c                      |   2 +
 drivers/usb/phy/phy-isp1301-omap.c                 |   2 +-
 drivers/usb/phy/phy-tahvo.c                        |   4 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |   5 +
 drivers/usb/renesas_usbhs/fifo.c                   |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  91 ++-
 drivers/usb/usbip/vhci_hcd.c                       |  36 +-
 include/linux/of.h                                 |   5 +
 include/linux/thunderbolt.h                        |   2 +
 include/linux/usb/audio-v2.h                       |  14 +
 include/linux/usb/ehci_def.h                       |  33 +-
 include/linux/usb/gadget.h                         |   6 +-
 include/linux/usb/otg.h                            |   1 +
 123 files changed, 3994 insertions(+), 1181 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-pmcmsp.c
