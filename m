Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E853DDD9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhHBQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhHBQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:26:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9462660FC0;
        Mon,  2 Aug 2021 16:26:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mAam7-002WEi-It; Mon, 02 Aug 2021 17:26:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH v2 00/14][treewide] irqdomain: Simplify interrupt handling
Date:   Mon,  2 Aug 2021 17:26:16 +0100
Message-Id: <20210802162630.2219813-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core patches for generic_handle_domain_irq() have made it
into the core code (see [1]), this series goes over the tree to
simplify the interrupt handling by directly using the irq_data that is
now stored in the IRQ domain.

In summary, anything of the form:

- generic_handle_irq(irq_find_mapping(domain, hwirq)) or
- generic_handle_irq(irq_linear_revmap(domain, hwirq))

is turned into generic_handle_domain_irq(domain, hwirq), which deals
with the gory details.

This series goes over a number of subsystems and architectures, and
also adds a bit of documentation. For those of you wondering about a
merge strategy, all the patches should be independent. Maintainers can
either pick them up themselves, or give me an Ack so that I can take
them via the irqchip tree. Just let me know.

I have an extra set of patches dealing with nested interrupts, but
that still needs to mature a bit.

* From v1 [1]:
  - Merged all the preliminary patches and core support
  - Caught up with a few extra users in 5.14
  - Picked up ABs, RBs, with thanks
  - Rebased on top of v5.14-rc4

[1] https://lore.kernel.org/r/20210520163751.27325-1-maz@kernel.org

Marc Zyngier (14):
  gpio: Bulk conversion to generic_handle_domain_irq()
  pinctrl: Bulk conversion to generic_handle_domain_irq()
  PCI: Bulk conversion to generic_handle_domain_irq()
  mfd: Bulk conversion to generic_handle_domain_irq()
  gpu: Bulk conversion to generic_handle_domain_irq()
  SH: Bulk conversion to generic_handle_domain_irq()
  ARM: Bulk conversion to generic_handle_domain_irq()
  mips: Bulk conversion to generic_handle_domain_irq()
  arc: Bulk conversion to generic_handle_domain_irq()
  xtensa: Bulk conversion to generic_handle_domain_irq()
  nios2: Bulk conversion to generic_handle_domain_irq()
  powerpc: Bulk conversion to generic_handle_domain_irq()
  EDAC/altera: Convert to generic_handle_domain_irq()
  Documentation: Update irq_domain.rst with new lookup APIs

 Documentation/core-api/irq/irq-domain.rst     | 28 +++++++++++++++++--
 arch/arc/kernel/mcip.c                        |  2 +-
 arch/arm/common/sa1111.c                      | 12 ++------
 arch/arm/mach-pxa/pxa_cplds_irqs.c            |  6 ++--
 arch/arm/mach-s3c/irq-s3c24xx.c               |  5 ++--
 arch/mips/ath25/ar2315.c                      | 14 +++++-----
 arch/mips/ath25/ar5312.c                      | 13 ++++-----
 arch/mips/lantiq/irq.c                        |  2 +-
 arch/mips/pci/pci-ar2315.c                    |  8 ++----
 arch/mips/pci/pci-rt3883.c                    |  5 ++--
 arch/mips/ralink/irq.c                        |  2 +-
 arch/mips/sgi-ip27/ip27-irq.c                 | 16 ++++-------
 arch/mips/sgi-ip30/ip30-irq.c                 |  8 ++----
 arch/nios2/kernel/irq.c                       |  4 +--
 arch/powerpc/platforms/4xx/uic.c              |  4 +--
 .../powerpc/platforms/512x/mpc5121_ads_cpld.c | 23 +++++++--------
 arch/powerpc/platforms/52xx/media5200.c       |  9 +++---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |  7 ++---
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c  |  6 ++--
 arch/powerpc/platforms/cell/interrupt.c       |  8 ++----
 arch/powerpc/platforms/cell/spider-pic.c      | 11 ++------
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 15 +++++-----
 arch/powerpc/platforms/powernv/opal-irqchip.c | 11 +++-----
 arch/powerpc/sysdev/fsl_mpic_err.c            | 11 +++-----
 arch/powerpc/sysdev/fsl_msi.c                 | 12 +++-----
 arch/sh/boards/mach-se/7343/irq.c             |  2 +-
 arch/sh/boards/mach-se/7722/irq.c             |  2 +-
 arch/sh/boards/mach-x3proto/gpio.c            |  2 +-
 arch/xtensa/kernel/irq.c                      |  4 +--
 drivers/edac/altera_edac.c                    |  7 ++---
 drivers/gpio/gpio-104-dio-48e.c               |  4 +--
 drivers/gpio/gpio-104-idi-48.c                |  4 +--
 drivers/gpio/gpio-104-idio-16.c               |  2 +-
 drivers/gpio/gpio-altera.c                    | 11 ++++----
 drivers/gpio/gpio-aspeed-sgpio.c              |  9 ++----
 drivers/gpio/gpio-aspeed.c                    |  9 ++----
 drivers/gpio/gpio-ath79.c                     |  7 ++---
 drivers/gpio/gpio-bcm-kona.c                  |  6 ++--
 drivers/gpio/gpio-brcmstb.c                   |  5 ++--
 drivers/gpio/gpio-cadence.c                   |  2 +-
 drivers/gpio/gpio-davinci.c                   |  3 +-
 drivers/gpio/gpio-dln2.c                      | 22 ++++++---------
 drivers/gpio/gpio-em.c                        |  2 +-
 drivers/gpio/gpio-ep93xx.c                    |  8 +++---
 drivers/gpio/gpio-ftgpio010.c                 |  3 +-
 drivers/gpio/gpio-hisi.c                      |  4 +--
 drivers/gpio/gpio-hlwd.c                      |  7 ++---
 drivers/gpio/gpio-merrifield.c                |  8 ++----
 drivers/gpio/gpio-mpc8xxx.c                   |  2 +-
 drivers/gpio/gpio-mt7621.c                    |  4 +--
 drivers/gpio/gpio-mxc.c                       |  2 +-
 drivers/gpio/gpio-mxs.c                       |  2 +-
 drivers/gpio/gpio-omap.c                      |  3 +-
 drivers/gpio/gpio-pci-idio-16.c               |  2 +-
 drivers/gpio/gpio-pcie-idio-24.c              |  3 +-
 drivers/gpio/gpio-pl061.c                     |  4 +--
 drivers/gpio/gpio-pxa.c                       |  9 +++---
 drivers/gpio/gpio-rcar.c                      |  4 +--
 drivers/gpio/gpio-rda.c                       |  8 ++----
 drivers/gpio/gpio-realtek-otto.c              |  7 ++---
 drivers/gpio/gpio-sch.c                       |  2 +-
 drivers/gpio/gpio-sodaville.c                 |  2 +-
 drivers/gpio/gpio-sprd.c                      | 12 +++-----
 drivers/gpio/gpio-tb10x.c                     |  2 +-
 drivers/gpio/gpio-tegra.c                     |  9 +++---
 drivers/gpio/gpio-tegra186.c                  |  9 ++----
 drivers/gpio/gpio-tqmx86.c                    | 10 +++----
 drivers/gpio/gpio-vf610.c                     |  2 +-
 drivers/gpio/gpio-ws16c48.c                   |  4 +--
 drivers/gpio/gpio-xgs-iproc.c                 |  2 +-
 drivers/gpio/gpio-xilinx.c                    |  2 +-
 drivers/gpio/gpio-xlp.c                       |  3 +-
 drivers/gpio/gpio-zynq.c                      |  8 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c      | 15 +++-------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c     |  3 +-
 drivers/gpu/ipu-v3/ipu-common.c               | 11 +++-----
 drivers/mfd/db8500-prcmu.c                    |  2 +-
 drivers/mfd/fsl-imx25-tsadc.c                 |  4 +--
 drivers/mfd/ioc3.c                            | 10 ++-----
 drivers/mfd/qcom-pm8xxx.c                     | 10 +++----
 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ++++-------
 drivers/pci/controller/dwc/pci-keystone.c     | 14 ++++------
 .../pci/controller/dwc/pcie-designware-host.c |  9 +++---
 drivers/pci/controller/dwc/pcie-uniphier.c    |  8 ++----
 .../controller/mobiveil/pcie-mobiveil-host.c  | 15 ++++------
 drivers/pci/controller/pci-aardvark.c         |  5 ++--
 drivers/pci/controller/pci-ftpci100.c         |  2 +-
 drivers/pci/controller/pci-tegra.c            |  8 ++----
 drivers/pci/controller/pci-xgene-msi.c        |  9 ++----
 drivers/pci/controller/pcie-altera-msi.c      | 10 +++----
 drivers/pci/controller/pcie-altera.c          | 10 +++----
 drivers/pci/controller/pcie-brcmstb.c         |  9 +++---
 drivers/pci/controller/pcie-iproc-msi.c       |  4 +--
 drivers/pci/controller/pcie-mediatek-gen3.c   | 13 +++------
 drivers/pci/controller/pcie-mediatek.c        | 12 +++-----
 drivers/pci/controller/pcie-microchip-host.c  | 18 +++++-------
 drivers/pci/controller/pcie-rcar-host.c       |  8 ++----
 drivers/pci/controller/pcie-rockchip-host.c   |  8 ++----
 drivers/pci/controller/pcie-xilinx-cpm.c      |  4 +--
 drivers/pci/controller/pcie-xilinx-nwl.c      | 13 ++-------
 drivers/pci/controller/pcie-xilinx.c          |  9 +++---
 drivers/pinctrl/actions/pinctrl-owl.c         |  5 ++--
 drivers/pinctrl/bcm/pinctrl-bcm2835.c         |  4 +--
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c      |  3 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c        |  3 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c      |  7 ++---
 drivers/pinctrl/intel/pinctrl-cherryview.c    |  5 ++--
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     |  8 ++----
 drivers/pinctrl/mediatek/mtk-eint.c           |  5 ++--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     |  2 +-
 drivers/pinctrl/pinctrl-amd.c                 |  6 ++--
 drivers/pinctrl/pinctrl-at91.c                |  6 ++--
 drivers/pinctrl/pinctrl-equilibrium.c         |  2 +-
 drivers/pinctrl/pinctrl-ingenic.c             |  2 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c     |  2 +-
 drivers/pinctrl/pinctrl-ocelot.c              |  3 +-
 drivers/pinctrl/pinctrl-oxnas.c               |  2 +-
 drivers/pinctrl/pinctrl-pic32.c               |  2 +-
 drivers/pinctrl/pinctrl-pistachio.c           |  2 +-
 drivers/pinctrl/pinctrl-rockchip.c            | 15 ++++------
 drivers/pinctrl/pinctrl-single.c              |  4 +--
 drivers/pinctrl/pinctrl-st.c                  |  2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c            |  4 +--
 drivers/pinctrl/samsung/pinctrl-exynos.c      | 15 +++++-----
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c     | 25 +++++++----------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c     | 17 +++++------
 drivers/pinctrl/spear/pinctrl-plgpio.c        |  3 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |  8 ++----
 130 files changed, 362 insertions(+), 555 deletions(-)

-- 
2.30.2

