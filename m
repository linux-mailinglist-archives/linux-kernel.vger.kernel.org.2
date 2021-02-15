Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4701931C0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBORaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhBOQ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:28:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B1664DF4;
        Mon, 15 Feb 2021 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613406480;
        bh=5iOTJC25gTrDXuDZ+GzYo1QWe6GMVdRRari310AiU5I=;
        h=Date:From:To:Cc:Subject:From;
        b=0k7zXcncJbl6zS/eemHSLCAff9ajQ3PIAFt5PZR5Upehm8xMt4ky25LUFE7HpgVeC
         +/c5KKHJGiw2uKSvMFtKlLaL+btrJPzNesFREZDkVHwejuJWiezLNKZC96lpQAykXj
         Kb2ZhHO2hVK3C455Xl5fkXHTp0qEg9k7HF8p8QL0=
Date:   Mon, 15 Feb 2021 17:27:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver changes for 5.12-rc1
Message-ID: <YCqhDaAPmOLln14y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc1

for you to fetch changes up to b5a12546e779d4f5586f58e60e0ef5070a833a64:

  dt-bindings: usb: mediatek: musb: add mt8516 compatbile (2021-02-12 16:42:03 +0100)

----------------------------------------------------------------
USB/Thunderbolt patches for 5.12-rc1

Here is the big set of USB and Thunderbolt driver changes for 5.12-rc1.

It's been an active set of development in these subsystems for the past
few months:
	- loads of typec features added for new hardware
	- xhci features and bugfixes
	- dwc3 features added for more hardware support
	- dwc2 fixes and new hardware support
	- cdns3 driver updates for more hardware support
	- gadget driver cleanups and minor fixes
	- usb-serial fixes, new driver, and more devices supported
	- thunderbolt feature additions for new hardware
	- lots of other tiny fixups and additions
The chrome driver changes are in here as well, as they depended on some
of the typec changes, and the maintainer acked them.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (1):
      usb: bdc: Remove the BDC PCI driver

Amelie Delaunay (3):
      usb: dwc2: set ahbcfg parameter for STM32MP15 OTG HS and FS
      usb: dwc2: enable FS/LS PHY clock select on STM32MP15 FS OTG
      usb: dwc2: disable Link Power Management on STM32MP15 HS OTG

Andrey Konovalov (2):
      usb: raw-gadget: add copyright
      usb: raw-gadget: update documentation and Kconfig

Andy Shevchenko (3):
      usb: gadget: u_serial: use %*ph to print small buffer
      usb: dwc3: keystone: Simplify with dev_err_probe()
      usb: dwc3: Simplify with dev_err_probe()

Aswath Govindraju (1):
      usb: cdns3: Add support for TI's AM64 SoC

Badhri Jagan Sridharan (5):
      usb: typec: tcpm: Handle vbus shutoff when in source mode
      usb: typec: tcpm: Set in_ams flag when Source caps have been received
      usb: typec: tcpm: Add Callback to Usb Communication capable partner
      usb: typec: tcpci: Add Callback to Usb Communication capable partner
      usb: typec: tcpci_maxim: Enable data path when partner is USB Comm capable

Benson Leung (8):
      usb: typec: Standardize PD Revision format with Type-C Revision
      usb: typec: Provide PD Specification Revision for cable and partner
      usb: typec: Add typec_partner_set_pd_revision
      Merge remote-tracking branch 'origin/cros-ec-typec-for-5.12' into ib-usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12
      platform/chrome: cros_ec_typec: Report SOP' PD revision from status
      platform/chrome: cros_ec_typec: Set Partner PD revision from status
      platform/chrome: cros_ec_typec: Set opmode to PD on SOP connected
      platform/chrome: cros_ec_typec: Fix call to typec_partner_set_pd_revision

Bhaskar Chowdhury (1):
      doc: devicetree: bindings: usb: Change descibe to describe in usbmisc-imx.txt

Chunfeng Yun (20):
      usb: gadget: bdc: fix improper SPDX comment style for header file
      usb: gadget: bdc: remove bdc_ep_set_halt() declaration
      usb: gadget: bdc: prefer pointer dereference to pointer type
      usb: gadget: bdc: fix warning of embedded function name
      usb: gadget: bdc: fix check warning of block comments alignment
      usb: gadget: bdc: add identifier name for function declaraion
      usb: gadget: bdc: avoid precedence issues
      usb: gadget: bdc: use the BIT macro to define bit filed
      usb: gadget: bdc: fix checkpatch.pl tab warning
      usb: gadget: bdc: fix checkpatch.pl spacing error
      usb: gadget: bdc: fix checkpatch.pl repeated word warning
      dt-bindings: usb: convert usb-device.txt to YAML schema
      dt-bindings: net: btusb: change reference file name
      dt-bindings: usb: convert mediatek, musb.txt to YAML schema
      dt-bindings: usb: convert mediatek, mtk-xhci.txt to YAML schema
      dt-bindings: usb: convert mediatek, mtu3.txt to YAML schema
      MAINTAINERS: update MediaTek PHY/USB entry
      dt-bindings: usb: mtk-xhci: add optional assigned clock properties
      dt-bindings: usb: mtk-xhci: add compatible for mt2701 and mt7623
      dt-bindings: usb: mediatek: musb: add mt8516 compatbile

Dan Carpenter (2):
      USB: serial: mos7840: fix error code in mos7840_write()
      USB: serial: mos7720: fix error code in mos7720_write()

Dave Penkler (4):
      USB: usbtmc: Fix reading stale status byte
      USB: usbtmc: Add USBTMC_IOCTL_GET_STB
      USB: usbtmc: Add separate USBTMC_IOCTL_GET_SRQ_STB
      USB: usbtmc: Bump USBTMC_API_VERSION value

Davidlohr Bueso (4):
      usb/gadget: f_midi: Replace tasklet with work
      usb: gadget: u_serial: Remove old tasklet comments
      USB: gadget: udc: Process disconnect synchronously
      usb/c67x00: Replace tasklet with work

Dmitry Osipenko (8):
      usb: phy: tegra: Add delay after power up
      usb: phy: tegra: Support waking up from a low power mode
      usb: chipidea: tegra: Remove MODULE_ALIAS
      usb: chipidea: tegra: Rename UDC to USB
      usb: chipidea: tegra: Support runtime PM
      usb: chipidea: tegra: Specify TX FIFO threshold in UDC SoC info
      usb: host: ehci-tegra: Remove the driver
      ARM: tegra_defconfig: Enable USB_CHIPIDEA_HOST and remove USB_EHCI_TEGRA

Fabio Estevam (1):
      usb: phy: phy-mxs-usb: Use of_device_get_match_data()

Greg Kroah-Hartman (8):
      Merge 5.11-rc3 into usb-next
      Merge v5.11-rc5 into usb-next
      Merge tag 'tag-ib-usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux into usb-next
      Merge tag 'tag-ib-usb-typec-chrome-platform-cros-ec-typec-clear-pd-discovery-events-for-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux into usb-next
      Merge 5.11-rc7 into usb-next
      Merge tag 'usb-v5.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next
      Merge tag 'thunderbolt-for-v5.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-5.12-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Guenter Roeck (3):
      usb: dwc2: Do not update data length if it is 0 on inbound transfers
      usb: dwc2: Abort transaction after errors with unknown reason
      usb: dwc2: Make "trimming xfer length" a debug message

Heikki Krogerus (11):
      software node: Introduce device_add_software_node()
      usb: dwc3: pci: Register a software node for the dwc3 platform device
      usb: dwc3: pci: ID for Tiger Lake CPU
      usb: dwc3: pci: add support for the Intel Alder Lake-P
      usb: typec: ucsi: Add conditional dependency on USB role switch
      usb: dwc2: pci: Drop the empty quirk function
      usb: dwc3: haps: Constify the software node
      usb: dwc3: qcom: Constify the software node
      software node: Provide replacement for device_add_properties()
      usb: dwc3: host: Use software node API with the properties
      xhci: ext-caps: Use software node API with the properties

Jack Pham (2):
      usb: gadget: u_audio: Free requests only after callback
      dt-bindings: usb: qcom,dwc3: Add bindings for SM8150, SM8250, SM8350

Jerome Brunet (3):
      usb: gadget: u_audio: factorize ssize to alsa fmt conversion
      usb: gadget: u_audio: remove struct uac_req
      usb: gadget: u_audio: clean up locking

Jiapeng Chong (1):
      usb: gadget: Assign boolean values to a bool variable

Jiapeng Zhong (1):
      drivers/usb/gadget/udc: Assign boolean values to a bool variable

Johan Hovold (33):
      USB: serial: pl2303: fix line-speed handling on newer chips
      USB: serial: cp210x: set IXOFF thresholds
      USB: serial: cp210x: update control-characters on every change
      USB: serial: cp210x: drop short control-transfer checks
      USB: serial: cp210x: drop unused includes
      USB: serial: cp210x: add copyright notice
      USB: serial: mxuport: drop short control-transfer check
      USB: serial: upd78f0730: drop short control-transfer check
      USB: serial: io_ti: drop short control-transfer check
      USB: serial: io_ti: fix a debug-message copy-paste error
      USB: serial: f81232: drop short control-transfer checks
      USB: serial: f81534: drop short control-transfer check
      USB: serial: xr: fix NULL-deref at probe
      USB: serial: xr: fix interface leak at disconnect
      USB: serial: xr: use subsystem usb_device at probe
      USB: serial: xr: use termios flag helpers
      USB: serial: xr: document vendor-request recipient
      USB: serial: xr: clean up line-settings handling
      USB: serial: xr: simplify line-speed logic
      USB: serial: xr: fix gpio-mode handling
      USB: serial: xr: fix pin configuration
      USB: serial: xr: fix B0 handling
      USB: serial: cp210x: suppress modem-control errors
      USB: serial: cp210x: fix modem-control handling
      USB: serial: cp210x: drop shift macros
      USB: serial: cp210x: clean up flow-control debug message
      USB: serial: cp210x: clean up printk zero padding
      USB: serial: cp210x: fix RTS handling
      USB: serial: cp210x: clean up auto-RTS handling
      USB: serial: ftdi_sio: fix FTX sub-integer prescaler
      USB: serial: ftdi_sio: restore divisor-encoding comments
      USB: serial: drop bogus to_usb_serial_port() checks
      USB: quirks: sort quirk entries

Johan Jonker (2):
      dt-bindings: usb: convert rockchip,dwc3.txt to yaml
      dt-bindings: usb: dwc3: add description for rk3328

Junlin Yang (2):
      usb: typec: tcpci_maxim: remove redundant assignment
      usb: typec: tcpci_maxim: add terminating newlines to logging

Kees Cook (1):
      usb: Replace lkml.org links with lore

Kyle Tso (15):
      usb: typec: tcpm: AMS and Collision Avoidance
      usb: typec: tcpm: Protocol Error handling
      usb: typec: tcpm: Respond Wait if VDM state machine is running
      usb: typec: tcpm: Create legacy PDOs for PD2 connection
      usb: typec: Return void in typec_partner_set_pd_revision
      usb: pd: Update VDO definitions
      usb: pd: Reland VDO definitions of PD2.0
      usb: typec: Manage SVDM version
      usb: pd: Make SVDM Version configurable in VDM header
      usb: typec: tcpm: Determine common SVDM Version
      usb: typec: ucsi: Determine common SVDM Version
      usb: typec: displayport: Fill the negotiated SVDM Version in the header
      dt-bindings: connector: Add SVDM VDO properties
      usb: typec: tcpm: Get Sink VDO from fwnode
      Documentation: connector: Update the description of sink-vdos

Lalithambika Krishna Kumar (1):
      xhci: check slot_id is valid before gathering slot info

Lech Perczak (1):
      USB: serial: option: update interface mapping for ZTE P685M

Lee Jones (11):
      thunderbolt: dma_port: Check 'dma_port_flash_write_block()'s return value
      thunderbolt: cap: Fix kernel-doc formatting issue
      thunderbolt: ctl: Demote non-conformant kernel-doc headers
      thunderbolt: eeprom: Demote non-conformant kernel-doc headers to standard comment blocks
      thunderbolt: xdomain: Fix 'tb_unregister_service_driver()'s 'drv' param
      thunderbolt: nhi: Demote some non-conformant kernel-doc headers
      thunderbolt: tb: Kernel-doc function headers should document their parameters
      thunderbolt: switch: Demote a bunch of non-conformant kernel-doc headers
      thunderbolt: icm: Fix a couple of formatting issues
      thunderbolt: tunnel: Fix misspelling of 'receive_path'
      thunderbolt: switch: Fix function name in the header

Li Jun (4):
      dt-bindings: usb: dwc3-imx8mp: add imx8mp dwc3 glue bindings
      usb: dwc3: add imx8mp dwc3 glue layer driver
      arm64: dtsi: imx8mp: add usb nodes
      arm64: dts: imx8mp-evk: enable usb1 as host mode

Linus Walleij (1):
      usb: typec: tcpci_maxim: Drop GPIO includes

Lorenzo Colitti (1):
      usb: gadget: u_ether: support configuring interface names.

Manivannan Sadhasivam (2):
      dt-bindings: usb: qcom,dwc3: Add binding for SDX55
      USB: serial: add MaxLinear/Exar USB to Serial driver

Mans Rullgard (1):
      dt-bindings: usb: usb-device: fix typo in required properties

Mario Limonciello (1):
      ACPI: Execute platform _OSC also with query bit clear

Mathias Nyman (26):
      xhci: Avoid parsing transfer events several times
      xhci: get isochronous ring directly from endpoint structure
      xhci: adjust parameters passed to cleanup_halted_endpoint()
      xhci: remove unused event parameter from completion handlers
      xhci: add xhci_get_virt_ep() helper
      xhci: check virt_dev is valid before dereferencing it
      xhci: add xhci_virt_ep_to_ring() helper
      xhci: remove xhci_stream_id_to_ring() helper
      xhci: prevent a theoretical endless loop while preparing rings.
      xhci: remove extra loop in interrupt context
      xhci: avoid DMA double fetch when reading event trb type.
      xhci: Check link TRBs when updating ring enqueue and dequeue pointers.
      xhci: flush endpoint start to reduce race risk with stop endpoint command.
      xhci: Add xhci_reset_halted_ep() helper function
      xhci: move xhci_td_cleanup so it can be called by more functions
      xhci: use xhci_td_cleanup() helper when giving back cancelled URBs
      xhci: store TD status in the td struct instead of passing it along
      xhci: turn cancelled td cleanup to its own function
      xhci: move and rename xhci_cleanup_halted_endpoint()
      xhci: split handling halted endpoints into two steps
      xhci: Fix halted endpoint at stop endpoint command completion
      xhci: handle stop endpoint command completion with endpoint in running state.
      xhci: introduce a new move_dequeue_past_td() function to replace old code.
      xhci: remove obsolete dequeue pointer moving code
      xhci: Check for pending reset endpoint command before queueing a new one.
      xhci: handle halting transfer event properly after endpoint stop and halt raced.

Mauro Carvalho Chehab (4):
      Documentation/devicetree/bindings/usb/dwc3-st.txt: update usb-drd.yaml reference
      dt-bindings: usb: update snps,dwc3.yaml references
      USB: dwc3: document gadget_max_speed
      USB: cdc-acm: ignore Exar XR21V141X when serial driver is built

Mayank Rana (1):
      usb: typec: ucsi: Add support for USB role switch

Michael R Sweet (1):
      USB: gadget: f_printer: set a default q_len

Michal Simek (2):
      dt-bindings: dwc3-xilinx: Add missing comma in example
      usb: misc: usb3503: Fix logic in usb3503_init()

Mika Westerberg (13):
      thunderbolt: Start lane initialization after sleep
      thunderbolt: Add support for de-authorizing devices
      thunderbolt: ctl: Fix kernel-doc descriptions of non-static functions
      thunderbolt: eeprom: Fix kernel-doc descriptions of non-static functions
      thunderbolt: path: Fix kernel-doc descriptions of non-static functions
      thunderbolt: nhi: Fix kernel-doc descriptions of non-static functions
      thunderbolt: switch: Fix kernel-doc descriptions of non-static functions
      thunderbolt: Add clarifying comments about USB4 terms router and adapter
      thunderbolt: dma_test: Drop unnecessary include
      thunderbolt: Add support for PCIe tunneling disabled (SL5)
      thunderbolt: Allow disabling XDomain protocol
      ACPI: Add support for native USB4 control _OSC
      thunderbolt: Add support for native USB4 _OSC

Nazime Hande Harputluoglu (1):
      kcov, usbip: collect coverage from vhci_rx_loop

Paul Cercueil (4):
      usb: musb: Fix runtime PM race in musb_queue_resume_work
      usb: musb: Fix NULL check on struct musb_request field
      usb: musb: dma: Remove unused variable
      usb: musb: jz4740: Add missing CR to error strings

Pawel Laszczak (19):
      usb: cdns3: Add support for DRD CDNSP
      usb: cdns3: Split core.c into cdns3-plat and core.c file
      usb: cdns3: Moves reusable code to separate module
      usb: cdns3: Refactoring names in reusable code
      usb: cdns3: Changed type of gadget_dev in cdns structure
      usb: cdnsp: Device side header file for CDNSP driver
      usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
      usb: cdnsp: Add tracepoints for CDNSP driver
      usb: cdns3: Change file names for cdns3 driver.
      MAINTAINERS: add Cadence USBSSP DRD IP driver entry
      usb: cdnsp: Removes some not useful function arguments
      usb: cdns3: Removes xhci_cdns3_suspend_quirk from host-export.h
      usb: cdnsp: fix error handling in cdnsp_mem_init()
      usb: cdns3: Fixes for sparse warnings
      usb: cdnsp: Fixes for sparse warnings
      usb: cdnsp: Fix for undefined reference to `usb_hcd_is_primary_hcd'
      usb: cdns3: Adds missing __iomem markers
      usb: cdnsp: fixes undefined reference to cdns_remove
      usb: cdnsp: Removes some useless trace events

Peter Geis (1):
      usb: chipidea: tegra: Support host mode

Prashant Malani (10):
      platform/chrome: cros_ec_typec: Make disc_done flag partner-only
      platform/chrome: cros_ec_typec: Factor out PD identity parsing
      platform/chrome: cros_ec_typec: Rename discovery struct
      platform/chrome: cros_ec_typec: Register cable
      platform/chrome: cros_ec_typec: Store cable plug type
      platform/chrome: cros_ec_typec: Set partner num_altmodes
      platform/chrome: cros_ec_typec: Register SOP' cable plug
      platform/chrome: cros_ec_typec: Register plug altmodes
      platform/chrome: cros_ec: Import Type C control command
      platform/chrome: cros_ec_typec: Clear Type C disc events

Randy Dunlap (2):
      usb: cdns3: fix build when PM_SLEEP is not set
      usb: cdns3: fix warning when USB_CDNS_HOST is not set

Rikard Falkeborn (1):
      thunderbolt: Constify static attribute_group structs

Rob Herring (2):
      dt-bindings: usb: generic-ehci: Add missing compatible strings
      dt-bindings: usb: generic-ohci: Add missing compatible strings

Sam Protsenko (2):
      usb: dwc3: drd: Avoid error when extcon is missing
      usb: dwc3: drd: Improve dwc3_get_extcon() style

Serge Semin (19):
      dt-bindings: usb: usb-hcd: Detach generic USB controller properties
      dt-bindings: usb: Convert generic USB properties to DT schemas
      dt-bindings: usb: usb-drd: Add "otg-rev" property constraints
      dt-bindings: usb: Add "ulpi/serial/hsic" PHY types
      dt-bindings: usb: usb-hcd: Add "tpl-support" property
      dt-bindings: usb: Add generic "usb-phy" property
      dt-bindings: usb: Convert xHCI bindings to DT schema
      dt-bindings: usb: xhci: Add Broadcom STB v2 compatible device
      dt-bindings: usb: renesas-xhci: Refer to the usb-xhci.yaml file
      dt-bindings: usb: Convert DWC USB3 bindings to DT schema
      dt-bindings: usb: dwc3: Add interrupt-names property support
      dt-bindings: usb: dwc3: Add synopsys, dwc3 compatible string
      dt-bindings: usb: dwc3: Add Tx De-emphasis constraints
      dt-bindings: usb: dwc3: Add Frame Length Adj constraints
      dt-bindings: usb: meson-g12a-usb: Fix FL-adj property value
      dt-bindings: usb: meson-g12a-usb: Validate DWC2/DWC3 sub-nodes
      dt-bindings: usb: keystone-dwc3: Validate DWC3 sub-node
      dt-bindings: usb: qcom,dwc3: Validate DWC3 sub-node
      dt-bindings: usb: intel, keembay-dwc3: Validate DWC3 sub-node

Shawn Guo (1):
      usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot

Stefan Ursella (1):
      usb: quirks: add quirk to start video capture on ELMO L-12F document camera reliable

Thinh Nguyen (16):
      usb: udc: core: Introduce started state
      usb: dwc3: gadget: Disable Vendor Test LMP Received event
      usb: ch9: Add USB 3.2 SSP attributes
      usb: gadget: composite: Use SSP sublink speed macros
      usb: gadget: Introduce SSP rates and lanes
      usb: gadget: Introduce udc_set_ssp_rate() for SSP
      usb: gadget: composite: Report various SSP sublink speeds
      dt-binding: usb: Include USB SSP rates in GenXxY
      usb: common: Parse for USB SSP genXxY
      usb: dwc3: core: Check maximum_speed SSP genXxY
      usb: dwc3: gadget: Implement setting of SSP rate
      usb: dwc3: gadget: Track connected SSP rate and lane count
      usb: dwc3: gadget: Set speed only up to the max supported
      usb: dwc3: gadget: Remove check for bounded driver
      usb: dwc3: gadget: Fix setting of DEPCFG.bInterval_m1
      usb: dwc3: gadget: Fix dep->interval for fullspeed interrupt

Tian Tao (1):
      thunderbolt: Use kmemdup instead of kzalloc and memcpy

Tom Rix (1):
      USB: serial: mos7720: improve OOM-handling in read_mos_reg()

Utkarsh Patel (2):
      platform/chrome: cros_ec_typec: Parameterize cros_typec_cmds_supported()
      platform/chrome: cros_ec_typec: Send mux configuration acknowledgment to EC

Uwe Kleine-König (2):
      USB: serial: drop if with an always false condition
      USB: serial: make remove callback return void

Wang Sheng Long (1):
      USB: serial: cp210x: add support for software flow control

Wesley Cheng (5):
      usb: dwc3: gadget: Introduce a DWC3 VBUS draw callback
      usb: gadget: composite: Split composite reset and disconnect
      usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
      usb: dwc3: gadget: Preserve UDC max speed setting
      usb: gadget: configfs: Add a specific configFS reset callback

Yejune Deng (1):
      usb: dwc3: core: Replace devm_reset_control_array_get()

Zheng Yongjun (1):
      usb: usbip: Use DEFINE_SPINLOCK() for spinlock

Zou Wei (1):
      usb: cdnsp: Mark cdnsp_gadget_ops with static keyword

 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   22 +-
 Documentation/ABI/testing/sysfs-class-typec        |   20 +-
 Documentation/admin-guide/thunderbolt.rst          |   23 +
 .../bindings/connector/usb-connector.yaml          |   12 +
 Documentation/devicetree/bindings/net/btusb.txt    |    2 +-
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |    6 +-
 Documentation/devicetree/bindings/usb/dwc3-st.txt  |    4 +-
 .../devicetree/bindings/usb/dwc3-xilinx.txt        |    2 +-
 Documentation/devicetree/bindings/usb/dwc3.txt     |  128 -
 .../devicetree/bindings/usb/exynos-usb.txt         |    2 +-
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml   |  105 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |   51 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |   34 +-
 .../devicetree/bindings/usb/generic-xhci.yaml      |   65 +
 Documentation/devicetree/bindings/usb/generic.txt  |   57 -
 .../bindings/usb/intel,keembay-dwc3.yaml           |    9 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |  121 -
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |  188 ++
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |  108 -
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |  287 +++
 .../devicetree/bindings/usb/mediatek,musb.txt      |   57 -
 .../devicetree/bindings/usb/mediatek,musb.yaml     |  114 +
 Documentation/devicetree/bindings/usb/omap-usb.txt |    2 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   13 +-
 .../devicetree/bindings/usb/renesas,usb-xhci.yaml  |    4 +-
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |   56 -
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     |  108 +
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  332 +++
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |    4 +-
 .../devicetree/bindings/usb/usb-device.txt         |  102 -
 .../devicetree/bindings/usb/usb-device.yaml        |  124 +
 Documentation/devicetree/bindings/usb/usb-drd.yaml |   78 +
 Documentation/devicetree/bindings/usb/usb-hcd.yaml |   36 +-
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   41 -
 .../devicetree/bindings/usb/usb-xhci.yaml          |   42 +
 Documentation/devicetree/bindings/usb/usb.yaml     |   63 +
 .../devicetree/bindings/usb/usbmisc-imx.txt        |    2 +-
 Documentation/usb/gadget-testing.rst               |   30 +-
 Documentation/usb/raw-gadget.rst                   |  102 +-
 MAINTAINERS                                        |   13 +-
 arch/arm/configs/tegra_defconfig                   |    3 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |   21 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   82 +
 drivers/acpi/bus.c                                 |  119 +-
 drivers/base/swnode.c                              |  114 +-
 drivers/platform/chrome/cros_ec_typec.c            |  286 ++-
 drivers/thunderbolt/acpi.c                         |   65 +
 drivers/thunderbolt/cap.c                          |    2 +-
 drivers/thunderbolt/ctl.c                          |   51 +-
 drivers/thunderbolt/dma_port.c                     |    2 +
 drivers/thunderbolt/dma_test.c                     |    5 +-
 drivers/thunderbolt/domain.c                       |   48 +-
 drivers/thunderbolt/eeprom.c                       |   33 +-
 drivers/thunderbolt/icm.c                          |   10 +-
 drivers/thunderbolt/lc.c                           |   35 +
 drivers/thunderbolt/nhi.c                          |   39 +-
 drivers/thunderbolt/path.c                         |    2 +
 drivers/thunderbolt/switch.c                       |   82 +-
 drivers/thunderbolt/tb.c                           |   54 +-
 drivers/thunderbolt/tb.h                           |   22 +
 drivers/thunderbolt/tb_regs.h                      |    1 +
 drivers/thunderbolt/tunnel.c                       |   12 +-
 drivers/thunderbolt/usb4.c                         |   11 +-
 drivers/thunderbolt/xdomain.c                      |   15 +-
 drivers/usb/Makefile                               |    2 +
 drivers/usb/c67x00/c67x00-hcd.h                    |    2 +-
 drivers/usb/c67x00/c67x00-sched.c                  |   12 +-
 drivers/usb/cdns3/Kconfig                          |   60 +-
 drivers/usb/cdns3/Makefile                         |   43 +-
 drivers/usb/cdns3/{debug.h => cdns3-debug.h}       |    0
 drivers/usb/cdns3/{ep0.c => cdns3-ep0.c}           |    8 +-
 drivers/usb/cdns3/{gadget.c => cdns3-gadget.c}     |   34 +-
 drivers/usb/cdns3/{gadget.h => cdns3-gadget.h}     |    0
 drivers/usb/cdns3/cdns3-imx.c                      |    2 +-
 drivers/usb/cdns3/cdns3-plat.c                     |  315 +++
 drivers/usb/cdns3/cdns3-ti.c                       |    1 +
 drivers/usb/cdns3/{trace.c => cdns3-trace.c}       |    2 +-
 drivers/usb/cdns3/{trace.h => cdns3-trace.h}       |    6 +-
 drivers/usb/cdns3/cdnsp-debug.h                    |  583 +++++
 drivers/usb/cdns3/cdnsp-ep0.c                      |  489 ++++
 drivers/usb/cdns3/cdnsp-gadget.c                   | 2009 ++++++++++++++++
 drivers/usb/cdns3/cdnsp-gadget.h                   | 1601 +++++++++++++
 drivers/usb/cdns3/cdnsp-mem.c                      | 1336 +++++++++++
 drivers/usb/cdns3/cdnsp-pci.c                      |  254 ++
 drivers/usb/cdns3/cdnsp-ring.c                     | 2438 ++++++++++++++++++++
 drivers/usb/cdns3/cdnsp-trace.c                    |   12 +
 drivers/usb/cdns3/cdnsp-trace.h                    |  830 +++++++
 drivers/usb/cdns3/core.c                           |  455 +---
 drivers/usb/cdns3/core.h                           |   65 +-
 drivers/usb/cdns3/drd.c                            |  224 +-
 drivers/usb/cdns3/drd.h                            |   94 +-
 drivers/usb/cdns3/gadget-export.h                  |   22 +-
 drivers/usb/cdns3/host-export.h                    |   18 +-
 drivers/usb/cdns3/host.c                           |   26 +-
 drivers/usb/chipidea/Kconfig                       |    3 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c               |  344 ++-
 drivers/usb/chipidea/core.c                        |   10 +-
 drivers/usb/chipidea/host.c                        |  104 +-
 drivers/usb/class/cdc-acm.c                        |    6 +
 drivers/usb/class/usbtmc.c                         |   85 +-
 drivers/usb/common/common.c                        |   26 +-
 drivers/usb/core/quirks.c                          |    9 +-
 drivers/usb/dwc2/hcd.c                             |   15 +-
 drivers/usb/dwc2/hcd_intr.c                        |   14 +-
 drivers/usb/dwc2/params.c                          |    8 +
 drivers/usb/dwc2/pci.c                             |   18 -
 drivers/usb/dwc3/Kconfig                           |   10 +
 drivers/usb/dwc3/Makefile                          |    1 +
 drivers/usb/dwc3/core.c                            |   83 +-
 drivers/usb/dwc3/core.h                            |   11 +
 drivers/usb/dwc3/drd.c                             |   25 +-
 drivers/usb/dwc3/dwc3-haps.c                       |    8 +-
 drivers/usb/dwc3/dwc3-imx8mp.c                     |  363 +++
 drivers/usb/dwc3/dwc3-keystone.c                   |    9 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   69 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   71 +-
 drivers/usb/dwc3/gadget.c                          |  245 +-
 drivers/usb/dwc3/host.c                            |    2 +-
 drivers/usb/gadget/composite.c                     |  104 +-
 drivers/usb/gadget/configfs.c                      |   24 +-
 drivers/usb/gadget/function/f_midi.c               |   12 +-
 drivers/usb/gadget/function/f_printer.c            |    5 +
 drivers/usb/gadget/function/u_audio.c              |  135 +-
 drivers/usb/gadget/function/u_ether.c              |   33 +-
 drivers/usb/gadget/function/u_ether.h              |   12 +
 drivers/usb/gadget/function/u_ether_configfs.h     |   15 +-
 drivers/usb/gadget/function/u_serial.c             |    8 +-
 drivers/usb/gadget/legacy/Kconfig                  |   13 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |    3 +-
 drivers/usb/gadget/udc/bdc/Kconfig                 |   11 -
 drivers/usb/gadget/udc/bdc/Makefile                |    2 -
 drivers/usb/gadget/udc/bdc/bdc.h                   |  134 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.c               |    2 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.h               |   21 +-
 drivers/usb/gadget/udc/bdc/bdc_dbg.c               |    2 +-
 drivers/usb/gadget/udc/bdc/bdc_dbg.h               |   10 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c                |   16 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.h                |   10 +-
 drivers/usb/gadget/udc/bdc/bdc_pci.c               |  128 -
 drivers/usb/gadget/udc/bdc/bdc_udc.c               |    8 +-
 drivers/usb/gadget/udc/core.c                      |   39 +-
 drivers/usb/gadget/udc/snps_udc_core.c             |   30 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |   10 +-
 drivers/usb/host/Kconfig                           |   10 +-
 drivers/usb/host/Makefile                          |    1 -
 drivers/usb/host/ehci-tegra.c                      |  604 -----
 drivers/usb/host/xhci-ext-caps.c                   |    3 +-
 drivers/usb/host/xhci-mem.c                        |   21 +-
 drivers/usb/host/xhci-ring.c                       | 1111 +++++----
 drivers/usb/host/xhci.c                            |   94 +-
 drivers/usb/host/xhci.h                            |   37 +-
 drivers/usb/misc/usb3503.c                         |    9 +-
 drivers/usb/musb/jz4740.c                          |   18 +-
 drivers/usb/musb/musb_core.c                       |   31 +-
 drivers/usb/musb/musb_gadget.c                     |    2 +-
 drivers/usb/musb/musbhsdma.c                       |    4 -
 drivers/usb/phy/phy-mxs-usb.c                      |    7 +-
 drivers/usb/phy/phy-tegra-usb.c                    |  103 +-
 drivers/usb/serial/Kconfig                         |    9 +
 drivers/usb/serial/Makefile                        |    1 +
 drivers/usb/serial/ark3116.c                       |   11 +-
 drivers/usb/serial/belkin_sa.c                     |    6 +-
 drivers/usb/serial/bus.c                           |   27 +-
 drivers/usb/serial/ch341.c                         |    4 +-
 drivers/usb/serial/cp210x.c                        |  217 +-
 drivers/usb/serial/cyberjack.c                     |    6 +-
 drivers/usb/serial/cypress_m8.c                    |    6 +-
 drivers/usb/serial/digi_acceleport.c               |    6 +-
 drivers/usb/serial/f81232.c                        |   12 +-
 drivers/usb/serial/f81534.c                        |    7 +-
 drivers/usb/serial/ftdi_sio.c                      |   27 +-
 drivers/usb/serial/garmin_gps.c                    |    3 +-
 drivers/usb/serial/io_edgeport.c                   |    6 +-
 drivers/usb/serial/io_ti.c                         |   12 +-
 drivers/usb/serial/iuu_phoenix.c                   |    4 +-
 drivers/usb/serial/keyspan.c                       |    6 +-
 drivers/usb/serial/keyspan_pda.c                   |    4 +-
 drivers/usb/serial/kl5kusb105.c                    |    6 +-
 drivers/usb/serial/kobil_sct.c                     |    6 +-
 drivers/usb/serial/mct_u232.c                      |    6 +-
 drivers/usb/serial/metro-usb.c                     |    4 +-
 drivers/usb/serial/mos7720.c                       |   12 +-
 drivers/usb/serial/mos7840.c                       |    8 +-
 drivers/usb/serial/mxuport.c                       |    7 -
 drivers/usb/serial/omninet.c                       |    6 +-
 drivers/usb/serial/opticon.c                       |    4 +-
 drivers/usb/serial/option.c                        |    3 +-
 drivers/usb/serial/oti6858.c                       |    6 +-
 drivers/usb/serial/pl2303.c                        |   12 +-
 drivers/usb/serial/quatech2.c                      |    4 +-
 drivers/usb/serial/sierra.c                        |    4 +-
 drivers/usb/serial/spcp8x5.c                       |    4 +-
 drivers/usb/serial/ssu100.c                        |    4 +-
 drivers/usb/serial/symbolserial.c                  |    4 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |    6 +-
 drivers/usb/serial/upd78f0730.c                    |    9 +-
 drivers/usb/serial/usb-wwan.h                      |    2 +-
 drivers/usb/serial/usb_wwan.c                      |    4 +-
 drivers/usb/serial/whiteheat.c                     |    6 +-
 drivers/usb/serial/xr_serial.c                     |  611 +++++
 drivers/usb/typec/altmodes/displayport.c           |   17 +-
 drivers/usb/typec/class.c                          |  104 +-
 drivers/usb/typec/tcpm/tcpci.c                     |    9 +
 drivers/usb/typec/tcpm/tcpci.h                     |    6 +
 drivers/usb/typec/tcpm/tcpci_maxim.c               |   35 +-
 drivers/usb/typec/tcpm/tcpm.c                      | 1173 ++++++++--
 drivers/usb/typec/ucsi/Kconfig                     |    1 +
 drivers/usb/typec/ucsi/displayport.c               |   32 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   56 +-
 drivers/usb/typec/ucsi/ucsi.h                      |    3 +
 drivers/usb/usbip/stub_main.c                      |    4 +-
 drivers/usb/usbip/usbip_common.h                   |   29 +
 drivers/usb/usbip/vhci_rx.c                        |    2 +
 drivers/usb/usbip/vhci_sysfs.c                     |    1 +
 include/dt-bindings/usb/pd.h                       |  311 ++-
 include/linux/acpi.h                               |   10 +
 include/linux/platform_data/cros_ec_commands.h     |   43 +
 include/linux/property.h                           |    7 +
 include/linux/thunderbolt.h                        |    3 +
 include/linux/usb/ch9.h                            |   20 +
 include/linux/usb/chipidea.h                       |    6 +
 include/linux/usb/composite.h                      |    2 +
 include/linux/usb/gadget.h                         |   11 +
 include/linux/usb/pd.h                             |    3 +
 include/linux/usb/pd_vdo.h                         |  304 ++-
 include/linux/usb/serial.h                         |    2 +-
 include/linux/usb/tcpm.h                           |    9 +
 include/linux/usb/tegra_usb_phy.h                  |    2 +
 include/linux/usb/typec.h                          |   23 +
 include/linux/usb/typec_altmode.h                  |   10 +
 include/uapi/linux/usb/ch9.h                       |   13 +
 include/uapi/linux/usb/tmc.h                       |    3 +
 232 files changed, 18518 insertions(+), 3855 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/generic-xhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/generic.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/snps,dwc3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-device.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-device.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/usb-drd.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-xhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-xhci.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/usb.yaml
 rename drivers/usb/cdns3/{debug.h => cdns3-debug.h} (100%)
 rename drivers/usb/cdns3/{ep0.c => cdns3-ep0.c} (99%)
 rename drivers/usb/cdns3/{gadget.c => cdns3-gadget.c} (99%)
 rename drivers/usb/cdns3/{gadget.h => cdns3-gadget.h} (100%)
 create mode 100644 drivers/usb/cdns3/cdns3-plat.c
 rename drivers/usb/cdns3/{trace.c => cdns3-trace.c} (89%)
 rename drivers/usb/cdns3/{trace.h => cdns3-trace.h} (99%)
 create mode 100644 drivers/usb/cdns3/cdnsp-debug.h
 create mode 100644 drivers/usb/cdns3/cdnsp-ep0.c
 create mode 100644 drivers/usb/cdns3/cdnsp-gadget.c
 create mode 100644 drivers/usb/cdns3/cdnsp-gadget.h
 create mode 100644 drivers/usb/cdns3/cdnsp-mem.c
 create mode 100644 drivers/usb/cdns3/cdnsp-pci.c
 create mode 100644 drivers/usb/cdns3/cdnsp-ring.c
 create mode 100644 drivers/usb/cdns3/cdnsp-trace.c
 create mode 100644 drivers/usb/cdns3/cdnsp-trace.h
 create mode 100644 drivers/usb/dwc3/dwc3-imx8mp.c
 delete mode 100644 drivers/usb/gadget/udc/bdc/bdc_pci.c
 delete mode 100644 drivers/usb/host/ehci-tegra.c
 create mode 100644 drivers/usb/serial/xr_serial.c
