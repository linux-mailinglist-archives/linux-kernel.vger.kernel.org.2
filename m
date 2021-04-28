Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F636E252
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 02:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhD1X6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhD1X6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:58:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2316608FC;
        Wed, 28 Apr 2021 23:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619654241;
        bh=/ueQqo5YaSqjV/QP5cIf9RZfTa/LlUJScV2gSzNYyCY=;
        h=From:To:Cc:Subject:Date:From;
        b=MuSCA5G75SbaymuUCsuobM3lCOSS2AvupKaBEh2Yp6Zc2P6c7ExOq6HanKR0cFxmP
         CjE0usQNa2dF3TJegs/xNtmxwSBw44FQzg/8lyFPIDgOgKSBS+cMHQ5kFr7RvwqCMl
         FsXkw+OzRYPdEIU+nY3CKDeVQTMfYnvXcJRvgDWlhzoQ4PAoL4qK6g3zB0/nwZkb+W
         BBsuHxi/dqz0W9B2n3pPsNWuAdYSJ0T5FWA3UXEU7yKtd4nwInPUxqW0jraLthHtBQ
         ZuyK4KSWubn2zYeToYzLAzXb87xvJAUAy8Oc5n+5nImAJcdV3Fv6sQvug7vGv9f+WK
         QXKoUb5KR9QGA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed, 28 Apr 2021 16:57:20 -0700
Message-Id: <20210428235720.624250-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e5c359f70e4b5e7b6c2bf4b0ca2d2686d543a37b:

  clk: qcom: camcc: Update the clock ops for the SC7180 (2021-03-29 14:08:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 3ba2d41dca14e1afbea0c41ba8164064df407c8b:

  Merge branch 'clk-ralink' into clk-next (2021-04-27 16:34:56 -0700)

----------------------------------------------------------------
Here's a collection of largely clk driver updates for the merge window. The
usual suspects are here: i.MX, Qualcomm, Renesas, Allwinner, Samsung, and
Rockchip, but it feels pretty light on commits. There's only one real commit to
the framework core and that's to consolidate code. Otherwise the diffstat is
dominated by many Qualcomm clk driver patches that modernize the driver for the
proper way of speciying clk parents. That's shifting data around, which could
subtly break things so I'll be on the lookout for fixes.

New Drivers:
 - Proper clk driver for Mediatek MT7621 SoCs
 - Support for the clock controller on the new Rockchip rk3568

Updates:
 - Simplify Zynq Kconfig dependencies
 - Use clk_hw pointers in socfpga driver
 - Cleanup parent data in qcom clk drivers
 - Some cleanups for rk3399 modularization
 - Fix reparenting of i.MX UART clocks by initializing only the ones
   associated to stdout
 - Correct the PCIE clocks for i.MX8MP and i.MX8MQ
 - Make i.MX LPCG and SCU clocks return on registering failure
 - Kernel doc fixes
 - Add DAB hardware accelerator clocks on Renesas R-Car E3 and M3-N
 - Add timer (TMU) clocks on Renesas R-Car H3 ES1.0
 - Add Timer (TMU & CMT) and thermal sensor (TSC) clocks on Renesas R-Car V3U
 - Sigma-delta modulation on Allwinner V3s audio PLL

----------------------------------------------------------------
Adam Ford (1):
      clk: imx: Fix reparenting of UARTs not associated with stdout

Alex Elder (1):
      clk: qcom: rpmh: add support for SDX55 rpmh IPA clock

Bhaskar Chowdhury (2):
      clk: at91: Trivial typo fixes in the file sama7g5.c
      clk: renesas: Couple of spelling fixes

Chen Hui (4):
      clk: samsung: Remove redundant dev_err calls
      clk: qcom: a7-pll: Add missing MODULE_DEVICE_TABLE
      clk: qcom: a53-pll: Add missing MODULE_DEVICE_TABLE
      clk: qcom: apss-ipq-pll: Add missing MODULE_DEVICE_TABLE

Colin Ian King (3):
      clk: socfpga: arria10: Fix memory leak of socfpga_clk on error return
      clk: socfpga: remove redundant initialization of variable div
      clk: uniphier: Fix potential infinite loop

Dinh Nguyen (3):
      clk: socfpga: use clk_hw_register for a5/c5
      clk: socfpga: arria10: convert to use clk_hw
      clk: socfpga: Convert to s10/agilex/n5x to use clk_hw

Dmitry Baryshkov (36):
      clk: qcom: dispcc-sc7180: drop unused enum entries
      clk: qcom: dispcc-sm8250: drop unused enum entries
      clk: qcom: gcc-sm8250: drop unused enum entries
      clk: qcom: gpucc-sc7180: drop unused enum entries
      clk: qcom: gpucc-sdm845: drop unused enum entries
      clk: qcom: gpucc-sm8150: drop unused enum entries
      clk: qcom: gpucc-sm8250: drop unused enum entries
      clk: qcom: videocc-sc7180: drop unused enum entries
      clk: qcom: videocc-sm8150: drop unused enum entries
      clk: qcom: videocc-sm8250: drop unused enum entries
      clk: qcom: dispcc-sdm845: convert to parent data
      clk: qcom: gpucc-sdm845: convert to parent data
      clk: qcom: videocc-sdm845: convert to parent data
      clk: qcom: gpucc-sdm845: get rid of the test clock
      clk: qcom: dispcc-sdm845: get rid of the test clock
      clk: qcom: videocc-sdm845: get rid of the test clock
      clk: qcom: dispcc-sc7180: use parent_hws where possible
      clk: qcom: dispcc-sm8250: use parent_hws where possible
      clk: qcom: gcc-sc7180: use parent_hws where possible
      clk: qcom: gcc-sc7280: use parent_hws where possible
      clk: qcom: gcc-sdx55: use parent_hws where possible
      clk: qcom: gcc-sm8150: use parent_hws where possible
      clk: qcom: gcc-sm8250: use parent_hws where possible
      clk: qcom: gcc-sm8350: use parent_hws where possible
      clk: qcom: gpucc-sm8150: use parent_hws where possible
      clk: qcom: gpucc-sm8250: use parent_hws where possible
      clk: qcom: videocc-sm8150: use parent_hws where possible
      clk: qcom: videocc-sm8250: use parent_hws where possible
      clk: qcom: gcc-sc7180: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-sc8180x: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-sm8150: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-sm8250: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-sm8350: use ARRAY_SIZE instead of specifying num_parents
      dt-bindings: clock: separate SDM845 GCC clock bindings
      clk: qcom: convert SDM845 Global Clock Controller to parent_data
      clk: qcom: gcc-sdm845: get rid of the test clock

Elaine Zhang (4):
      clk: rockchip: add dt-binding header for rk3568
      dt-binding: clock: Document rockchip, rk3568-cru bindings
      clk: rockchip: support more core div setting
      clk: rockchip: add clock controller for rk3568

Fabrizio Castro (2):
      clk: renesas: r8a77990: Add DAB clock
      clk: renesas: r8a77965: Add DAB clock

Geert Uytterhoeven (2):
      clk: Drop double "if" in clk_core_determine_round_nolock() comment
      clk: renesas: Zero init clk_init_data

Heiko Stuebner (2):
      clk: rockchip: drop parenthesis from ARM || COMPILE_TEST depends
      clk: rockchip: drop MODULE_ALIAS from rk3399 clock controller

Jian Dong (1):
      clk: imx: Reference preceded by free

Lee Jones (1):
      clk: sunxi: Demote non-conformant kernel-doc headers

Niklas Söderlund (2):
      clk: renesas: r8a779a0: Add TSC clock
      clk: renesas: r8a7795: Add TMU clocks

Paweł Chmiel (1):
      clk: exynos7: Mark aclk_fsys1_200 as critical

Punit Agrawal (2):
      clk: zynqmp: Enable the driver if ZYNQMP_FIRMWARE is selected
      clk: zynqmp: Drop dependency on ARCH_ZYNQMP

Quanyang Wang (2):
      clk: zynqmp: move zynqmp_pll_set_mode out of round_rate callback
      clk: zynqmp: pll: add set_pll_mode to check condition in zynqmp_pll_enable

Rasmus Villemoes (1):
      clk: use clk_core_enable_lock() a bit more

Richard Zhu (2):
      clk: imx8mp: Remove the none exist pcie clocks
      clk: imx8mq: Correct the pcie1 sels

Sergio Paracuellos (6):
      dt-bindings: clock: add dt binding header for mt7621 clocks
      dt: bindings: add mt7621-sysc device tree binding documentation
      clk: ralink: add clock driver for mt7621 SoC
      staging: mt7621-dts: make use of new 'mt7621-clk'
      staging: mt7621-dts: use valid vendor 'mediatek' instead of invalid 'mtk'
      MAINTAINERS: add MT7621 CLOCK maintainer

Stephen Boyd (10):
      Merge tag 'renesas-clk-for-v5.13-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      clk: socfpga: Fix code formatting
      Merge tag 'renesas-clk-for-v5.13-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-5.13-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-imx-5.13' of https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'clk-v5.13-samsung' of https://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk into clk-samsung
      Merge tag 'v5.13-rockchip-clocks' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge branches 'clk-cleanup', 'clk-renesas', 'clk-socfpga', 'clk-allwinner' and 'clk-qcom' into clk-next
      Merge branches 'clk-imx', 'clk-samsung', 'clk-zynq', 'clk-rockchip' and 'clk-uniphier' into clk-next
      Merge branch 'clk-ralink' into clk-next

Tobias Schramm (1):
      clk: sunxi-ng: v3s: use sigma-delta modulation for audio-pll

Wolfram Sang (2):
      clk: renesas: r8a779a0: Add TMU clocks
      clk: renesas: r8a779a0: Add CMT clocks

 .../bindings/clock/mediatek,mt7621-sysc.yaml       |   68 +
 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |   82 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    2 -
 .../bindings/clock/rockchip,rk3568-cru.yaml        |   60 +
 MAINTAINERS                                        |    6 +
 arch/mips/ralink/mt7621.c                          |    6 +-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/at91/sama7g5.c                         |    6 +-
 drivers/clk/clk.c                                  |   20 +-
 drivers/clk/imx/clk-imx25.c                        |   12 +-
 drivers/clk/imx/clk-imx27.c                        |   13 +-
 drivers/clk/imx/clk-imx35.c                        |   10 +-
 drivers/clk/imx/clk-imx5.c                         |   30 +-
 drivers/clk/imx/clk-imx6q.c                        |   16 +-
 drivers/clk/imx/clk-imx6sl.c                       |   16 +-
 drivers/clk/imx/clk-imx6sll.c                      |   24 +-
 drivers/clk/imx/clk-imx6sx.c                       |   16 +-
 drivers/clk/imx/clk-imx7d.c                        |   22 +-
 drivers/clk/imx/clk-imx7ulp.c                      |   31 +-
 drivers/clk/imx/clk-imx8mm.c                       |   18 +-
 drivers/clk/imx/clk-imx8mn.c                       |   18 +-
 drivers/clk/imx/clk-imx8mp.c                       |   32 +-
 drivers/clk/imx/clk-imx8mq.c                       |   22 +-
 drivers/clk/imx/clk-lpcg-scu.c                     |    1 +
 drivers/clk/imx/clk-scu.c                          |    1 +
 drivers/clk/imx/clk.c                              |   41 +-
 drivers/clk/imx/clk.h                              |    4 +-
 drivers/clk/qcom/a53-pll.c                         |    1 +
 drivers/clk/qcom/a7-pll.c                          |    1 +
 drivers/clk/qcom/apss-ipq-pll.c                    |    1 +
 drivers/clk/qcom/clk-rpmh.c                        |    2 +
 drivers/clk/qcom/dispcc-sc7180.c                   |   70 +-
 drivers/clk/qcom/dispcc-sdm845.c                   |  217 ++-
 drivers/clk/qcom/dispcc-sm8250.c                   |  124 +-
 drivers/clk/qcom/gcc-sc7180.c                      |  196 +--
 drivers/clk/qcom/gcc-sc7280.c                      |  248 +--
 drivers/clk/qcom/gcc-sc8180x.c                     |  122 +-
 drivers/clk/qcom/gcc-sdm845.c                      |  650 ++++----
 drivers/clk/qcom/gcc-sdx55.c                       |    8 +-
 drivers/clk/qcom/gcc-sm8150.c                      |  100 +-
 drivers/clk/qcom/gcc-sm8250.c                      |  345 ++--
 drivers/clk/qcom/gcc-sm8350.c                      |  418 +++--
 drivers/clk/qcom/gpucc-sc7180.c                    |    3 -
 drivers/clk/qcom/gpucc-sdm845.c                    |   45 +-
 drivers/clk/qcom/gpucc-sm8150.c                    |    9 +-
 drivers/clk/qcom/gpucc-sm8250.c                    |    9 +-
 drivers/clk/qcom/videocc-sc7180.c                  |    4 -
 drivers/clk/qcom/videocc-sdm845.c                  |   55 +-
 drivers/clk/qcom/videocc-sm8150.c                  |   20 +-
 drivers/clk/qcom/videocc-sm8250.c                  |   30 +-
 drivers/clk/ralink/Kconfig                         |   11 +
 drivers/clk/ralink/Makefile                        |    2 +
 drivers/clk/ralink/clk-mt7621.c                    |  495 ++++++
 drivers/clk/renesas/clk-div6.c                     |    3 +-
 drivers/clk/renesas/clk-mstp.c                     |    2 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    6 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |   11 +
 drivers/clk/renesas/r9a06g032-clocks.c             |   12 +-
 drivers/clk/renesas/rcar-cpg-lib.c                 |    2 +-
 drivers/clk/renesas/rcar-gen2-cpg.c                |    3 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |    2 +-
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |    5 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    2 +-
 drivers/clk/rockchip/Kconfig                       |   29 +-
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-cpu.c                     |   53 +-
 drivers/clk/rockchip/clk-px30.c                    |    7 +-
 drivers/clk/rockchip/clk-rk3036.c                  |    7 +-
 drivers/clk/rockchip/clk-rk3128.c                  |    7 +-
 drivers/clk/rockchip/clk-rk3188.c                  |   14 +-
 drivers/clk/rockchip/clk-rk3228.c                  |    7 +-
 drivers/clk/rockchip/clk-rk3288.c                  |    7 +-
 drivers/clk/rockchip/clk-rk3308.c                  |    7 +-
 drivers/clk/rockchip/clk-rk3328.c                  |    7 +-
 drivers/clk/rockchip/clk-rk3368.c                  |   14 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   15 +-
 drivers/clk/rockchip/clk-rk3568.c                  | 1725 ++++++++++++++++++++
 drivers/clk/rockchip/clk-rv1108.c                  |    7 +-
 drivers/clk/rockchip/clk.h                         |   54 +-
 drivers/clk/samsung/clk-exynos4412-isp.c           |    4 +-
 drivers/clk/samsung/clk-exynos7.c                  |    7 +-
 drivers/clk/samsung/clk-s5pv210-audss.c            |    4 +-
 drivers/clk/socfpga/clk-agilex.c                   |  117 +-
 drivers/clk/socfpga/clk-gate-a10.c                 |    9 +-
 drivers/clk/socfpga/clk-gate-s10.c                 |   17 +-
 drivers/clk/socfpga/clk-gate.c                     |   11 +-
 drivers/clk/socfpga/clk-periph-a10.c               |   11 +-
 drivers/clk/socfpga/clk-periph-s10.c               |   42 +-
 drivers/clk/socfpga/clk-periph.c                   |    8 +-
 drivers/clk/socfpga/clk-pll-a10.c                  |   12 +-
 drivers/clk/socfpga/clk-pll-s10.c                  |   45 +-
 drivers/clk/socfpga/clk-pll.c                      |   18 +-
 drivers/clk/socfpga/clk-s10.c                      |   68 +-
 drivers/clk/socfpga/stratix10-clk.h                |   24 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |   33 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c                |    2 +-
 drivers/clk/sunxi/clk-sun9i-core.c                 |    8 +-
 drivers/clk/sunxi/clk-usb.c                        |    2 +-
 drivers/clk/uniphier/clk-uniphier-mux.c            |    4 +-
 drivers/clk/zynqmp/Kconfig                         |    4 +-
 drivers/clk/zynqmp/pll.c                           |   24 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |   11 -
 drivers/staging/mt7621-dts/mt7621.dtsi             |   82 +-
 include/dt-bindings/clock/imx8mp-clock.h           |    3 -
 include/dt-bindings/clock/mt7621-clk.h             |   41 +
 include/dt-bindings/clock/rk3568-cru.h             |  926 +++++++++++
 109 files changed, 5279 insertions(+), 2034 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
 create mode 100644 drivers/clk/ralink/Kconfig
 create mode 100644 drivers/clk/ralink/Makefile
 create mode 100644 drivers/clk/ralink/clk-mt7621.c
 create mode 100644 drivers/clk/rockchip/clk-rk3568.c
 create mode 100644 include/dt-bindings/clock/mt7621-clk.h
 create mode 100644 include/dt-bindings/clock/rk3568-cru.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
