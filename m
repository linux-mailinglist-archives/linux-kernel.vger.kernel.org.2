Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5836B3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhDZM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhDZM7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:59:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDFFC61103;
        Mon, 26 Apr 2021 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619441949;
        bh=AxiIKLhKCFcR/W3cfDJ4JmRE4ZJVPeiYlG347s43tpc=;
        h=Date:From:To:Cc:Subject:From;
        b=CpYijX9v0u56dBkQsiYfH3nkV9kWcuPr33HRdZjveLvmhrvPgYNwqqXcvK/URo5hR
         vQ0iMERSAogvAanW6Ibq9+hnZeLRsWgL2RZQa7Pwt+wDnMYg8rFKOtlQ60/pQmaTXo
         PBFmOa5Px77tXJ5JSBcgIiDOytaNaVxzP0QJehcc=
Date:   Mon, 26 Apr 2021 14:59:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver updates for 5.13-rc1
Message-ID: <YIa5GtU/7FpKPUAN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc1

for you to fetch changes up to caa93d9bd2d7ca7ffe5a23df9f003b81721c8e1b:

  usb: Fix up movement of USB core kerneldoc location (2021-04-24 16:01:09 +0200)

----------------------------------------------------------------
USB/Thunderbolt patches for 5.13-rc1

Here is the big set of USB and Thunderbolt driver updates for 5.13-rc1.

Lots of little things in here, with loads of tiny fixes and cleanups
over these drivers, as well as these "larger" changes:
	- thunderbolt updates and new features added
	- xhci driver updates and split out of a mediatek-specific xhci
	  driver from the main xhci module to make it easier to work
	  with (something that I have been wanting for a while).
	- loads of typec feature additions and updates
	- dwc2 driver updates
	- dwc3 driver updates
	- gadget driver fixes and minor updates
	- loads of usb-serial cleanups and fixes and updates
	- usbip documentation updates and fixes
	- lots of other tiny USB driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Srivastava (4):
      usb: dwc3: imx8mp: fix incorrect kernel-doc comment syntax
      usb: dwc3: st: fix incorrect kernel-doc comment syntax in file
      usb: dwc3: fix incorrect kernel-doc comment syntax in files
      usb: dwc3: exynos: fix incorrect kernel-doc comment syntax

Anant Thazhemadam (3):
      usb: misc: ehset: update to use the usb_control_msg_{send|recv}() API
      usb: misc: ezusb: update to use usb_control_msg_send()
      usb: misc: usbsevseg: update to use usb_control_msg_send()

Andy Shevchenko (11):
      usb: gadget: pch_udc: Replace cpu_to_le32() by lower_32_bits()
      usb: gadget: pch_udc: Check if driver is present before calling ->setup()
      usb: gadget: pch_udc: Check for DMA mapping error
      usb: gadget: pch_udc: Move pch_udc_init() to satisfy kernel doc
      usb: gadget: pch_udc: Revert d3cb25a12138 completely
      usb: gadget: pch_udc: Initialize device pointer before use
      usb: gadget: pch_udc: Provide a GPIO line used on Intel Minnowboard (v1)
      usb: gadget: pch_udc: switch over to usb_gadget_map/unmap_request()
      usb: gadget: pch_udc: Remove CONFIG_PM_SLEEP ifdefery
      usb: gadget: pch_udc: Use PCI sub IDs instead of DMI
      usb: gadget: pch_udc: Convert Intel Quark quirk to use driver data

Anirudh Rayabharam (1):
      usb: gadget: dummy_hcd: fix gpf in gadget_setup

Arnd Bergmann (1):
      usb: sl811-hcd: improve misleading indentation

Artur Petrosyan (41):
      usb: dwc2: Add device partial power down functions
      usb: dwc2: Add host partial power down functions
      usb: dwc2: Update enter and exit partial power down functions
      usb: dwc2: Add partial power down exit flow in wakeup intr.
      usb: dwc2: Update port suspend/resume function definitions.
      usb: dwc2: Add enter partial power down when port is suspended
      usb: dwc2: Add exit partial power down when port is resumed
      usb: dwc2: Add exit partial power down when port reset is asserted
      usb: dwc2: Add part. power down exit from dwc2_conn_id_status_change().
      usb: dwc2: Allow exit partial power down in urb enqueue
      usb: dwc2: Fix session request interrupt handler
      usb: dwc2: Update partial power down entering by system suspend
      usb: dwc2: Fix partial power down exiting by system resume
      usb: dwc2: Add exit partial power down before removing driver
      usb: dwc2: Add device clock gating support functions
      usb: dwc2: Add host clock gating support functions
      usb: dwc2: Allow entering clock gating from USB_SUSPEND interrupt
      usb: dwc2: Add exit clock gating from wakeup interrupt
      usb: dwc2: Add exit clock gating from session request interrupt
      usb: dwc2: Add exit clock gating when port reset is asserted
      usb: dwc2: Update enter clock gating when port is suspended
      usb: dwc2: Update exit clock gating when port is resumed
      usb: dwc2: Allow exit clock gating in urb enqueue
      usb: dwc2: Add clock gating entering flow by system suspend
      usb: dwc2: Add clock gating exiting flow by system resume
      usb: dwc2: Add exit clock gating before removing driver
      usb: dwc2: Update exit hibernation when port reset is asserted
      usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
      usb: dwc2: Fix host mode hibernation exit with remote wakeup flow.
      usb: dwc2: Fix hibernation between host and device modes.
      usb: dwc2: Allow exiting hibernation from gpwrdn rst detect
      usb: dwc2: Clear fifo_map when resetting core.
      usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generated.
      usb: dwc2: Move enter hibernation to dwc2_port_suspend() function
      usb: dwc2: Move exit hibernation to dwc2_port_resume() function
      usb: dwc2: Allow exit hibernation in urb enqueue
      usb: dwc2: Add hibernation entering flow by system suspend
      usb: dwc2: Add hibernation exiting flow by system resume
      usb: dwc2: Add exit hibernation mode before removing drive
      usb: dwc2: Update dwc2_handle_usb_suspend_intr function.
      usb: dwc2: Get rid of useless error checks in suspend interrupt

Badhri Jagan Sridharan (12):
      usb: typec: tcpm: Wait for vbus discharge to VSAFE0V before toggling
      usb: typec: tcpci: Check ROLE_CONTROL while interpreting CC_STATUS
      usb: typec: tcpci: Refactor tcpc_presenting_cc1_rd macro
      usb: typec: tcpci: Added few missing TCPCI register definitions
      usb: typec: tcpm: PD3.0 sinks can send Discover Identity even in device mode
      usb: typec: tcpm: Address incorrect values of tcpm psy for fixed supply
      usb: typec: tcpm: Address incorrect values of tcpm psy for pps supply
      usb: typec: tcpm: update power supply once partner accepts
      usb: typec: tcpm: Honour pSnkStdby requirement during negotiation
      usb: typec: tcpm: Allow slow charging loops to comply to pSnkStby
      usb: typec: tcpm: Fix error while calculating PPS out values
      dt-bindings: connector: Add slow-charger-loop definition

Bhaskar Chowdhury (2):
      usb: host: Mundane spello fix in the file sl811_cs.c
      usb: typec: Fix a typo

Bixuan Cui (3):
      usb: musb: fix PM reference leak in musb_irq_work()
      usb: core: hub: Fix PM reference leak in usb_port_resume()
      usb: dwc3: qcom: Remove redundant dev_err call in dwc3_qcom_probe()

Chen Lin (1):
      usb: gadget: storage: Remove unused function pointer typedef fsg_routine_t

Chris Chiu (1):
      USB: Add reset-resume quirk for WD19's Realtek Hub

Christophe JAILLET (2):
      usb: gadget: s3c: Fix incorrect resources releasing
      usb: gadget: s3c: Fix the error handling path in 's3c2410_udc_probe()'

Chunfeng Yun (42):
      usb: xhci-mtk: remove or operator for setting schedule parameters
      usb: xhci-mtk: improve bandwidth scheduling with TT
      usb: xhci-mtk: get the microframe boundary for ESIT
      usb: xhci-mtk: add only one extra CS for FS/LS INTR
      usb: xhci-mtk: use @sch_tt to check whether need do TT schedule
      usb: xhci-mtk: add a function to (un)load bandwidth info
      usb: xhci-mtk: add a function to get bandwidth boundary
      usb: xhci-mtk: remove unnecessary members of mu3h_sch_tt struct
      usb: xhci-mtk: use clear type instead of void
      usb: xhci-mtk: add a member @speed in mu3h_sch_ep_info struct
      usb: xhci-mtk: use @tt_info to check the FS/LS device is under a HS hub
      usb: xhci-mtk: rebuild the way to get bandwidth domain
      usb: xhci-mtk: add some schedule error number
      usb: xhci-mtk: remove declaration of xhci_mtk_setup()
      usb: xhci-mtk: support to build xhci-mtk-hcd.ko
      usb: common: add function to get interval expressed in us unit
      usb: xhci-mtk: print debug info of endpoint interval
      usb: common: move function's kerneldoc next to its definition
      dt-bindings: usb: fix yamllint check warning
      usb: xhci-mtk: support ip-sleep wakeup for MT8183
      usb: xhci-mtk: add support ip-sleep wakeup for mT8192
      usb: mtu3: support ip-sleep wakeup for MT8183
      usb: mtu3: add support ip-sleep wakeup for MT8192
      usb: mtu3: drop CONFIG_OF
      dt-bindings: usb: mtk-xhci: add support wakeup for mt8183 and mt8192
      dt-bindings: usb: mtu3: support wakeup for mt8183 and mt8192
      usb: xhci-mtk: drop CONFIG_OF
      usb: xhci-mtk: remove MODULE_ALIAS
      arm64: dts: mt8183: update wakeup register offset
      usb: xhci-mtk: fix wrong remainder of bandwidth budget
      usb: xhci-mtk: fix oops when unbind driver
      dt-bindings: usb: mtk-xhci: support property usb2-lpm-disable
      dt-bindings: usb: mtk-xhci: remove redefinitions of usb3-lpm-capable
      usb: xhci-mtk: fix broken streams issue on 0.96 xHCI
      usb: xhci-mtk: support quirk to disable usb2 lpm
      usb: core: reduce power-on-good delay time of root hub
      usb: xhci-mtk: check return value in suspend/resume hooks
      dt-bindings: usb: mtk-xhci: add wakeup interrupt
      usb: xhci-mtk: add support runtime PM
      usb: xhci-mtk: use clock bulk to get clocks
      usb: xhci-mtk: remove unused members
      usb: xhci-mtk: remove bus status check

Colin Ian King (8):
      USB: gadget: dummy-hcd: remove redundant initialization of variable 'value'
      usb: dwc3: Fix dereferencing of null dwc->usb_psy
      usb: mtu3: Fix spelling mistake "disabed" -> "disabled"
      USB: serial: iuu_phoenix: remove redundant variable 'error'
      usb: gadget: r8a66597: Add missing null check on return from platform_get_resource
      usb: cdnsp: remove redundant initialization of variable ret
      usb: storage: datafab: remove redundant assignment of variable result
      usb: gadget: net2272: remove redundant initialization of status

Dan Carpenter (3):
      thunderbolt: Unlock on error path in tb_domain_add()
      usb: typec: silence a static checker warning
      usb: gadget: prevent a ternary sign expansion bug

Dean Anderson (1):
      usb: gadget/function/f_fs string table fix for multiple languages

Dmitry Osipenko (3):
      ARM: multi_v7_defconfig: Stop using deprecated USB_EHCI_TEGRA
      usb: host: ehci-tegra: Select USB_GADGET Kconfig option
      usb: chipidea: tegra: Silence deferred probe error

Fabian Vogt (7):
      fotg210-udc: Fix DMA on EP0 for length > max packet size
      fotg210-udc: Fix EP0 IN requests bigger than two packets
      fotg210-udc: Remove a dubious condition leading to fotg210_done
      fotg210-udc: Mask GRP2 interrupts we don't handle
      fotg210-udc: Call usb_gadget_udc_reset
      fotg210-udc: Don't DMA more than the buffer can take
      fotg210-udc: Complete OUT requests on short packets

Fabio Estevam (2):
      usb: usb-mx2: Remove unused file
      usb: Fix up movement of USB core kerneldoc location

Florian Fainelli (1):
      usb: ehci: add spurious flag to disable overcurrent checking

Frank Li (3):
      usb: cdns3: add power lost support for system resume
      usb: cdns3: imx: add power lost support for system resume
      usb: cdns3: fix static checker warning.

Gil Fine (3):
      thunderbolt: debugfs: Handle fail reading block
      thunderbolt: Drop unused functions tb_switch_is_[ice|tiger]_lake()
      thunderbolt: debugfs: Show all accessible dwords

Greg Kroah-Hartman (16):
      USB: core: no need to save usb_devices_root
      USB: host: isp116x: remove dentry pointer for debugfs
      USB: host: isp1362: remove dentry pointer for debugfs
      USB: host: sl811: remove dentry pointer for debugfs
      USB: host: uhci: remove dentry pointer for debugfs
      USB: typec: fusb302: create debugfs subdir for the driver
      USB: typec: tcpm: create debugfs subdir for the driver
      USB: remove usb_bus_type from usb.h
      Merge 5.12-rc3 into usb-next
      Merge 5.12-rc4 into usb-next
      Merge 5.12-rc6 into usb-next
      Merge 5.12-rc7 into usb-next
      Revert "usb: Link the ports to the connectors they are attached to"
      Merge tag 'usb-v5.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next
      Merge tag 'thunderbolt-for-v5.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-5.13-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Guido Günther (4):
      usb: typec: tps6598x: Add trace event for IRQ events
      usb: typec: tps6598x: Add trace event for status register
      usb: typec: tps6598x: Add trace event for power status register
      usb: typec: tps6598x: Add trace event for data status

Hans de Goede (4):
      usb: roles: Call try_module_get() from usb_role_switch_find_by_fwnode()
      usb: typec: Add typec_port_register_altmodes()
      usb: typec: tcpm: Add support for altmodes
      platform/x86/intel_cht_int33fe: Add displayport altmode fwnode to the connector fwnode

He Fengqing (1):
      drivers: usb: Fix a typo in dwc3-qcom.c

Heikki Krogerus (10):
      usb: typec: tps6598x: Fix tracepoint header file
      usb: typec: tps6598x: Move the driver under its own subdirectory
      usb: typec: tipd: Separate file for tracepoint creation
      usb: typec: Organize the private headers properly
      usb: typec: Declare the typec_class static
      usb: typec: Port mapping utility
      usb: Link the ports to the connectors they are attached to
      usb: Iterator for ports
      usb: typec: Link all ports during connector registration
      usb: dwc3: pci: add support for the Intel Alder Lake-M

Hemant Kumar (1):
      usb: gadget: Fix double free of device descriptor pointers

Hongren Zheng (Zenithal) (3):
      usbip: tools: add options and examples in man page related to device mode
      usbip: tools: add usage of device mode in usbip_list.c
      docs: usbip: Fix major fields and descriptions in protocol

Jeremy Linton (1):
      usb: dwc2: Enable RPi in ACPI mode

Jia-Ju Bai (3):
      usb: renesas_usbhs: fix error return code of usbhsf_pkt_handler()
      usb: gadget: legacy: fix error return code of multi_bind()
      usb: gadget: legacy: fix error return code of msg_bind()

Jiri Slaby (2):
      USB: serial: keyspan: drop unneeded forward declarations
      USB: serial: io_edgeport: drop unneeded forward declarations

Johan Hovold (74):
      USB: serial: pl2303: clean up type detection
      USB: serial: pl2303: amend and tighten type detection
      USB: serial: pl2303: rename legacy PL2303H type
      USB: serial: pl2303: tighten type HXN (G) detection
      USB: serial: pl2303: add device-type names
      USB: ehci: drop workaround for forced irq threading
      USB: core: drop outdated interface-binding comment
      USB: core: rename usb_driver_claim_interface() data parameter
      USB: xhci: drop workaround for forced irq threading
      USB: serial: xr: fix CSIZE handling
      USB: serial: drop unused suspending flag
      USB: serial: refactor endpoint classification
      USB: serial: add support for multi-interface functions
      USB: serial: xr: claim both interfaces
      USB: serial: ark3116: fix TIOCGSERIAL implementation
      USB: serial: f81232: fix TIOCGSERIAL implementation
      USB: serial: f81534: fix TIOCGSERIAL implementation
      USB: serial: ftdi_sio: fix TIOCGSERIAL implementation
      USB: serial: io_edgeport: fix TIOCGSERIAL implementation
      USB: serial: io_ti: fix TIOCGSERIAL implementation
      USB: serial: mos7720: fix TIOCGSERIAL implementation
      USB: serial: mos7840: fix TIOCGSERIAL implementation
      USB: serial: opticon: fix TIOCGSERIAL implementation
      USB: serial: pl2303: fix TIOCGSERIAL implementation
      USB: serial: quatech2: fix TIOCGSERIAL implementation
      USB: serial: ssu100: fix TIOCGSERIAL implementation
      USB: serial: ti_usb_3410_5052: fix TIOCGSERIAL implementation
      USB: serial: ti_usb_3410_5052: fix TIOCSSERIAL permission check
      USB: serial: usb_wwan: fix TIOCSSERIAL jiffies conversions
      USB: serial: usb_wwan: fix unprivileged TIOCCSERIAL
      USB: serial: usb_wwan: fix TIOCGSERIAL implementation
      USB: serial: whiteheat: fix TIOCGSERIAL implementation
      USB: serial: fix return value for unsupported ioctls
      USB: serial: add generic support for TIOCSSERIAL
      USB: serial: stop reporting legacy UART types
      USB: serial: ftdi_sio: ignore baud_base changes
      USB: serial: ftdi_sio: simplify TIOCGSERIAL permission check
      USB: serial: ftdi_sio: clean up TIOCSSERIAL
      USB: serial: io_ti: drop closing_wait module parameter
      USB: serial: io_ti: switch to 30-second closing wait
      USB: serial: ti_usb_3410_5052: drop closing_wait module parameter
      USB: serial: ti_usb_3410_5052: switch to 30-second closing wait
      USB: serial: io_edgeport: drop unused definitions
      Revert "USB: cdc-acm: fix rounding error in TIOCSSERIAL"
      USB: cdc-acm: fix unprivileged TIOCCSERIAL
      USB: cdc-acm: fix TIOCGSERIAL implementation
      USB: serial: do not use tty class device for debugging
      USB: serial: cp210x: provide gpio valid mask
      USB: serial: cp210x: add gpio-configuration debug printk
      USB: serial: f81232: drop time-based drain delay
      USB: serial: io_ti: document reason for drain delay
      USB: serial: ti_usb_3410_5052: reduce drain delay to one char
      USB: serial: ti_usb_3410_5052: drop drain delay for 3410
      USB: serial: io_ti: clean up vendor-request helpers
      USB: serial: io_ti: add send-port-command helper
      USB: serial: io_ti: add read-port-command helper
      USB: serial: io_ti: use kernel types consistently
      USB: serial: io_ti: drop unnecessary packed attributes
      USB: serial: ti_usb_3410_5052: drop unnecessary packed attributes
      USB: serial: ti_usb_3410_5052: clean up vendor-request helpers
      USB: serial: ti_usb_3410_5052: add port-command helpers
      USB: serial: ti_usb_3410_5052: use kernel types consistently
      USB: serial: ti_usb_3410_5052: clean up termios CSIZE handling
      USB: serial: xr: add support for XR21V1412 and XR21V1414
      USB: serial: xr: rename GPIO-mode defines
      USB: serial: xr: rename GPIO-pin defines
      USB: serial: xr: move pin configuration to probe
      USB: serial: xr: drop type prefix from shared defines
      USB: serial: xr: add type abstraction
      USB: serial: xr: add support for XR21B1421, XR21B1422 and XR21B1424
      USB: serial: xr: add support for XR21B1411
      USB: serial: xr: add support for XR22801, XR22802, XR22804
      USB: serial: xr: reset FIFOs on open
      USB: serial: xr: add copyright notice

Kai-Heng Feng (1):
      USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock Gen2 Ethernet

Longfang Liu (1):
      USB:ehci:fix Kunpeng920 ehci hardware problem

Malte Deiseroth (1):
      usb: misc: adutux: fix whitespace coding style issue

Manish Narani (4):
      dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3 Controller
      usb: dwc3: Add driver for Xilinx platforms
      usb: dwc3: Resolve kernel-doc warning for Xilinx DWC3 driver
      usb: dwc3: xilinx: Remove the extra freeing of clocks

Martin Devera (1):
      usb: dwc2: Add STM32 related debugfs entries

Mathias Nyman (4):
      xhci: check port array allocation was successful before dereferencing it
      xhci: check control context is valid before dereferencing it.
      xhci: fix potential array out of bounds with several interrupters
      xhci: prevent double-fetch of transfer and transfer event TRBs

Mauro Carvalho Chehab (1):
      USB: cdc-acm: add more Maxlinear/Exar models to ignore list

Michael G. Katzmann (1):
      USB: serial: pl2303: TA & TB alternate divider with non-standard baud rates

Mika Westerberg (20):
      thunderbolt: Disable retry logic for intra-domain control packets
      thunderbolt: Do not pass timeout for tb_cfg_reset()
      thunderbolt: Decrease control channel timeout for software connection manager
      Documentation / thunderbolt: Drop speed/lanes entries for XDomain
      thunderbolt: Add more logging to XDomain connections
      thunderbolt: Do not re-establish XDomain DMA paths automatically
      thunderbolt: Use pseudo-random number as initial property block generation
      thunderbolt: Align XDomain protocol timeouts with the spec
      thunderbolt: Add tb_property_copy_dir()
      thunderbolt: Add support for maxhopid XDomain property
      thunderbolt: Use dedicated flow control for DMA tunnels
      thunderbolt: Drop unused tb_port_set_initial_credits()
      thunderbolt: Allow multiple DMA tunnels over a single XDomain connection
      net: thunderbolt: Align the driver to the USB4 networking spec
      thunderbolt: Add KUnit tests for XDomain properties
      thunderbolt: Add KUnit tests for DMA tunnels
      thunderbolt: Check quirks in tb_switch_add()
      thunderbolt: Add support for USB4 DROM
      thunderbolt: Add details to router uevent
      thunderbolt: Hide authorized attribute if router does not support PCIe tunnels

Oliver Neukum (1):
      USB: CDC-ACM: fix poison/unpoison imbalance

Pawel Laszczak (5):
      usb: gadget: uvc: add bInterval checking for HS mode
      usb: gadget: uvc: Updating bcdUVC field to 0x0110
      usb: webcam: Invalid size of Processing Unit Descriptor
      usb: f_uac2: adds support for SS and SSP
      usb: cdnsp: Fixes issue with Configure Endpoint command

Peter Chen (1):
      usb: cdns3: trace: delete the trace parameter for request->trb

Randy Dunlap (1):
      tools: usbip: list.h: fix kernel-doc for list_del()

Rasmus Villemoes (1):
      USB: gadget: legacy: remove left-over __ref annotations

Ray Chi (6):
      usb: dwc3: add a power supply for current control
      usb: dwc3: add an alternate path in vbus_draw callback
      usb: dwc3: document usb_psy in struct dwc3
      usb: dwc3: gadget: modify the scale in vbus_draw callback
      power: supply: Fix build error when CONFIG_POWER_SUPPLY is not enabled.
      usb: dwc3: add cancelled reasons for dwc3 requests

Rob Herring (2):
      dt-bindings: usb: mediatek,mtu3: Use graph schema
      dt-bindings: usb: usb-nop-xceiv: Convert to DT schema

Ruslan Bilovol (4):
      usb: gadget: f_uac2: validate input parameters
      usb: gadget: f_uac1: validate input parameters
      usb: gadget: f_uac1: disable IN/OUT ep if unused
      usb: gadget: u_audio: convert to strscpy

Sandeep Maheswaram (2):
      dt-bindings: usb: qcom,dwc3: Add bindings for SC7280
      usb: dwc3: core: Add shutdown callback for dwc3

Sanket Parmar (2):
      usb: cdns3: Use dma_pool_* api to alloc trb pool
      usb: cdns3: Optimize DMA request buffer allocation

Saurav Girepunje (1):
      usb: musb: musb_core: Add space after that ','

Serge Semin (1):
      usb: dwc3: qcom: Detect DWC3 DT-nodes using compatible string

Shubhankar Kuranagatti (2):
      drivers: usb: host: fotg210-hcd.c: Fix indentation error
      drivers: usb: host: fotg210-hcd.c: Fix alignment of comment

Tao Ren (1):
      usb: gadget: aspeed: fix dma map failure

Thinh Nguyen (18):
      usb: dwc3: gadget: Remove invalid low-speed setting
      usb: core: Track SuperSpeed Plus GenXxY
      usb: core: hub: Remove port_speed_is_ssp()
      usb: core: hub: Print speed name based on ssp rate
      usb: core: sysfs: Check for SSP rate in speed attr
      usb: xhci: Init root hub SSP rate
      usb: xhci: Fix port minor revision
      usb: xhci: Rewrite xhci_create_usb3_bos_desc()
      usb: xhci: Remove unused function
      usb: dwc3: trace: Print register read and write offset
      usb: dwc3: Create helper function getting MDWIDTH
      usb: dwc3: gadget: Ignore Packet Pending bit
      usb: dwc3: gadget: Check for disabled LPM quirk
      usb: dwc3: gadget: Fix START_TRANSFER link state check
      dt-bindings: usb: dwc3: Add disabling LPM for gadget
      usb: dwc3: gadget: Remove FS bInterval_m1 limitation
      usb: dwc3: Capture new capability register GHWPARAMS9
      usb: dwc3: gadget: Handle DEV_TXF_FLUSH_BYPASS capability

Tian Tao (2):
      usb: dwc2: add parenthess and space around *
      usb: dwc2: delete duplicate word in the comment

Wang Qing (1):
      usb: cdns3: delete repeated clear operations

Wei Ming Chen (1):
      usb: gadget: function: fix typo in f_printer.c

Wei Yongjun (4):
      usb: typec: tps6598x: Fix return value check in tps6598x_probe()
      usb: typec: stusb160x: fix return value check in stusb160x_probe()
      usb: typec: tcpci_maxim: Make symbol 'max_tcpci_tcpci_write_table' static
      usb: cdns3: imx: mark cdns_imx_system_resume as __maybe_unused

Wesley Cheng (2):
      usb: dwc3: gadget: Avoid continuing preparing TRBs during teardown
      usb: dwc3: gadget: Ignore EP queue requests during bus reset

Yang Li (1):
      usb: typec: tcpm: turn tcpm_ams_finish into void function

Yang Yingliang (2):
      USB: gadget: udc: fix wrong pointer passed to IS_ERR() and PTR_ERR()
      usb: gadget: tegra-xudc: Fix possible use-after-free in tegra_xudc_remove()

Ye Bin (1):
      usbip: vudc: fix missing unlock on error in usbip_sockfd_store()

Yu Chen (1):
      usb: dwc3: core: Do core softreset when switch mode

Zhen Lei (2):
      dt-bindings: usb: dwc3-imx8mp: Use the correct name for child node "snps, dwc3"
      arm64: dts: imx8mp: Use the correct name for child node "snps, dwc3"

Zheng Yongjun (1):
      usb: host: u132-hcd: use DEFINE_MUTEX() for mutex lock

kernel test robot (2):
      usb: chipidea: tegra: fix flexible_array.cocci warnings
      USB: gadget: f_fs: fix memdup_user.cocci warnings

Álvaro Fernández Rojas (2):
      dt-bindings: usb: generic-ehci: document spurious-oc flag
      usb: host: ehci-platform: add spurious_oc DT support

 Documentation/ABI/testing/sysfs-bus-thunderbolt    |  35 +-
 .../bindings/connector/usb-connector.yaml          |  10 +
 .../devicetree/bindings/usb/dwc3-xilinx.txt        |  28 +-
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml   |   9 +-
 .../devicetree/bindings/usb/generic-ehci.yaml      |   6 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |  29 +-
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |  12 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   8 +-
 .../devicetree/bindings/usb/usb-device.yaml        |   6 +-
 .../devicetree/bindings/usb/usb-nop-xceiv.txt      |  43 --
 .../devicetree/bindings/usb/usb-nop-xceiv.yaml     |  64 ++
 Documentation/driver-api/usb/usb.rst               |  15 +-
 Documentation/usb/usbip_protocol.rst               | 344 +++++-----
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   2 +-
 drivers/net/thunderbolt.c                          |  56 +-
 drivers/platform/x86/intel_cht_int33fe_typec.c     |  19 +
 drivers/thunderbolt/ctl.c                          |  21 +-
 drivers/thunderbolt/ctl.h                          |   8 +-
 drivers/thunderbolt/debugfs.c                      |  37 +-
 drivers/thunderbolt/dma_test.c                     |  35 +-
 drivers/thunderbolt/domain.c                       |  89 +--
 drivers/thunderbolt/eeprom.c                       | 105 ++-
 drivers/thunderbolt/icm.c                          |  34 +-
 drivers/thunderbolt/property.c                     |  71 ++
 drivers/thunderbolt/switch.c                       |  75 +-
 drivers/thunderbolt/tb.c                           |  52 +-
 drivers/thunderbolt/tb.h                           |  45 +-
 drivers/thunderbolt/test.c                         | 492 ++++++++++++++
 drivers/thunderbolt/tunnel.c                       | 102 ++-
 drivers/thunderbolt/tunnel.h                       |   8 +-
 drivers/thunderbolt/xdomain.c                      | 416 +++++++-----
 drivers/usb/cdns3/cdns3-gadget.c                   |  73 +-
 drivers/usb/cdns3/cdns3-gadget.h                   |   3 +
 drivers/usb/cdns3/cdns3-imx.c                      |  34 +
 drivers/usb/cdns3/cdns3-plat.c                     |  23 +-
 drivers/usb/cdns3/cdns3-trace.h                    |   5 +-
 drivers/usb/cdns3/cdnsp-gadget.c                   |  17 +-
 drivers/usb/cdns3/cdnsp-gadget.h                   |   1 +
 drivers/usb/cdns3/cdnsp-mem.c                      |   3 +-
 drivers/usb/cdns3/core.c                           |  29 +-
 drivers/usb/cdns3/drd.c                            |  15 +
 drivers/usb/cdns3/drd.h                            |   2 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   8 +-
 drivers/usb/chipidea/host.c                        |   2 +-
 drivers/usb/class/cdc-acm.c                        |  33 +-
 drivers/usb/common/common.c                        |  76 +++
 drivers/usb/common/debug.c                         |  22 +-
 drivers/usb/core/devices.c                         |  21 +-
 drivers/usb/core/driver.c                          |  10 +-
 drivers/usb/core/endpoint.c                        |  35 +-
 drivers/usb/core/hcd.c                             |   6 +-
 drivers/usb/core/hub.c                             |  99 ++-
 drivers/usb/core/hub.h                             |   6 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/core/sysfs.c                           |   5 +-
 drivers/usb/core/usb.c                             |  54 +-
 drivers/usb/dwc2/core.c                            | 138 ++--
 drivers/usb/dwc2/core.h                            |  49 +-
 drivers/usb/dwc2/core_intr.c                       | 279 ++++----
 drivers/usb/dwc2/debugfs.c                         |   2 +
 drivers/usb/dwc2/gadget.c                          | 223 +++++-
 drivers/usb/dwc2/hcd.c                             | 645 ++++++++++++++----
 drivers/usb/dwc2/hcd_queue.c                       |   2 +-
 drivers/usb/dwc2/hw.h                              |   1 +
 drivers/usb/dwc2/params.c                          |  18 +-
 drivers/usb/dwc2/platform.c                        |  36 +-
 drivers/usb/dwc3/Kconfig                           |   9 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  54 +-
 drivers/usb/dwc3/core.h                            |  53 +-
 drivers/usb/dwc3/debug.h                           |   2 +-
 drivers/usb/dwc3/debugfs.c                         |  14 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |   2 +-
 drivers/usb/dwc3/dwc3-imx8mp.c                     |   2 +-
 drivers/usb/dwc3/dwc3-keystone.c                   |   2 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   1 -
 drivers/usb/dwc3/dwc3-pci.c                        |   6 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   5 +-
 drivers/usb/dwc3/dwc3-st.c                         |   2 +-
 drivers/usb/dwc3/dwc3-xilinx.c                     | 337 +++++++++
 drivers/usb/dwc3/gadget.c                          | 125 +++-
 drivers/usb/dwc3/gadget.h                          |   6 +-
 drivers/usb/dwc3/io.h                              |   2 +-
 drivers/usb/dwc3/trace.c                           |   2 +-
 drivers/usb/dwc3/trace.h                           |   8 +-
 drivers/usb/gadget/config.c                        |   4 +
 drivers/usb/gadget/function/f_fs.c                 |  14 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   2 -
 drivers/usb/gadget/function/f_printer.c            |   2 +-
 drivers/usb/gadget/function/f_uac1.c               | 272 ++++++--
 drivers/usb/gadget/function/f_uac2.c               | 263 +++++--
 drivers/usb/gadget/function/f_uvc.c                |   8 +-
 drivers/usb/gadget/function/u_audio.c              |   6 +-
 drivers/usb/gadget/function/uvc_configfs.c         |   2 +-
 drivers/usb/gadget/legacy/inode.c                  |   3 +-
 drivers/usb/gadget/legacy/mass_storage.c           |   4 +-
 drivers/usb/gadget/legacy/multi.c                  |  14 +-
 drivers/usb/gadget/legacy/webcam.c                 |   3 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |   3 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |   2 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |  25 +-
 drivers/usb/gadget/udc/fotg210-udc.c               |  28 +-
 drivers/usb/gadget/udc/net2272.c                   |   3 +-
 drivers/usb/gadget/udc/pch_udc.c                   | 241 ++++---
 drivers/usb/gadget/udc/r8a66597-udc.c              |   2 +
 drivers/usb/gadget/udc/s3c2410_udc.c               |  24 +-
 drivers/usb/gadget/udc/snps_udc_plat.c             |   4 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |   2 +-
 drivers/usb/host/Kconfig                           |   1 +
 drivers/usb/host/Makefile                          |   6 +-
 drivers/usb/host/ehci-hcd.c                        |  15 +-
 drivers/usb/host/ehci-hub.c                        |   4 +-
 drivers/usb/host/ehci-pci.c                        |   3 +
 drivers/usb/host/ehci-platform.c                   |   5 +
 drivers/usb/host/ehci.h                            |   1 +
 drivers/usb/host/fotg210-hcd.c                     |  12 +-
 drivers/usb/host/isp116x-hcd.c                     |   7 +-
 drivers/usb/host/isp116x.h                         |   1 -
 drivers/usb/host/isp1362-hcd.c                     |   8 +-
 drivers/usb/host/isp1362.h                         |   1 -
 drivers/usb/host/sl811-hcd.c                       |  16 +-
 drivers/usb/host/sl811.h                           |   1 -
 drivers/usb/host/sl811_cs.c                        |   2 +-
 drivers/usb/host/u132-hcd.c                        |   3 +-
 drivers/usb/host/uhci-hcd.c                        |  12 +-
 drivers/usb/host/uhci-hcd.h                        |   4 -
 drivers/usb/host/xhci-hub.c                        | 320 +++++----
 drivers/usb/host/xhci-mem.c                        |  14 +-
 drivers/usb/host/xhci-mtk-sch.c                    | 369 ++++++----
 drivers/usb/host/xhci-mtk.c                        | 289 ++++----
 drivers/usb/host/xhci-mtk.h                        |  60 +-
 drivers/usb/host/xhci-ring.c                       |  48 +-
 drivers/usb/host/xhci.c                            |  46 +-
 drivers/usb/host/xhci.h                            |   8 +
 drivers/usb/misc/adutux.c                          |   6 +-
 drivers/usb/misc/ehset.c                           |  76 +--
 drivers/usb/misc/ezusb.c                           |  16 +-
 drivers/usb/misc/usbsevseg.c                       |  60 +-
 drivers/usb/mtu3/mtu3_host.c                       |  30 +-
 drivers/usb/mtu3/mtu3_plat.c                       |   7 +-
 drivers/usb/musb/musb_core.c                       |   2 +-
 drivers/usb/musb/musb_core.h                       |   4 +-
 drivers/usb/renesas_usbhs/fifo.c                   |   4 +-
 drivers/usb/roles/class.c                          |   2 +
 drivers/usb/serial/ark3116.c                       |  13 -
 drivers/usb/serial/cp210x.c                        |  31 +-
 drivers/usb/serial/f81232.c                        |  12 +-
 drivers/usb/serial/f81534.c                        |   7 +-
 drivers/usb/serial/ftdi_sio.c                      |  35 +-
 drivers/usb/serial/io_edgeport.c                   |  67 +-
 drivers/usb/serial/io_edgeport.h                   |  68 --
 drivers/usb/serial/io_ti.c                         | 210 +++---
 drivers/usb/serial/io_ti.h                         |  38 +-
 drivers/usb/serial/iuu_phoenix.c                   |   4 +-
 drivers/usb/serial/keyspan.c                       |  20 -
 drivers/usb/serial/metro-usb.c                     |   4 +-
 drivers/usb/serial/mos7720.c                       |  18 -
 drivers/usb/serial/mos7840.c                       |  23 -
 drivers/usb/serial/opticon.c                       |  18 -
 drivers/usb/serial/option.c                        |   2 -
 drivers/usb/serial/pl2303.c                        | 188 +++--
 drivers/usb/serial/quatech2.c                      |  16 -
 drivers/usb/serial/ssu100.c                        |  16 -
 drivers/usb/serial/ti_usb_3410_5052.c              | 213 +++---
 drivers/usb/serial/upd78f0730.c                    |   7 +-
 drivers/usb/serial/usb-serial.c                    | 226 ++++--
 drivers/usb/serial/usb-wwan.h                      |   4 -
 drivers/usb/serial/usb_wwan.c                      |  45 --
 drivers/usb/serial/whiteheat.c                     |  17 +-
 drivers/usb/serial/xr_serial.c                     | 754 ++++++++++++++++-----
 drivers/usb/storage/datafab.c                      |   1 -
 drivers/usb/typec/Kconfig                          |  15 +-
 drivers/usb/typec/Makefile                         |   4 +-
 drivers/usb/typec/bus.c                            |   2 +
 drivers/usb/typec/bus.h                            |  19 +-
 drivers/usb/typec/class.c                          | 155 +++--
 drivers/usb/typec/class.h                          |  85 +++
 drivers/usb/typec/mux.c                            |   4 +-
 drivers/usb/typec/mux.h                            |  21 +
 drivers/usb/typec/port-mapper.c                    | 279 ++++++++
 drivers/usb/typec/stusb160x.c                      |   4 +-
 drivers/usb/typec/tcpm/fusb302.c                   |   5 +-
 drivers/usb/typec/tcpm/tcpci.c                     |  17 +-
 drivers/usb/typec/tcpm/tcpci.h                     |  16 +
 drivers/usb/typec/tcpm/tcpci_maxim.c               |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      | 233 +++++--
 drivers/usb/typec/tipd/Kconfig                     |  12 +
 drivers/usb/typec/tipd/Makefile                    |   6 +
 drivers/usb/typec/{tps6598x.c => tipd/core.c}      |  68 +-
 drivers/usb/typec/tipd/tps6598x.h                  | 189 ++++++
 drivers/usb/typec/tipd/trace.c                     |   9 +
 drivers/usb/typec/tipd/trace.h                     | 283 ++++++++
 drivers/usb/typec/ucsi/ucsi.c                      |   2 +-
 drivers/usb/usbip/vudc_sysfs.c                     |   2 +
 include/linux/platform_data/usb-mx2.h              |  29 -
 include/linux/power_supply.h                       |   7 +
 include/linux/thunderbolt.h                        |  54 +-
 include/linux/usb.h                                |  15 +-
 include/linux/usb/ch9.h                            |  62 +-
 include/linux/usb/ehci_pdriver.h                   |   1 +
 include/linux/usb/pd.h                             |   2 +
 include/linux/usb/serial.h                         |  10 +-
 include/linux/usb/typec.h                          |  19 +
 include/uapi/linux/usb/video.h                     |   3 +-
 tools/usb/usbip/doc/usbip.8                        |  42 +-
 tools/usb/usbip/doc/usbipd.8                       |  26 +
 tools/usb/usbip/libsrc/list.h                      |  10 +-
 tools/usb/usbip/src/usbip_list.c                   |   3 +-
 211 files changed, 7612 insertions(+), 3449 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c
 create mode 100644 drivers/usb/typec/class.h
 create mode 100644 drivers/usb/typec/mux.h
 create mode 100644 drivers/usb/typec/port-mapper.c
 create mode 100644 drivers/usb/typec/tipd/Kconfig
 create mode 100644 drivers/usb/typec/tipd/Makefile
 rename drivers/usb/typec/{tps6598x.c => tipd/core.c} (91%)
 create mode 100644 drivers/usb/typec/tipd/tps6598x.h
 create mode 100644 drivers/usb/typec/tipd/trace.c
 create mode 100644 drivers/usb/typec/tipd/trace.h
 delete mode 100644 include/linux/platform_data/usb-mx2.h
