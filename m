Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508FE3FF3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347379AbhIBTID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347374AbhIBTIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:08:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DF316054E;
        Thu,  2 Sep 2021 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630609623;
        bh=BMc/z8iM2tnHsDQwFq19RmkDky3aEI+1aeIBcEWV4Z8=;
        h=From:To:Cc:Subject:Date:From;
        b=h5ryv3m4rBOdMV2V4drPhsphHj9A3fGVn0Eu81v/R8Vtzy6mKbFzTcpdqTsrj4vQd
         hAgL1wZIor7UhlfOy1I6t1g9WdgOZPOYP04M+YEnSh7xuoGwj5Pl9o+DSW2Enpfatu
         QaZxNZNtQcLmHwiT8UOrj/+ckY59iuIq3q9W+IiLEQ/tdFjd202Qq75DfN4pXq3wYg
         J+O1yS3OrohjpSP8ouA6M8g/fI8xWIZeOK2c3jZlX5n7Q2F/wBLyXnxa2cXEmlKq3C
         TtM+c48goyAgDCxFx85Is7SjXguYK724MEvTAmjkzOwT72Y8S2UGzVwPIyEdGSvV5J
         pb3WzpWzDZRaw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL] clk changes for the merge window
Date:   Thu,  2 Sep 2021 12:07:02 -0700
Message-Id: <20210902190702.516457-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please note there's one merge conflict in the DT bindings. Rob called it out on
the DT pull request earlier. We add 'mediatek,mt8192-mmsys' to the list of
compatible strings so that needs to be ported over to the yaml binding.

The following changes since commit 59c6fceb2ecc382c3d20508a235b539bf23af1f0:

  soc/tegra: fuse: Enable fuse clock on suspend for Tegra124 (2021-08-11 11:55:56 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 47505bf3a82166c3576155c229e941af922bf147:

  Merge branches 'clk-kirkwood', 'clk-imx', 'clk-doc', 'clk-zynq' and 'clk-ralink' into clk-next (2021-09-01 15:27:07 -0700)

----------------------------------------------------------------
Nothing changed in the clk framework core this time around. We did get
some updates to the basic clk types to use determine_rate for the
divider type and add a power of two fractional divider flag though.
Otherwise, this is a collection of clk driver updates. More than half
the diffstat is in the Qualcomm clk driver where we add a bunch of data
to describe clks on various SoCs and fix bugs. The other big new thing
in here is the Mediatek MT8192 clk driver. That's been under review for
a while and it's nice to see that it's finally upstream.

Beyond that it's the usual set of minor fixes and tweaks to clk drivers.
There are some non-clk driver bits in here which have all been acked by
the respective maintainers.

New Drivers:
 - Support video, gpu, display clks on qcom sc7280 SoCs
 - GCC clks on qcom MSM8953, SM4250/6115, and SM6350 SoCs
 - Multimedia clks (MMCC) on qcom MSM8994/MSM8992
 - RPMh clks on qcom SM6350 SoCs
 - Support for Mediatek MT8192 SoCs
 - Add display (DU and DSI) clocks on Renesas R-Car V3U
 - Add I2C, DMAC, USB, sound (SSIF-2), GPIO, CANFD, and ADC clocks and
   resets on Renesas RZ/G2L

Updates:
 - Support the SD/OE pin on IDT VersaClock 5 and 6 clock generators
 - Add power of two flag to fractional divider clk type
 - Migrate some clk drivers to clk_divider_ops.determine_rate
 - Migrate to clk_parent_data in gcc-sdm660
 - Fix CLKOUT clocks on i.MX8MM and i.MX8MN by using imx_clk_hw_mux2
 - Switch from .round_rate to .determine_rate in clk-divider-gate
 - Fix clock tree update for TF-A controlled clocks for all i.MX8M
 - Add missing M7 core clock for i.MX8MN
 - YAML conversion of rk3399 clock controller binding
 - Removal of GRF dependency for the rk3328/rk3036 pll types
 - Drop CLK_IS_CRITICAL flag from Tegra fuse clk
 - Make CLK_R9A06G032 Kconfig symbol invisible
 - Convert various DT bindings to YAML

----------------------------------------------------------------
Ahmad Fatoum (1):
      clk: imx8m: fix clock tree update of TF-A managed clocks

Andy Shevchenko (5):
      clk: x86: Rename clk-lpt to more specific clk-lpss-atom
      clk: fractional-divider: Export approximation algorithm to the CCF users
      clk: fractional-divider: Hide clk_fractional_divider_ops from wide audience
      clk: fractional-divider: Introduce POWER_OF_TWO_PS flag
      clk: fractional-divider: Document the arithmetics used behind the code

Arnd Bergmann (1):
      clk: tegra: fix old-style declaration

Biju Das (4):
      clk: renesas: r9a07g044: Add I2C clocks/resets
      clk: renesas: r9a07g044: Add DMAC clocks/resets
      clk: renesas: r9a07g044: Add USB clocks/resets
      clk: renesas: r9a07g044: Add SSIF-2 clock and reset entries

Bjorn Andersson (3):
      clk: qcom: dispcc-sm8250: Add additional parent clocks for DP
      clk: qcom: gpucc-sm8150: Add SC8180x support
      clk: qcom: gcc-sdm660: Replace usage of parent_names

Chris Morgan (1):
      clk: rockchip: add dt-binding clkid for hclk_sfc on rk3036

Chun-Jie Chen (21):
      dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock
      dt-bindings: ARM: Mediatek: Add mmsys document binding for MT8192
      dt-bindings: ARM: Mediatek: Add audsys document binding for MT8192
      clk: mediatek: Add dt-bindings of MT8192 clocks
      clk: mediatek: Get regmap without syscon compatible check
      clk: mediatek: Fix asymmetrical PLL enable and disable control
      clk: mediatek: Add configurable enable control to mtk_pll_data
      clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers
      clk: mediatek: Add MT8192 basic clocks support
      clk: mediatek: Add MT8192 audio clock support
      clk: mediatek: Add MT8192 camsys clock support
      clk: mediatek: Add MT8192 imgsys clock support
      clk: mediatek: Add MT8192 imp i2c wrapper clock support
      clk: mediatek: Add MT8192 ipesys clock support
      clk: mediatek: Add MT8192 mdpsys clock support
      clk: mediatek: Add MT8192 mfgcfg clock support
      clk: mediatek: Add MT8192 mmsys clock support
      clk: mediatek: Add MT8192 msdc clock support
      clk: mediatek: Add MT8192 scp adsp clock support
      clk: mediatek: Add MT8192 vdecsys clock support
      clk: mediatek: Add MT8192 vencsys clock support

Codrin Ciubotariu (1):
      clk: at91: clk-generated: Limit the requested rate to our range

Dan Carpenter (2):
      clk: renesas: rzg2l: Fix a double free on error
      clk: renesas: rzg2l: Avoid mixing error pointers and NULL

Dinh Nguyen (3):
      clk: socfpga: agilex: fix the parents of the psi_ref_clk
      clk: socfpga: agilex: fix up s2f_user0_clk representation
      clk: socfpga: agilex: add the bypass register for s2f_usr0 clock

Dmitry Baryshkov (3):
      PM: runtime: add devm_pm_runtime_enable helper
      PM: runtime: add devm_pm_clk_create helper
      clk: qcom: use devm_pm_runtime_enable and devm_pm_clk_create

Dmitry Osipenko (1):
      clk: tegra: Remove CLK_IS_CRITICAL flag from fuse clock

Geert Uytterhoeven (5):
      clk: renesas: rzg2: Rename i2c-dvfs to iic-pmic
      clk: renesas: Rename renesas-rzg2l-cpg.[ch] to rzg2l-cpg.[ch]
      Merge tag 'renesas-r9a07g044-dt-binding-defs-tag2' into renesas-clk-for-v5.15
      clk: Align provider-specific CLK_* bit definitions
      clk: renesas: Make CLK_R9A06G032 invisible

Iskren Chernev (4):
      dt-bindings: clock: qcom: rpmcc: Document SM6115 compatible
      clk: qcom: smd: Add support for SM6115 rpm clocks
      dt-bindings: clk: qcom: gcc-sm6115: Document SM6115 GCC
      clk: qcom: Add Global Clock controller (GCC) driver for SM6115

Jason Wang (1):
      clk: palmas: Add a missing SPDX license header

Jon Lin (2):
      clk: rockchip: rk3036: fix up the sclk_sfc parent error
      clk: rockchip: Add support for hclk_sfc on rk3036

Kieran Bingham (2):
      clk: renesas: r8a779a0: Add the DU clock
      clk: renesas: r8a779a0: Add the DSI clocks

Konrad Dybcio (9):
      dt-bindings: clock: qcom: rpmcc: Document MDM9607 compatible
      clk: qcom: smd-rpm: Add mdm9607 clocks
      dt-bindings: clock: Add support for MSM8992/4 MMCC
      clk: qcom: Add msm8994 MMCC driver
      clk: qcom: mmcc-msm8994: Add MSM8992 support
      dt-bindings: clock: Add RPMHCC bindings for SM6350
      clk: qcom: rpmh: Add support for RPMH clocks on SM6350
      dt-bindings: clock: Add SM6350 GCC clock bindings
      clk: qcom: Add SM6350 GCC driver

Krzysztof Kozlowski (9):
      dt-bindings: clock: samsung: convert Exynos5250 to dtschema
      dt-bindings: clock: samsung: add bindings for Exynos external clock
      dt-bindings: clock: samsung: convert Exynos542x to dtschema
      dt-bindings: clock: samsung: convert Exynos3250 to dtschema
      dt-bindings: clock: samsung: convert Exynos4 to dtschema
      dt-bindings: clock: samsung: convert Exynos AudSS to dtschema
      dt-bindings: clock: samsung: convert S5Pv210 AudSS to dtschema
      MAINTAINERS: clock: include S3C and S5P in Samsung SoC clock entry
      dt-bindings: clock: samsung: fix header path in example

Lad Prabhakar (5):
      clk: renesas: rzg2l: Fix off-by-one check in rzg2l_cpg_clk_src_twocell_get()
      clk: renesas: r9a07g044: Add GPIO clock and reset entries
      clk: renesas: r9a07g044: Add clock and reset entries for CANFD
      clk: renesas: r9a07g044: Add clock and reset entries for ADC
      clk: renesas: r9a07g044: Add entry for fixed clock P0_DIV2

Liam Beguin (1):
      clk: lmk04832: drop redundant fallthrough statements

Linus Walleij (1):
      clk: kirkwood: Fix a clocking boot regression

Lucas Stach (2):
      clk: imx8mm: use correct mux type for clkout path
      clk: imx8mn: use correct mux type for clkout path

Lukas Bulwahn (1):
      clk: qcom: adjust selects for SM_VIDEOCC_8150 and SM_VIDEOCC_8250

Marek Vasut (1):
      clk: imx8mn: Add M7 core clock

Martin Blumenstingl (6):
      clk: divider: Implement and wire up .determine_rate by default
      clk: bcm2835: Switch to clk_divider.determine_rate
      clk: stm32f4: Switch to clk_divider.determine_rate
      clk: stm32h7: Switch to clk_divider.determine_rate
      clk: stm32mp1: Switch to clk_divider.determine_rate
      clk: imx: clk-divider-gate: Switch to clk_divider.determine_rate

Martin Botka (2):
      dt-bindings: clk: qcom: smd-rpm: Document SM6125 compatible
      clk: qcom: smd: Add support for SM6125 rpm clocks

Michal Simek (1):
      clk: zynqmp: Fix kernel-doc format

Miles Chen (1):
      clk: mediatek: make COMMON_CLK_MT8167* depend on COMMON_CLK_MT8167

Nícolas F. R. A. Prado (1):
      dt-bindings: clk: Convert rockchip,rk3399-cru to DT schema

Peter Geis (1):
      clk: rockchip: drop GRF dependency for rk3328/rk3036 pll types

Rafał Miłecki (1):
      dt-bindings: clock: brcm,iproc-clocks: fix armpll properties

Rajan Vaja (1):
      clk: zynqmp: fix kernel doc

Randy Dunlap (1):
      clk: at91: sama7g5: remove all kernel-doc & kernel-doc warnings

Sean Anderson (3):
      dt-bindings: clk: vc5: Add properties for configuring the SD/OE pin
      clk: vc5: Use dev_err_probe
      clk: vc5: Add properties for configuring SD/OE behavior

Sergio Paracuellos (1):
      clk: ralink: avoid to set 'CLK_IS_CRITICAL' flag for gates

Shawn Guo (4):
      clk: qcom: apcs-msm8916: Flag a53mux instead of a53pll as critical
      clk: qcom: a53pll/mux: Use unique clock name
      dt-bindings: clock: Update qcom,a53pll bindings for MSM8939 support
      clk: qcom: a53-pll: Add MSM8939 a53pll support

Shubhrajyoti Datta (2):
      clk: zynqmp: Check the return type
      clk: zynqmp: Fix a memory leak

Stephen Boyd (11):
      Merge tag 'renesas-clk-for-v5.15-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'renesas-clk-for-v5.15-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'for-5.15-clk' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into clk-nvidia
      Merge tag 'v5.15-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      clk: qcom: gcc-sdm660: Move parent tables after PLLs
      Merge tag 'clk-imx-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge branches 'clk-qcom', 'clk-socfpga', 'clk-mediatek', 'clk-lmk' and 'clk-x86' into clk-next
      Merge branches 'clk-renesas', 'clk-cleanup' and 'clk-determine-divider' into clk-next
      Merge branch 'clk-frac-divider' into clk-next
      Merge branches 'clk-nvidia', 'clk-rockchip', 'clk-at91' and 'clk-vc5' into clk-next
      Merge branches 'clk-kirkwood', 'clk-imx', 'clk-doc', 'clk-zynq' and 'clk-ralink' into clk-next

Taniya Das (7):
      dt-bindings: clock: qcom: Update license for GCC SC7280
      dt-bindings: clock: Add SC7280 DISPCC clock binding
      clk: qcom: Add display clock controller driver for SC7280
      dt-bindings: clock: Add SC7280 GPUCC clock binding
      clk: qcom: Add graphics clock controller driver for SC7280
      dt-bindings: clock: Add SC7280 VideoCC clock binding
      clk: qcom: Add video clock controller driver for SC7280

Thierry Reding (1):
      Merge branch 'for-5.15/soc' into for-5.15/clk

Vladimir Lypak (4):
      dt-bindings: clock: qcom-rpmcc: Add compatible for MSM8953 SoC
      clk: qcom: rpmcc: Add support for MSM8953 RPM clocks.
      dt-bindings: clock: add Qualcomm MSM8953 GCC driver bindings
      clk: qcom: Add Global Clock Controller driver for MSM8953

Yang Li (2):
      clk: renesas: rzg2l: Remove unneeded semicolon
      clk: renesas: rzg2l: Fix return value and unused assignment

Yunhao Tian (1):
      clk: rockchip: make rk3308 ddrphy4x clock critical

 Documentation/ABI/testing/sysfs-ptp                |   20 +
 Documentation/dev-tools/kunit/running_tips.rst     |   14 +-
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../arm/mediatek/mediatek,mt8192-clock.yaml        |  199 +
 .../arm/mediatek/mediatek,mt8192-sys-clock.yaml    |   65 +
 .../bindings/clock/brcm,iproc-clocks.yaml          |   28 +-
 .../devicetree/bindings/clock/clk-exynos-audss.txt |  103 -
 .../bindings/clock/clk-s5pv210-audss.txt           |   53 -
 .../devicetree/bindings/clock/exynos3250-clock.txt |   57 -
 .../devicetree/bindings/clock/exynos4-clock.txt    |   86 -
 .../devicetree/bindings/clock/exynos5250-clock.txt |   41 -
 .../devicetree/bindings/clock/exynos5420-clock.txt |   42 -
 .../devicetree/bindings/clock/idt,versaclock5.yaml |   40 +
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |    3 +
 .../devicetree/bindings/clock/qcom,gcc-sm6115.yaml |   72 +
 .../devicetree/bindings/clock/qcom,gcc-sm6350.yaml |   76 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    2 +
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |    7 +-
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |    2 +
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |    4 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sc7280-dispcc.yaml         |   94 +
 .../devicetree/bindings/clock/qcom,videocc.yaml    |    6 +-
 .../bindings/clock/rockchip,rk3399-cru.txt         |   68 -
 .../bindings/clock/rockchip,rk3399-cru.yaml        |   92 +
 .../bindings/clock/samsung,exynos-audss-clock.yaml |   80 +
 .../bindings/clock/samsung,exynos-clock.yaml       |   59 +
 .../bindings/clock/samsung,exynos-ext-clock.yaml   |   46 +
 .../clock/samsung,exynos4412-isp-clock.yaml        |   64 +
 .../clock/samsung,s5pv210-audss-clock.yaml         |   78 +
 .../devicetree/bindings/display/renesas,du.yaml    |    1 -
 .../devicetree/bindings/hwmon/adt7475.yaml         |   22 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    6 +-
 .../devicetree/bindings/iommu/rockchip,iommu.yaml  |    2 -
 .../bindings/memory-controllers/arm,pl353-smc.yaml |    1 -
 .../devicetree/bindings/mtd/brcm,brcmnand.yaml     |    8 -
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |    4 +-
 Documentation/devicetree/bindings/net/gpmc-eth.txt |    2 +-
 .../devicetree/bindings/net/smsc,lan9115.yaml      |  110 +
 Documentation/devicetree/bindings/net/smsc911x.txt |   43 -
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   56 +-
 .../devicetree/bindings/regulator/mps,mpq7920.yaml |    6 +-
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   |    3 +-
 .../devicetree/bindings/rtc/faraday,ftrtc010.yaml  |    1 -
 .../devicetree/bindings/spi/spi-controller.yaml    |   32 +-
 .../devicetree/bindings/usb/nxp,isp1760.yaml       |    2 -
 .../early-userspace/early_userspace_support.rst    |    8 +-
 .../core/thread-info-in-task/arch-support.txt      |   32 +
 .../time/arch-tick-broadcast/arch-support.txt      |    2 +-
 .../filesystems/ramfs-rootfs-initramfs.rst         |    2 +-
 Documentation/networking/ethtool-netlink.rst       |   22 +
 Documentation/networking/nf_conntrack-sysctl.rst   |    6 +
 Documentation/networking/tipc.rst                  |  121 +-
 .../translations/zh_CN/process/2.Process.rst       |    4 +-
 LICENSES/dual/CC-BY-4.0                            |    2 +-
 MAINTAINERS                                        |   12 +
 Makefile                                           |   13 +-
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  |    4 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |    9 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |    5 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |    6 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |    4 +-
 arch/arm/boot/dts/versatile-ab.dts                 |    5 +-
 arch/arm/boot/dts/versatile-pb.dts                 |    2 +-
 arch/arm/configs/integrator_defconfig              |    5 +-
 arch/arm/configs/multi_v7_defconfig                |    2 +-
 arch/arm/configs/realview_defconfig                |    4 +-
 arch/arm/configs/shmobile_defconfig                |    1 +
 arch/arm/configs/u8500_defconfig                   |    5 +
 arch/arm/configs/versatile_defconfig               |    4 +-
 arch/arm/configs/vexpress_defconfig                |   17 +-
 arch/arm64/Kconfig                                 |    3 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   13 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi         |    4 +-
 arch/arm64/include/asm/cache.h                     |    2 +-
 arch/arm64/include/asm/smp_plat.h                  |    1 +
 arch/arm64/kernel/Makefile                         |    2 +-
 arch/arm64/kernel/cpufeature.c                     |    1 +
 arch/arm64/kernel/entry-common.c                   |    2 +-
 arch/arm64/kernel/mte.c                            |   15 +-
 arch/arm64/lib/copy_from_user.S                    |   13 +-
 arch/arm64/lib/copy_in_user.S                      |   21 +-
 arch/arm64/lib/copy_to_user.S                      |   14 +-
 arch/arm64/lib/strlen.S                            |   10 +
 arch/mips/include/asm/fpu.h                        |    2 +-
 arch/mips/mm/tlbex.c                               |    2 +
 arch/powerpc/platforms/powermac/smp.c              |    1 +
 arch/s390/kernel/uprobes.c                         |    1 +
 arch/x86/kvm/cpuid.c                               |   30 +-
 arch/x86/kvm/mmu/mmu.c                             |    2 +
 arch/x86/kvm/mmu/paging.h                          |   14 +
 arch/x86/kvm/mmu/paging_tmpl.h                     |    4 +-
 arch/x86/kvm/mmu/spte.h                            |    6 -
 arch/x86/kvm/svm/nested.c                          |   53 +-
 arch/x86/kvm/svm/sev.c                             |   14 +-
 arch/x86/kvm/svm/svm.c                             |   77 +-
 arch/x86/kvm/svm/svm.h                             |    5 +
 arch/x86/kvm/vmx/vmx.h                             |    2 -
 arch/x86/kvm/x86.c                                 |    5 +-
 arch/x86/net/bpf_jit_comp.c                        |    3 +
 drivers/acpi/acpi_lpss.c                           |   10 +-
 drivers/base/power/clock_ops.c                     |   17 +
 drivers/base/power/runtime.c                       |   17 +
 drivers/block/nbd.c                                |    2 +-
 drivers/block/paride/pd.c                          |    2 +-
 drivers/block/xen-blkfront.c                       |  224 +-
 drivers/char/powernv-op-panel.c                    |    1 +
 drivers/clk/at91/clk-generated.c                   |    6 +
 drivers/clk/at91/sama7g5.c                         |   14 +-
 drivers/clk/bcm/clk-bcm2835.c                      |    9 +-
 drivers/clk/clk-divider.c                          |   23 +
 drivers/clk/clk-fractional-divider.c               |   56 +-
 drivers/clk/clk-fractional-divider.h               |   15 +
 drivers/clk/clk-lmk04832.c                         |   18 -
 drivers/clk/clk-palmas.c                           |   10 +-
 drivers/clk/clk-stm32f4.c                          |    8 +-
 drivers/clk/clk-stm32h7.c                          |    8 +-
 drivers/clk/clk-stm32mp1.c                         |   10 +-
 drivers/clk/clk-versaclock5.c                      |   42 +-
 drivers/clk/imx/clk-composite-7ulp.c               |    1 +
 drivers/clk/imx/clk-composite-8m.c                 |    3 +-
 drivers/clk/imx/clk-divider-gate.c                 |   10 +-
 drivers/clk/imx/clk-imx8mm.c                       |   11 +-
 drivers/clk/imx/clk-imx8mn.c                       |   16 +-
 drivers/clk/imx/clk-imx8mq.c                       |    7 +-
 drivers/clk/imx/clk.h                              |   16 +-
 drivers/clk/mediatek/Kconfig                       |  105 +-
 drivers/clk/mediatek/Makefile                      |   13 +
 drivers/clk/mediatek/clk-cpumux.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8192-aud.c              |  118 +
 drivers/clk/mediatek/clk-mt8192-cam.c              |  107 +
 drivers/clk/mediatek/clk-mt8192-img.c              |   70 +
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c     |  119 +
 drivers/clk/mediatek/clk-mt8192-ipe.c              |   57 +
 drivers/clk/mediatek/clk-mt8192-mdp.c              |   82 +
 drivers/clk/mediatek/clk-mt8192-mfg.c              |   50 +
 drivers/clk/mediatek/clk-mt8192-mm.c               |  108 +
 drivers/clk/mediatek/clk-mt8192-msdc.c             |   85 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c         |   50 +
 drivers/clk/mediatek/clk-mt8192-vdec.c             |   94 +
 drivers/clk/mediatek/clk-mt8192-venc.c             |   53 +
 drivers/clk/mediatek/clk-mt8192.c                  | 1326 ++++++
 drivers/clk/mediatek/clk-mtk.c                     |   25 +-
 drivers/clk/mediatek/clk-mtk.h                     |   28 +-
 drivers/clk/mediatek/clk-mux.c                     |   11 +-
 drivers/clk/mediatek/clk-mux.h                     |   18 +-
 drivers/clk/mediatek/clk-pll.c                     |   31 +-
 drivers/clk/mediatek/reset.c                       |    2 +-
 drivers/clk/mvebu/kirkwood.c                       |    1 +
 drivers/clk/qcom/Kconfig                           |   60 +-
 drivers/clk/qcom/Makefile                          |    7 +
 drivers/clk/qcom/a53-pll.c                         |   68 +-
 drivers/clk/qcom/apcs-msm8916.c                    |   10 +-
 drivers/clk/qcom/camcc-sc7180.c                    |   25 +-
 drivers/clk/qcom/clk-rpmh.c                        |   21 +
 drivers/clk/qcom/clk-smd-rpm.c                     |  158 +
 drivers/clk/qcom/dispcc-sc7280.c                   |  908 +++++
 drivers/clk/qcom/dispcc-sm8250.c                   |   22 +-
 drivers/clk/qcom/gcc-msm8953.c                     | 4250 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sdm660.c                      |  504 +--
 drivers/clk/qcom/gcc-sm6115.c                      | 3544 ++++++++++++++++
 drivers/clk/qcom/gcc-sm6350.c                      | 2588 ++++++++++++
 drivers/clk/qcom/gpucc-sc7280.c                    |  491 +++
 drivers/clk/qcom/gpucc-sm8150.c                    |   12 +
 drivers/clk/qcom/lpass-gfm-sm8250.c                |   21 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c              |   18 +-
 drivers/clk/qcom/mmcc-msm8994.c                    | 2620 ++++++++++++
 drivers/clk/qcom/mss-sc7180.c                      |   30 +-
 drivers/clk/qcom/q6sstop-qcs404.c                  |   32 +-
 drivers/clk/qcom/turingcc-qcs404.c                 |   30 +-
 drivers/clk/qcom/videocc-sc7280.c                  |  325 ++
 drivers/clk/ralink/clk-mt7621.c                    |    9 +-
 drivers/clk/renesas/Kconfig                        |    4 +-
 drivers/clk/renesas/Makefile                       |    2 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a774e1-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    5 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |  151 +-
 .../renesas/{renesas-rzg2l-cpg.c => rzg2l-cpg.c}   |  132 +-
 .../renesas/{renesas-rzg2l-cpg.h => rzg2l-cpg.h}   |   37 +-
 drivers/clk/rockchip/clk-pll.c                     |    2 +-
 drivers/clk/rockchip/clk-rk3036.c                  |    5 +-
 drivers/clk/rockchip/clk-rk3308.c                  |    1 +
 drivers/clk/rockchip/clk.c                         |   17 +-
 drivers/clk/socfpga/clk-agilex.c                   |   19 +-
 drivers/clk/tegra/clk-dfll.c                       |    2 +-
 drivers/clk/tegra/clk-tegra-periph.c               |    6 +-
 drivers/clk/x86/Makefile                           |    2 +-
 drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c}     |   12 +-
 drivers/clk/zynqmp/clk-gate-zynqmp.c               |    4 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |    2 +-
 drivers/clk/zynqmp/clk-zynqmp.h                    |    1 +
 drivers/clk/zynqmp/clkc.c                          |    4 +-
 drivers/cpufreq/longhaul.c                         |    2 -
 drivers/dma-buf/sync_file.c                        |   13 +-
 drivers/dma/ipu/ipu_idmac.c                        |    2 +
 drivers/dma/mpc512x_dma.c                          |    1 +
 drivers/dma/ti/k3-udma.c                           |    1 +
 drivers/edac/Kconfig                               |    2 +-
 drivers/firmware/arm_ffa/bus.c                     |    6 +-
 drivers/firmware/arm_ffa/driver.c                  |    8 +-
 drivers/firmware/arm_scmi/bus.c                    |    8 +-
 drivers/firmware/arm_scmi/driver.c                 |   14 +-
 drivers/firmware/arm_scmi/notify.c                 |    4 +
 drivers/firmware/arm_scmi/sensors.c                |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   18 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   49 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    2 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   45 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   30 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    2 +-
 .../drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    8 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |    2 +-
 .../drm/amd/include/asic_reg/mp/mp_13_0_1_offset.h |  355 --
 .../amd/include/asic_reg/mp/mp_13_0_1_sh_mask.h    |  531 ---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h             |    1 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h           |   57 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile        |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   24 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c   |  311 --
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |   49 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |    1 +
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |    5 +-
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |    2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c      |    4 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    2 +-
 drivers/gpu/drm/ttm/ttm_range_manager.c            |    3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |    1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |    1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   13 +-
 drivers/iommu/intel/iommu.c                        |   34 +-
 drivers/iommu/rockchip-iommu.c                     |    6 +-
 drivers/mfd/intel-lpss.c                           |    3 +-
 drivers/mmc/host/jz4740_mmc.c                      |    2 +
 drivers/mtd/chips/cfi_util.c                       |    4 +-
 drivers/net/bonding/bond_main.c                    |  181 +-
 drivers/net/caif/Kconfig                           |    9 -
 drivers/net/caif/Makefile                          |    3 -
 drivers/net/caif/caif_hsi.c                        | 1454 -------
 drivers/net/dsa/microchip/ksz_common.c             |    4 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   22 +-
 drivers/net/dsa/mv88e6xxx/serdes.c                 |    6 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |   14 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_hw.c      |    5 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   23 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |    6 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   18 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c     |    3 +
 drivers/net/ethernet/google/gve/gve_main.c         |   19 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |    7 -
 drivers/net/ethernet/ibm/ibmvnic.c                 |   22 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |    1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c        |    1 +
 drivers/net/ethernet/intel/igb/igb_main.c          |   15 +-
 drivers/net/ethernet/intel/igc/igc.h               |    2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |    3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    1 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |   20 +-
 drivers/net/ethernet/marvell/mvneta.c              |   20 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |  292 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |   10 +
 .../ethernet/marvell/octeontx2/af/lmac_common.h    |   12 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   58 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    7 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  111 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |  200 +
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   88 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |    3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |   10 +
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |    3 +-
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |    2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   87 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |    3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   18 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c |  173 +
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  229 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   26 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |    2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |    1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   12 +-
 drivers/net/ethernet/microchip/sparx5/Kconfig      |    1 +
 drivers/net/ethernet/moxa/moxart_ether.c           |    4 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |    9 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |   14 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |    3 +-
 drivers/net/ethernet/sfc/efx_channels.c            |   22 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |    9 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    1 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   41 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   56 +-
 drivers/net/ethernet/ti/tlan.c                     |    3 +-
 drivers/net/fddi/defza.c                           |    3 +-
 drivers/net/netdevsim/ipsec.c                      |    8 +-
 drivers/net/phy/marvell10g.c                       |   40 +-
 drivers/net/usb/asix_devices.c                     |    1 +
 drivers/net/virtio_net.c                           |    8 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |   22 +-
 drivers/net/wan/hdlc_cisco.c                       |    8 +-
 drivers/net/wan/hdlc_fr.c                          |    8 +-
 drivers/net/wan/hdlc_ppp.c                         |    8 +-
 drivers/net/wan/hdlc_raw.c                         |    8 +-
 drivers/net/wan/hdlc_raw_eth.c                     |    8 +-
 drivers/net/wan/hdlc_x25.c                         |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |    3 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c          |   21 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h          |    6 +-
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c         |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_uevent.c            |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_wwan.c              |   11 +-
 drivers/nvme/host/pci.c                            |   67 +-
 drivers/nvme/host/tcp.c                            |    4 +-
 drivers/pci/proc.c                                 |    2 +-
 drivers/power/supply/ab8500_fg.c                   |    2 +
 drivers/power/supply/abx500_chargalg.c             |    1 +
 drivers/ptp/Makefile                               |    2 +-
 drivers/ptp/ptp_clock.c                            |   44 +-
 drivers/ptp/ptp_private.h                          |   39 +
 drivers/ptp/ptp_sysfs.c                            |  160 +
 drivers/ptp/ptp_vclock.c                           |  219 +
 drivers/pwm/pwm-berlin.c                           |    9 +-
 drivers/pwm/pwm-ep93xx.c                           |   85 +-
 drivers/pwm/pwm-spear.c                            |    9 +-
 drivers/pwm/pwm-sprd.c                             |   11 +-
 drivers/pwm/pwm-tiecap.c                           |   15 +-
 drivers/s390/char/tape_char.c                      |    2 -
 drivers/s390/net/ctcm_fsms.c                       |    1 +
 drivers/s390/net/qeth_l3_main.c                    |    1 +
 drivers/s390/scsi/zfcp_sysfs.c                     |    1 +
 drivers/scsi/arm/fas216.c                          |    2 +-
 drivers/scsi/hosts.c                               |    1 +
 drivers/scsi/libsas/sas_discover.c                 |    2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |   15 +-
 drivers/scsi/pm8001/pm8001_ctl.c                   |   48 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |   18 +-
 drivers/scsi/pm8001/pm8001_init.c                  |   29 +-
 drivers/scsi/pm8001/pm8001_sas.c                   |   41 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |   50 +-
 drivers/scsi/scsi_lib.c                            |    2 +-
 drivers/scsi/sd.c                                  |    4 -
 drivers/scsi/ufs/ufshcd.h                          |    9 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |    1 +
 drivers/video/fbdev/core/fbmem.c                   |   12 +-
 drivers/video/fbdev/xilinxfb.c                     |    2 +
 fs/btrfs/block-group.c                             |  367 +-
 fs/btrfs/block-group.h                             |    6 +-
 fs/btrfs/ctree.c                                   |   67 +-
 fs/btrfs/inode.c                                   |  147 +-
 fs/btrfs/transaction.c                             |   15 +-
 fs/btrfs/transaction.h                             |    9 +-
 fs/btrfs/tree-log.c                                |    2 +-
 fs/btrfs/volumes.c                                 |  355 +-
 fs/btrfs/volumes.h                                 |    5 +-
 fs/cifs/cifs_dfs_ref.c                             |    6 +-
 fs/cifs/cifsglob.h                                 |    7 +
 fs/cifs/connect.c                                  |  110 +-
 fs/cifs/dns_resolve.c                              |   10 +-
 fs/cifs/dns_resolve.h                              |    2 +-
 fs/cifs/misc.c                                     |    2 +-
 fs/cifs/smb2ops.c                                  |    6 +-
 fs/cifs/smb2pdu.h                                  |    1 +
 fs/configfs/file.c                                 |   29 +-
 fs/fcntl.c                                         |    2 +-
 fs/fs_context.c                                    |   54 +-
 fs/hfs/bfind.c                                     |   14 +-
 fs/hfs/bnode.c                                     |   25 +-
 fs/hfs/btree.h                                     |    7 +
 fs/hfs/super.c                                     |   10 +-
 fs/io_uring.c                                      |    8 +-
 fs/iomap/buffered-io.c                             |    8 +-
 fs/iomap/seek.c                                    |   25 +-
 fs/vboxsf/dir.c                                    |   76 +-
 fs/vboxsf/file.c                                   |   71 +-
 fs/vboxsf/vfsmod.h                                 |    7 +
 fs/xfs/libxfs/xfs_ag.c                             |    8 +
 fs/xfs/libxfs/xfs_attr.c                           |   16 +-
 fs/xfs/libxfs/xfs_ialloc.c                         |   55 +
 fs/xfs/libxfs/xfs_ialloc.h                         |    3 +
 fs/xfs/libxfs/xfs_inode_buf.c                      |   28 +-
 fs/xfs/libxfs/xfs_trans_inode.c                    |   10 +-
 fs/xfs/scrub/inode.c                               |   18 +-
 fs/xfs/xfs_inode.c                                 |   13 +
 fs/xfs/xfs_ioctl.c                                 |   27 +-
 fs/xfs/xfs_rtalloc.c                               |   49 +-
 fs/zonefs/super.c                                  |    3 -
 include/dt-bindings/clock/imx8mn-clock.h           |    4 +-
 include/dt-bindings/clock/mt8192-clk.h             |  585 +++
 include/dt-bindings/clock/qcom,dispcc-sc7280.h     |   55 +
 include/dt-bindings/clock/qcom,gcc-msm8953.h       |  234 ++
 include/dt-bindings/clock/qcom,gcc-sc7280.h        |    2 +-
 include/dt-bindings/clock/qcom,gcc-sm6115.h        |  201 +
 include/dt-bindings/clock/qcom,gcc-sm6350.h        |  178 +
 include/dt-bindings/clock/qcom,gpucc-sc7280.h      |   35 +
 include/dt-bindings/clock/qcom,mmcc-msm8994.h      |  155 +
 include/dt-bindings/clock/qcom,rpmcc.h             |   10 +
 include/dt-bindings/clock/qcom,rpmh.h              |    2 +
 include/dt-bindings/clock/qcom,videocc-sc7280.h    |   27 +
 include/dt-bindings/clock/r9a07g044-cpg.h          |  237 +-
 include/dt-bindings/clock/rk3036-cru.h             |    1 +
 include/linux/bpf.h                                |    1 +
 include/linux/clk-provider.h                       |   14 +-
 include/linux/ethtool.h                            |   10 +
 include/linux/fs_context.h                         |    2 +
 include/linux/kasan.h                              |    1 +
 include/linux/marvell_phy.h                        |    6 +-
 include/linux/migrate.h                            |    5 -
 include/linux/mm.h                                 |    1 +
 include/linux/platform_data/x86/clk-lpss.h         |    2 +-
 include/linux/pm_clock.h                           |    5 +
 include/linux/pm_runtime.h                         |    4 +
 include/linux/ptp_clock_kernel.h                   |   31 +-
 include/linux/rmap.h                               |    4 +-
 include/linux/scmi_protocol.h                      |   14 +-
 include/linux/scpi_protocol.h                      |    8 +
 include/linux/soc/qcom/smd-rpm.h                   |    1 +
 include/linux/stmmac.h                             |    2 +
 include/math-emu/op-common.h                       |    2 +-
 include/net/bonding.h                              |    9 +-
 include/net/busy_poll.h                            |    2 +-
 include/net/caif/caif_hsi.h                        |  200 -
 include/net/dst_metadata.h                         |    4 +-
 include/net/ip6_route.h                            |    2 +-
 include/net/mptcp.h                                |    5 +-
 include/net/netfilter/nf_conntrack_core.h          |    1 -
 include/net/netns/conntrack.h                      |    1 +
 include/net/sctp/constants.h                       |    4 +-
 include/net/sock.h                                 |    8 +-
 include/net/tcp.h                                  |    4 +
 include/soc/tegra/mc.h                             |    9 +-
 include/uapi/linux/ethtool_netlink.h               |   15 +
 include/uapi/linux/net_tstamp.h                    |   17 +-
 include/uapi/linux/netfilter/nfnetlink_log.h       |    2 +-
 include/uapi/linux/netfilter/nfnetlink_queue.h     |    4 +-
 init/Kconfig                                       |    1 -
 kernel/bpf/core.c                                  |    8 +-
 kernel/bpf/devmap.c                                |    6 +-
 kernel/bpf/verifier.c                              |   60 +-
 kernel/cgroup/cgroup-v1.c                          |   12 +-
 kernel/debug/gdbstub.c                             |    2 +-
 kernel/rcu/refscale.c                              |    6 +-
 kernel/rcu/tasks.h                                 |    6 +-
 kernel/rcu/tree_stall.h                            |    4 +-
 kernel/scftorture.c                                |    6 +-
 kernel/trace/trace_events_hist.c                   |    6 +-
 lib/test_hmm.c                                     |    2 -
 mm/hugetlb.c                                       |    5 +-
 mm/kasan/kasan.h                                   |   12 +
 mm/migrate.c                                       |   48 -
 mm/page_alloc.c                                    |   28 +-
 mm/rmap.c                                          |   39 +-
 mm/slab.h                                          |   15 +-
 mm/slub.c                                          |   93 +-
 mm/util.c                                          |   10 +
 net/802/garp.c                                     |   14 +
 net/802/mrp.c                                      |   14 +
 net/bridge/br_if.c                                 |   17 +-
 net/bridge/br_multicast.c                          |    6 +
 net/core/dev.c                                     |   16 +
 net/core/skbuff.c                                  |    1 +
 net/core/sock.c                                    |   71 +-
 net/dsa/switch.c                                   |    8 +-
 net/ethtool/Makefile                               |    2 +-
 net/ethtool/common.c                               |   14 +
 net/ethtool/netlink.c                              |   10 +
 net/ethtool/netlink.h                              |    2 +
 net/ethtool/phc_vclocks.c                          |   94 +
 net/ipv4/fib_frontend.c                            |    2 +-
 net/ipv4/inet_diag.c                               |    5 +-
 net/ipv4/ip_tunnel.c                               |   18 +-
 net/ipv4/ipmr.c                                    |    2 +-
 net/ipv4/raw_diag.c                                |    7 +-
 net/ipv4/tcp.c                                     |    3 +
 net/ipv4/tcp_input.c                               |   21 +-
 net/ipv4/tcp_ipv4.c                                |    4 +-
 net/ipv4/tcp_output.c                              |    1 +
 net/ipv4/udp.c                                     |    6 +-
 net/ipv4/udp_diag.c                                |    6 +-
 net/ipv4/udp_offload.c                             |    6 +-
 net/ipv6/ip6_output.c                              |   32 +-
 net/ipv6/tcp_ipv6.c                                |   21 +-
 net/ipv6/udp.c                                     |    2 +-
 net/ipv6/xfrm6_output.c                            |    2 +-
 net/iucv/iucv.c                                    |   22 +-
 net/mptcp/mib.c                                    |    1 +
 net/mptcp/mib.h                                    |    1 +
 net/mptcp/mptcp_diag.c                             |    6 +-
 net/mptcp/options.c                                |   19 +-
 net/mptcp/protocol.c                               |   12 +-
 net/mptcp/protocol.h                               |   10 +-
 net/mptcp/sockopt.c                                |   68 +-
 net/mptcp/subflow.c                                |   11 +-
 net/mptcp/syncookies.c                             |   16 +-
 net/ncsi/Kconfig                                   |    6 +
 net/ncsi/internal.h                                |    5 +
 net/ncsi/ncsi-manage.c                             |   51 +-
 net/ncsi/ncsi-rsp.c                                |   11 +-
 net/netfilter/nf_conntrack_core.c                  |   11 +-
 net/netfilter/nf_conntrack_netlink.c               |    3 +
 net/netfilter/nf_conntrack_proto.c                 |    7 -
 net/netfilter/nf_conntrack_proto_gre.c             |   13 -
 net/netfilter/nf_conntrack_proto_tcp.c             |   69 +-
 net/netfilter/nf_conntrack_standalone.c            |   10 +
 net/netfilter/nf_tables_api.c                      |    3 +-
 net/netfilter/nft_last.c                           |   12 +-
 net/netlink/af_netlink.c                           |    2 +-
 net/openvswitch/flow_table.c                       |    6 +-
 net/sched/act_ct.c                                 |   14 +-
 net/sched/sch_taprio.c                             |    2 +-
 net/sctp/diag.c                                    |    6 +-
 net/sctp/protocol.c                                |    3 +-
 net/sctp/sm_make_chunk.c                           |    2 +-
 net/sctp/transport.c                               |   11 +-
 net/socket.c                                       |   19 +-
 net/unix/diag.c                                    |    6 +-
 samples/bpf/Makefile                               |    1 +
 samples/bpf/xdpsock_user.c                         |   28 +
 scripts/Makefile.build                             |    2 +-
 scripts/setlocalversion                            |   13 +-
 scripts/spdxcheck.py                               |    2 +-
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |    1 +
 tools/arch/arm64/include/uapi/asm/unistd.h         |    1 +
 tools/bpf/Makefile                                 |    7 +-
 tools/bpf/bpftool/jit_disasm.c                     |    6 +-
 tools/bpf/runqslower/runqslower.bpf.c              |    2 +-
 tools/include/linux/kconfig.h                      |    6 -
 tools/include/uapi/asm-generic/unistd.h            |    7 +-
 tools/lib/bpf/libbpf.c                             |    4 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    1 +
 tools/perf/builtin-inject.c                        |   13 +-
 tools/perf/builtin-report.c                        |   33 +-
 tools/perf/builtin-sched.c                         |   35 +-
 tools/perf/builtin-script.c                        |    8 +
 tools/perf/builtin-stat.c                          |    3 -
 tools/perf/builtin-trace.c                         |   45 +-
 tools/perf/tests/bpf.c                             |    2 +
 tools/perf/tests/event_update.c                    |    6 +-
 tools/perf/tests/evsel-roundtrip-name.c            |    3 +-
 tools/perf/tests/maps.c                            |    2 +
 tools/perf/tests/parse-events.c                    |   16 +-
 tools/perf/tests/perf-time-to-tsc.c                |    3 +-
 tools/perf/tests/topology.c                        |    1 +
 tools/perf/util/cs-etm.c                           |  168 +-
 tools/perf/util/data.c                             |    2 +-
 tools/perf/util/dso.c                              |    4 +-
 tools/perf/util/dwarf-aux.c                        |    8 +-
 tools/perf/util/dwarf-aux.h                        |    2 +-
 tools/perf/util/env.c                              |    2 +
 tools/perf/util/lzma.c                             |    8 +-
 tools/perf/util/map.c                              |    2 +
 tools/perf/util/pfm.c                              |    2 +-
 tools/perf/util/pmu.c                              |    9 +-
 tools/perf/util/probe-event.c                      |   53 +-
 tools/perf/util/probe-event.h                      |    4 +-
 tools/perf/util/probe-file.c                       |    4 +-
 tools/perf/util/probe-finder.c                     |   15 +-
 tools/perf/util/probe-finder.h                     |    2 +-
 tools/perf/util/session.c                          |    1 +
 tools/perf/util/sort.c                             |    2 +-
 tools/perf/util/sort.h                             |    2 +-
 tools/perf/util/stat-display.c                     |   14 +-
 tools/testing/kunit/kunit.py                       |    2 +
 tools/testing/kunit/kunit_kernel.py                |    6 +-
 tools/testing/kunit/kunit_parser.py                |    6 +-
 tools/testing/kunit/kunit_tool_test.py             |   16 +-
 ...test_is_test_passed-no_tests_run_no_header.log} |    0
 ...est_is_test_passed-no_tests_run_with_header.log |    2 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |   36 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf4.c        |   18 +
 tools/testing/selftests/kvm/include/kvm_util.h     |    3 +-
 .../testing/selftests/kvm/lib/aarch64/processor.c  |    2 +-
 tools/testing/selftests/kvm/lib/guest_modes.c      |   16 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |    5 +
 .../testing/selftests/kvm/set_memory_region_test.c |    3 +-
 .../testing/selftests/kvm/x86_64/hyperv_features.c |    2 +-
 tools/testing/selftests/kvm/x86_64/mmu_role_test.c |    2 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c      |   70 +-
 .../selftests/memory-hotplug/mem-on-off-test.sh    |    4 +-
 tools/testing/selftests/net/icmp_redirect.sh       |    5 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |    2 +-
 tools/testing/selftests/net/timestamping.c         |   55 +-
 tools/testing/selftests/netfilter/Makefile         |    2 +-
 .../selftests/netfilter/conntrack_tcp_unreplied.sh |  167 +
 virt/kvm/coalesced_mmio.c                          |    2 +-
 virt/kvm/kvm_main.c                                |    2 +-
 608 files changed, 27520 insertions(+), 6366 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos3250-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos4-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5250-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5420-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-audss-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-ext-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/net/smsc,lan9115.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/smsc911x.txt
 create mode 100644 Documentation/features/core/thread-info-in-task/arch-support.txt
 create mode 100644 arch/x86/kvm/mmu/paging.h
 create mode 100644 drivers/clk/clk-fractional-divider.h
 create mode 100644 drivers/clk/mediatek/clk-mt8192-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mdp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-scp_adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192.c
 create mode 100644 drivers/clk/qcom/dispcc-sc7280.c
 create mode 100644 drivers/clk/qcom/gcc-msm8953.c
 create mode 100644 drivers/clk/qcom/gcc-sm6115.c
 create mode 100644 drivers/clk/qcom/gcc-sm6350.c
 create mode 100644 drivers/clk/qcom/gpucc-sc7280.c
 create mode 100644 drivers/clk/qcom/mmcc-msm8994.c
 create mode 100644 drivers/clk/qcom/videocc-sc7280.c
 rename drivers/clk/renesas/{renesas-rzg2l-cpg.c => rzg2l-cpg.c} (89%)
 rename drivers/clk/renesas/{renesas-rzg2l-cpg.h => rzg2l-cpg.h} (88%)
 rename drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c} (76%)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_1_offset.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_1_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
 delete mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
 delete mode 100644 drivers/net/caif/caif_hsi.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c
 create mode 100644 drivers/ptp/ptp_vclock.c
 create mode 100644 include/dt-bindings/clock/mt8192-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8953.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm6115.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm6350.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8994.h
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sc7280.h
 delete mode 100644 include/net/caif/caif_hsi.h
 create mode 100644 net/ethtool/phc_vclocks.c
 rename tools/testing/kunit/test_data/{test_is_test_passed-no_tests_run.log => test_is_test_passed-no_tests_run_no_header.log} (100%)
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
 create mode 100755 tools/testing/selftests/netfilter/conntrack_tcp_unreplied.sh

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
