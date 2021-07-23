Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9493D3C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhGWONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhGWONQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C69B460EBC;
        Fri, 23 Jul 2021 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627052030;
        bh=vRu/xkzXNVGQFHkOTPQhC/L062RFRXp6Kp7+apFbUkI=;
        h=Date:From:To:Cc:Subject:From;
        b=bc4MwcaeBEBPAvowzxlB04Bzotr3TZlyy6hG2EZQkHCIHB/vzb/7/gNpJMD2v3V5b
         6Rdbg+Em2VAGVftk+hXkfU9/Mvl+55TjdUac1rXiNGQwjmnW+oQUAyWHmGDfkYpmfJ
         Kl1soYCLPNYXpojLNPyD/X4gJGomVtQ6SHCM7cNk=
Date:   Fri, 23 Jul 2021 16:53:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.14-rc3
Message-ID: <YPrX98Lqa1xH8uH7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc3

for you to fetch changes up to 1d1b97d5e7636d72890a5bdd0b40e980e54b2d34:

  Merge tag 'usb-serial-5.14-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2021-07-22 20:51:14 +0200)

----------------------------------------------------------------
USB fixes for 5.14-rc3

Here are some USB fixes for 5.14-rc3 to resolve a bunch of tiny problems
reported.  Included in here are:
	- dtsi revert to resolve a problem which broke android systems
	  that relied on the dts name to find the USB controller device.
	  People are still working out the "real" solution for this, but
	  for now the revert is needed.
	- core USB fix for pipe calculation found by syzbot
	- typec fixes
	- gadget driver fixes
	- new usb-serial device ids
	- new USB quirks
	- xhci fixes
	- usb hub fixes for power management issues reported
	- other tiny fixes

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: core: Fix incorrect pipe calculation in do_proc_control()

Amelie Delaunay (2):
      usb: typec: stusb160x: register role switch before interrupt registration
      usb: typec: stusb160x: Don't block probing of consumer of "connector" nodes

Artur Petrosyan (1):
      usb: phy: Fix page fault from usb_phy_uevent

Colin Ian King (1):
      usb: gadget: u_serial: remove WARN_ON on null port

David Jeffery (1):
      usb: ehci: Prevent missed ehci interrupts with edge-triggered MSI

Greg Kroah-Hartman (2):
      Revert "arm64: dts: qcom: Harmonize DWC USB3 DT nodes name"
      Merge tag 'usb-serial-5.14-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Greg Thelen (1):
      usb: xhci: avoid renesas_usb_fw.mem when it's unusable

Ian Ray (1):
      USB: serial: cp210x: fix comments for GE CS1000

John Keeping (1):
      USB: serial: cp210x: add ID for CEL EM3588 USB ZigBee stick

Julian Sikorski (1):
      USB: usb-storage: Add LaCie Rugged USB3-FW to IGNORE_UAS

Linyu Yuan (1):
      usb: dwc3: avoid NULL access of usb_gadget_driver

Lukas Bulwahn (1):
      MAINTAINERS: repair reference in USB IP DRIVER FOR HISILICON KIRIN 970

Marco De Marco (1):
      USB: serial: option: add support for u-blox LARA-R6 family

Marek Szyprowski (1):
      usb: dwc2: Skip clock gating on Samsung SoCs

Mark Tomlinson (1):
      usb: max-3421: Prevent corruption of freed memory

Martin Kepplinger (1):
      usb: typec: tipd: Don't block probing of consumer of "connector" nodes

Mathias Nyman (3):
      xhci: Fix lost USB 2 remote wake
      usb: hub: Fix link power management max exit latency (MEL) calculations
      usb: hub: Disable USB 3 device initiated lpm if exit latency is too high

Minas Harutyunyan (2):
      usb: dwc2: gadget: Fix GOUTNAK flow for Slave mode.
      usb: dwc2: gadget: Fix sending zero length packet in DDMA mode.

Moritz Fischer (1):
      Revert "usb: renesas-xhci: Fix handling of unknown ROM state"

Vincent Palatin (1):
      Revert "USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem"

Wei Yongjun (1):
      usb: cdc-wdm: fix build error when CONFIG_WWAN_CORE is not set

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: Fix superfluous irqs happen after usb_pkt_pop()

Zhang Qilong (1):
      usb: gadget: Fix Unbalanced pm_runtime_enable in tegra_xudc_probe

 MAINTAINERS                                  |   2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |   4 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi        |   4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi        |   4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi        |   2 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     |   2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi         |   2 +-
 drivers/usb/class/cdc-wdm.c                  |   6 +-
 drivers/usb/core/devio.c                     |   2 +-
 drivers/usb/core/hub.c                       | 120 +++++++++++++++++++--------
 drivers/usb/core/quirks.c                    |   4 -
 drivers/usb/dwc2/core.h                      |   4 +
 drivers/usb/dwc2/core_intr.c                 |   3 +-
 drivers/usb/dwc2/gadget.c                    |  31 ++++++-
 drivers/usb/dwc2/hcd.c                       |   6 +-
 drivers/usb/dwc2/params.c                    |   1 +
 drivers/usb/dwc3/core.h                      |   1 +
 drivers/usb/dwc3/ep0.c                       |  10 ++-
 drivers/usb/dwc3/gadget.c                    |  21 +++--
 drivers/usb/gadget/function/u_serial.c       |   2 +-
 drivers/usb/gadget/udc/tegra-xudc.c          |   1 +
 drivers/usb/host/ehci-hcd.c                  |  18 +++-
 drivers/usb/host/max3421-hcd.c               |  44 ++++------
 drivers/usb/host/xhci-hub.c                  |   3 +-
 drivers/usb/host/xhci-pci-renesas.c          |  16 ++--
 drivers/usb/host/xhci-pci.c                  |   7 ++
 drivers/usb/phy/phy.c                        |  10 ++-
 drivers/usb/renesas_usbhs/fifo.c             |   7 ++
 drivers/usb/serial/cp210x.c                  |   5 +-
 drivers/usb/serial/option.c                  |   3 +
 drivers/usb/storage/unusual_uas.h            |   7 ++
 drivers/usb/typec/stusb160x.c                |  20 ++++-
 drivers/usb/typec/tipd/core.c                |   9 ++
 36 files changed, 264 insertions(+), 127 deletions(-)
