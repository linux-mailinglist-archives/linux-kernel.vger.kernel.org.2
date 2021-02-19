Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4331FF99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBST4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhBST4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:56:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7498D64EB3;
        Fri, 19 Feb 2021 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613764549;
        bh=Vjc3v/Rh1sAA6GkEpTNzvtpaoJjzyh6ILZN4m5YrbiY=;
        h=From:To:Cc:Subject:Date:From;
        b=G4S+/fKhRJj3d2ltkbDvO7+I5c4ySTa3QtjnQMhVbZ6OnkjgI8u72Qz6gIyZgNF1k
         kgZvmt7jVV9hBpPsUlnzBLhJ0m7jonq5bIDaxnMG/t3QtHNyc/Vd9ppDulzabORctM
         dZTmZrqVYx2e0n4f1+uHtBnKUbmBd5BKLWacwvHP+259lCv1sHO/nO6rmZKB14TmEk
         kWS1IlCpNOFkK6UND6Xl3rr+VhP+HWIZMj4elWkabTIi8fn6020hR5m9nB4nWOTJHI
         4Km98RCIqQYDELXDOVe/l9YoAcM8hW9TGqZ2ll+Pg9630katLfdN4ByjU8wZWbxxtF
         YrGADuGlu+JxA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Fri, 19 Feb 2021 11:55:48 -0800
Message-Id: <20210219195548.3379073-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 4d5c4ae32945ac86cf68740a2236205b333d5a66:

  Merge branches 'clk-socfpga', 'clk-mstar', 'clk-qcom' and 'clk-warnings' into clk-next (2021-02-16 14:09:24 -0800)

----------------------------------------------------------------
This is all driver updates, the majority of which is a bunch of new Qualcomm
clk drivers that dominate the diffstat because we add support for six SoCs from
that particular vendor. The other big change is the removal of various clk
drivers that are no longer used now that the kernel is dropping support for
those SoCs. Beyond that there's the usual non-critical fixes for existing
drivers and a good number of patches from Lee Jones that cleanup a bunch of W=1
enabled builds.

Removed Drivers:
 - Remove efm32 clk driver
 - Remove tango4 clk driver
 - Remove zte zx clk driver
 - Remove sirf prima2/atlast clk drivers
 - Remove u300 clk driver

New Drivers:
 - PLL support on MStar/SigmaStar ARMv7 SoCs
 - CPU clks for Qualcomm SDX55
 - GCC and RPMh clks for Qualcomm SC8180x and SC7280 SoCs
 - GCC clks for Qualcomm SM8350
 - GPU clks for Qualcomm SDM660/SDM630

Updates:
 - Video clk fixups on Qualcomm SM8250
 - Improvements for multimedia clks on Qualcomm MSM8998
 - Fix many warnings with W=1 enabled builds under drivers/clk/
 - Support crystal load capacitance for Versaclock VC5
 - Add a "skip recall" DT binding for Silicon Labs' si570 to avoid glitches at boot
 - Convert Xilinx VCU clk driver to a proper clk provider driver
 - Expose Xilinx ZynqMP clk driver to more platforms
 - Amlogic pll driver fixup
 - Amlogic meson8b clock controller dt support clean up
 - Remove mipi clk from the Amlogic axg clock controller
 - New Rockchip rk3368 clock ids related to camera input
 - Use pr_notice() instead of pr_warn() on i.MX6Q pre-boot ldb_di_clk reparenting
 - A series from Liu Ying that adds some SCU clocks support for i.MX8qxp
   DC0/MIPI-LVDS subsystems
 - A series from Lucas Stach that adds PLL monitor clocks for i.MX8MQ, and
   clkout1/2 support for i.MX8MM/MN
 - Add I2c and Ethernet (RAVB) clocks on Renesas R-Car V3U
 - Add timer (TMU) clocks on most Renesas R-Car Gen3 SoCs
 - Add video-related (FCPVD/VSPD/VSPX), watchdog (RWDT), serial
   (HSCIF), pincontrol/GPIO (PFC/GPIO), SPI (MSIOF), SDHI, and DMA
   (SYS-DMAC) clocks on Renesas R-Car V3U
 - Add support for the USB 2.0 clock selector on Renesas RZ/G2 SoCs
 - Allwinner H616 SoC clk support

----------------------------------------------------------------
Abel Vesa (1):
      MAINTAINERS: Add section for NXP i.MX clock drivers

Adam Ford (3):
      dt-bindings: clock: renesas: rcar-usb2-clock-sel: Add support for RZ/G2 M/N/H
      dt-bindings: clk: versaclock5: Add optional load capacitance property
      clk: vc5: Add support for optional load capacitance

Ahmad Fatoum (1):
      clk: imx6q: demote warning about pre-boot ldb_di_clk reparenting

Alexandru Ardelean (4):
      clk: axi-clkgen: replace ARCH dependencies with driver deps
      clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
      dt-bindings: clock: adi,axi-clkgen: add compatible string for ZynqMP support
      clk: axi-clkgen: use devm_platform_ioremap_resource() short-hand

Andre Przywara (5):
      clk: sunxi-ng: h6: Fix CEC clock
      clk: sunxi-ng: h6: Fix clock divider range on some clocks
      dt-bindings: clk: sunxi-ccu: Add compatible string for Allwinner H616
      clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
      clk: sunxi-ng: Add support for the Allwinner H616 CCU

AngeloGioacchino Del Regno (18):
      dt-bindings: clocks: gcc-msm8998: Add GCC_MMSS_GPLL0_CLK definition
      clk: qcom: gcc-msm8998: Wire up gcc_mmss_gpll0 clock
      dt-bindings: clock: gcc-msm8998: Add HMSS_GPLL0_CLK_SRC definition
      clk: qcom: gcc-msm8998: Add missing hmss_gpll0_clk_src clock
      clk: qcom: gcc-msm8998: Mark gpu_cfg_ahb_clk as critical
      clk: qcom: gcc-msm8998: Fix Alpha PLL type for all GPLLs
      clk: qcom: mmcc-msm8998: Add hardware clockgating registers to some clks
      clk: qcom: mmcc-msm8998: Set bimc_smmu_gdsc always on
      clk: qcom: gdsc: Implement NO_RET_PERIPH flag
      clk: qcom: gpucc-msm8998: Add resets, cxc, fix flags on gpu_gx_gdsc
      clk: qcom: gpucc-msm8998: Allow fabia gpupll0 rate setting
      clk: qcom: gcc-sdm660: Mark MMSS NoC CFG AHB clock as critical
      clk: qcom: gcc-sdm660: Mark GPU CFG AHB clock as critical
      dt-bindings: clock: Add support for the SDM630 and SDM660 mmcc
      clk: qcom: rcg2: Stop hardcoding gfx3d pingpong parent numbers
      clk: qcom: mmcc-msm8996: Migrate gfx3d clock to clk_rcg2_gfx3d
      clk: qcom: Add SDM660 GPU Clock Controller (GPUCC) driver
      dt-bindings: clock: Add QCOM SDM630 and SDM660 graphics clock bindings

Arnd Bergmann (4):
      clk: remove tango4 driver
      clk: remove zte zx driver
      clk: remove sirf prima2/atlas drivers
      clk: remove u300 driver

Bjorn Andersson (4):
      dt-bindings: clock: qcom: rpmhcc: Add sc8180x rpmh clocks
      clk: qcom: rpmhcc: Add sc8180x rpmh clocks
      dt-bindings: clock: Add SC8180x GCC binding
      clk: qcom: gcc: Add global clock controller driver for SC8180x

Bryan O'Donoghue (4):
      dt-bindings: clock: Add missing SM8250 videoc clock indices
      clk: qcom: videocc: Add sm8250 VIDEO_CC_MVS0_DIV_CLK_SRC
      clk: qcom: videocc: Add sm8250 VIDEO_CC_MVS0_CLK
      clk: qcom: videocc: Add gdsc mmcx-reg supply hook

Daniel Palmer (6):
      dt-bindings: clk: mstar msc313 mpll binding header
      dt-bindings: clk: mstar msc313 mpll binding description
      clk: fixed: add devm helper for clk_hw_register_fixed_factor()
      clk: mstar: MStar/SigmaStar MPLL driver
      clk: mstar: Allow MStar clk drivers to be compile tested
      clk: mstar: msc313-mpll: Fix format specifier

Dinh Nguyen (2):
      dt-bindings: documentation: add clock bindings information for eASIC N5X
      clk: socfpga: agilex: add clock driver for eASIC N5X platform

Enric Balletbo i Serra (1):
      clk: mediatek: Select all the MT8183 clocks by default

Fabio Estevam (1):
      dt-bindings: clock: imx: Switch to my personal address

Geert Uytterhoeven (5):
      clk: renesas: r8a779a0: Remove non-existent S2 clock
      clk: renesas: r8a779a0: Fix parent of CBFUSA clock
      clk: renesas: r8a779a0: Add PFC/GPIO clocks
      clk: renesas: r8a779a0: Add MSIOF clocks
      clk: renesas: r8a779a0: Add SYS-DMAC clocks

Heiko Stuebner (5):
      clk: rockchip: add clock ids for PCLK_DPHYRX and PCLK_DPHYTX0 on rk3368
      clk: rockchip: use clock ids for PCLK_DPHYRX and PCLK_DPHYTX0 on rk3368
      clk: rockchip: add clock id for SCLK_VIP_OUT on rk3368
      clk: rockchip: use clock id for SCLK_VIP_OUT on rk3368
      clk: rockchip: fix DPHY gate locations on rk3368

Kieran Bingham (3):
      clk: renesas: r8a779a0: Add FCPVD clock support
      clk: renesas: r8a779a0: Add VSPD clock support
      clk: renesas: r8a779a0: Add VSPX clock support

Laurent Pinchart (2):
      clk: mediatek: mux: Drop unused clock ops
      clk: mediatek: mux: Update parent at enable time

Lee Jones (37):
      clk: sunxi: clk-sunxi: Demote a bunch of non-conformant kernel-doc headers
      clk: sunxi: clk-a10-ve: Demote obvious kernel-doc abuse
      clk: sunxi: clk-mod0: Demote non-conformant kernel-doc header
      clk: rockchip: Demote non-conformant kernel-doc headers in main clock code
      clk: rockchip: Remove unused/undocumented struct members from clk-cpu
      clk: rockchip: Demote kernel-doc abuses to standard comment blocks in plls
      clk: rockchip: Demote non-conformant kernel-doc header in half-divider
      clk: renesas: cpg-mssr: Fix formatting issues for 'smstpcr_saved's documentation
      clk: imx: clk-imx31: Remove unused static const table 'uart_clks'
      clk: imx: Move 'imx6sl_set_wait_clk()'s prototype out to accessible header
      clk: zynq: pll: Fix kernel-doc formatting in 'clk_register_zynq_pll's header
      clk: ti: clkt_dpll: Fix some kernel-doc misdemeanours
      clk: ti: dpll3xxx: Fix some kernel-doc headers and promote other worthy ones
      clk: qcom: clk-regmap: Provide missing description for 'devm_clk_register_regmap()'s dev param
      clk: tegra: clk-tegra30: Remove unused variable 'reg'
      clk: tegra: cvb: Provide missing description for 'tegra_cvb_add_opp_table()'s align param
      clk: ti: dpll44xx: Fix some potential doc-rot
      clk: qcom: gcc-ipq4019: Remove unused variable 'ret'
      clk: clk-fixed-mmio: Demote obvious kernel-doc abuse
      clk: clk-npcm7xx: Remove unused static const tables 'npcm7xx_gates' and 'npcm7xx_divs_fx'
      clk: qcom: mmcc-msm8974: Remove unused static const tables 'mmcc_xo_mmpll0_1_2_gpll0{map}'
      clk: clk-xgene: Add description for 'mask' and fix formatting for 'flags'
      clk: qcom: clk-rpm: Remove a bunch of superfluous code
      clk: spear: Move prototype to accessible header
      clk: zynqmp: divider: Add missing description for 'max_div'
      clk: bcm: clk-iproc-pll: Demote kernel-doc abuse
      clk: sifive: fu540-prci: Declare static const variable 'prci_clk_fu540' where it's used
      clk: socfpga: clk-pll: Remove unused variable 'rc'
      clk: socfpga: clk-pll-a10: Remove set but unused variable 'rc'
      clk: mvebu: ap-cpu-clk: Demote non-conformant kernel-doc header
      clk: st: clkgen-pll: Demote unpopulated kernel-doc header
      clk: st: clkgen-fsyn: Fix worthy struct documentation demote partially filled one
      clk: ti: clockdomain: Fix description for 'omap2_init_clk_clkdm's hw param
      clk: ti: dpll: Fix misnaming of '_register_dpll()'s 'user' parameter
      clk: ti: gate: Fix possible doc-rot in 'omap36xx_gate_clk_enable_with_hsdiv_restore'
      clk: versatile: clk-icst: Fix worthy struct documentation block
      clk: zynq: clkc: Remove various instances of an unused variable 'clk'

Liu Ying (4):
      clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 PLL clocks
      clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 bypass clocks
      clk: imx: clk-imx8qxp: Register DC0 display clocks with imx_clk_scu2()
      clk: imx: clk-imx8qxp: Add some SCU clocks support for MIPI-LVDS subsystems

Lucas Stach (3):
      clk: imx8mq: add PLL monitor output
      clk: imx8mm: add clkout1/2 support
      clk: imx8mn: add clkout1/2 support

Manivannan Sadhasivam (3):
      dt-bindings: clock: Add Qualcomm A7 PLL binding
      clk: qcom: Add A7 PLL support
      clk: qcom: Add SDX55 APCS clock controller support

Martin Blumenstingl (5):
      clk: meson: clk-pll: fix initializing the old rate (fallback) for a PLL
      clk: meson: clk-pll: make "ret" a signed integer
      clk: meson: clk-pll: propagate the error from meson_clk_pll_set_rate()
      clk: meson: meson8b: remove compatibility code for old .dtbs
      dt-bindings: clock: meson8b: remove non-existing clock macros

Martin Botka (1):
      clk: qcom: Add SDM660 Multimedia Clock Controller (MMCC) driver

Matti Vaittinen (1):
      clk: BD718x7: Do not depend on parent driver data

Michael Tretter (15):
      ARM: dts: vcu: define indexes for output clocks
      clk: divider: fix initialization with parent_hw
      soc: xilinx: vcu: drop coreclk from struct xlnx_vcu
      soc: xilinx: vcu: add helper to wait for PLL locked
      soc: xilinx: vcu: add helpers for configuring PLL
      soc: xilinx: vcu: implement PLL disable
      soc: xilinx: vcu: register PLL as fixed rate clock
      soc: xilinx: vcu: implement clock provider for output clocks
      soc: xilinx: vcu: make pll post divider explicit
      soc: xilinx: vcu: make the PLL configurable
      soc: xilinx: vcu: remove calculation of PLL configuration
      soc: xilinx: vcu: use bitfields for register definition
      soc: xilinx: vcu: fix repeated word the in comment
      soc: xilinx: vcu: fix alignment to open parenthesis
      clk: xilinx: move xlnx_vcu clock driver from soc

Niklas Söderlund (4):
      clk: renesas: r8a7796: Add TMU clocks
      clk: renesas: r8a77965: Add TMU clocks
      clk: renesas: r8a77990: Add TMU clocks
      clk: renesas: r8a77995: Add TMU clocks

Randy Dunlap (1):
      linux/clk.h: use correct kernel-doc notation for 2 functions

Remi Pommarel (2):
      clk: meson-axg: remove CLKID_MIPI_ENABLE
      clk: meson: axg: Remove MIPI enable clock gate

Ryan Chen (1):
      clk: aspeed: Fix APLL calculate formula from ast2600-A2

Saeed Nowshadi (2):
      dt-bindings: clock: si570: Add 'silabs,skip-recall' property
      clk: si570: Skip NVM to RAM recall operation if an optional property is set

Samuel Holland (1):
      clk: sunxi-ng: h6-r: Add R_APB2_RSB clock and reset

Srinivas Kandagatla (1):
      clk: qcom: gfm-mux: fix clk mask

Stephen Boyd (10):
      Merge tag 'renesas-clk-for-v5.12-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-5.12' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-imx-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into clk-imx
      Merge tag 'v5.12-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-meson-v5.12-1-fixed' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge branches 'clk-doc', 'clk-renesas', 'clk-allwinner', 'clk-rockchip' and 'clk-xilinx' into clk-next
      Merge branch 'clk-unused' into clk-next
      Merge branches 'clk-mediatek', 'clk-imx', 'clk-amlogic' and 'clk-at91' into clk-next
      Merge branches 'clk-vc5', 'clk-silabs', 'clk-aspeed', 'clk-qoriq' and 'clk-rohm' into clk-next
      Merge branches 'clk-socfpga', 'clk-mstar', 'clk-qcom' and 'clk-warnings' into clk-next

Taniya Das (5):
      clk: qcom: gcc-sc7180: Mark the MM XO clocks to be always ON
      dt-bindings: clock: Add RPMHCC bindings for SC7280
      clk: qcom: rpmh: Add support for RPMH clocks on SC7280
      dt-bindings: clock: Add SC7280 GCC clock binding
      clk: qcom: Add Global Clock controller (GCC) driver for SC7280

Tudor Ambarus (1):
      clk: at91: Fix the declaration of the clocks

Uwe Kleine-König (1):
      clk: Drop unused efm32gg driver

Vinod Koul (4):
      clk: qcom: clk-alpha-pll: replace regval with val
      clk: qcom: clk-alpha-pll: modularize alpha_pll_trion_set_rate()
      dt-bindings: clock: Add SM8350 GCC clock bindings
      clk: qcom: gcc-sm8350: add gdsc

Vivek Aknurwar (2):
      clk: qcom: clk-alpha-pll: Add support for Lucid 5LPE PLL
      clk: qcom: gcc: Add clock driver for SM8350

Wasim Khan (1):
      clk: qoriq: use macros to generate pll_mask

Wolfram Sang (7):
      clk: renesas: r8a779a0: Add RWDT clocks
      clk: renesas: r8a779a0: Add HSCIF support
      clk: renesas: rcar-gen3: Remove cpg_quirks access when registering SD clock
      clk: renesas: rcar-gen3: Factor out CPG library
      clk: renesas: r8a779a0: Add SDHI support
      clk: renesas: r8a779a0: Add I2C clocks
      clk: renesas: r8a779a0: Add RAVB clocks

 .../devicetree/bindings/clock/adi,axi-clkgen.yaml  |    1 +
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |    4 +
 .../devicetree/bindings/clock/csr,atlas7-car.txt   |   55 -
 .../devicetree/bindings/clock/idt,versaclock5.yaml |    6 +
 .../devicetree/bindings/clock/imx27-clock.yaml     |    2 +-
 .../devicetree/bindings/clock/imx31-clock.yaml     |    2 +-
 .../devicetree/bindings/clock/imx5-clock.yaml      |    2 +-
 .../devicetree/bindings/clock/intel,easic-n5x.yaml |   46 +
 .../bindings/clock/mstar,msc313-mpll.yaml          |   46 +
 .../devicetree/bindings/clock/prima2-clock.txt     |   73 -
 .../devicetree/bindings/clock/qcom,a7pll.yaml      |   51 +
 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |   92 +
 .../bindings/clock/qcom,gcc-sc8180x.yaml           |   76 +
 .../devicetree/bindings/clock/qcom,gcc-sm8350.yaml |   96 +
 .../bindings/clock/qcom,gpucc-sdm660.yaml          |   76 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |    2 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    2 +
 .../clock/renesas,rcar-usb2-clock-sel.yaml         |    3 +
 .../devicetree/bindings/clock/silabs,si570.txt     |    2 +
 .../bindings/clock/ste-u300-syscon-clock.txt       |   80 -
 .../devicetree/bindings/clock/tango4-clock.txt     |   23 -
 .../devicetree/bindings/clock/zx296702-clk.txt     |   34 -
 .../devicetree/bindings/clock/zx296718-clk.txt     |   37 -
 MAINTAINERS                                        |   10 +
 arch/arm/mach-imx/common.h                         |    1 -
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |    1 +
 arch/arm/mach-imx/pm-imx6.c                        |    1 +
 arch/arm/mach-spear/generic.h                      |   12 -
 arch/arm/mach-spear/spear13xx.c                    |    1 +
 drivers/clk/Kconfig                                |    5 +-
 drivers/clk/Makefile                               |    7 +-
 drivers/clk/at91/at91rm9200.c                      |    3 +-
 drivers/clk/at91/at91sam9260.c                     |   16 +-
 drivers/clk/at91/at91sam9g45.c                     |    3 +-
 drivers/clk/at91/at91sam9n12.c                     |    3 +-
 drivers/clk/at91/at91sam9rl.c                      |    3 +-
 drivers/clk/at91/at91sam9x5.c                      |   20 +-
 drivers/clk/at91/sama5d2.c                         |    3 +-
 drivers/clk/at91/sama5d3.c                         |    2 +-
 drivers/clk/at91/sama5d4.c                         |    3 +-
 drivers/clk/bcm/clk-iproc-pll.c                    |    2 +-
 drivers/clk/clk-ast2600.c                          |   37 +-
 drivers/clk/clk-axi-clkgen.c                       |   15 +-
 drivers/clk/clk-bd718x7.c                          |   12 +-
 drivers/clk/clk-divider.c                          |    9 +-
 drivers/clk/clk-efm32gg.c                          |   84 -
 drivers/clk/clk-fixed-factor.c                     |   39 +-
 drivers/clk/clk-fixed-mmio.c                       |    2 +-
 drivers/clk/clk-npcm7xx.c                          |  108 -
 drivers/clk/clk-qoriq.c                            |   62 +-
 drivers/clk/clk-si570.c                            |   16 +-
 drivers/clk/clk-tango4.c                           |   85 -
 drivers/clk/clk-u300.c                             | 1199 -----
 drivers/clk/clk-versaclock5.c                      |   64 +
 drivers/clk/clk-xgene.c                            |    5 +-
 drivers/clk/imx/clk-imx31.c                        |   10 -
 drivers/clk/imx/clk-imx6q.c                        |    6 +-
 drivers/clk/imx/clk-imx6sl.c                       |    1 +
 drivers/clk/imx/clk-imx8mm.c                       |   12 +
 drivers/clk/imx/clk-imx8mn.c                       |   12 +
 drivers/clk/imx/clk-imx8mq.c                       |   22 +
 drivers/clk/imx/clk-imx8qxp.c                      |   26 +-
 drivers/clk/mediatek/Kconfig                       |   11 +
 drivers/clk/mediatek/clk-mux.c                     |   89 +-
 drivers/clk/mediatek/clk-mux.h                     |   14 +-
 drivers/clk/meson/axg.c                            |    3 -
 drivers/clk/meson/axg.h                            |    1 -
 drivers/clk/meson/clk-pll.c                        |   10 +-
 drivers/clk/meson/meson8b.c                        |   45 +-
 drivers/clk/mstar/Kconfig                          |    9 +
 drivers/clk/mstar/Makefile                         |    6 +
 drivers/clk/mstar/clk-msc313-mpll.c                |  155 +
 drivers/clk/mvebu/ap-cpu-clk.c                     |    2 +-
 drivers/clk/qcom/Kconfig                           |   61 +
 drivers/clk/qcom/Makefile                          |    7 +
 drivers/clk/qcom/a7-pll.c                          |  100 +
 drivers/clk/qcom/apcs-sdx55.c                      |  149 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  209 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    4 +
 drivers/clk/qcom/clk-rcg.h                         |    9 +
 drivers/clk/qcom/clk-rcg2.c                        |   57 +-
 drivers/clk/qcom/clk-regmap.c                      |    1 +
 drivers/clk/qcom/clk-rpm.c                         |   63 -
 drivers/clk/qcom/clk-rpmh.c                        |   49 +-
 drivers/clk/qcom/gcc-ipq4019.c                     |    7 +-
 drivers/clk/qcom/gcc-msm8998.c                     |  143 +-
 drivers/clk/qcom/gcc-sc7180.c                      |   47 +-
 drivers/clk/qcom/gcc-sc7280.c                      | 3603 +++++++++++++++
 drivers/clk/qcom/gcc-sc8180x.c                     | 4629 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sdm660.c                      |    7 +
 drivers/clk/qcom/gcc-sm8350.c                      | 3890 ++++++++++++++++
 drivers/clk/qcom/gdsc.c                            |   10 +-
 drivers/clk/qcom/gdsc.h                            |    3 +-
 drivers/clk/qcom/gpucc-msm8998.c                   |   18 +-
 drivers/clk/qcom/gpucc-sdm660.c                    |  349 ++
 drivers/clk/qcom/lpass-gfm-sm8250.c                |    8 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |   16 -
 drivers/clk/qcom/mmcc-msm8996.c                    |   29 +-
 drivers/clk/qcom/mmcc-msm8998.c                    |   12 +-
 drivers/clk/qcom/mmcc-sdm660.c                     | 2864 ++++++++++++
 drivers/clk/qcom/videocc-sm8250.c                  |   39 +
 drivers/clk/renesas/Kconfig                        |    5 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    5 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    5 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    5 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    5 +
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |   67 +-
 drivers/clk/renesas/rcar-cpg-lib.c                 |  270 ++
 drivers/clk/renesas/rcar-cpg-lib.h                 |   33 +
 drivers/clk/renesas/rcar-gen3-cpg.c                |  267 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    4 +-
 drivers/clk/rockchip/clk-cpu.c                     |    4 -
 drivers/clk/rockchip/clk-half-divider.c            |    2 +-
 drivers/clk/rockchip/clk-pll.c                     |    6 +-
 drivers/clk/rockchip/clk-rk3368.c                  |    6 +-
 drivers/clk/rockchip/clk.c                         |    4 +-
 drivers/clk/sifive/fu540-prci.h                    |    5 -
 drivers/clk/sifive/sifive-prci.c                   |    5 +
 drivers/clk/sirf/Makefile                          |    6 -
 drivers/clk/sirf/atlas6.h                          |   32 -
 drivers/clk/sirf/clk-atlas6.c                      |  150 -
 drivers/clk/sirf/clk-atlas7.c                      | 1682 -------
 drivers/clk/sirf/clk-common.c                      | 1037 -----
 drivers/clk/sirf/clk-prima2.c                      |  149 -
 drivers/clk/sirf/prima2.h                          |   26 -
 drivers/clk/socfpga/clk-agilex.c                   |   88 +-
 drivers/clk/socfpga/clk-periph-s10.c               |   53 +
 drivers/clk/socfpga/clk-pll-a10.c                  |    3 +-
 drivers/clk/socfpga/clk-pll-s10.c                  |   83 +
 drivers/clk/socfpga/clk-pll.c                      |    3 +-
 drivers/clk/socfpga/stratix10-clk.h                |   17 +-
 drivers/clk/spear/spear1310_clock.c                |    1 +
 drivers/clk/spear/spear1340_clock.c                |    1 +
 drivers/clk/st/clkgen-fsyn.c                       |    6 +-
 drivers/clk/st/clkgen-pll.c                        |    3 +-
 drivers/clk/sunxi-ng/Kconfig                       |    7 +-
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |   53 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   10 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c             | 1150 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h             |   56 +
 drivers/clk/sunxi/clk-a10-ve.c                     |    2 +-
 drivers/clk/sunxi/clk-mod0.c                       |    2 +-
 drivers/clk/sunxi/clk-sunxi.c                      |   32 +-
 drivers/clk/tegra/clk-tegra30.c                    |    5 +-
 drivers/clk/tegra/cvb.c                            |    1 +
 drivers/clk/ti/clkt_dpll.c                         |    3 +-
 drivers/clk/ti/clockdomain.c                       |    2 +-
 drivers/clk/ti/dpll.c                              |    2 +-
 drivers/clk/ti/dpll3xxx.c                          |   20 +-
 drivers/clk/ti/dpll44xx.c                          |    6 +-
 drivers/clk/ti/gate.c                              |    2 +-
 drivers/clk/versatile/clk-icst.c                   |    7 +-
 drivers/clk/xilinx/Kconfig                         |   19 +
 drivers/clk/xilinx/Makefile                        |    2 +
 drivers/clk/xilinx/xlnx_vcu.c                      |  743 ++++
 drivers/clk/zte/Makefile                           |    4 -
 drivers/clk/zte/clk-zx296702.c                     |  741 ----
 drivers/clk/zte/clk-zx296718.c                     | 1074 -----
 drivers/clk/zte/clk.c                              |  446 --
 drivers/clk/zte/clk.h                              |  174 -
 drivers/clk/zynq/clkc.c                            |   73 +-
 drivers/clk/zynq/pll.c                             |   12 +-
 drivers/clk/zynqmp/divider.c                       |    1 +
 drivers/soc/xilinx/Kconfig                         |   17 -
 drivers/soc/xilinx/Makefile                        |    1 -
 drivers/soc/xilinx/xlnx_vcu.c                      |  628 ---
 include/dt-bindings/clock/axg-clkc.h               |    1 -
 include/dt-bindings/clock/imx8-clock.h             |    2 +
 include/dt-bindings/clock/imx8mm-clock.h           |   10 +-
 include/dt-bindings/clock/imx8mn-clock.h           |    9 +-
 include/dt-bindings/clock/imx8mq-clock.h           |   16 +-
 include/dt-bindings/clock/meson8b-clkc.h           |    2 -
 include/dt-bindings/clock/mstar-msc313-mpll.h      |   19 +
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |    2 +
 include/dt-bindings/clock/qcom,gcc-sc7280.h        |  226 +
 include/dt-bindings/clock/qcom,gcc-sc8180x.h       |  309 ++
 include/dt-bindings/clock/qcom,gcc-sm8350.h        |  266 ++
 include/dt-bindings/clock/qcom,gpucc-sdm660.h      |   28 +
 include/dt-bindings/clock/qcom,mmcc-sdm660.h       |  162 +
 include/dt-bindings/clock/qcom,videocc-sm8250.h    |    2 +
 include/dt-bindings/clock/rk3368-cru.h             |    3 +
 include/dt-bindings/clock/sun50i-h6-r-ccu.h        |    2 +
 include/dt-bindings/clock/sun50i-h616-ccu.h        |  115 +
 include/dt-bindings/clock/xlnx-vcu.h               |   15 +
 include/dt-bindings/clock/zx296702-clock.h         |  180 -
 include/dt-bindings/reset/sun50i-h6-r-ccu.h        |    1 +
 include/dt-bindings/reset/sun50i-h616-ccu.h        |   70 +
 include/linux/clk-provider.h                       |    4 +-
 include/linux/clk.h                                |    4 +-
 include/linux/clk/imx.h                            |   15 +
 include/linux/clk/spear.h                          |   23 +
 include/linux/platform_data/clk-u300.h             |    1 -
 195 files changed, 21291 insertions(+), 8994 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/csr,atlas7-car.txt
 create mode 100644 Documentation/devicetree/bindings/clock/intel,easic-n5x.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/prima2-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a7pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sdm660.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/tango4-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/zx296718-clk.txt
 delete mode 100644 drivers/clk/clk-efm32gg.c
 delete mode 100644 drivers/clk/clk-tango4.c
 delete mode 100644 drivers/clk/clk-u300.c
 create mode 100644 drivers/clk/mstar/Kconfig
 create mode 100644 drivers/clk/mstar/Makefile
 create mode 100644 drivers/clk/mstar/clk-msc313-mpll.c
 create mode 100644 drivers/clk/qcom/a7-pll.c
 create mode 100644 drivers/clk/qcom/apcs-sdx55.c
 create mode 100644 drivers/clk/qcom/gcc-sc7280.c
 create mode 100644 drivers/clk/qcom/gcc-sc8180x.c
 create mode 100644 drivers/clk/qcom/gcc-sm8350.c
 create mode 100644 drivers/clk/qcom/gpucc-sdm660.c
 create mode 100644 drivers/clk/qcom/mmcc-sdm660.c
 create mode 100644 drivers/clk/renesas/rcar-cpg-lib.c
 create mode 100644 drivers/clk/renesas/rcar-cpg-lib.h
 delete mode 100644 drivers/clk/sirf/Makefile
 delete mode 100644 drivers/clk/sirf/atlas6.h
 delete mode 100644 drivers/clk/sirf/clk-atlas6.c
 delete mode 100644 drivers/clk/sirf/clk-atlas7.c
 delete mode 100644 drivers/clk/sirf/clk-common.c
 delete mode 100644 drivers/clk/sirf/clk-prima2.c
 delete mode 100644 drivers/clk/sirf/prima2.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
 create mode 100644 drivers/clk/xilinx/Kconfig
 create mode 100644 drivers/clk/xilinx/Makefile
 create mode 100644 drivers/clk/xilinx/xlnx_vcu.c
 delete mode 100644 drivers/clk/zte/Makefile
 delete mode 100644 drivers/clk/zte/clk-zx296702.c
 delete mode 100644 drivers/clk/zte/clk-zx296718.c
 delete mode 100644 drivers/clk/zte/clk.c
 delete mode 100644 drivers/clk/zte/clk.h
 delete mode 100644 drivers/soc/xilinx/xlnx_vcu.c
 create mode 100644 include/dt-bindings/clock/mstar-msc313-mpll.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc8180x.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8350.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm660.h
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-sdm660.h
 create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
 create mode 100644 include/dt-bindings/clock/xlnx-vcu.h
 delete mode 100644 include/dt-bindings/clock/zx296702-clock.h
 create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h
 create mode 100644 include/linux/clk/imx.h
 create mode 100644 include/linux/clk/spear.h
 delete mode 100644 include/linux/platform_data/clk-u300.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
