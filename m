Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803C9445382
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhKDNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhKDNIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F114960F9D;
        Thu,  4 Nov 2021 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636031129;
        bh=4OyghZgXjem8lZWGejLqpDwDxX3SAk7txZ/ApHtflno=;
        h=Date:From:To:Cc:Subject:From;
        b=Pu8fyUFl98EGdT0k1BvQfcTfsxqG/F5782d70jIFsNqXQqHQ2bv+lUvlsQbyhQcjr
         fzFmzjHCgwQS9pc2iD26O935HuV4j3gd5aF10z1EF0aYe+ANR75rXNK3zmBuud/1yp
         tnJUnYADjQYzIk/bnzxZYdDyMulNQ4vwCfASMUCU=
Date:   Thu, 4 Nov 2021 14:05:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt changes for 5.16-rc1
Message-ID: <YYPaloH8ltR32qUk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc1

for you to fetch changes up to a0548b26901f082684ad1fb3ba397d2de3a1406a:

  usb: gadget: Mark USB_FSL_QE broken on 64-bit (2021-10-30 11:00:09 +0200)

----------------------------------------------------------------
USB / Thunderbolt changes for 5.16-rc1

Here is the big set of USB and Thunderbolt driver updates for 5.16-rc1.

Nothing major in here, just lots of little cleanups and additions for
new hardware, all of which have been in linux-next for a while with no
reported problems.

Included in here are:
	- tiny Thunderbolt driver updates
	- USB typec driver updates
	- USB serial driver updates
	- USB gadget driver updates
	- dwc2 and dwc3 controller driver updates
	- tiny USB host driver updates
	- minor USB driver fixes and updates
	- USB dts updates for various platforms

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Garg (1):
      usb: gadget: fix for a typo that conveys logically-inverted information.

Alan Stern (2):
      USB: core: Make do_proc_control() and do_proc_bulk() killable
      USB: EHCI: Improve port index sanitizing

Amelie Delaunay (3):
      usb: dwc2: drd: fix dwc2_force_mode call in dwc2_ovr_init
      usb: dwc2: drd: fix dwc2_drd_role_sw_set when clock could be disabled
      usb: dwc2: drd: reset current session before setting the new one

Andy Shevchenko (2):
      usb: gadget: udc: core: Use pr_fmt() to prefix messages
      usb: gadget: udc: core: Print error code in usb_gadget_probe_driver()

Arnd Bergmann (2):
      thunderbolt: Fix -Wrestrict warning
      usb: gadget: avoid unusual inline assembly

Balaji Prakash J (1):
      usb: dwc3: reference clock period configuration

Baruch Siach (2):
      dt-bindings: usb: dwc3: add reference clock period
      dt-bindings: usb: qcom,dwc3: add binding for IPQ6018

Cai Huoqing (5):
      usb: ehci: Fix a function name in comments
      usb: host: fotg210: Fix a function name in comments
      usb: host: oxu210hp: Fix a function name in comments
      usb: host: fotg210: Make use of dma_pool_zalloc() instead of dma_pool_alloc/memset()
      usb: host: ehci: Make use of dma_pool_zalloc() instead of dma_pool_alloc/memset()

Christophe JAILLET (1):
      USB: gadget: udc: Remove some dead code

Chunfeng Yun (1):
      usb: xhci-mtk: use xhci_dbg() to print log

Colin Ian King (2):
      usb: gadget: f_uac2: clean up some inconsistent indenting
      usb: gadget: goku_udc: Fix mask and set operation on variable master

Cristian Birsan (2):
      dt-bindings: usb: atmel: add USB PHY type property
      USB: host: ehci-atmel: Add support for HSIC phy

Dan Carpenter (1):
      usb: gadget: hid: fix error code in do_config()

Dmitry Osipenko (3):
      dt-bindings: phy: tegra20-usb-phy: Convert to schema
      dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG mode
      usb: phy: tegra: Support OTG mode programming

Fabrice Gasnier (5):
      ARM: dts: stm32: set otg-rev on stm32mp151
      dt-bindings: usb: dwc2: Add reference to usb-drd.yaml
      dt-bindings: usb: dwc2: adopt otg properties defined in usb-drd.yaml
      usb: dwc2: add otg_rev and otg_caps information for gadget driver
      usb: dwc2: stm32mp15: set otg_rev

Geert Uytterhoeven (1):
      usb: gadget: Mark USB_FSL_QE broken on 64-bit

Greg Kroah-Hartman (6):
      Revert "arm64: qcom: ipq6018: add usb3 DT description"
      Merge 5.15-rc3 into usb-next
      Merge 5.15-rc5 into usb-next
      Merge 5.15-rc6 into usb-next
      Merge tag 'thunderbolt-for-v5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-5.16-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Gustavo A. R. Silva (1):
      usb: atm: Use struct_size() helper

Heikki Krogerus (7):
      usb: typec: ucsi: Always cancel the command if PPM reports BUSY condition
      usb: typec: ucsi: Don't stop alt mode registration on busy condition
      usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking
      usb: typec: ucsi: acpi: Reduce the command completion timeout
      usb: typec: ucsi: Check the partner alt modes always if there is PD contract
      usb: typec: ucsi: Read the PDOs in separate work
      usb: typec: ucsi: Better fix for missing unplug events issue

Himadri Pandya (6):
      USB: serial: f81232: use usb_control_msg_recv() and usb_control_msg_send()
      USB: serial: ftdi_sio: use usb_control_msg_recv()
      USB: serial: keyspan_pda: use usb_control_msg_recv()
      USB: serial: kl5kusb105: use usb_control_msg_recv() and usb_control_msg_send()
      USB: serial: ch314: use usb_control_msg_recv()
      USB: serial: cp210x: use usb_control_msg_recv() and usb_control_msg_send()

Jack Pham (2):
      usb: dwc3: gadget: Skip resizing EP's TX FIFO if already resized
      usb: dwc3: Align DWC3_EP_* flag macros

Jakub Kicinski (1):
      usb: gadget: u_ether: use eth_hw_addr_set()

James Buren (1):
      usb-storage: Add compatibility quirk flags for iODD 2531/2541

Johan Hovold (9):
      USB: serial: clean up core error labels
      USB: serial: allow hung up ports to be suspended
      USB: serial: kl5kusb105: clean up line-status handling
      USB: serial: kl5kusb105: simplify line-status handling
      USB: serial: kl5kusb105: drop line-status helper
      Revert "usb: misc: ehset: Workaround for "special" hubs"
      USB: chipidea: fix interrupt deadlock
      Documentation: USB: fix example bulk-message timeout
      USB: iowarrior: fix control-message timeouts

Kathiravan T (1):
      arm64: qcom: ipq6018: add usb3 DT description

Krzysztof Kozlowski (3):
      USB: cdc-acm: remove duplicate USB device ID
      usb: host: ehci-mv: drop duplicated MODULE_ALIAS
      usb: exynos: describe driver in KConfig

Len Baker (1):
      usb: ohci: Prefer struct_size over open coded arithmetic

Linyu Yuan (2):
      usb: gadget: configfs: add cfg_to_gadget_info() helper
      usb: gadget: configfs: change config attributes file operation

Maxime Ripard (2):
      dt-bindings: usb: Convert SMSC USB3503 binding to a schema
      dt-bindings: usb: dwc3: Fix usb-phy check

Michael Grzeschik (6):
      usb: gadget: uvc: consistently use define for headerlen
      usb: gadget: uvc: test if ep->desc is valid on ep_queue
      usb: gadget: uvc: only schedule stream in streaming state
      usb: gadget: uvc: only pump video data if necessary
      usb: gadget: uvc: ensure the vdev is unset
      usb: gadget: uvc: use on returned header len in video_encode_isoc_sg

Michael Olbrich (1):
      usb: gadget: uvc: implement dwPresentationTime and scrSourceClock

Michael Tretter (1):
      usb: gadget: uvc: rename function to be more consistent

Neal Liu (1):
      usb: ehci: handshake CMD_RUN instead of STS_HALT

Nehal Bakulchandra Shah (1):
      usb: xhci: Enable runtime-pm by default on AMD Yellow Carp platform

Nikita Yushchenko (1):
      usb: gadget: storage: add support for media larger than 2T

Pavel Hofman (2):
      usb: gadget: u_audio.c: Adding Playback Pitch ctl for sync playback
      usb:gadget: f_uac1: fixed sync playback

Philipp Hortmann (3):
      usb: usb-skeleton: Update min() to min_t()
      Docs: usb: update struct usb_driver
      Docs: usb: remove :c:func: for usb_register and usb_deregister

Philipp Zabel (1):
      usb: typec: hd3ss3220: Use regmap_write_bits()

Piyush Mehta (1):
      usb: chipidea: udc: make controller hardware endpoint primed

Randy Dunlap (2):
      usb: musb: select GENERIC_PHY instead of depending on it
      usb: typec: STUSB160X should select REGMAP_I2C

Razvan Heghedus (1):
      usb: misc: ehset: Workaround for "special" hubs

Rikard Falkeborn (1):
      usb: cdc-wdm: Constify static struct wwan_port_ops

Robert Greener (1):
      usb: core: config: Change sizeof(struct ...) to sizeof(*...)

Roman Stratiienko (1):
      usb: musb: sunxi: Don't print error on MUSB_ULPI_BUSCONTROL access

Sanjay R Mehta (1):
      thunderbolt: Enable retry logic for intra-domain control packets

Saranya Gopal (2):
      usb: typec: tipd: Enable event interrupts by default
      Revert "platform/x86: i2c-multi-instantiate: Don't create platform device for INT3515 ACPI nodes"

Sergey Shtylyov (1):
      usb: core: hcd: fix messages in usb_hcd_request_irqs()

Shubhrajyoti Datta (1):
      usb: gadget: udc-xilinx: Add clock support

Sungbo Eo (1):
      usb: musb: mediatek: Expose role-switch control to userspace

Sven Peter (9):
      usb: typec: tipd: Don't read/write more bytes than required
      usb: typec: tipd: Add an additional overflow check
      usb: typec: tipd: Remove WARN_ON in tps6598x_block_read
      dt-bindings: usb: tps6598x: Add Apple CD321x compatible
      usb: typec: tipd: Split interrupt handler
      usb: typec: tipd: Add short-circuit for no irqs
      usb: typec: tipd: Add support for Apple CD321X
      usb: typec: tipd: Switch CD321X power state to S0
      usb: typec: tipd: Remove FIXME about testing with I2C_FUNC_I2C

Thomas Haemmerle (1):
      usb: gadget: uvc: fix multiple opens

Uwe Kleine-König (1):
      usb: max-3421: Use driver data instead of maintaining a list of bound devices

Viraj Shah (1):
      usb: musb: Balance list entry in musb_gadget_queue

Wang Hai (1):
      USB: serial: keyspan: fix memleak on probe errors

Wesley Cheng (4):
      usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind
      usb: dwc3: gadget: Change to dev_dbg() when queuing to inactive gadget/ep
      usb: gadget: udc: core: Revise comments for USB ep enable/disable
      usb: gadget: f_mass_storage: Disable eps during disconnect

Xu Yang (1):
      usb: typec: tcpci: Fix spelling mistake "resolbed" -> "resolved"

Yang Yingliang (2):
      usb: musb: tusb6010: check return value after calling platform_get_resource()
      usb: host: ohci-tmio: check return value after calling platform_get_resource()

Yinbo Zhu (1):
      usb: ohci: disable start-of-frame interrupt in ohci_rh_suspend

Zhiwei Yang (1):
      USB: phy: tahvo:remove unnecessary debug log

 .../bindings/phy/nvidia,tegra20-usb-phy.txt        |  74 ----
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml       | 373 +++++++++++++++++++++
 .../devicetree/bindings/usb/atmel-usb.txt          |   4 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |  16 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
 .../devicetree/bindings/usb/smsc,usb3503.yaml      | 108 ++++++
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  18 +-
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |   4 +
 Documentation/devicetree/bindings/usb/usb3503.txt  |  39 ---
 .../driver-api/usb/writing_usb_driver.rst          |  13 +-
 arch/arm/boot/dts/stm32mp151.dtsi                  |   1 +
 drivers/platform/x86/i2c-multi-instantiate.c       |  31 +-
 drivers/thunderbolt/ctl.c                          |   2 +-
 drivers/thunderbolt/xdomain.c                      |   2 +-
 drivers/usb/atm/usbatm.c                           |   4 +-
 drivers/usb/chipidea/core.c                        |  23 +-
 drivers/usb/chipidea/udc.c                         |   8 +
 drivers/usb/class/cdc-acm.c                        |   1 -
 drivers/usb/class/cdc-wdm.c                        |   2 +-
 drivers/usb/core/config.c                          |   4 +-
 drivers/usb/core/devio.c                           | 144 ++++++--
 drivers/usb/core/hcd.c                             |   6 +-
 drivers/usb/dwc2/core.h                            |  19 +-
 drivers/usb/dwc2/debugfs.c                         |   4 +-
 drivers/usb/dwc2/drd.c                             |  24 +-
 drivers/usb/dwc2/gadget.c                          |   1 +
 drivers/usb/dwc2/hcd.c                             |  12 +-
 drivers/usb/dwc2/params.c                          |  75 +++--
 drivers/usb/dwc3/Kconfig                           |   7 +-
 drivers/usb/dwc3/core.c                            |  29 ++
 drivers/usb/dwc3/core.h                            |  25 +-
 drivers/usb/dwc3/gadget.c                          |  14 +-
 drivers/usb/gadget/configfs.c                      |  26 +-
 drivers/usb/gadget/epautoconf.c                    |   2 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  97 +++++-
 drivers/usb/gadget/function/f_uac1.c               |   1 +
 drivers/usb/gadget/function/f_uac2.c               |  24 +-
 drivers/usb/gadget/function/f_uvc.c                |   8 +-
 drivers/usb/gadget/function/u_audio.c              |  96 ++++--
 drivers/usb/gadget/function/u_audio.h              |  10 +-
 drivers/usb/gadget/function/u_ether.c              |   4 +-
 drivers/usb/gadget/function/u_uac2.h               |   1 -
 drivers/usb/gadget/function/uvc.h                  |   6 +-
 drivers/usb/gadget/function/uvc_queue.c            |   2 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |  52 ++-
 drivers/usb/gadget/function/uvc_video.c            |  71 +++-
 drivers/usb/gadget/function/uvc_video.h            |   2 -
 drivers/usb/gadget/legacy/hid.c                    |   4 +-
 drivers/usb/gadget/udc/Kconfig                     |   1 +
 drivers/usb/gadget/udc/amd5536udc.h                |   1 -
 drivers/usb/gadget/udc/core.c                      |  10 +-
 drivers/usb/gadget/udc/goku_udc.c                  |   6 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |   2 +-
 drivers/usb/gadget/udc/snps_udc_plat.c             |   5 -
 drivers/usb/gadget/udc/udc-xilinx.c                |  25 ++
 drivers/usb/host/Kconfig                           |   6 +-
 drivers/usb/host/ehci-atmel.c                      |   8 +
 drivers/usb/host/ehci-hcd.c                        |  13 +-
 drivers/usb/host/ehci-hub.c                        |  11 +-
 drivers/usb/host/ehci-mem.c                        |   3 +-
 drivers/usb/host/ehci-mv.c                         |   2 -
 drivers/usb/host/ehci-platform.c                   |   6 +
 drivers/usb/host/ehci.h                            |   1 +
 drivers/usb/host/fotg210-hcd.c                     |   5 +-
 drivers/usb/host/max3421-hcd.c                     |  25 +-
 drivers/usb/host/ohci-hcd.c                        |   3 +-
 drivers/usb/host/ohci-hub.c                        |   3 +
 drivers/usb/host/ohci-tmio.c                       |   2 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   2 +-
 drivers/usb/host/xhci-mtk-sch.c                    |   2 +-
 drivers/usb/host/xhci-pci.c                        |  16 +
 drivers/usb/misc/iowarrior.c                       |   8 +-
 drivers/usb/musb/Kconfig                           |   2 +-
 drivers/usb/musb/mediatek.c                        |   1 +
 drivers/usb/musb/musb_gadget.c                     |   4 +-
 drivers/usb/musb/sunxi.c                           |   8 +
 drivers/usb/musb/tusb6010.c                        |   5 +
 drivers/usb/phy/phy-tahvo.c                        |   4 -
 drivers/usb/phy/phy-tegra-usb.c                    | 198 ++++++++++-
 drivers/usb/serial/ch341.c                         |  85 ++---
 drivers/usb/serial/cp210x.c                        | 109 ++----
 drivers/usb/serial/f81232.c                        |  96 ++----
 drivers/usb/serial/ftdi_sio.c                      |  53 +--
 drivers/usb/serial/keyspan.c                       |  15 +-
 drivers/usb/serial/keyspan_pda.c                   |  67 ++--
 drivers/usb/serial/kl5kusb105.c                    | 115 +++----
 drivers/usb/serial/usb-serial.c                    |  59 ++--
 drivers/usb/storage/unusual_devs.h                 |  10 +
 drivers/usb/typec/Kconfig                          |   4 +-
 drivers/usb/typec/hd3ss3220.c                      |   8 +-
 drivers/usb/typec/tcpm/tcpci.c                     |   2 +-
 drivers/usb/typec/tipd/core.c                      | 223 +++++++++---
 drivers/usb/typec/tipd/tps6598x.h                  |  12 +
 drivers/usb/typec/tipd/trace.h                     |  23 ++
 drivers/usb/typec/ucsi/ucsi.c                      | 337 +++++++++----------
 drivers/usb/typec/ucsi/ucsi.h                      |   3 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |   2 +-
 drivers/usb/usb-skeleton.c                         |   2 +-
 include/linux/usb/tegra_usb_phy.h                  |   5 +
 99 files changed, 2074 insertions(+), 1038 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb3503.txt
