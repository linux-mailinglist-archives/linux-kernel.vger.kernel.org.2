Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE2388BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348168AbhESKn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:43:29 -0400
Received: from foss.arm.com ([217.140.110.172]:58784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232768AbhESKn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:43:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 357E6101E;
        Wed, 19 May 2021 03:42:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745363F719;
        Wed, 19 May 2021 03:42:06 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/17] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Wed, 19 May 2021 11:41:35 +0100
Message-Id: <20210519104152.21119-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after some pause those are the "remaining" patches to get the new
Allwinner H616 SoC supported.
Compared to v5 from January there are quite some changes: For a start
the clock, pinctrl and MMC bits made it into v5.12 already, so this series
starts right after that. The missing interrupt facility of the AXP is now
hopefully solved properly (patch 02).
The RTC turned out to be incompatible, the date is stored in a different
way. Patch 04 addresses this now. And finally the USB support got some
major overhaul: For a start it now seems to work - but I claimed that
before, so don't hold your breath, but test, please! There are now two
new patches to the Allwinner USB PHY driver to make this happen (11 and 12),
plus we need some seemingly random extra list of clocks and reset added to
each EHCI and OHCI node. Not pretty, but this looks like a nasty hardware
problem, so probably justifies some quirk. Meh.

Changelog below. Based on 5.13-rc1.

U-Boot support is part of the v2021.04 release, and Trusted Firmware
support is also mainline and part of the just released v2.5 version.

As an added bonus I got myself the "X96 Mate" TV box [2] with this SoC, so
the final patch contains a DT for this box as well. Probably the first
supported Allwinner machine with 4GB of DRAM actually usable.

The whole series can also be found here:
https://github.com/apritzel/linux/commits/h616-v6

Thanks!
Andre

==================
This series gathers patches to support the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

Various DT binding patches are sprinkled throughout the series, to add
the new compatible names right before they are used.
Patch 2 teaches the AXP MFD driver to get along without having an
interrupt, as the missing NMI pin on the H616 leads to some boards not
having the AXP IRQ line connected.
Patch 4 and 5 add support for the new RTC: the date is now stored as a
linear number, not broken down into day-month-year. The benefit is that
this lifts the limit of the old date counter, which would have rolled
over around 2032. 
Patch 7 adds a tweak to the EMAC driver, to deal with the second EMAC
clock used for the second Ethernet controller.
This is somewhat optional for the current .dts, as this doesn't use
the second EMAC (yet).
Patches 10-13 add the USB support, there are several small changes needed
to the Allwinner PHY driver to make this work. Some hardware changes look
like accidents ;-)
Eventually we get the .dtsi for the SoC in patch 14, and the .dts for
the OrangePi Zero2 board[1] in the penultimate patch, followed by
the .dts for the X96 Mate TV box[2] in the final commit.

U-Boot and Trusted Firmware support is now merged in released versions,
it allows booting via FEL or SD card, also you can TFTP kernels in on
the OrangePi Zero 2 board.

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

Happy reviewing!

Cheers,
Andre

[1] https://linux-sunxi.org/Orange_Pi_Zero_2
[2] https://linux-sunxi.org/X96_Mate

Changelog v5 .. v6:
- Drop already merged clock, pinctrl and MMC support from this series
- Properly fix AXP support by skipping power key initialisation
- Add patch to support new RTC date storage encoding
- Re-add USB HCI PHY refactoring
- Add patch to allow USB reset line sharing
- Add patch to introduce quirk for PHY2 SIDDQ clearing
- Re-add USB nodes to the .dtsi
- Enable USB gadget support
- Add DT for X96 Mate TV box

Changelog v4 .. v5:
- Fix CCU binding to pass dtbs_check
- Add RSB compatible string to binding doc
- Rename IR pin name to pass dtbs_check
- Add EMAC compatible string to binding doc
- Drop USB PHY support and binding doc patches 
- Drop USB nodes from .dtsi and .dts
- Drop second EMAC node from .dtsi

Changelog v3 .. v4:
- Drop MMC and pinctrl matches (already in some -next trees)
- Add Maxime's Acks
- Add patch to update the AXP MFD DT bindings
- Add new patch (05/21) to fix axp20x-pek driver
- Change AXP IRQ fix to check for invalid IRQ line number
- Split joint DT bindings patch (v3 18/21) into subsystems
- move dwmac variable to keep christmas tree
- Use enums for USB PHY compatible strings in DT binding
- Enable watchdog (briefly verified to work)
- Add PHY2 to HCI1&3, this fixes USB
- limit r-ccu register frame length to not collide with NMI controller
- add interrupt-controller property to AXP DT node

Changelog v2 .. v3:
- Add Rob's Acks
- Drop redundant maxItems from pinctrl DT binding
- Rename h_i2s* to just i2s* in pinctrl names
- Use more declarative i2s0_d{in,out}{0,1} names
- Add RSB pins to pinctrl
- Include RSB clocks (sharing with newly added H6 versions)
- Fix CEC clock (add 2nd enable bit, also fix predivider flag)
- Rename PMU_UNK1 register in USB PHY
- Add USB and MUSB DT binding patches
- Add MMC/SD speed modes to .dtsi

Changelog v1 .. v2:
- pinctrl: adjust irq bank map to cover undocumented GPIO bank IRQs
- use differing h_i2s0 pin output names
- r-ccu: fix number of used clocks
- ccu: remove PLL-PERIPHy(4X)
- ccu: fix gpu1 divider range
- ccu: fix usb-phy3 parent
- ccu: add missing TV clocks
- ccu: rework to CLK_OF_DECLARE style
- ccu: enable output bit for PLL clocks
- ccu: renumber clocks
- .dtsi: drop sun50i-a64-system-control fallback
- .dtsi: drop unknown SRAM regions
- .dtsi: add more (undocumented) GPIO interrupts
- .dtsi: fix I2C3 pin names
- .dtsi: use a100-emmc fallback for MMC2
- .dtsi: add second EMAC controller
- .dtsi: use H3 MUSB controller fallback
- .dtsi: fix frame size for USB PHY PMU registers
- .dtsi: add USB0 PHY references
- .dtsi: fix IR controller clock source
- .dts: fix LED naming and swap pins
- .dts: use 5V supply parent for USB supply
- .dts: drop dummy IRQ for AXP
- .dts: enable 3V3 header pin power rail
- .dts: add SPI flash node
- .dts: make USB-C port peripheral only
- add IRQ-less AXP support
- add two patches to support more than one EMAC clock
- add patch to rework and extend USB PHY support
- add DT binding documentation patches

Andre Przywara (20):
  dt-bindings: clk: sunxi-ccu: Add compatible string for Allwinner H616
  clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
  clk: sunxi-ng: Add support for the Allwinner H616 CCU
  dt-bindings: mfd: axp20x: Add AXP305 compatible (plus optional IRQ)
  Input: axp20x-pek: Bail out if AXP has no interrupt line connected
  mfd: axp20x: Allow AXP chips without interrupt lines
  dt-bindings: sram: sunxi-sram: Add H616 compatible string
  soc: sunxi: sram: Add support for more than one EMAC clock
  dt-bindings: watchdog: sun4i: Add H616 compatible string
  dt-bindings: i2c: mv64xxx: Add H616 compatible string
  dt-bindings: media: IR: Add H616 IR compatible string
  dt-bindings: rtc: sun6i: Add H616 compatible string
  dt-bindings: spi: sunxi: Add H616 compatible string
  dt-bindings: bus: rsb: Add H616 compatible string
  dt-bindings: net: sun8i-emac: Add H616 compatible string
  net: stmmac: dwmac-sun8i: Prepare for second EMAC clock register
  phy: sun4i-usb: Rework HCI PHY (aka. "pmu_unk1") handling
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
  arm64: dts: allwinner: Add OrangePi Zero 2 .dts

Andre Przywara (17):
  dt-bindings: mfd: axp20x: Add AXP305 compatible (plus optional IRQ)
  mfd: axp20x: Allow AXP 806 chips without interrupt lines
  dt-bindings: rtc: sun6i: Add H616 compatible string
  rtc: sun6i: Add support for linear day storage
  rtc: sun6i: Add Allwinner H616 support
  dt-bindings: net: sun8i-emac: Add H616 compatible string
  net: stmmac: dwmac-sun8i: Prepare for second EMAC clock register
  dt-bindings: usb: Add H616 compatible string
  dt-bindings: usb: sunxi-musb: Add H616 compatible string
  phy: sun4i-usb: Rework HCI PHY (aka. "pmu_unk1") handling
  phy: sun4i-usb: Allow reset line to be shared
  phy: sun4i-usb: Introduce port2 SIDDQ quirk
  phy: sun4i-usb: Add support for the H616 USB PHY
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
  arm64: dts: allwinner: h616: Add OrangePi Zero 2 board support
  arm64: dts: allwinner: h616: Add X96 Mate TV box support

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../devicetree/bindings/mfd/axp20x.txt        |   3 +-
 .../net/allwinner,sun8i-a83t-emac.yaml        |   4 +-
 .../phy/allwinner,sun8i-h3-usb-phy.yaml       |   4 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |   5 +-
 .../usb/allwinner,sun4i-a10-musb.yaml         |   3 +
 arch/arm64/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  | 245 ++++++
 .../dts/allwinner/sun50i-h616-x96-mate.dts    | 201 +++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 747 ++++++++++++++++++
 drivers/mfd/axp20x.c                          |  24 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  12 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         |  73 +-
 drivers/rtc/rtc-sun6i.c                       |  62 +-
 14 files changed, 1342 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi

-- 
2.17.5

