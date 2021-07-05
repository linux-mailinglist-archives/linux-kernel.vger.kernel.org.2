Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817C33BC228
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhGERQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhGERQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:16:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A710561935;
        Mon,  5 Jul 2021 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625505228;
        bh=Y84rRU8RVvUkepBxGQH1H35fmdzF7zOq1ve+NegjsFk=;
        h=Date:From:To:Cc:Subject:From;
        b=fZWteHa2eu2b/W+SDpmYuTB4b70YII29qDWqbI0jN9bMbv1SX1PuBojSuw9JX65o7
         Pt/rK6yes+IafhKU14E2GSwJ7vYKwGQ7iV5q5a4HTNFnOM36xgOQwkDVeCYyPqqSKU
         MVlKOqmV3ZncBmgNWyAwlH0Kj/HN5eCtdoEBiaWI=
Date:   Mon, 5 Jul 2021 19:13:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver changes for 5.14-rc1
Message-ID: <YOM9yTZZsEicMW3f@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc1

for you to fetch changes up to 7756f1d6369e61d1cc47d6e51619d1e1d1681a2e:

  phy: qcom-qusb2: Add configuration for SM4250 and SM6115 (2021-06-24 14:31:56 +0200)

----------------------------------------------------------------
USB / Thunderbolt patches for 5.14-rc1

Here is the big set of USB and Thunderbolt patches for 5.14-rc1.

Nothing major here just lots of little changes for new hardware and
features.  Highlights are:
	- more USB 4 support added to the thunderbolt core
	- build warning fixes all over the place
	- usb-serial driver updates and new device support
	- mtu3 driver updates
	- gadget driver updates
	- dwc3 driver updates
	- dwc2 driver updates
	- isp1760 host driver updates
	- musb driver updates
	- lots of other tiny things.

Full details are in the shortlog.

All of these have been in linux-next for a while now with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Srivastava (1):
      USB: gadget: udc: fix kernel-doc syntax in file headers

Alan Stern (7):
      USB: core: WARN if pipe direction != setup packet direction
      USB: core: Check buffer length matches wLength for control transfers
      USB: UDC core: Add udc_async_callbacks gadget op
      USB: UDC: Implement udc_async_callbacks in dummy-hcd
      USB: UDC: Implement udc_async_callbacks in net2280
      USB: UDC: Implement udc_async_callbacks in net2272
      USB: core: Avoid WARNings for 0-length descriptor requests

Andre Przywara (2):
      dt-bindings: usb: sunxi-musb: Add H616 compatible string
      dt-bindings: usb: Add H616 compatible string

Andrew Gabbasov (1):
      usb: gadget: f_fs: Fix setting of device and driver data cross-references

Andy Shevchenko (2):
      usb: typec: wcove: Fx wrong kernel doc format
      usb: phy: isp1301: Deduplicate of_find_i2c_device_by_node()

Aswath Govindraju (2):
      doc: dt-binding: cdns,usb3: Add interrupt-names property under required
      doc: dt-binding: cdns,usb3: Add interrupt-names property under required

Azhar Shaikh (2):
      usb: typec: intel_pmc_mux: Update IOM port status offset for AlderLake
      thunderbolt: Add support for Intel Alder Lake

Badhri Jagan Sridharan (5):
      usb: typec: tcpm: Fix up PR_SWAP when vsafe0v is signalled
      usb: typec: tcpm: Refactor logic to enable/disable auto vbus dicharge
      usb: typec: tcpm: Move TCPC to APPLY_RC state during PR_SWAP
      usb: typec: tcpci: Implement callback for apply_rc
      usb: typec: tcpci: Fix up sink disconnect thresholds for PD

Baokun Li (2):
      usb: gadget: function: printer: use list_move instead of list_del/list_add
      usb: cdns3: cdns3-gadget: Use list_move_tail instead of list_del/list_add_tail

Chris Chiu (2):
      USB: Verify the port status when timeout happens during port suspend
      Revert "USB: Add reset-resume quirk for WD19's Realtek Hub"

Chunfeng Yun (24):
      usb: dwc3: remove repeated setting of current_dr_role
      usb: xhci-mtk: use bitfield instead of bool
      usb: xhci-mtk: remove unnecessary setting of has_ippc
      usb: xhci-mtk: use first-fit for LS/FS
      usb: common: usb-conn-gpio: fix NULL pointer dereference of charger
      usb: common: usb-conn-gpio: use dev_err_probe() to print log
      usb: roles: add helper usb_role_string()
      usb: common: usb-conn-gpio: use usb_role_string() to print role status
      usb: mtu3: remove mtu3_ep0_setup() declaration in mtu3.h
      usb: mtu3: remove repeated setting of speed
      usb: mtu3: dump a status register of IPPC
      usb: mtu3: use dev_err_probe to print error log about extcon
      usb: mtu3: skip getting extcon when use manual drd switch
      usb: mtu3: power down device IP by default
      usb: mtu3: power down port when power down device IP
      usb: mtu3: remove wakelock
      usb: mtu3: drop support vbus detection
      usb: mtu3: use enum usb_role instead of private defined ones
      usb: mtu3: rebuild role switch flow of extcon
      usb: mtu3: add helper to get pointer of ssusb_mtk struct
      usb: mtu3: use force mode for dual role switch
      usb: mtu3: rebuild role switch get/set hooks
      usb: mtu3: use clock bulk to get clocks
      usb: xhci-mtk: allow multiple Start-Split in a microframe

Clément Lassieur (1):
      usb: dwc2: Don't reset the core after setting turnaround time

Colin Ian King (4):
      usb: host: u132-hcd: remove redundant continue statements
      USB: UDC: net2280: remove redundant continue statement
      xhci: remove redundant continue statement
      usb: ftdi-elan: remove redundant continue statement in a while-loop

Crag Wang (1):
      thunderbolt: Add self-authenticate support for new dock

Dmitry Osipenko (2):
      usb: phy: tegra: Wait for VBUS wakeup status deassertion on suspend
      usb: phy: tegra: Correct definition of B_SESS_VLD_WAKEUP_EN bit

Geert Uytterhoeven (1):
      dt-bindings: usb: cdns,usb3: Fix interrupts order

Geoffrey D. Bennett (1):
      USB: usbfs: remove double evaluation of usb_sndctrlpipe()

Gil Fine (2):
      thunderbolt: Poll 10ms for REG_FW_STS_NVM_AUTH_DONE to be set
      thunderbolt: Fix DROM handling for USB4 DROM

Gopalakrishnan Santhanam (1):
      fsl-usb: add need_oc_pp_cycle flag for 85xx also

Greg Kroah-Hartman (21):
      Merge 5.13-rc2 into usb-next
      USB: gadget: lpc32xx_udc: remove debugfs dentry variable
      USB: gadget: s3c2410_udc: remove dentry storage for debugfs file
      USB: gadget: pxa25x_udc: remove dentry storage for debugfs file
      USB: chipidea: remove dentry storage for debugfs file
      USB: gadget: bcm63xx_udc: remove dentry storage for debugfs file
      USB: gadget: pxa27x_udc: remove dentry storage for debugfs file
      USB: fotg210-hcd: remove dentry storage for debugfs file
      Merge 5.13-rc4 into usb-next
      USB: gr_udc: remove dentry storage for debugfs file
      USB: dwc3: remove debugfs root dentry storage
      Merge tag 'v5.13-rc6' into usb-next
      Merge tag 'for-5.14-usb' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into usb-next
      Revert "arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub"
      Revert "usb: host: xhci-plat: Create platform device for onboard hubs in probe()"
      Revert "of/platform: Add stubs for of_platform_device_create/destroy()"
      Revert "USB: misc: Add onboard_usb_hub driver"
      Merge tag 'v5.13-rc7' into usb-next
      Merge tag 'usb-v5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next
      Merge tag 'thunderbolt-for-v5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-5.14-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Grzegorz Jaszczyk (1):
      usb: phy: introduce usb_phy device type with its own uevent handler

Guenter Roeck (1):
      usb: gadget: Drop unnecessary NULL checks after container_of

Gustavo A. R. Silva (1):
      usb: gadget: s3c-hsudc: Use struct_size() in devm_kzalloc()

Hannu Hartikainen (1):
      USB: cdc-acm: blacklist Heimann USB Appset device

Heikki Krogerus (3):
      usb: typec: mux: Use device type instead of device name for matching
      usb: typec: mux: Remove requirement for the "orientation-switch" device property
      Revert "usb: typec: mux: Remove requirement for the "orientation-switch" device property"

Ikjoon Jang (1):
      usb: xhci-mtk: remove unnecessary assignments in periodic TT scheduler

Iskren Chernev (3):
      dt-bindings: usb: qcom,dwc3: Add bindings for sm6115/4250
      dt-bindings: phy: qcom,qusb2: document sm4250/6115 compatible
      phy: qcom-qusb2: Add configuration for SM4250 and SM6115

JC Kuo (9):
      phy: tegra: xusb: Move usb3 port init for Tegra210
      phy: tegra: xusb: Rearrange UPHY init on Tegra210
      phy: tegra: xusb: Add Tegra210 lane_iddq operation
      phy: tegra: xusb: Add sleepwalk and suspend/resume
      phy: tegra: xusb: Add wake/sleepwalk for Tegra210
      phy: tegra: xusb: Tegra210 host mode VBUS control
      phy: tegra: xusb: Add wake/sleepwalk for Tegra186
      usb: xhci: tegra: Unlink power domain devices
      usb: xhci: tegra: Enable ELPG for runtime/system PM

Jack Pham (1):
      usb: dwc3: debugfs: Add and remove endpoint dirs dynamically

Jason Wang (1):
      usb: ehci: do not initialise static variables

Jing Xiangfeng (1):
      usb: typec: Add the missed altmode_id_remove() in typec_register_altmode()

Jiri Slaby (2):
      USB: serial: make usb_serial_driver::write_room return uint
      USB: serial: make usb_serial_driver::chars_in_buffer return uint

Johan Hovold (9):
      USB: serial: digi_acceleport: reduce chars_in_buffer over-reporting
      USB: serial: digi_acceleport: add chars_in_buffer locking
      USB: serial: io_edgeport: drop buffer-callback sanity checks
      USB: serial: mos7720: drop buffer-callback sanity checks
      USB: serial: mos7840: drop buffer-callback return-value comments
      USB: serial: drop irq-flags initialisations
      USB: cdnsp: drop irq-flags initialisations
      USB: dwc2: drop irq-flags initialisations
      USB: gadget: drop irq-flags initialisations

Jon Hunter (2):
      usb: gadget: tegra-xudc: Don't print error on probe deferral
      usb: gadget: tegra-xudc: Use dev_err_probe()

Junlin Yang (1):
      usb: class: cdc-wdm: return the correct errno code

Kyle Tso (2):
      usb: typec: tcpm: Ignore Vsafe0v in PR_SWAP_SNK_SRC_SOURCE_ON state
      usb: typec: tcpm: Relax disconnect threshold during power negotiation

Lee Jones (21):
      usb: cdns3: core: Fix a couple of incorrectly documented function names
      usb: cdns3: cdns3-plat: Fix incorrect naming of function 'cdns3_plat_remove()'
      usb: cdns3: cdns3-gadget: Fix a bunch of kernel-doc related formatting issues
      usb: cdns3: cdns3-ti: File headers are not good candidates for kernel-doc
      usb: cdns3: cdns3-ep0: Fix a few kernel-doc formatting issues
      usb: cdns3: cdns3-imx: File headers are not good candidates for kernel-doc
      usb: chipidea: core: Fix incorrectly documented function 'ci_usb_phy_exit()'
      usb: chipidea: otg: Fix formatting and missing documentation issues
      usb: chipidea: udc: Fix incorrectly documented function 'hw_port_is_high_speed()'
      usb: cdns3: cdns3-gadget: Provide correct function naming for '__cdns3_gadget_ep_queue()'
      usb: cdns3: cdnsp-gadget: Provide function name for 'cdnsp_find_next_ext_cap()'
      usb: dwc2: platform: Provide function name for 'dwc2_check_core_version()'
      usb: common: ulpi: Add leading underscores for function name '__ulpi_register_driver()'
      usb: dwc2: params: Fix naming of 'dwc2_get_hwparams()' in the docs
      usb: isp1760: isp1760-udc: Provide missing description for 'udc' param
      usb: dwc2: hcd_queue: Fix typeo in function name 'dwc2_hs_pmap_unschedule()'
      usb: dwc2: pci: Fix possible copy/paste issue
      usb: dwc2: gadget: Repair 'dwc2_hsotg_core_init_disconnected()'s documentation
      usb: typec: ucsi: Fix copy/paste issue for 'ucsi_set_drvdata()'
      usb: gadget: udc: pxa27x_udc: Fix documentation for 'pxa27x_udc_start()'
      usb: gadget: udc: udc-xilinx: Place correct function names into the headers

Li Jun (1):
      usb: core: hcd: use map_urb_for_dma for single step set feature urb

Li Yang (1):
      usb: gadget: fsl: properly remove remnant of MXC support

Linyu Yuan (1):
      usb: gadget: eem: fix echo command packet response issue

Mathias Nyman (3):
      xhci: Remove unused defines for ERST_SIZE and ERST_ENTRIES
      xhci: Add adaptive interrupt rate for isoch TRBs with XHCI_AVOID_BEI quirk
      xhci: handle failed buffer copy to URB sg list and fix a W=1 copiler warning

Matthias Kaehlcke (5):
      dt-bindings: usb: Add binding for Realtek RTS5411 hub controller
      USB: misc: Add onboard_usb_hub driver
      of/platform: Add stubs for of_platform_device_create/destroy()
      usb: host: xhci-plat: Create platform device for onboard hubs in probe()
      arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub

Mayank Rana (1):
      usb: dwc3: trace: Remove unused fields in dwc3_log_trb

Mika Westerberg (20):
      thunderbolt: Split NVM read/write generic functions out from usb4.c
      thunderbolt: Use generic tb_nvm_[read|write]_data() for Thunderbolt 2/3 devices
      Documentation / thunderbolt: Clean up entries
      thunderbolt: Add wake from DisplayPort
      thunderbolt: Align USB4 router wakes configuration with the CM guide
      thunderbolt: Make tb_port_type() take const parameter
      thunderbolt: Move nfc_credits field to struct tb_path_hop
      thunderbolt: Wait for the lanes to actually bond
      thunderbolt: Read router preferred credit allocation information
      thunderbolt: Update port credits after bonding is enabled/disabled
      thunderbolt: Allocate credits according to router preferences
      thunderbolt: Add quirk for Intel Goshen Ridge DP credits
      thunderbolt: Add KUnit tests for credit allocation
      thunderbolt: Log the link as TBT instead of TBT3
      thunderbolt: Add USB4 port devices
      thunderbolt: Allow router NVM authenticate separately
      thunderbolt: Check for NVM authentication status after the operation started
      thunderbolt: Bond lanes only when dual_link_port != NULL in alloc_dev_default()
      thunderbolt: Add device links only when software connection manager is used
      thunderbolt: No need to include <linux/acpi.h> in usb4_port.c

Minas Harutyunyan (1):
      usb: dwc3: Fix debugfs creation flow

Moritz Fischer (2):
      usb: renesas-xhci: Replace BIT(15) with macro
      usb: renesas-xhci: Fix handling of unknown ROM state

Pawel Laszczak (1):
      usb: cdnsp: Useless condition has been removed

Peter Chen (2):
      usb: host: move EH SINGLE_STEP_SET_FEATURE implementation to core
      usb: dwc3: core: fix kernel panic when do reboot

Pho Tran (1):
      USB: serial: cp210x: add support for GPIOs on CP2108

Rajat Jain (2):
      driver core: Move the "removable" attribute from USB to core
      PCI: Add sysfs "removable" attribute

Rajmohan Mani (5):
      thunderbolt: Add support for ACPI _DSM to power on/off retimers
      thunderbolt: Add additional USB4 port operations for retimer access
      thunderbolt: Add support for retimer NVM upgrade when there is no link
      thunderbolt: Move nvm_write_ops to tb.h
      thunderbolt: Add WRITE_ONLY and AUTHENTICATE_ONLY NVM operations for retimers

Randy Dunlap (1):
      usb: gadget: fsl_qe_udc: fix implicit-fallthrough warnings

Raymond Tan (1):
      usb: dwc3: pci: Fix DEFINE for Intel Elkhart Lake

Rikard Falkeborn (1):
      usb: gadget: tegra-xudc: Constify static structs

Rui Miguel Silva (9):
      usb: isp1760: fix strict typechecking
      usb: isp1760: move to regmap for register access
      usb: isp1760: use relaxed primitives
      usb: isp1760: remove platform data struct and code
      usb: isp1760: hcd: refactor mempool config and setup
      usb: isp1760: use dr_mode binding
      usb: isp1760: add support for isp1763
      dt-bindings: usb: nxp,isp1760: add bindings
      usb: isp1763: add peripheral mode

Ruslan Bilovol (4):
      usb: gadget: f_uac2/u_audio: add feedback endpoint support
      usb: gadget: f_uac2: add adaptive sync support for capture
      usb: gadget: u_audio: add real feedback implementation
      usb: gadget: f_hid: fix endianness issue with descriptors

Saurav Girepunje (4):
      usb: musb: Fix spelling mistake "tranfer" -> "transfer"
      usb: musb: Remove duplicate declaration of functions
      usb: musb: Remove unused local variable dma, urb, offset
      usb: musb: Remove unused function argument dma, qh, offset, length

Souptick Joarder (1):
      usb: cdns3: Corrected comment to align with kernel-doc comment

Subbaraman Narayanamurthy (1):
      usb: typec: ucsi: Fix a comment in ucsi_init()

Sven Peter (1):
      usb: dwc3: support 64 bit DMA in platform driver

Thierry Reding (1):
      Merge branch 'for-5.14/phy' into for-5.14/usb

Tobias Schramm (1):
      dt-bindings: usb: dwc2: add compatible for RK3308 USB controller

Tong Tiangen (1):
      usb: isp1760: Fix meaningless check in isp1763_run()

Tony Lindgren (4):
      usb: musb: Add missing PM suspend and resume functions for 2430 glue
      usb: musb: Check devctl status again for a spurious session request
      usb: musb: Simplify cable state handling
      usb: musb: Implement tracing for state change events

Wei Ming Chen (3):
      usb: gadget: function: fix typo in f_hid.c
      usb: gadget: function: Fix inconsistent indent
      usb: phy: Use fallthrough pseudo-keyword

Wei Yongjun (1):
      usb: typec: tcpci: Make symbol 'tcpci_apply_rc' static

Yang Yingliang (5):
      USB: gadget: udc: s3c2410_udc: s3c2410_udc_set_ep0_ss() can be static
      usb: host: xhci-tegra: add missing put_device() in tegra_xusb_probe()
      usb: host: xhci-tegra: Add missing of_node_put() in tegra_xusb_probe()
      usb: host: xhci-tegra: Use devm_platform_get_and_ioremap_resource()
      usb: gadget: hid: fix error return code in hid_bind()

Zhangjiantao (Kirin, nanjing) (1):
      xhci: solve a double free problem while doing s4

Zhen Lei (1):
      usb: fix spelling mistakes in header files

zuoqilin (1):
      usb: atm: cxacru: Fix typo in comment

 Documentation/ABI/testing/configfs-usb-gadget-uac2 |    2 +
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   82 +-
 Documentation/ABI/testing/sysfs-bus-usb            |   11 -
 Documentation/ABI/testing/sysfs-devices-removable  |   18 +
 Documentation/admin-guide/thunderbolt.rst          |   29 +
 .../bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   |    4 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    2 +
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     |    3 +
 .../devicetree/bindings/usb/cdns,usb3.yaml         |    3 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |    1 +
 .../devicetree/bindings/usb/nxp,isp1760.yaml       |   69 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    2 +
 .../devicetree/bindings/usb/realtek,rts5411.yaml   |   62 +
 Documentation/driver-api/usb/error-codes.rst       |    3 +
 Documentation/usb/gadget-testing.rst               |    2 +
 arch/arm/boot/dts/arm-realview-eb.dtsi             |    2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts          |    2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |    2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi            |    2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |    2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |    2 +-
 drivers/base/core.c                                |   28 +
 drivers/pci/probe.c                                |   22 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   34 +
 drivers/phy/tegra/xusb-tegra186.c                  |  550 +++++-
 drivers/phy/tegra/xusb-tegra210.c                  | 1877 +++++++++++++++-----
 drivers/phy/tegra/xusb.c                           |   92 +-
 drivers/phy/tegra/xusb.h                           |   22 +-
 drivers/thunderbolt/Makefile                       |    2 +-
 drivers/thunderbolt/acpi.c                         |  206 +++
 drivers/thunderbolt/dma_port.c                     |   94 +-
 drivers/thunderbolt/domain.c                       |    9 +-
 drivers/thunderbolt/eeprom.c                       |   19 +-
 drivers/thunderbolt/icm.c                          |   20 +-
 drivers/thunderbolt/lc.c                           |    6 +-
 drivers/thunderbolt/nhi.c                          |   71 +-
 drivers/thunderbolt/nhi.h                          |    2 +
 drivers/thunderbolt/nvm.c                          |   95 +
 drivers/thunderbolt/path.c                         |    4 +-
 drivers/thunderbolt/quirks.c                       |   30 +-
 drivers/thunderbolt/retimer.c                      |  108 +-
 drivers/thunderbolt/sb_regs.h                      |    2 +
 drivers/thunderbolt/switch.c                       |  274 ++-
 drivers/thunderbolt/tb.c                           |   71 +-
 drivers/thunderbolt/tb.h                           |  116 +-
 drivers/thunderbolt/tb_regs.h                      |    4 +
 drivers/thunderbolt/test.c                         |  559 +++++-
 drivers/thunderbolt/tunnel.c                       |  401 ++++-
 drivers/thunderbolt/tunnel.h                       |    2 +
 drivers/thunderbolt/usb4.c                         |  438 +++--
 drivers/thunderbolt/usb4_port.c                    |  280 +++
 drivers/thunderbolt/xdomain.c                      |   10 +
 drivers/usb/atm/cxacru.c                           |    2 +-
 drivers/usb/cdns3/cdns3-ep0.c                      |    6 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   40 +-
 drivers/usb/cdns3/cdns3-imx.c                      |    2 +-
 drivers/usb/cdns3/cdns3-plat.c                     |    2 +-
 drivers/usb/cdns3/cdns3-ti.c                       |    2 +-
 drivers/usb/cdns3/cdnsp-gadget.c                   |    7 +-
 drivers/usb/cdns3/cdnsp-mem.c                      |    5 +-
 drivers/usb/cdns3/core.c                           |    4 +-
 drivers/usb/chipidea/ci.h                          |    2 -
 drivers/usb/chipidea/core.c                        |    2 +-
 drivers/usb/chipidea/debug.c                       |   34 +-
 drivers/usb/chipidea/otg.c                         |    9 +-
 drivers/usb/chipidea/udc.c                         |    2 +-
 drivers/usb/class/cdc-acm.c                        |    5 +
 drivers/usb/class/cdc-wdm.c                        |    5 +-
 drivers/usb/common/ulpi.c                          |    2 +-
 drivers/usb/common/usb-conn-gpio.c                 |   62 +-
 drivers/usb/core/devio.c                           |    2 +-
 drivers/usb/core/hcd.c                             |  130 ++
 drivers/usb/core/hub.c                             |   34 +-
 drivers/usb/core/message.c                         |    6 +
 drivers/usb/core/quirks.c                          |    1 -
 drivers/usb/core/sysfs.c                           |   24 -
 drivers/usb/core/urb.c                             |    9 +
 drivers/usb/dwc2/core.c                            |   30 +-
 drivers/usb/dwc2/gadget.c                          |   14 +-
 drivers/usb/dwc2/hcd_queue.c                       |    2 +-
 drivers/usb/dwc2/params.c                          |    4 +-
 drivers/usb/dwc2/pci.c                             |    2 +-
 drivers/usb/dwc2/platform.c                        |    2 +-
 drivers/usb/dwc3/core.c                            |    7 +-
 drivers/usb/dwc3/core.h                            |    2 -
 drivers/usb/dwc3/debugfs.c                         |    8 +-
 drivers/usb/dwc3/drd.c                             |    1 -
 drivers/usb/dwc3/dwc3-pci.c                        |    8 +-
 drivers/usb/dwc3/gadget.c                          |    4 +-
 drivers/usb/dwc3/trace.h                           |    2 -
 drivers/usb/gadget/function/f_eem.c                |   43 +-
 drivers/usb/gadget/function/f_fs.c                 |   65 +-
 drivers/usb/gadget/function/f_hid.c                |    4 +-
 drivers/usb/gadget/function/f_printer.c            |    3 +-
 drivers/usb/gadget/function/f_uac2.c               |  144 +-
 drivers/usb/gadget/function/u_audio.c              |  225 ++-
 drivers/usb/gadget/function/u_audio.h              |   12 +
 drivers/usb/gadget/function/u_hid.h                |    4 +-
 drivers/usb/gadget/function/u_midi.h               |    4 +-
 drivers/usb/gadget/function/u_uac2.h               |    4 +
 drivers/usb/gadget/function/uvc_configfs.c         |    5 -
 drivers/usb/gadget/legacy/hid.c                    |    4 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |    7 +-
 drivers/usb/gadget/udc/core.c                      |   49 +
 drivers/usb/gadget/udc/dummy_hcd.c                 |   11 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |    5 +
 drivers/usb/gadget/udc/fsl_udc_core.c              |   44 +-
 drivers/usb/gadget/udc/fsl_usb2_udc.h              |   19 -
 drivers/usb/gadget/udc/gr_udc.c                    |    7 +-
 drivers/usb/gadget/udc/gr_udc.h                    |    2 -
 drivers/usb/gadget/udc/lpc32xx_udc.c               |    5 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |    2 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |    2 +-
 drivers/usb/gadget/udc/net2272.c                   |   41 +-
 drivers/usb/gadget/udc/net2272.h                   |    1 +
 drivers/usb/gadget/udc/net2280.c                   |   51 +-
 drivers/usb/gadget/udc/net2280.h                   |    1 +
 drivers/usb/gadget/udc/pxa25x_udc.c                |    4 +-
 drivers/usb/gadget/udc/pxa25x_udc.h                |    4 -
 drivers/usb/gadget/udc/pxa27x_udc.c                |    6 +-
 drivers/usb/gadget/udc/pxa27x_udc.h                |    4 -
 drivers/usb/gadget/udc/s3c-hsudc.c                 |    5 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |    9 +-
 drivers/usb/gadget/udc/s3c2410_udc.h               |    1 -
 drivers/usb/gadget/udc/tegra-xudc.c                |   30 +-
 drivers/usb/gadget/udc/trace.c                     |    2 +-
 drivers/usb/gadget/udc/trace.h                     |    2 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |    4 +-
 drivers/usb/host/ehci-fsl.c                        |    8 +-
 drivers/usb/host/ehci-hcd.c                        |    8 +-
 drivers/usb/host/ehci-hub.c                        |  139 --
 drivers/usb/host/ehci-q.c                          |    2 +-
 drivers/usb/host/fotg210-hcd.c                     |    5 +-
 drivers/usb/host/fotg210.h                         |    3 -
 drivers/usb/host/u132-hcd.c                        |    6 +-
 drivers/usb/host/xhci-mem.c                        |    3 +
 drivers/usb/host/xhci-mtk-sch.c                    |   60 +-
 drivers/usb/host/xhci-mtk.c                        |    2 -
 drivers/usb/host/xhci-mtk.h                        |   10 +-
 drivers/usb/host/xhci-pci-renesas.c                |   18 +-
 drivers/usb/host/xhci-ring.c                       |    7 +-
 drivers/usb/host/xhci-tegra.c                      |  621 +++++--
 drivers/usb/host/xhci.c                            |   10 +-
 drivers/usb/host/xhci.h                            |   11 +-
 drivers/usb/isp1760/Kconfig                        |    5 +-
 drivers/usb/isp1760/isp1760-core.c                 |  513 +++++-
 drivers/usb/isp1760/isp1760-core.h                 |   44 +-
 drivers/usb/isp1760/isp1760-hcd.c                  | 1020 +++++++----
 drivers/usb/isp1760/isp1760-hcd.h                  |   57 +-
 drivers/usb/isp1760/isp1760-if.c                   |   41 +-
 drivers/usb/isp1760/isp1760-regs.h                 |  435 +++--
 drivers/usb/isp1760/isp1760-udc.c                  |  251 ++-
 drivers/usb/isp1760/isp1760-udc.h                  |   13 +-
 drivers/usb/misc/ftdi-elan.c                       |    1 -
 drivers/usb/mtu3/mtu3.h                            |   30 +-
 drivers/usb/mtu3/mtu3_core.c                       |   20 +-
 drivers/usb/mtu3/mtu3_debugfs.c                    |    1 +
 drivers/usb/mtu3/mtu3_dr.c                         |  169 +-
 drivers/usb/mtu3/mtu3_gadget.c                     |    2 +-
 drivers/usb/mtu3/mtu3_host.c                       |    6 +-
 drivers/usb/mtu3/mtu3_plat.c                       |   95 +-
 drivers/usb/musb/musb_core.c                       |   71 +-
 drivers/usb/musb/musb_gadget.c                     |    2 +-
 drivers/usb/musb/musb_host.c                       |   18 +-
 drivers/usb/musb/musb_host.h                       |    4 -
 drivers/usb/musb/musb_trace.h                      |   17 +
 drivers/usb/musb/omap2430.c                        |   32 +
 drivers/usb/phy/phy-isp1301-omap.c                 |    2 +-
 drivers/usb/phy/phy-isp1301.c                      |   25 +-
 drivers/usb/phy/phy-tegra-usb.c                    |   15 +-
 drivers/usb/phy/phy.c                              |   55 +-
 drivers/usb/roles/class.c                          |    9 +
 drivers/usb/serial/cp210x.c                        |  189 +-
 drivers/usb/serial/cyberjack.c                     |    4 +-
 drivers/usb/serial/cypress_m8.c                    |   16 +-
 drivers/usb/serial/digi_acceleport.c               |   46 +-
 drivers/usb/serial/garmin_gps.c                    |    2 +-
 drivers/usb/serial/generic.c                       |   12 +-
 drivers/usb/serial/io_edgeport.c                   |   39 +-
 drivers/usb/serial/io_ti.c                         |   12 +-
 drivers/usb/serial/ir-usb.c                        |    6 +-
 drivers/usb/serial/keyspan.c                       |    4 +-
 drivers/usb/serial/kobil_sct.c                     |    4 +-
 drivers/usb/serial/metro-usb.c                     |   12 +-
 drivers/usb/serial/mos7720.c                       |   29 +-
 drivers/usb/serial/mos7840.c                       |   17 +-
 drivers/usb/serial/opticon.c                       |    6 +-
 drivers/usb/serial/oti6858.c                       |   12 +-
 drivers/usb/serial/quatech2.c                      |    6 +-
 drivers/usb/serial/sierra.c                        |    8 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   16 +-
 drivers/usb/serial/usb-wwan.h                      |    4 +-
 drivers/usb/serial/usb_wwan.c                      |   12 +-
 drivers/usb/typec/class.c                          |    4 +-
 drivers/usb/typec/mux.c                            |   39 +-
 drivers/usb/typec/mux.h                            |    6 +
 drivers/usb/typec/mux/intel_pmc_mux.c              |   28 +-
 drivers/usb/typec/tcpm/tcpci.c                     |   46 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   86 +-
 drivers/usb/typec/tcpm/wcove.c                     |    2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |    4 +-
 include/linux/device.h                             |   37 +
 include/linux/phy/tegra/xusb.h                     |   10 +-
 include/linux/usb.h                                |    9 +-
 include/linux/usb/composite.h                      |    2 +-
 include/linux/usb/gadget.h                         |    3 +-
 include/linux/usb/hcd.h                            |   17 +-
 include/linux/usb/isp1760.h                        |   19 -
 include/linux/usb/otg-fsm.h                        |    6 +-
 include/linux/usb/otg.h                            |    2 +-
 include/linux/usb/quirks.h                         |    2 +-
 include/linux/usb/role.h                           |    6 +
 include/linux/usb/serial.h                         |   10 +-
 include/linux/usb/tcpm.h                           |    4 +
 include/linux/usb/typec_dp.h                       |    2 +-
 215 files changed, 8849 insertions(+), 2890 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-removable
 create mode 100644 Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
 create mode 100644 drivers/thunderbolt/usb4_port.c
 delete mode 100644 include/linux/usb/isp1760.h
