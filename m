Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149AD3061EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhA0R0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:26:50 -0500
Received: from foss.arm.com ([217.140.110.172]:56368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234551AbhA0R0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:26:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66A311FB;
        Wed, 27 Jan 2021 09:25:47 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83C923F66E;
        Wed, 27 Jan 2021 09:25:45 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v5 00/20] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Wed, 27 Jan 2021 17:24:40 +0000
Message-Id: <20210127172500.13356-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a small update from v4, fixing some DT validation issues:
dtbs_check now comes back clean for me.
Also I dropped USB support for now. It turns out that this is more messy
than we thought: it only works if all four USB controllers are enabled
(and not just some PHYs). That smells like some shared reset or clock
gate, but we haven't found the culprit yet. Also the BSP source suggests
that there is a "hardware design issue" that requires some PHY tune
register to be programmed, so we probably need more code anyway.
I also dropped the DT node for the second EMAC, as this is mostly
untested at this point.

Changelog below. Based on the (updated) sunxi/for-next branch.

I was hoping that at least the clock and AXP patches (01/20-06/20) could
make it into 5.12 still?  That would allow booting boards from SD card.
Patch 08/20 would enable Ethernet.
U-Boot support is now merged into its master tree.

Thanks!
Andre

==================
This series gathers patches to support the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

Various DT binding patches are sprinkled throughout the series, to add
the new compatible names right before they are used.
Patch 2 and 3 add clock support. For the -R clock this is shared with
the H6 code, as the clocks are identical, with the H616 just having
fewer of them. The main clocks are different enough to warrant a separate
file.
Patches 5 and 6 teach the AXP MFD driver to get along without having an
interrupt, as the missing NMI pin on the H616 leads to some boards not
having the AXP IRQ line connected.
Patch 8 and 16 add some tweaks to the syscon and EMAC driver, to deal
with the second EMAC clock used for the second Ethernet controller.
This is somewhat optional for the current .dts, as this doesn't use
the second EMAC.

The remaining patches add DT bindings, which just add the new compatible
string along with an existing name as a fallback string.
Eventually we get the .dtsi for the SoC in patch 19, and the .dts for
the OrangePi Zero2 board[1] in the last patch.

We have U-Boot and Trusted-Firmware support in a working state, booting
via FEL or SD card and even TFTPing kernels work already [2][3].
The U-Boot patches are already merged into the mainline repository.

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

The whole series (including the other patches) can also be found here:
https://github.com/apritzel/linux/commits/h616-v5

Happy reviewing!

Cheers,
Andre

[1] https://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
[2] https://github.com/jernejsk/u-boot/commits/h616-v2
[3] https://github.com/apritzel/arm-trusted-firmware/commits/h616-v1

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

 .../devicetree/bindings/arm/sunxi.yaml        |    5 +
 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml |    4 +-
 .../clock/allwinner,sun4i-a10-ccu.yaml        |    4 +
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |   21 +-
 .../media/allwinner,sun4i-a10-ir.yaml         |   16 +-
 .../devicetree/bindings/mfd/axp20x.txt        |    3 +-
 .../net/allwinner,sun8i-a83t-emac.yaml        |    4 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |    3 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |    1 +
 .../allwinner,sun4i-a10-system-control.yaml   |    1 +
 .../watchdog/allwinner,sun4i-a10-wdt.yaml     |   12 +-
 arch/arm64/boot/dts/allwinner/Makefile        |    1 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |  203 +++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  573 ++++++++
 drivers/clk/sunxi-ng/Kconfig                  |    7 +-
 drivers/clk/sunxi-ng/Makefile                 |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   48 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c        | 1150 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   56 +
 drivers/input/misc/axp20x-pek.c               |    4 +
 drivers/mfd/axp20x.c                          |   17 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   12 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         |   29 +-
 drivers/soc/sunxi/sunxi_sram.c                |   31 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h   |  115 ++
 include/dt-bindings/reset/sun50i-h616-ccu.h   |   70 +
 26 files changed, 2323 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
 create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h

-- 
2.17.5

