Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AE83FA59B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhH1MLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 08:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234182AbhH1ML3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:11:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1502A60725;
        Sat, 28 Aug 2021 12:10:38 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mJxAS-007jTj-03; Sat, 28 Aug 2021 13:10:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chen Zhu <zhuchen@loongson.cn>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hector Martin <marcan@marcan.st>,
        Heiko Stuebner <heiko@sntech.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        James Morse <james.morse@arm.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.15
Date:   Sat, 28 Aug 2021 13:10:13 +0100
Message-Id: <20210828121013.2647964-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, alexandru.elisei@arm.com, andriy.shevchenko@linux.intel.com, wenst@chromium.org, zhuchen@loongson.cn, geert+renesas@glider.be, marcan@marcan.st, heiko@sntech.de, chenhuacai@loongson.cn, james.morse@arm.com, jay.xu@rock-chips.com, krzysztof.kozlowski@canonical.com, lee.jones@linaro.org, linus.walleij@linaro.org, msp@baylibre.com, mkshah@codeaurora.org, sven@svenpeter.dev, tsbogend@alpha.franken.de, valentin.schneider@arm.com, vgupta@synopsys.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the set of updates from the irqchip department for 5.15.

A large part is the tail end of the the generic_handle_domain_irq()
updates, covering all arches and subsystems (which has been simmering
in -next for several weeks). Note that this is dragging a pinctrl
branch set up by LinusW in order to avoid merge conflicts.

The rest is the usual bunch of random fixes affecting a bunch of
drivers (GICv3, Apple AIC, Qualcomm PDC, Loongson, Mediatek sysirq).

And for once, no new drivers. May it last forever!

Please pull,

	M.

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.15

for you to fetch changes up to 6e3b473ee06445d4eae2f8b1e143db70ed66f519:

  Merge branch irq/qcom-pdc-nowake-cleanup into irq/irqchip-next (2021-08-23 09:50:46 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.15

API updates:

- Treewide conversion to generic_handle_domain_irq() for anything
  that looks like a chained interrupt controller

- Update the irqdomain documentation

- Use of bitmap_zalloc() throughout the tree

New functionalities:

- Support for GICv3 EPPI partitions

Fixes:

- Qualcomm PDC hierarchy fixes

- Yet another priority decoding fix for the GICv3 pseudo-NMIs

- Fix the apple-aic driver irq_eoi() callback to always unmask
  the interrupt

- Properly handle edge interrupts on loongson-pch-pic

- Let the mtk-sysirq driver advertise IRQCHIP_SKIP_SET_WAKE

----------------------------------------------------------------
Andy Shevchenko (7):
      irqchip/partitions: Switch to bitmap_zalloc()
      irqchip/alpine-msi: Switch to bitmap_zalloc()
      irqchip/gic-v2m: Switch to bitmap_zalloc()
      irqchip/gic-v3: Switch to bitmap_zalloc()
      irqchip/ls-scfg-msi: Switch to devm_bitmap_zalloc()
      irqchip/mvebu-gicp: Switch to devm_bitmap_zalloc()
      irqchip/mvebu-odmi: Switch to bitmap_zalloc()

Chen-Yu Tsai (1):
      irqchip/gic-v3: Fix priority comparison when non-secure priorities are used

Huacai Chen (1):
      irqchip/loongson-pch-pic: Improve edge triggered interrupt support

James Morse (2):
      irqchip/gic-v3: Add __gic_get_ppi_index() to find the PPI number from hwirq
      irqchip/gic-v3: Fix selection of partition domain for EPPIs

Jianqun Xu (9):
      pinctrl/rockchip: always enable clock for gpio controller
      pinctrl/rockchip: separate struct rockchip_pin_bank to a head file
      pinctrl/rockchip: add pinctrl device to gpio bank struct
      dt-bindings: gpio: change items restriction of clock for rockchip,gpio-bank
      gpio/rockchip: add driver for rockchip gpio
      gpio/rockchip: use struct rockchip_gpio_regs for gpio controller
      gpio/rockchip: support next version gpio controller
      gpio/rockchip: drop irq_gc_lock/irq_gc_unlock for irq set type
      pinctrl/rockchip: drop the gpio related codes

Marc Zyngier (22):
      Merge branch irq/bitmap_zalloc into irq/irqchip-next
      Merge branch irq/gicv3-eppi-partition into irq/irqchip-next
      Documentation: Update irq_domain.rst with new lookup APIs
      gpio: Bulk conversion to generic_handle_domain_irq()
      pinctrl: Bulk conversion to generic_handle_domain_irq()
      mfd: Bulk conversion to generic_handle_domain_irq()
      ARM: Bulk conversion to generic_handle_domain_irq()
      arc: Bulk conversion to generic_handle_domain_irq()
      mips: Bulk conversion to generic_handle_domain_irq()
      gpu: Bulk conversion to generic_handle_domain_irq()
      SH: Bulk conversion to generic_handle_domain_irq()
      xtensa: Bulk conversion to generic_handle_domain_irq()
      nios2: Bulk conversion to generic_handle_domain_irq()
      powerpc: Bulk conversion to generic_handle_domain_irq()
      EDAC/altera: Convert to generic_handle_domain_irq()
      Merge branch irq/generic_handle_domain_irq into irq/irqchip-next
      Merge branch irq/misc-5.15 into irq/irqchip-next
      Merge remote-tracking branch 'linusw/ib-rockchip' into irq/generic_handle_domain_irq
      Merge branch irq/generic_handle_domain_irq into irq/irqchip-next
      Merge branch irq/misc-5.15 into irq/irqchip-next
      irqchip/qcom-pdc: Trim unused levels of the interrupt hierarchy
      Merge branch irq/qcom-pdc-nowake-cleanup into irq/irqchip-next

Markus Schneider-Pargmann (1):
      irqchip/mtk-sysirq: Skip setting irq-wake

Maulik Shah (1):
      irqdomain: Export irq_domain_disconnect_hierarchy()

Sven Peter (1):
      irqchip/apple-aic: Fix irq_disable from within irq handlers

 Documentation/core-api/irq/irq-domain.rst          |  28 +-
 .../bindings/gpio/rockchip,gpio-bank.yaml          |   5 +-
 arch/arc/kernel/mcip.c                             |   2 +-
 arch/arm/common/sa1111.c                           |  12 +-
 arch/arm/mach-pxa/pxa_cplds_irqs.c                 |   6 +-
 arch/arm/mach-s3c/irq-s3c24xx.c                    |   5 +-
 arch/mips/ath25/ar2315.c                           |  14 +-
 arch/mips/ath25/ar5312.c                           |  13 +-
 arch/mips/lantiq/irq.c                             |   2 +-
 arch/mips/pci/pci-ar2315.c                         |   8 +-
 arch/mips/pci/pci-rt3883.c                         |   5 +-
 arch/mips/ralink/irq.c                             |   2 +-
 arch/mips/sgi-ip27/ip27-irq.c                      |  16 +-
 arch/mips/sgi-ip30/ip30-irq.c                      |   8 +-
 arch/nios2/kernel/irq.c                            |   4 +-
 arch/powerpc/platforms/4xx/uic.c                   |   4 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c     |  23 +-
 arch/powerpc/platforms/52xx/media5200.c            |   9 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |   7 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |   6 +-
 arch/powerpc/platforms/cell/interrupt.c            |   8 +-
 arch/powerpc/platforms/cell/spider-pic.c           |  11 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |  15 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      |  11 +-
 arch/powerpc/sysdev/fsl_mpic_err.c                 |  11 +-
 arch/powerpc/sysdev/fsl_msi.c                      |  12 +-
 arch/sh/boards/mach-se/7343/irq.c                  |   2 +-
 arch/sh/boards/mach-se/7722/irq.c                  |   2 +-
 arch/sh/boards/mach-x3proto/gpio.c                 |   2 +-
 arch/xtensa/kernel/irq.c                           |   4 +-
 drivers/edac/altera_edac.c                         |   7 +-
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-104-dio-48e.c                    |   4 +-
 drivers/gpio/gpio-104-idi-48.c                     |   4 +-
 drivers/gpio/gpio-104-idio-16.c                    |   2 +-
 drivers/gpio/gpio-altera.c                         |  11 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   |   9 +-
 drivers/gpio/gpio-aspeed.c                         |   9 +-
 drivers/gpio/gpio-ath79.c                          |   7 +-
 drivers/gpio/gpio-bcm-kona.c                       |   6 +-
 drivers/gpio/gpio-brcmstb.c                        |   5 +-
 drivers/gpio/gpio-cadence.c                        |   2 +-
 drivers/gpio/gpio-davinci.c                        |   3 +-
 drivers/gpio/gpio-dln2.c                           |  22 +-
 drivers/gpio/gpio-em.c                             |   2 +-
 drivers/gpio/gpio-ep93xx.c                         |   8 +-
 drivers/gpio/gpio-ftgpio010.c                      |   3 +-
 drivers/gpio/gpio-hisi.c                           |   4 +-
 drivers/gpio/gpio-hlwd.c                           |   7 +-
 drivers/gpio/gpio-merrifield.c                     |   8 +-
 drivers/gpio/gpio-mpc8xxx.c                        |   2 +-
 drivers/gpio/gpio-mt7621.c                         |   4 +-
 drivers/gpio/gpio-mxc.c                            |   2 +-
 drivers/gpio/gpio-mxs.c                            |   2 +-
 drivers/gpio/gpio-omap.c                           |   3 +-
 drivers/gpio/gpio-pci-idio-16.c                    |   2 +-
 drivers/gpio/gpio-pcie-idio-24.c                   |   3 +-
 drivers/gpio/gpio-pl061.c                          |   4 +-
 drivers/gpio/gpio-pxa.c                            |   9 +-
 drivers/gpio/gpio-rcar.c                           |   4 +-
 drivers/gpio/gpio-rda.c                            |   8 +-
 drivers/gpio/gpio-realtek-otto.c                   |   7 +-
 drivers/gpio/gpio-rockchip.c                       | 771 +++++++++++++++++
 drivers/gpio/gpio-sch.c                            |   2 +-
 drivers/gpio/gpio-sodaville.c                      |   2 +-
 drivers/gpio/gpio-sprd.c                           |  12 +-
 drivers/gpio/gpio-tb10x.c                          |   2 +-
 drivers/gpio/gpio-tegra.c                          |   9 +-
 drivers/gpio/gpio-tegra186.c                       |   9 +-
 drivers/gpio/gpio-tqmx86.c                         |  10 +-
 drivers/gpio/gpio-vf610.c                          |   2 +-
 drivers/gpio/gpio-ws16c48.c                        |   4 +-
 drivers/gpio/gpio-xgs-iproc.c                      |   2 +-
 drivers/gpio/gpio-xilinx.c                         |   2 +-
 drivers/gpio/gpio-xlp.c                            |   3 +-
 drivers/gpio/gpio-zynq.c                           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |  15 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c          |   3 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |  11 +-
 drivers/irqchip/irq-alpine-msi.c                   |   6 +-
 drivers/irqchip/irq-apple-aic.c                    |   2 +-
 drivers/irqchip/irq-gic-v2m.c                      |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   6 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |   5 +-
 drivers/irqchip/irq-gic-v3.c                       |  84 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  19 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |   5 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |   1 +
 drivers/irqchip/irq-mvebu-gicp.c                   |   4 +-
 drivers/irqchip/irq-mvebu-odmi.c                   |   5 +-
 drivers/irqchip/irq-partition-percpu.c             |   3 +-
 drivers/irqchip/qcom-pdc.c                         |  68 +-
 drivers/mfd/db8500-prcmu.c                         |   2 +-
 drivers/mfd/fsl-imx25-tsadc.c                      |   4 +-
 drivers/mfd/ioc3.c                                 |  10 +-
 drivers/mfd/qcom-pm8xxx.c                          |  10 +-
 drivers/pinctrl/actions/pinctrl-owl.c              |   5 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   4 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |   3 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             |   3 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   7 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |   8 +-
 drivers/pinctrl/mediatek/mtk-eint.c                |   5 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |   2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   2 +-
 drivers/pinctrl/pinctrl-amd.c                      |   6 +-
 drivers/pinctrl/pinctrl-at91.c                     |   6 +-
 drivers/pinctrl/pinctrl-equilibrium.c              |   2 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   2 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |   2 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |   3 +-
 drivers/pinctrl/pinctrl-oxnas.c                    |   2 +-
 drivers/pinctrl/pinctrl-pic32.c                    |   2 +-
 drivers/pinctrl/pinctrl-pistachio.c                |   2 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 909 +--------------------
 drivers/pinctrl/pinctrl-rockchip.h                 | 287 +++++++
 drivers/pinctrl/pinctrl-single.c                   |   4 +-
 drivers/pinctrl/pinctrl-st.c                       |   2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   4 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  15 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |  25 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |  17 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             |   3 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   8 +-
 kernel/irq/irqdomain.c                             |   1 +
 128 files changed, 1488 insertions(+), 1405 deletions(-)
 create mode 100644 drivers/gpio/gpio-rockchip.c
 create mode 100644 drivers/pinctrl/pinctrl-rockchip.h
