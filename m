Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC983B8895
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhF3Sky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbhF3Skx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D013B613F1;
        Wed, 30 Jun 2021 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078304;
        bh=XPfKGss8+iRq7chr4p+CYOn2SGnh8R/z0BKtpyVPt9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=t9xSUj7BObR/GrAl7Cml0uy7fE8T+7RZeI24IZlGcN36HX1x/YnhZVnoRsaOLMp32
         3KqCd2ZW8iUmv5SguCeMnGNPbzJogJxERCncCx73ec5Z8qYD/MtUaVUOve/ju+9sGm
         8kJHUhlc82YmcH2C+ZtDEwppqqCEKQDnKw7ep8s6k0n0x94IG71ikSE3nuCqZ2D9k6
         VLtVI5of8BwxNCMRDQexzhQORWBWOLmY4GAu+VMVW8SHzRrYU5YEEMkVvOiKSfewvJ
         Paiv28gYrES/gYjiPO7fKqHWocUM+d6mORsYJN3aSwiuQEeNxFsVXKEiGdeBmQuloT
         3N9MFIPxCNRKg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed, 30 Jun 2021 11:38:23 -0700
Message-Id: <20210630183823.3500371-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to d2b21013bf5fb177c08b2c9c4dfa32ee0fc97b53:

  Merge branches 'clk-st', 'clk-si' and 'clk-hisilicon' into clk-next (2021-06-29 13:33:42 -0700)

----------------------------------------------------------------
This round has a diffstat dominated by Qualcomm clk drivers. Honestly though
that's just a bunch of data so the diffstat reflects that. Looking beyond that
there's just a bunch of updates all around in various clk drivers. Renesas and
NXP (for i.MX) are two SoC vendors that have a lot of patches in here. Overall
the driver changes look to be mostly enabling more clks and non-critical fixes
that we could hold until the next merge window.

I'm especially excited about the series from Arnd that graduates clkdev to be
the only implementation of clk_get() and clk_put(). That's a good step in the
right direction to migreate eveerything over to the common clk framework. Now
we don't have to worry about clkdev specific details, they're just part of the
clk API now.

Core:
 - clkdev is now the only option, i.e. clk_get()/clk_put() is implemented in
   only one place in the kernel instead of in drivers/clk/clkdev.c and in
   architectures that want their own implementation

New Drivers:
 - Texas Instruments' LMK04832 Ultra Low-Noise JESD204B Compliant Clock
   Jitter Cleaner With Dual Loop PLLs
 - Qualcomm MDM9607 GCC
 - Qualcomm SC8180X display clks
 - Qualcomm SM6125 GCC
 - Qualcomm SM8250 CAMCC (camera)
 - Renesas RZ/G2L SoC
 - Hisilicon hi3559A SoC

Updates:
 - Stop using clock-output-names in ST clk drivers (yay!)
 - Support secure mode of STM32MP1 SoCs
 - Improve clock support for Actions S500 SoC
 - duty cycle setting support on qcom clks
 - Add TI am33xx spread spectrum clock support
 - Use determine_rate() for the Amlogic pll ops instead of round_rate()
 - Restrict Amlogic gp0/1 and audio plls range on g12a/sm1
 - Improve Amlogic axg-audio controller error on deferral
 - Add NNA clocks on Amlogic g12a
 - Reduce memory footprint of Rockchip PLL rate tables
 - A fix for the newly added Rockchip rk3568 clk driver
 - Exported clock for the newly added Rockchip video decoder
 - Remove audio ipg clock from i.MX8MP
 - Remove deprecated legacy clock binding for i.MX SCU clock driver
 - Use common clk-imx8qxp for both i.MX8QXP and i.MX8QM
 - Add multiple clocks to clk-imx8qxp driver (enet, hdmi, lcdif, audio,
   parallel interface)
 - Add dedicated clock ops for i.MX paralel interface
 - Different fixes for clocks controlled by ATF on i.MX SoCs
 - Add A53/A72 frequency scaling support i.MX clk-scu driver
 - Add special case for DCSS clock on suspend for i.MX clk-scu driver
 - Add parent save/restore on suspend/resume to i.MX clk-scu driver
 - Skip runtime PM enablement for CPU clocks in i.MX clk-scu driver
 - Remove the sys1_pll/sys2_pll clock gates for i.MX8MQ and their
   bindings
 - Tegra clk driver no longer deasserts resets on clk_enable as it
   gets in the way of certain power-up sequences
 - Fix compile testing for Tegra clk driver
 - One patch to fix a divider on the Allwinner v3s Audio PLL
 - Add support for CPU core clock boost modes on Renesas R-Car Gen3
 - Add ISPCS (Image Signal Processor) clocks on Renesas R-Car V3U
 - Switch SH/R-Mobile and R-Car "DIV6" clocks to .determine_rate()
   and improve support for multiple parents
 - Switch Renesas RZ/N1 divider clocks to .determine_rate()
 - Add ZA2 (Audio Clock Generator) clock on Renesas R-Car D3
 - Convert ar7 to common clk framework
 - Convert ralink to common clk framework

----------------------------------------------------------------
Alain Volmat (7):
      clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
      clk: st: flexgen: embed soc clock outputs within compatible data
      dt-bindings: clock: st: flexgen: add new introduced compatible
      clk: st: clkgen-pll: embed soc clock outputs within compatible data
      dt-bindings: clock: st: clkgen-pll: add new introduced compatible
      clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
      dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible

Alex Bee (1):
      clk: rockchip: export ACLK_VCODEC for RK3036

Alexandru Ardelean (1):
      clk: tegra: clk-tegra124-dfll-fcpu: don't use devm functions for regulator

Anson Huang (3):
      clk: imx: scu: Add A53 frequency scaling support
      clk: imx: scu: Add A72 frequency scaling support
      clk: imx: scu: Only save DC SS clock using non-cached clock rate

Arnd Bergmann (7):
      mips: ar7: convert to clkdev_lookup
      mips: ar7: convert to CONFIG_COMMON_CLK
      mips: ralink: convert to CONFIG_COMMON_CLK
      m68k: coldfire: use clkdev_lookup on most coldfire
      m68k: coldfire: remove private clk_get/clk_put
      clkdev: remove CONFIG_CLKDEV_LOOKUP
      clkdev: remove unused clkdev_alloc() interfaces

Bartosz Dudziak (4):
      dt-bindings: clock: qcom: rpmcc: Document MSM8226 compatible
      dt-bindings: clock: qcom: Add MSM8226 GCC clock bindings
      clk: qcom: gcc: Add support for Global Clock controller found on MSM8226
      clk: qcom: smd-rpmcc: Add support for MSM8226 rpm clocks

Bjorn Andersson (2):
      clk: qcom: dispcc-sm8250: Add sc8180x support
      clk: qcom: dispcc-sm8250: Add EDP clocks

Christophe JAILLET (1):
      clk: zynqmp: pll: Remove some dead code

Cristian Ciocaltea (6):
      clk: actions: Fix UART clock dividers on Owl S500 SoC
      clk: actions: Fix SD clocks factor table on Owl S500 SoC
      clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
      clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
      dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
      clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC

Dan Carpenter (1):
      clk: qcom: cleanup some dev_err_probe() calls

Dario Binacchi (5):
      clk: ti: fix typo in routine description
      dt-bindings: ti: dpll: add spread spectrum support
      ARM: dts: am33xx-clocks: add spread spectrum support
      ARM: dts: am43xx-clocks: add spread spectrum support
      clk: ti: add am33xx/am43xx spread spectrum clock support

Dinghao Liu (1):
      clk: renesas: rcar-usb2-clock-sel: Fix error handling in .probe()

Dinh Nguyen (4):
      clk: agilex/stratix10: remove noc_clk
      clk: agilex/stratix10: fix bypass representation
      clk: agilex/stratix10: add support for the 2nd bypass
      clk: agilex/stratix10/n5x: fix how the bypass_reg is handled

Dmitry Osipenko (9):
      clk: tegra30: Use 300MHz for video decoder by default
      clk: tegra: Fix refcounting of gate clocks
      clk: tegra: Ensure that PLLU configuration is applied properly
      clk: tegra: Halve SCLK rate on Tegra20
      clk: tegra: Don't allow zero clock rate for PLLs
      clk: tegra: cclk: Handle thermal DIV2 CPU frequency throttling
      clk: tegra: Mark external clocks as not having reset control
      clk: tegra: Don't deassert reset on enabling clocks
      clk: tegra: Add stubs needed for compile-testing

Dong Aisheng (12):
      dt-bindings: arm: imx: scu: fix naming typo of clk compatible string
      dt-bindings: arm: imx: scu: drop deprecated legacy clock binding
      clk: imx: scu: remove legacy scu clock binding support
      clk: imx: scu: add gpr clocks support
      clk: imx8qxp: add clock valid checking mechnism
      clk: imx8qm: add clock valid resource checking
      clk: imx: scu: add enet rgmii gpr clocks
      clk: imx: scu: add more scu clocks
      clk: imx: scu: bypass cpu clock save and restore
      clk: imx: scu: detach pd if can't power up
      clk: imx: scu: bypass pi_pll enable status restore
      clk: imx: scu: add parent save and restore

Dongjiu Geng (2):
      dt-bindings: Document the hi3559a clock bindings
      clk: hisilicon: Add clock driver for hi3559A SoC

Elaine Zhang (1):
      clk: rockchip: Optimize PLL table memory usage

Gabriel Fernandez (11):
      clk: stm32mp1: merge 'clk-hsi-div' and 'ck_hsi' into one clock
      clk: stm32mp1: merge 'ck_hse_rtc' and 'ck_rtc' into one clock
      clk: stm32mp1: remove intermediate pll clocks
      clk: stm32mp1: convert to module driver
      clk: stm32mp1: move RCC reset controller into RCC clock driver
      reset: stm32mp1: remove stm32mp1 reset
      dt-bindings: clock: add IDs for SCMI clocks on stm32mp15
      dt-bindings: reset: add IDs for SCMI reset domains on stm32mp15
      dt-bindings: reset: add MCU HOLD BOOT ID for SCMI reset domains on stm32mp15
      dt-bindings: clock: stm32mp1 new compatible for secure rcc
      clk: stm32mp1: new compatible for secure RCC support

Geert Uytterhoeven (17):
      clk: renesas: rcar-gen3: Update Z clock rate formula in comments
      clk: renesas: rcar-gen3: Make cpg_z_clk.mask u32
      clk: renesas: rcar-gen3: Remove superfluous masking in cpg_z_clk_set_rate()
      clk: renesas: rcar-gen3: Grammar s/dependent of/dependent on/
      clk: renesas: rcar-gen3: Increase Z clock accuracy
      clk: renesas: rcar-gen3: Add custom clock for PLLs
      clk: renesas: rcar-gen3: Add boost support to Z clocks
      clk: renesas: div6: Use clamp() instead of clamp_t()
      clk: renesas: div6: Simplify src mask handling
      clk: renesas: div6: Switch to .determine_rate()
      clk: renesas: div6: Consider all parents for requested rate
      clk: renesas: div6: Implement range checking
      clk: renesas: r9a06g032: Switch to .determine_rate()
      clk: renesas: cpg-mssr: Remove unused [RM]MSTPCR() definitions
      clk: renesas: cpg-mssr: Make srstclr[] comment block consistent
      Merge tag 'renesas-r9a07g044-dt-binding-defs-tag' into renesas-clk-for-v5.14
      dt-bindings: clock: gpio-mux-clock: Convert to json-schema

Guoniu.zhou (1):
      clk: imx: scu: add parallel port clock ops

Jacky Bai (1):
      clk: imx: Remove the audio ipg clock from imx8mp

Jerome Brunet (2):
      clk: meson: g12a: fix gp0 and hifi ranges
      clk: meson: axg-audio: improve deferral handling

Jian Xin (1):
      clk: socfpga: clk-pll: Remove unused variable 'rc'

Jonathan Marek (4):
      clk: qcom: clk-alpha-pll: add support for zonda pll
      dt-bindings: clock: add QCOM SM8250 camera clock bindings
      clk: qcom: Add camera clock controller driver for SM8250
      clk: qcom: clk-alpha-pll: fix CAL_L write in alpha_pll_fabia_prepare

Konrad Dybcio (6):
      dt-bindings: clock: Add MDM9607 GCC clock bindings
      clk: qcom: Add MDM9607 GCC driver
      clk: qcom: smd-rpm: Switch to parent_data
      clk: qcom: smd-rpm: De-duplicate identical entries
      clk: qcom: smd-rpm: Fix wrongly assigned RPM_SMD_PNOC_CLK
      clk: qcom: Add SM6125 (TRINKET) GCC driver

Kuninori Morimoto (1):
      clk: renesas: r8a77995: Add ZA2 clock

Lad Prabhakar (4):
      dt-bindings: clock: Add r9a07g044 CPG Clock Definitions
      dt-bindings: clock: renesas: Document RZ/G2L SoC CPG driver
      clk: renesas: Add CPG core wrapper for RZ/G2L SoC
      clk: renesas: Add support for R9A07G044 SoC

Liam Beguin (3):
      dt-bindings: clock: add ti,lmk04832 bindings
      clk: add support for the lmk04832
      clk: lmk04832: add support for digital delay

Lokesh Vutla (2):
      dt-bindings: clock: ehrpwm: Add support for AM64 specific compatible
      clk: keystone: syscon-clk: Add support for AM64 specific epwm-tbclk

Luca Ceresoli (1):
      clk: vc5: fix output disabling when enabling a FOD

Lucas Stach (1):
      clk: imx8mq: remove SYS PLL 1/2 clock gates

Martin Blumenstingl (1):
      clk: meson: pll: switch to determine_rate for the PLL ops

Martin Botka (1):
      dt-bindings: clk: qcom: gcc-sm6125: Document SM6125 GCC driver

Matti Vaittinen (1):
      clk: bd718xx: Drop BD70528 support

Michal Simek (1):
      clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE

Nick Xie (1):
      clk: meson: g12a: Add missing NNA source clocks for g12b

Niklas Söderlund (1):
      clk: renesas: r8a779a0: Add ISPCS clocks

Nitin Garg (1):
      clk: imx: scu: Do not enable runtime PM for CPU clks

Paul Cercueil (6):
      dt-bindings: clock: ingenic: Add ingenic,jz4760{,b}-cgu compatibles
      clk: Support bypassing dividers
      clk: ingenic: Read bypass register only when there is one
      clk: ingenic: Remove pll_info.no_bypass_bit
      clk: ingenic: Support overriding PLLs M/N/OD calc algorithm
      clk: ingenic: Add support for the JZ4760

Peter Collingbourne (1):
      clk: versatile: remove dependency on ARCH_*

Peter Geis (1):
      clk: rockchip: fix rk3568 cpll clk gate bits

Pu Lehui (1):
      clk/qcom: Remove unused variables

Rajan Vaja (4):
      clk: zynqmp: Use firmware specific common clock flags
      clk: zynqmp: Use firmware specific divider clock flags
      clk: zynqmp: Use firmware specific mux clock flags
      clk: zynqmp: Handle divider specific read only flag

Robert Hancock (9):
      dt-bindings: clock: clk-si5341: Add new attributes
      clk: si5341: Wait for DEVICE_READY on startup
      clk: si5341: Avoid divide errors due to bogus register contents
      clk: si5341: Check for input clock presence and PLL lock on startup
      clk: si5341: Update initialization magic
      clk: si5341: Allow different output VDD_SEL values
      clk: si5341: Add silabs,xaxb-ext-clk property
      clk: si5341: Add silabs,iovdd-33 property
      clk: si5341: Add sysfs properties to allow checking/resetting device faults

Stephen Boyd (16):
      Merge tag 'renesas-clk-for-v5.14-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      clk: versatile: Depend on HAS_IOMEM
      Merge tag 'clkdev-cleanup' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic into clk-legacy
      Merge tag 'renesas-clk-for-v5.14-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-fixes-for-5.13-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'for-5.14-clk' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into clk-nvidia
      Merge tag 'clk-imx-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'v5.14-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-meson-v5.14-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      clk: lmk04832: Depend on SPI
      clk: lmk04832: Use of match table
      Merge branches 'clk-qcom', 'clk-versatile', 'clk-renesas', 'clk-sifive' and 'clk-ti' into clk-next
      Merge branches 'clk-legacy', 'clk-vc5', 'clk-allwinner', 'clk-nvidia' and 'clk-imx' into clk-next
      Merge branches 'clk-rockchip', 'clk-amlogic', 'clk-yaml', 'clk-zynq' and 'clk-socfpga' into clk-next
      Merge branches 'clk-lmk04832', 'clk-stm', 'clk-rohm', 'clk-actions' and 'clk-ingenic' into clk-next
      Merge branches 'clk-st', 'clk-si' and 'clk-hisilicon' into clk-next

Taniya Das (2):
      clk: qcom: clk-rcg2: Add support for duty-cycle for RCG
      clk: qcom: gcc: Add support for a new frequency for SC7280

Tobias Schramm (1):
      clk: sunxi-ng: v3s: fix incorrect postdivider on pll-audio

Uwe Kleine-König (1):
      clk: qcom: Simplify usage of dev_err_probe()

Yang Li (1):
      clk: sifive: Fix kernel-doc

Yang Yingliang (2):
      clk: analogbits: fix doc warning in wrpll-cln28hpc.c
      clk: tegra: tegra124-emc: Fix clock imbalance in emc_set_timing()

Yu Jiahua (1):
      drivers: ti: remove redundant error message in adpll.c

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   10 +-
 .../devicetree/bindings/clock/gpio-mux-clock.txt   |   19 -
 .../devicetree/bindings/clock/gpio-mux-clock.yaml  |   45 +
 .../clock/hisilicon,hi3559av100-clock.yaml         |   59 +
 .../devicetree/bindings/clock/ingenic,cgu.yaml     |    4 +
 .../bindings/clock/qcom,camcc-sm8250.yaml          |   68 +
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm6125.yaml |   72 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    7 +-
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |    1 +
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |   83 +
 .../devicetree/bindings/clock/silabs,si5341.txt    |   16 +-
 .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml |    6 +-
 .../devicetree/bindings/clock/st/st,clkgen-pll.txt |    3 +
 .../devicetree/bindings/clock/st/st,flexgen.txt    |   10 +
 .../devicetree/bindings/clock/st/st,quadfs.txt     |    3 +
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml      |    4 +-
 .../devicetree/bindings/clock/ti,lmk04832.yaml     |  209 +
 .../devicetree/bindings/clock/ti/dpll.txt          |   20 +
 arch/arm/Kconfig                                   |    2 -
 arch/arm/boot/dts/am33xx-clocks.dtsi               |   10 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               |   12 +-
 arch/m68k/coldfire/clk.c                           |   21 -
 arch/m68k/coldfire/m5206.c                         |   25 +-
 arch/m68k/coldfire/m520x.c                         |   51 +-
 arch/m68k/coldfire/m523x.c                         |   42 +-
 arch/m68k/coldfire/m5249.c                         |   33 +-
 arch/m68k/coldfire/m525x.c                         |   33 +-
 arch/m68k/coldfire/m5272.c                         |   35 +-
 arch/m68k/coldfire/m527x.c                         |   44 +-
 arch/m68k/coldfire/m528x.c                         |   42 +-
 arch/m68k/coldfire/m5307.c                         |   27 +-
 arch/m68k/coldfire/m53xx.c                         |   78 +-
 arch/m68k/coldfire/m5407.c                         |   25 +-
 arch/m68k/coldfire/m5441x.c                        |  126 +-
 arch/m68k/coldfire/m54xx.c                         |   33 +-
 arch/m68k/include/asm/mcfclk.h                     |    5 -
 arch/mips/Kconfig                                  |    6 +-
 arch/mips/ar7/clock.c                              |  113 +-
 arch/mips/include/asm/mach-ar7/ar7.h               |    4 -
 arch/mips/pic32/Kconfig                            |    1 -
 arch/mips/ralink/Kconfig                           |    5 -
 arch/mips/ralink/clk.c                             |   64 +-
 arch/sh/Kconfig                                    |    1 -
 drivers/clk/Kconfig                                |   30 +-
 drivers/clk/Makefile                               |    4 +-
 drivers/clk/actions/owl-s500.c                     |   92 +-
 drivers/clk/analogbits/wrpll-cln28hpc.c            |    2 +-
 drivers/clk/clk-bd718x7.c                          |   11 +-
 drivers/clk/clk-lmk04832.c                         | 1599 ++++++++
 drivers/clk/clk-si5341.c                           |  324 +-
 drivers/clk/clk-stm32mp1.c                         |  500 ++-
 drivers/clk/clk-versaclock5.c                      |   27 +-
 drivers/clk/clkdev.c                               |   28 -
 drivers/clk/hisilicon/Kconfig                      |    7 +
 drivers/clk/hisilicon/Makefile                     |    1 +
 drivers/clk/hisilicon/clk-hi3559a.c                |  846 ++++
 drivers/clk/hisilicon/clk.c                        |    2 +-
 drivers/clk/hisilicon/clk.h                        |    2 +-
 drivers/clk/imx/Makefile                           |    3 +-
 drivers/clk/imx/clk-imx8mp.c                       |    1 -
 drivers/clk/imx/clk-imx8mq.c                       |   56 +-
 drivers/clk/imx/clk-imx8qm-rsrc.c                  |  116 +
 drivers/clk/imx/clk-imx8qxp-rsrc.c                 |   89 +
 drivers/clk/imx/clk-imx8qxp.c                      |  377 +-
 drivers/clk/imx/clk-scu.c                          |  312 +-
 drivers/clk/imx/clk-scu.h                          |   56 +-
 drivers/clk/ingenic/Kconfig                        |   10 +
 drivers/clk/ingenic/Makefile                       |    1 +
 drivers/clk/ingenic/cgu.c                          |   92 +-
 drivers/clk/ingenic/cgu.h                          |   12 +-
 drivers/clk/ingenic/jz4725b-cgu.c                  |   12 +-
 drivers/clk/ingenic/jz4740-cgu.c                   |   12 +-
 drivers/clk/ingenic/jz4760-cgu.c                   |  428 ++
 drivers/clk/ingenic/jz4770-cgu.c                   |   15 +-
 drivers/clk/ingenic/tcu.c                          |    2 +
 drivers/clk/keystone/syscon-clk.c                  |   17 +
 drivers/clk/meson/axg-audio.c                      |    5 +-
 drivers/clk/meson/clk-pll.c                        |   26 +-
 drivers/clk/meson/g12a.c                           |    8 +-
 drivers/clk/qcom/Kconfig                           |   21 +
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/apcs-sdx55.c                      |   18 +-
 drivers/clk/qcom/camcc-sm8250.c                    | 2456 ++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |  176 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    6 +
 drivers/clk/qcom/clk-rcg2.c                        |   81 +
 drivers/clk/qcom/clk-smd-rpm.c                     |  673 ++--
 drivers/clk/qcom/dispcc-sm8250.c                   |  190 +-
 drivers/clk/qcom/gcc-mdm9607.c                     | 1632 ++++++++
 drivers/clk/qcom/gcc-msm8974.c                     |  169 +-
 drivers/clk/qcom/gcc-sc7280.c                      |    1 +
 drivers/clk/qcom/gcc-sm6125.c                      | 4190 ++++++++++++++++++++
 drivers/clk/renesas/Kconfig                        |    9 +
 drivers/clk/renesas/Makefile                       |    2 +
 drivers/clk/renesas/clk-div6.c                     |   80 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    4 +
 drivers/clk/renesas/r9a06g032-clocks.c             |   25 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |  127 +
 drivers/clk/renesas/rcar-gen3-cpg.c                |  183 +-
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |   24 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   10 +-
 drivers/clk/renesas/renesas-rzg2l-cpg.c            |  750 ++++
 drivers/clk/renesas/renesas-rzg2l-cpg.h            |  136 +
 drivers/clk/rockchip/clk-rk3036.c                  |    2 +-
 drivers/clk/rockchip/clk-rk3568.c                  |   10 +-
 drivers/clk/rockchip/clk.h                         |   29 +-
 drivers/clk/sifive/sifive-prci.c                   |    2 +-
 drivers/clk/socfpga/clk-agilex.c                   |   93 +-
 drivers/clk/socfpga/clk-gate-s10.c                 |  119 +-
 drivers/clk/socfpga/clk-periph-s10.c               |   11 +-
 drivers/clk/socfpga/clk-pll.c                      |    3 +-
 drivers/clk/socfpga/clk-s10.c                      |   87 +-
 drivers/clk/socfpga/stratix10-clk.h                |    2 +
 drivers/clk/st/clk-flexgen.c                       |  367 +-
 drivers/clk/st/clkgen-fsyn.c                       |  113 +-
 drivers/clk/st/clkgen-pll.c                        |  121 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    4 +-
 drivers/clk/tegra/clk-periph-gate.c                |   80 +-
 drivers/clk/tegra/clk-periph.c                     |   11 +
 drivers/clk/tegra/clk-pll.c                        |   12 +-
 drivers/clk/tegra/clk-tegra-periph.c               |    6 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c           |   16 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |    4 +-
 drivers/clk/tegra/clk-tegra124-emc.c               |    4 +-
 drivers/clk/tegra/clk-tegra20.c                    |    6 +-
 drivers/clk/tegra/clk-tegra30.c                    |    6 +-
 drivers/clk/tegra/clk.h                            |    4 -
 drivers/clk/ti/adpll.c                             |    5 +-
 drivers/clk/ti/dpll.c                              |   39 +
 drivers/clk/ti/dpll3xxx.c                          |   87 +-
 drivers/clk/versatile/Kconfig                      |    3 +-
 drivers/clk/zynqmp/clk-gate-zynqmp.c               |    4 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |   37 +-
 drivers/clk/zynqmp/clk-zynqmp.h                    |   33 +
 drivers/clk/zynqmp/clkc.c                          |   25 +-
 drivers/clk/zynqmp/divider.c                       |   40 +-
 drivers/clk/zynqmp/pll.c                           |   28 +-
 drivers/clocksource/Kconfig                        |    6 +-
 drivers/mmc/host/Kconfig                           |    4 +-
 drivers/reset/Kconfig                              |    6 -
 drivers/reset/Makefile                             |    1 -
 drivers/reset/reset-stm32mp1.c                     |  115 -
 drivers/soc/tegra/pmc.c                            |    5 -
 drivers/staging/board/Kconfig                      |    2 +-
 include/dt-bindings/clock/actions,s500-cmu.h       |    6 +-
 include/dt-bindings/clock/hi3559av100-clock.h      |  165 +
 include/dt-bindings/clock/imx8-clock.h             |  128 -
 include/dt-bindings/clock/imx8mq-clock.h           |   19 -
 include/dt-bindings/clock/jz4760-cgu.h             |   54 +
 include/dt-bindings/clock/qcom,camcc-sm8250.h      |  138 +
 include/dt-bindings/clock/qcom,dispcc-sm8250.h     |    9 +
 include/dt-bindings/clock/qcom,gcc-mdm9607.h       |  104 +
 include/dt-bindings/clock/qcom,gcc-sm6125.h        |  240 ++
 include/dt-bindings/clock/r9a07g044-cpg.h          |   89 +
 include/dt-bindings/clock/stm32mp1-clks.h          |   27 +
 include/dt-bindings/reset/stm32mp1-resets.h        |   15 +
 include/linux/clk/tegra.h                          |  100 +-
 include/linux/clk/ti.h                             |   22 +
 include/linux/clkdev.h                             |    5 -
 sound/soc/dwc/Kconfig                              |    2 +-
 sound/soc/rockchip/Kconfig                         |   14 +-
 163 files changed, 18191 insertions(+), 2068 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/gpio-mux-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-mux-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
 create mode 100644 drivers/clk/clk-lmk04832.c
 create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
 create mode 100644 drivers/clk/imx/clk-imx8qm-rsrc.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-rsrc.c
 create mode 100644 drivers/clk/ingenic/jz4760-cgu.c
 create mode 100644 drivers/clk/qcom/camcc-sm8250.c
 create mode 100644 drivers/clk/qcom/gcc-mdm9607.c
 create mode 100644 drivers/clk/qcom/gcc-sm6125.c
 create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
 create mode 100644 drivers/clk/renesas/renesas-rzg2l-cpg.c
 create mode 100644 drivers/clk/renesas/renesas-rzg2l-cpg.h
 delete mode 100644 drivers/reset/reset-stm32mp1.c
 create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
 create mode 100644 include/dt-bindings/clock/jz4760-cgu.h
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sm8250.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-mdm9607.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm6125.h
 create mode 100644 include/dt-bindings/clock/r9a07g044-cpg.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
