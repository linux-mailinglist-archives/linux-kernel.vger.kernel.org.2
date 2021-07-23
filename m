Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612A43D3C83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhGWO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:58:46 -0400
Received: from foss.arm.com ([217.140.110.172]:47570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235503AbhGWO6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:58:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546BC139F;
        Fri, 23 Jul 2021 08:39:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97F043F73D;
        Fri, 23 Jul 2021 08:39:13 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH v8 00/11] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Fri, 23 Jul 2021 16:38:27 +0100
Message-Id: <20210723153838.6785-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another try on the basic Allwinner H616 support, now on top of 5.14-rc1.

This time I dropped the USB support from the basic series, to split off
the discussion, and simplify the core SoC support. I will post the USB
series soon, to be applied on top.
I kept the RTC support in, even though this is still under discussion,
because this is important to keep future DT files compatible with this
kernel. This gains one fix patch for the existing RTC driver.

For a complete changelog, see below.

Based on 5.14-rc1. Let me know if you need a different base.
Relies on this pinctrl fix:
http://lists.infradead.org/pipermail/linux-arm-kernel/2021-July/672813.html

Also available here: https://github.com/apritzel/linux/commits/h616-v8

Thanks!
Andre

==================
This series gathers patches to support the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

Some DT binding patches are sprinkled throughout the series, to add
the new compatible names right before they are used.
Patch 3-7 add support for the new RTC: the date is now stored as a
linear number, not broken down into day-month-year. The benefit is that
this lifts the limit of the old date counter, which would have rolled
over around 2032. Also the alarm setting is using the same storage
format as the current time, compared to the number of seconds left used
in existing SoCs.
Eventually we get the .dtsi for the SoC in patch 8, and the .dts for
the OrangePi Zero2 board[1] in the penultimate patch, followed by
the .dts for the X96 Mate TV box[2] in the final commit.

U-Boot and Trusted Firmware support is now merged in released versions,
it allows booting via FEL or SD card, also you can TFTP kernels in on
the OrangePi Zero 2 board.

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

The whole series (including the pinctrl fix) can also be found here:
https://github.com/apritzel/linux/commits/h616-v8

Happy reviewing!

Cheers,
Andre

[1] https://linux-sunxi.org/Orange_Pi_Zero_2
[2] https://linux-sunxi.org/X96_Mate

Changelog v7 .. v8:
- Rebase on top of 5.14-rc1, which already includes the previous v7 02/19
- Drop USB and Ethernet patches (to keep series small)
- Use "clocks: false" in RTC DT binding (2/11)
- Include fix for RTC overflow check (3/11)
- Use div_64() to avoid linking error on some 32-bit platforms (4+5/11)
- Adjust to changed RTC overflow check (5/11)
- Drop USB nodes from .dtsi file
- Move mmc-ddr-1_8v property from .dtsi file into board .dts
- Fix DTC warnings (underscore in node name, soc@0, #a-c in IRQ controllers)

Changelog v6 .. v7:
- Fix AXP305 binding documentation blunder (01/19)
- Improve new linear day support (use existing conversion functions) (04/19)
- Add support for changed RTC alarm registers (05/19)
- Add support for RTCs without a LOSC clock (06/19)
- Rework USB PHY2 SIDDQ quirk to use PHY clocks directly (14/19)
- Add X96 Mate compatible string to binding doc (17/19)
- Add Rob's ACKs

Changelog v5 .. v6:
- Drop already merged clock, pinctrl and MMC support from this series
- Properly fix AXP support by skipping power key initialisation
- Add patch to support new RTC date storage encoding
- Re-add USB HCI PHY refactoring
- Add patch to allow USB reset line sharing
- Add patch to introduce quirk for PHY2 SIDDQ clearing
- Re-add USB nodes to the .dtsi
- Add USB gadget support
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

Andre Przywara (11):
  dt-bindings: mfd: axp20x: Add AXP305 compatible (plus optional IRQ)
  dt-bindings: rtc: sun6i: Add H616 compatible string
  rtc: sun6i: Fix time overflow handling
  rtc: sun6i: Add support for linear day storage
  rtc: sun6i: Add support for broken-down alarm registers
  rtc: sun6i: Add support for RTCs without external LOSCs
  rtc: sun6i: Add Allwinner H616 support
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  dt-bindings: arm: sunxi: Add two H616 board compatible strings
  arm64: dts: allwinner: h616: Add OrangePi Zero 2 board support
  arm64: dts: allwinner: h616: Add X96 Mate TV box support

 .../devicetree/bindings/arm/sunxi.yaml        |  10 +
 .../devicetree/bindings/mfd/axp20x.txt        |   3 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |  14 +
 arch/arm64/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  | 204 +++++++
 .../dts/allwinner/sun50i-h616-x96-mate.dts    | 178 ++++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 575 ++++++++++++++++++
 drivers/rtc/rtc-sun6i.c                       | 169 +++--
 8 files changed, 1104 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi

-- 
2.17.6

