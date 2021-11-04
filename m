Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37F444CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhKDAvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhKDAvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:51:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8582560EDF;
        Thu,  4 Nov 2021 00:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635986938;
        bh=iNAwm+JLvKN55mEKV639pMxzIojhPTsQbLd8nD/9BBg=;
        h=From:To:Cc:Subject:Date:From;
        b=ato1QOPkglhZa/wLjC/tcbFX8ELISnZ0bfU5gtTlNnle/vy/5qe+f01m5D4TGevDk
         x3mnmDmVF0m+MBgnktlsviJynhDlOyTR8yk5szq/9buxzVXk/FmJs55UW15QN9wRcA
         HuiMIyCZIFMosw97UmEmpclEYoFpv3rZTXv9YtE4RwYn2vrc+Kr5pbmipaKSpkM+0s
         Y4OVCjNAjFfRNTi2KZ4CGVU3T9LdSzs9Tee8fEC33Dw95AkuBezlCHtYw2DDJKQDpk
         CJ6DpmDavQ3ezpid4ilVzFU0UiTfO8RJ13KTQYQEVMK+0x3WQconPIRgB2K6fnnLez
         xOxHEWq9oxO3Q==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed,  3 Nov 2021 17:48:57 -0700
Message-Id: <20211104004857.609841-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 675c496d0f92b481ebe4abf4fb06eadad7789de6:

  clk: composite: Also consider .determine_rate for rate + mux composites (2021-10-18 12:59:42 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to e2ceaa867d266472b31f3e03ba16f3120aefc152:

  Merge branches 'clk-composite-determine-fix', 'clk-allwinner', 'clk-amlogic' and 'clk-samsung' into clk-next (2021-11-02 11:27:06 -0700)

----------------------------------------------------------------
The usual collection of clk driver updates and new driver additions. In
terms of lines it's mainly Qualcomm and Mediatek code, supporting
various SoCs and their multitude of clk controllers.

New Drivers:
 - GCC and RPMcc support for Qualcomm QCM2290 SoCs
 - GCC support for Qualcomm MSM8994/MSM8992 SoCs
 - LPASSCC and CAMCC support for Qualcomm SC7280 SoCs
 - Support for Mediatek MT8195 SoCs
 - Initial clock driver for the Exynos850 SoC
 - Add i.MX8ULP clock driver and related bindings

Updates:
 - Clock power management for new SAMA7G5 SoC
 - Updates to the master clock driver and sam9x60-pll to be able to use
   cpufreq-dt driver and avoid overclocking of CPU and MCK0 domains while
   changing the frequency via DVFS
 - Use ARRAY_SIZE in qcom clk drivers
 - Remove some impractical fallback parent names in qcom clk drivers
 - Make Mediatek clk drivers tristate
 - Refactoring of the CPU clock code and conversion of Samsung Exynos5433
   CPU clock driver to the platform driver
 - A few conversions to devm_platform_ioremap_resource()
 - Updates of the Samsung Kconfig help text
 - Update video path realted clocks for Amlogic meson8
 - Add SPI Multi I/O Bus and SDHI clocks and resets on Renesas RZ/G2L
 - Add SPI Multi I/O Bus (RPC) clocks on Renesas R-Car V3U
 - Add MediaLB clocks on Renesas R-Car H3, M3-W/W+, and M3-N
 - Remove unused helpers from i.MX specific clock header
 - Rework all i.MX clk based helpers to use clk_hw based ones
 - Rework i.MX gate/mux/divider wrappers
 - Rework imx_clk_hw_composite and imx_clk_hw_pll14xx wrappers
 - Update i.MX pllv4 and composite clocks to support i.MX8ULP
 - Disable i.MX7ULP composite clock during initialization
 - Add CLK_SET_RATE_NO_REPARENT flag to the i.MX7ULP composite
 - Disable the i.MX pfd when set pfdv2 clock rate
 - Add support for i.MX8ULP in pfdv2
 - Add the pcc reset controller support on i.MX8ULP
 - Fix the build break when clk-imx8ulp is built as module
 - Move csi_sel mux to correct base register in i.MX6UL clock drivr
 - Fix csi clk gate register in i.MX6UL clock driver
 - Fix build bug making CLK_IMX8ULP select MXC_CLK
 - Add TPU (PWM), and Z (Cortex-A76) clocks on Renesas R-Car V3U
 - Add Ethernet clocks on Renesas RZ/G2L
 - Move Rockchip to use module_platform_probe
 - Enable usage of Coresight related clocks on Rockchip rk3399

----------------------------------------------------------------
Abel Vesa (8):
      clk: imx: Remove unused helpers
      clk: imx: Make mux/mux2 clk based helpers use clk_hw based ones
      clk: imx: Rework all clk_hw_register_gate wrappers
      clk: imx: Rework all clk_hw_register_gate2 wrappers
      clk: imx: Rework all clk_hw_register_mux wrappers
      clk: imx: Rework all clk_hw_register_divider wrappers
      clk: imx: Rework all imx_clk_hw_composite wrappers
      clk: imx: Rework imx_clk_hw_pll14xx wrapper

Andrey Gusakov (1):
      clk: renesas: r8a779[56]x: Add MLP clocks

AngeloGioacchino Del Regno (2):
      clk: qcom: mmcc-sdm660: Add necessary CXCs to venus_gdsc
      clk: qcom: mmcc-sdm660: Add hw_ctrl flag to venus_core0_gdsc

Anson Huang (1):
      clk: imx: disable i.mx7ulp composite clock during initialization

Biju Das (6):
      clk: renesas: rzg2l: Add support to handle MUX clocks
      clk: renesas: r9a07g044: Add ethernet clock sources
      clk: renesas: rzg2l: Add support to handle coupled clocks
      clk: renesas: r9a07g044: Add GbEthernet clock/reset
      clk: renesas: rzg2l: Add SDHI clk mux support
      clk: renesas: r9a07g044: Add SDHI clock and reset entries

Brian Norris (2):
      clk: rockchip: rk3399: make CPU clocks critical
      clk: rockchip: rk3399: expose PCLK_COREDBG_{B,L}

Cai Huoqing (20):
      clk: sunxi: clk-mod0: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun50i-a64: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun50i-h6: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun8i-a83t: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun8i-de2: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun8i-r40: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun9i-a80: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun9i-a80-de: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi-ng: ccu-sun9i-a80-usb: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi: sun6i-apb0: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi: sun6i-apb0-gates: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi: sun6i-ar100: Make use of the helper function devm_platform_ioremap_resource()
      clk: sunxi: sun8i-apb0: Make use of the helper function devm_platform_ioremap_resource()
      clk: samsung: exynos-audss: Make use of devm_platform_ioremap_resource()
      clk: samsung: exynos4412-isp: Make use of devm_platform_ioremap_resource()
      clk: samsung: exynos5433: Make use of devm_platform_ioremap_resource()
      clk: samsung: s5pv210-audss: Make use of devm_platform_ioremap_resource()
      clk: qcom: a53-pll: Make use of the helper function devm_platform_ioremap_resource()
      clk: qcom: common: Make use of the helper function devm_platform_ioremap_resource()
      clk: qcom: kpss-xcc: Make use of the helper function devm_platform_ioremap_resource()

Christophe JAILLET (1):
      clk: mvebu: ap-cpu-clk: Fix a memory leak in error handling paths

Chun-Jie Chen (24):
      dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock
      clk: mediatek: Add dt-bindings of MT8195 clocks
      clk: mediatek: Fix corner case of tuner_en_reg
      clk: mediatek: Add API for clock resource recycle
      clk: mediatek: Fix resource leak in mtk_clk_simple_probe
      clk: mediatek: Add MT8195 apmixedsys clock support
      clk: mediatek: Add MT8195 topckgen clock support
      clk: mediatek: Add MT8195 peripheral clock support
      clk: mediatek: Add MT8195 infrastructure clock support
      clk: mediatek: Add MT8195 camsys clock support
      clk: mediatek: Add MT8195 ccusys clock support
      clk: mediatek: Add MT8195 imgsys clock support
      clk: mediatek: Add MT8195 ipesys clock support
      clk: mediatek: Add MT8195 mfgcfg clock support
      clk: mediatek: Add MT8195 scp adsp clock support
      clk: mediatek: Add MT8195 vdecsys clock support
      clk: mediatek: Add MT8195 vdosys0 clock support
      clk: mediatek: Add MT8195 vdosys1 clock support
      clk: mediatek: Add MT8195 vencsys clock support
      clk: mediatek: Add MT8195 vppsys0 clock support
      clk: mediatek: Add MT8195 vppsys1 clock support
      clk: mediatek: Add MT8195 wpesys clock support
      clk: mediatek: Add MT8195 imp i2c wrapper clock support
      clk: mediatek: Add MT8195 apusys clock support

Claudiu Beznea (15):
      clk: at91: re-factor clocks suspend/resume
      clk: at91: pmc: execute suspend/resume only for backup mode
      clk: at91: sama7g5: add securam's peripheral clock
      clk: at91: clk-master: add register definition for sama7g5's master clock
      clk: at91: clk-master: improve readability by using local variables
      clk: at91: pmc: add sama7g5 to the list of available pmcs
      clk: at91: sam9x60-pll: use DIV_ROUND_CLOSEST_ULL
      clk: at91: clk-master: check if div or pres is zero
      clk: at91: clk-master: mask mckr against layout->mask
      clk: at91: clk-master: fix prescaler logic
      clk: at91: clk-sam9x60-pll: add notifier for div part of PLL
      clk: at91: clk-master: add notifier for divider
      clk: at91: sama7g5: remove prescaler part of master clock
      clk: at91: sama7g5: set low limit for mck0 at 32KHz
      clk: use clk_core_get_rate_recalc() in clk_rate_get()

Clément Léger (1):
      clk: at91: check pmc node status before registering syscore ops

Dmitry Baryshkov (5):
      dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
      dt-bindings: clock: qcom,videocc: add mmcx power domain
      clk: qcom: dispcc-sm8250: use runtime PM for the clock controller
      clk: qcom: videocc-sm8250: use runtime PM for the clock controller
      clk: qcom: gdsc: enable optional power domain support

Fabio Estevam (1):
      clk: imx: Make CLK_IMX8ULP select MXC_CLK

Geert Uytterhoeven (1):
      clk: renesas: r8a779a0: Add Z0 and Z1 clock support

Jacky Bai (9):
      dt-bindings: clock: Add imx8ulp clock support
      clk: imx: Update the pllv4 to support imx8ulp
      clk: imx: Update the compsite driver to support imx8ulp
      clk: imx: Add 'CLK_SET_RATE_NO_REPARENT' for composite-7ulp
      clk: imx: disable the pfd when set pfdv2 clock rate
      clk: imx: Update the pfdv2 for 8ulp specific support
      clk: imx: Add clock driver for imx8ulp
      clk: imx: Add the pcc reset controller support on imx8ulp
      clk: imx: Fix the build break when clk-imx8ulp build as module

Jean Delvare (2):
      clk: versatile: Rename ICST to CLK_ICST
      clk: versatile: hide clock drivers from non-ARM users

Kai Song (1):
      clk: qcom: Remove redundant .owner

Konrad Dybcio (9):
      dt-bindings: clk: qcom: Add bindings for MSM8994 GCC driver
      clk: qcom: gcc-msm8994: Modernize the driver
      clk: qcom: gcc-msm8994: Fix up SPI QUP clocks
      clk: qcom: gcc-msm8994: Add missing NoC clocks
      clk: qcom: gcc-msm8994: Add missing clocks
      clk: qcom: gcc-msm8994: Remove the inexistent GDSC_PCIE
      clk: qcom: gcc-msm8994: Add modem reset
      clk: qcom: gcc-msm8994: Add proper msm8992 support
      clk: qcom: gcc-msm8994: Use ARRAY_SIZE() for num_parents

Krzysztof Kozlowski (1):
      clk: samsung: describe drivers in Kconfig

Lad Prabhakar (1):
      clk: renesas: r9a07g044: Add clock and reset entries for SPI Multi I/O Bus Controller

Linus Walleij (2):
      dt-bindings: clock: u8500: Rewrite in YAML and extend
      clk: ux500: Add driver for the reset portions of PRCC

Marek Behún (1):
      dt-bindings: clk: fixed-mmio-clock: Convert to YAML

Marijn Suijten (12):
      clk: qcom: gcc-sdm660: Use ARRAY_SIZE for num_parents
      clk: qcom: gpucc-sdm660: Use ARRAY_SIZE for num_parents
      clk: qcom: mmcc-sdm660: Use ARRAY_SIZE for num_parents
      clk: qcom: gpucc-sdm660: Remove fallback to global clock names
      clk: qcom: gcc-msm8998: Move parent names and mapping below GPLLs
      clk: qcom: gcc-msm8998: Use parent_data/hws for internal clock relations
      clk: qcom: gcc-msm8998: Remove transient global "xo" clock
      clk: qcom: gpucc-msm8998: Use ARRAY_SIZE for num_parents
      clk: qcom: mmcc-msm8998: Use ARRAY_SIZE for num_parents
      dt-bindings: clocks: qcom,gcc-msm8998: Reflect actually referenced clks
      clk: qcom: gpucc-msm8998: Remove unnecessary fallbacks to global clocks
      clk: qcom: mmcc-msm8998: Remove unnecessary fallbacks to global clocks

Martin Blumenstingl (7):
      clk: meson: meson8b: Export the video clocks
      clk: meson: meson8b: Use CLK_SET_RATE_NO_REPARENT for vclk{,2}_in_sel
      clk: meson: meson8b: Add the vid_pll_lvds_en gate clock
      clk: meson: meson8b: Add the HDMI PLL M/N parameters
      clk: meson: meson8b: Initialize the HDMI PLL registers
      clk: meson: meson8b: Make the video clock trees mutable
      clk: composite: Use rate_ops.determine_rate when also a mux is available

Maxime Ripard (1):
      dt-bindings: clocks: Fix typo in the H6 compatible

Miles Chen (4):
      clk: composite: export clk_register_composite
      clk: mediatek: support COMMON_CLK_MEDIATEK module build
      clk: mediatek: support COMMON_CLK_MT6779 module build
      clk: rockchip: use module_platform_driver_probe

Rob Herring (2):
      dt-bindings: clock: arm,syscon-icst: Use 'reg' instead of 'vco-offset' for VCO register address
      clk: versatile: clk-icst: Support 'reg' in addition to 'vco-offset' for register address

Sam Protsenko (5):
      clk: samsung: clk-pll: Implement pll0822x PLL type
      clk: samsung: clk-pll: Implement pll0831x PLL type
      dt-bindings: clock: Add bindings definitions for Exynos850 CMU
      dt-bindings: clock: Document Exynos850 CMU bindings
      clk: samsung: Introduce Exynos850 clock driver

Samuel Holland (5):
      clk: sunxi-ng: mux: Remove unused 'reg' field
      clk: sunxi-ng: Add machine dependency to A83T CCU
      clk: sunxi-ng: Unregister clocks/resets when unbinding
      clk: sunxi-ng: Prevent unbinding CCUs via sysfs
      clk: sunxi-ng: Use a separate lock for each CCU instance

Shawn Guo (5):
      dt-bindings: clk: qcom: Add QCM2290 Global Clock Controller bindings
      clk: qcom: Add Global Clock Controller driver for QCM2290
      clk: qcom: smd-rpm: Add .recalc_rate hook for clk_smd_rpm_branch_ops
      dt-bindings: clk: qcom,rpmcc: Document QCM2290 compatible
      clk: qcom: smd-rpm: Add QCM2290 RPM clock support

Stefan Riedmueller (2):
      clk: imx: imx6ul: Move csi_sel mux to correct base register
      clk: imx: imx6ul: Fix csi clk gate register

Stephen Boyd (13):
      clk: mediatek: Export clk_ops structures to modules
      Merge tag 'v5.16-rockchip-clk-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'renesas-clk-for-v5.16-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-imx-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      clk: qcom: gcc-sc7280: Drop unused array
      Merge tag 'renesas-clk-for-v5.16-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-5.16-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-meson-v5.16-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-v5.16-samsung' of https://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk into clk-samsung
      Merge branches 'clk-qcom', 'clk-mtk', 'clk-versatile' and 'clk-doc' into clk-next
      Merge branches 'clk-leak', 'clk-rockchip', 'clk-renesas' and 'clk-at91' into clk-next
      Merge branches 'clk-imx', 'clk-ux500' and 'clk-debugfs' into clk-next
      Merge branches 'clk-composite-determine-fix', 'clk-allwinner', 'clk-amlogic' and 'clk-samsung' into clk-next

Taniya Das (6):
      clk: qcom: gcc: Remove CPUSS clocks control for SC7280
      clk: qcom: Kconfig: Sort the symbol for SC_LPASS_CORECC_7180
      dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280
      clk: qcom: Add lpass clock controller driver for SC7280
      dt-bindings: clock: Add YAML schemas for CAMCC clocks on SC7280
      clk: qcom: camcc: Add camera clock controller driver for SC7280

Will McVicker (2):
      clk: samsung: add support for CPU clocks
      clk: samsung: exynos5433: update apollo and atlas clock probing

Wolfram Sang (3):
      clk: renesas: r8a779a0: Add TPU clock
      clk: renesas: cpg-lib: Move RPC clock registration to the library
      clk: renesas: r8a779a0: Add RPC support

 .../arm/mediatek/mediatek,mt8195-clock.yaml        |  254 ++
 .../arm/mediatek/mediatek,mt8195-sys-clock.yaml    |   73 +
 .../clock/allwinner,sun8i-a83t-de2-clk.yaml        |    2 +-
 .../devicetree/bindings/clock/arm,syscon-icst.yaml |    5 +
 .../devicetree/bindings/clock/fixed-mmio-clock.txt |   24 -
 .../bindings/clock/fixed-mmio-clock.yaml           |   47 +
 .../bindings/clock/imx8ulp-cgc-clock.yaml          |   43 +
 .../bindings/clock/imx8ulp-pcc-clock.yaml          |   50 +
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |   13 +
 .../bindings/clock/qcom,gcc-msm8994.yaml           |   70 +
 .../bindings/clock/qcom,gcc-msm8998.yaml           |   26 +-
 .../bindings/clock/qcom,gcc-qcm2290.yaml           |   72 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    2 -
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |    1 +
 .../bindings/clock/qcom,sc7280-camcc.yaml          |   71 +
 .../bindings/clock/qcom,sc7280-lpasscc.yaml        |   68 +
 .../devicetree/bindings/clock/qcom,videocc.yaml    |   13 +
 .../bindings/clock/samsung,exynos850-clock.yaml    |  185 ++
 .../bindings/clock/stericsson,u8500-clks.yaml      |  121 +
 Documentation/devicetree/bindings/clock/ux500.txt  |   64 -
 arch/arm/mach-integrator/Kconfig                   |    2 +-
 arch/arm/mach-realview/Kconfig                     |    2 +-
 arch/arm/mach-ux500/Kconfig                        |    1 +
 arch/arm/mach-versatile/Kconfig                    |    2 +-
 arch/arm/mach-vexpress/Kconfig                     |    2 +-
 drivers/clk/at91/at91rm9200.c                      |    2 +-
 drivers/clk/at91/at91sam9260.c                     |    2 +-
 drivers/clk/at91/at91sam9g45.c                     |    2 +-
 drivers/clk/at91/at91sam9n12.c                     |    2 +-
 drivers/clk/at91/at91sam9rl.c                      |    2 +-
 drivers/clk/at91/at91sam9x5.c                      |    2 +-
 drivers/clk/at91/clk-generated.c                   |   46 +-
 drivers/clk/at91/clk-main.c                        |   66 +
 drivers/clk/at91/clk-master.c                      |  463 ++-
 drivers/clk/at91/clk-peripheral.c                  |   40 +-
 drivers/clk/at91/clk-pll.c                         |   39 +
 drivers/clk/at91/clk-programmable.c                |   29 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |  174 +-
 drivers/clk/at91/clk-system.c                      |   20 +
 drivers/clk/at91/clk-usb.c                         |   27 +
 drivers/clk/at91/clk-utmi.c                        |   39 +
 drivers/clk/at91/dt-compat.c                       |    2 +-
 drivers/clk/at91/pmc.c                             |  178 +-
 drivers/clk/at91/pmc.h                             |   29 +-
 drivers/clk/at91/sam9x60.c                         |    6 +-
 drivers/clk/at91/sama5d2.c                         |    2 +-
 drivers/clk/at91/sama5d3.c                         |    2 +-
 drivers/clk/at91/sama5d4.c                         |    2 +-
 drivers/clk/at91/sama7g5.c                         |   29 +-
 drivers/clk/clk-composite.c                        |   69 +-
 drivers/clk/clk.c                                  |    5 +-
 drivers/clk/imx/Kconfig                            |    7 +
 drivers/clk/imx/Makefile                           |    2 +
 drivers/clk/imx/clk-composite-7ulp.c               |   88 +-
 drivers/clk/imx/clk-composite-8m.c                 |    4 +-
 drivers/clk/imx/clk-imx6ul.c                       |    9 +-
 drivers/clk/imx/clk-imx7ulp.c                      |   20 +-
 drivers/clk/imx/clk-imx8ulp.c                      |  569 ++++
 drivers/clk/imx/clk-pfdv2.c                        |   23 +-
 drivers/clk/imx/clk-pllv4.c                        |   35 +-
 drivers/clk/imx/clk.h                              |  457 +--
 drivers/clk/mediatek/Kconfig                       |   28 +-
 drivers/clk/mediatek/Makefile                      |    8 +
 drivers/clk/mediatek/clk-apmixed.c                 |    3 +
 drivers/clk/mediatek/clk-cpumux.c                  |    3 +
 drivers/clk/mediatek/clk-gate.c                    |    8 +
 drivers/clk/mediatek/clk-mt6779-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-cam.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt6779-venc.c             |    4 +-
 drivers/clk/mediatek/clk-mt6779.c                  |    2 +
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |  145 +
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c       |   92 +
 drivers/clk/mediatek/clk-mt8195-cam.c              |  142 +
 drivers/clk/mediatek/clk-mt8195-ccu.c              |   50 +
 drivers/clk/mediatek/clk-mt8195-img.c              |   96 +
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c     |   68 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |  206 ++
 drivers/clk/mediatek/clk-mt8195-ipe.c              |   51 +
 drivers/clk/mediatek/clk-mt8195-mfg.c              |   47 +
 drivers/clk/mediatek/clk-mt8195-peri_ao.c          |   62 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c         |   47 +
 drivers/clk/mediatek/clk-mt8195-topckgen.c         | 1273 ++++++++
 drivers/clk/mediatek/clk-mt8195-vdec.c             |  104 +
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |  123 +
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |  140 +
 drivers/clk/mediatek/clk-mt8195-venc.c             |   69 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c             |  110 +
 drivers/clk/mediatek/clk-mt8195-vpp1.c             |  108 +
 drivers/clk/mediatek/clk-mt8195-wpe.c              |  143 +
 drivers/clk/mediatek/clk-mtk.c                     |   29 +-
 drivers/clk/mediatek/clk-mtk.h                     |    1 +
 drivers/clk/mediatek/clk-mux.c                     |    6 +
 drivers/clk/mediatek/clk-pll.c                     |    6 +-
 drivers/clk/mediatek/reset.c                       |    2 +
 drivers/clk/meson/meson8b.c                        |  163 +-
 drivers/clk/meson/meson8b.h                        |   26 +-
 drivers/clk/mvebu/ap-cpu-clk.c                     |   14 +-
 drivers/clk/qcom/Kconfig                           |   43 +-
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/a53-pll.c                         |    4 +-
 drivers/clk/qcom/camcc-sc7280.c                    | 2484 ++++++++++++++++
 drivers/clk/qcom/clk-smd-rpm.c                     |  135 +-
 drivers/clk/qcom/common.c                          |    8 +-
 drivers/clk/qcom/dispcc-sm8250.c                   |   27 +-
 drivers/clk/qcom/gcc-msm8953.c                     |    1 -
 drivers/clk/qcom/gcc-msm8994.c                     | 1384 +++++----
 drivers/clk/qcom/gcc-msm8998.c                     |  705 ++---
 drivers/clk/qcom/gcc-qcm2290.c                     | 3044 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sc7280.c                      |   85 -
 drivers/clk/qcom/gcc-sdm660.c                      |   80 +-
 drivers/clk/qcom/gdsc.c                            |   51 +-
 drivers/clk/qcom/gdsc.h                            |    2 +
 drivers/clk/qcom/gpucc-msm8998.c                   |   13 +-
 drivers/clk/qcom/gpucc-sdm660.c                    |   15 +-
 drivers/clk/qcom/kpss-xcc.c                        |    4 +-
 drivers/clk/qcom/lpasscc-sc7280.c                  |  216 ++
 drivers/clk/qcom/mmcc-msm8998.c                    |  183 +-
 drivers/clk/qcom/mmcc-sdm660.c                     |   75 +-
 drivers/clk/qcom/videocc-sm8250.c                  |   27 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    1 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |  191 ++
 drivers/clk/renesas/r9a07g044-cpg.c                |   85 +-
 drivers/clk/renesas/rcar-cpg-lib.c                 |   83 +
 drivers/clk/renesas/rcar-cpg-lib.h                 |    7 +
 drivers/clk/renesas/rcar-gen3-cpg.c                |   89 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |  214 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |   45 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   17 +-
 drivers/clk/rockchip/clk-rk3568.c                  |    2 +-
 drivers/clk/samsung/Kconfig                        |   30 +-
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-cpu.c                      |   18 +
 drivers/clk/samsung/clk-exynos-audss.c             |    4 +-
 drivers/clk/samsung/clk-exynos4412-isp.c           |    4 +-
 drivers/clk/samsung/clk-exynos5433.c               |  124 +-
 drivers/clk/samsung/clk-exynos850.c                |  835 ++++++
 drivers/clk/samsung/clk-pll.c                      |  196 ++
 drivers/clk/samsung/clk-pll.h                      |    2 +
 drivers/clk/samsung/clk-s5pv210-audss.c            |    4 +-
 drivers/clk/samsung/clk.c                          |    2 +
 drivers/clk/samsung/clk.h                          |   26 +
 drivers/clk/sunxi-ng/Kconfig                       |    1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c           |    3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c             |    3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |    7 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |    7 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c             |    4 +-
 drivers/clk/sunxi-ng/ccu-sun5i.c                   |    2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |    7 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |    6 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |    7 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            |    8 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |    7 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               |    7 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |    2 +-
 drivers/clk/sunxi-ng/ccu_common.c                  |   96 +-
 drivers/clk/sunxi-ng/ccu_common.h                  |    6 +-
 drivers/clk/sunxi-ng/ccu_mux.h                     |    1 -
 drivers/clk/sunxi/clk-mod0.c                       |    4 +-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c           |    4 +-
 drivers/clk/sunxi/clk-sun6i-apb0.c                 |    4 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c                |    4 +-
 drivers/clk/sunxi/clk-sun8i-apb0.c                 |    4 +-
 drivers/clk/ux500/Makefile                         |    3 +
 drivers/clk/ux500/prcc.h                           |   19 +
 drivers/clk/ux500/reset-prcc.c                     |  181 ++
 drivers/clk/ux500/reset-prcc.h                     |   23 +
 drivers/clk/ux500/u8500_of_clk.c                   |   30 +-
 drivers/clk/versatile/Kconfig                      |    3 +-
 drivers/clk/versatile/Makefile                     |    2 +-
 drivers/clk/versatile/clk-icst.c                   |    3 +-
 include/dt-bindings/clock/exynos850.h              |  141 +
 include/dt-bindings/clock/imx8ulp-clock.h          |  258 ++
 include/dt-bindings/clock/meson8b-clkc.h           |   10 +
 include/dt-bindings/clock/mt8195-clk.h             |  864 ++++++
 include/dt-bindings/clock/qcom,camcc-sc7280.h      |  127 +
 include/dt-bindings/clock/qcom,gcc-msm8994.h       |   13 +
 include/dt-bindings/clock/qcom,gcc-qcm2290.h       |  188 ++
 include/dt-bindings/clock/qcom,lpass-sc7280.h      |   16 +
 include/dt-bindings/clock/qcom,rpmcc.h             |    6 +
 include/dt-bindings/reset/imx8ulp-pcc-reset.h      |   59 +
 .../reset/stericsson,db8500-prcc-reset.h           |   51 +
 include/linux/soc/qcom/smd-rpm.h                   |    2 +
 198 files changed, 17429 insertions(+), 2464 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-mmio-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx8ulp-cgc-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx8ulp-pcc-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ux500.txt
 create mode 100644 drivers/clk/imx/clk-imx8ulp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apusys_pll.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ccu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-infra_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-peri_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-scp_adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-wpe.c
 create mode 100644 drivers/clk/qcom/camcc-sc7280.c
 create mode 100644 drivers/clk/qcom/gcc-qcm2290.c
 create mode 100644 drivers/clk/qcom/lpasscc-sc7280.c
 create mode 100644 drivers/clk/samsung/clk-exynos850.c
 create mode 100644 drivers/clk/ux500/prcc.h
 create mode 100644 drivers/clk/ux500/reset-prcc.c
 create mode 100644 drivers/clk/ux500/reset-prcc.h
 create mode 100644 include/dt-bindings/clock/exynos850.h
 create mode 100644 include/dt-bindings/clock/imx8ulp-clock.h
 create mode 100644 include/dt-bindings/clock/mt8195-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-qcm2290.h
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sc7280.h
 create mode 100644 include/dt-bindings/reset/imx8ulp-pcc-reset.h
 create mode 100644 include/dt-bindings/reset/stericsson,db8500-prcc-reset.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
