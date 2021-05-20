Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4D38B460
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhETQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhETQjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:39:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF3661019;
        Thu, 20 May 2021 16:37:57 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgJ-002d7b-D7; Thu, 20 May 2021 17:37:55 +0100
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
Subject: [PATCH 00/39] irqdomain: Simplify interrupt handling
Date:   Thu, 20 May 2021 17:37:12 +0100
Message-Id: <20210520163751.27325-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although most device drivers only deal with an interrupt number, the
core IRQ code is mostly concerned with the irq_desc structure that
describes the full interrupt context (hierarchy, handlers, state).

However, the low-level interrupt handling code that relies on the
irqdomain abstraction has to perform an annoying dance to eventually
get the core code to invoke interrupt handlers: the irqdomain code
converts a low-level identifier to the unique Linux interrupt number,
and the core code resolves this into an irq_desc pointer.

Each of these two lookups ends-up parsing a radix tree (although the
irqdomain code can use a linear mapping for the smallest domains),
which is obviously one too many. Wouldn't it be nice if the irqdomain
would cache the irq_desc instead of forcing the core code to look it
up on each and every interrupt? This is what this long series is all
about.

There is roughly 3 parts here:

- a substantial amount of massaging for some architectures (nios, mips
  and powerpc) to disentangle weird include constructs (asm/irq.h
  including linux/irqdomain.h is pretty bad...) and simplify bits of
  the irqdomain code

- some rework of the irqdomain code to allow the caching of a irq_data
  pointer, unify the RCU behaviour and offer new APIs.

- Perform a bulk of conversions that turn constructs similar to
  generic_handle_irq(irq_find_mapping(domain, hwirq)) into a simpler
  call to generic_handle_domain_irq(domain, hwirq). Yes, this is a
  mouthful.

I've kept most of the conversions per-subsystem/per-arch in order to
keep the number of patches low (though it is debatable whether I have
succeeded).

This ends up with a negative diffstat, so it can't be completely bad!
Given the breadth of the changes, I do expect some breakage, although
I've extensively compile-tested it and the kbuild robot has been
invaluable in helping with the coverage.

Thanks,

	M.

Marc Zyngier (39):
  nios2: Do not include linux/irqdomain.h from asm/irq.h
  staging: octeon-hcd: Directly include linux/of.h
  mfd: ioc3: Directly include linux/irqdomain.h
  watchdog/octeon-wdt: Directly include linux/irqdomain.h
  irqchip/mips-gic: Directly include linux/irqdomain.h
  MIPS: lantiq: Directly include linux/of.h in xway/dma.c
  MIPS: Add missing linux/irqdomain.h includes
  MIPS: Do not include linux/irqdomain.h from asm/irq.h
  powerpc: Add missing linux/{of.h,irqdomain.h} include directives
  scsi/ibmvscsi: Directly include linux/{of.h,irqdomain.h}
  powerpc: Convert irq_domain_add_legacy_isa use to
    irq_domain_add_legacy
  powerpc: Drop dependency between asm/irq.h and linux/irqdomain.h
  irqdomain: Kill irq_domain_add_legacy_isa
  irqdomain: Reimplement irq_linear_revmap() with irq_find_mapping()
  powerpc: Move the use of irq_domain_add_nomap() behind a config option
  irqdomain: Make normal and nomap irqdomains exclusive
  irqdomain: Use struct_size() helper when allocating irqdomain
  irqdomain: Cache irq_data instead of a virq number in the revmap
  irqdomain: Implement irq_domain_clear_mapping() with
    irq_domain_set_mapping()
  irqdomain: Protect the linear revmap with RCU
  irqdomain: Introduce irq_resolve_mapping()
  genirq: Use irq_resolve_mapping() to implement __handle_domain_irq()
    and co
  irqdesc: Fix __handle_domain_irq() comment
  irqchip/nvic: Convert from handle_IRQ() to handle_domain_irq()
  genirq: Add generic_handle_domain_irq() helper
  genirq: Move non-irqdomain handle_domain_irq() handling into ARM's
    handle_IRQ()
  irqchip: Bulk conversion to generic_handle_domain_irq()
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

 Documentation/core-api/irq/irq-domain.rst     |   1 -
 arch/arc/kernel/mcip.c                        |   2 +-
 arch/arm/kernel/irq.c                         |  22 +++-
 arch/arm/mach-pxa/pxa_cplds_irqs.c            |   6 +-
 arch/arm/mach-s3c/irq-s3c24xx.c               |   5 +-
 arch/mips/ath25/ar2315.c                      |  14 +--
 arch/mips/ath25/ar5312.c                      |  13 +-
 arch/mips/include/asm/irq.h                   |   1 -
 arch/mips/lantiq/irq.c                        |   2 +-
 arch/mips/lantiq/xway/dma.c                   |   1 +
 arch/mips/pci/pci-ar2315.c                    |   8 +-
 arch/mips/pci/pci-rt3883.c                    |   6 +-
 arch/mips/pci/pci-xtalk-bridge.c              |   1 +
 arch/mips/ralink/irq.c                        |   2 +-
 arch/mips/sgi-ip27/ip27-irq.c                 |  17 ++-
 arch/mips/sgi-ip30/ip30-irq.c                 |   9 +-
 arch/nios2/include/asm/irq.h                  |   1 -
 arch/nios2/kernel/irq.c                       |   5 +-
 arch/powerpc/include/asm/irq.h                |   5 +-
 arch/powerpc/kernel/mce.c                     |   1 +
 arch/powerpc/kvm/book3s_hv_uvmem.c            |   1 +
 arch/powerpc/kvm/book3s_xive.c                |   1 +
 arch/powerpc/kvm/book3s_xive_native.c         |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   1 +
 arch/powerpc/platforms/4xx/uic.c              |   4 +-
 .../powerpc/platforms/512x/mpc5121_ads_cpld.c |  23 ++--
 arch/powerpc/platforms/52xx/media5200.c       |   9 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |   7 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c  |   6 +-
 arch/powerpc/platforms/cell/Kconfig           |   1 +
 arch/powerpc/platforms/cell/interrupt.c       |   8 +-
 arch/powerpc/platforms/cell/pmu.c             |   1 +
 arch/powerpc/platforms/cell/spider-pic.c      |  11 +-
 .../platforms/embedded6xx/flipper-pic.c       |   1 +
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c |  15 ++-
 arch/powerpc/platforms/powermac/Kconfig       |   1 +
 arch/powerpc/platforms/powernv/opal-irqchip.c |  11 +-
 arch/powerpc/platforms/ps3/Kconfig            |   1 +
 arch/powerpc/platforms/ps3/interrupt.c        |   5 +-
 arch/powerpc/platforms/pseries/ibmebus.c      |   1 +
 arch/powerpc/sysdev/ehv_pic.c                 |   1 +
 arch/powerpc/sysdev/fsl_mpic_err.c            |  12 +-
 arch/powerpc/sysdev/fsl_msi.c                 |   8 +-
 arch/powerpc/sysdev/i8259.c                   |   3 +-
 arch/powerpc/sysdev/mpic.c                    |   2 +-
 arch/powerpc/sysdev/tsi108_pci.c              |   3 +-
 arch/powerpc/sysdev/xics/icp-hv.c             |   1 +
 arch/powerpc/sysdev/xics/icp-opal.c           |   1 +
 arch/powerpc/sysdev/xics/xics-common.c        |   2 +-
 arch/powerpc/sysdev/xive/Kconfig              |   1 +
 arch/sh/boards/mach-se/7343/irq.c             |   2 +-
 arch/sh/boards/mach-se/7722/irq.c             |   2 +-
 arch/sh/boards/mach-x3proto/gpio.c            |   2 +-
 arch/xtensa/kernel/irq.c                      |   4 +-
 drivers/gpio/gpio-104-dio-48e.c               |   4 +-
 drivers/gpio/gpio-104-idi-48.c                |   4 +-
 drivers/gpio/gpio-104-idio-16.c               |   2 +-
 drivers/gpio/gpio-altera.c                    |  11 +-
 drivers/gpio/gpio-aspeed-sgpio.c              |   9 +-
 drivers/gpio/gpio-aspeed.c                    |   9 +-
 drivers/gpio/gpio-ath79.c                     |   7 +-
 drivers/gpio/gpio-bcm-kona.c                  |   6 +-
 drivers/gpio/gpio-brcmstb.c                   |   5 +-
 drivers/gpio/gpio-cadence.c                   |   2 +-
 drivers/gpio/gpio-davinci.c                   |   3 +-
 drivers/gpio/gpio-dln2.c                      |  22 ++--
 drivers/gpio/gpio-em.c                        |   2 +-
 drivers/gpio/gpio-ep93xx.c                    |   8 +-
 drivers/gpio/gpio-ftgpio010.c                 |   3 +-
 drivers/gpio/gpio-hisi.c                      |   4 +-
 drivers/gpio/gpio-hlwd.c                      |   7 +-
 drivers/gpio/gpio-merrifield.c                |   8 +-
 drivers/gpio/gpio-mpc8xxx.c                   |   2 +-
 drivers/gpio/gpio-mt7621.c                    |   4 +-
 drivers/gpio/gpio-mxc.c                       |   2 +-
 drivers/gpio/gpio-mxs.c                       |   2 +-
 drivers/gpio/gpio-omap.c                      |   3 +-
 drivers/gpio/gpio-pci-idio-16.c               |   2 +-
 drivers/gpio/gpio-pcie-idio-24.c              |   3 +-
 drivers/gpio/gpio-pl061.c                     |   4 +-
 drivers/gpio/gpio-pxa.c                       |   9 +-
 drivers/gpio/gpio-rcar.c                      |   4 +-
 drivers/gpio/gpio-rda.c                       |   8 +-
 drivers/gpio/gpio-realtek-otto.c              |   7 +-
 drivers/gpio/gpio-sch.c                       |   2 +-
 drivers/gpio/gpio-sodaville.c                 |   2 +-
 drivers/gpio/gpio-sprd.c                      |  12 +-
 drivers/gpio/gpio-tb10x.c                     |   2 +-
 drivers/gpio/gpio-tegra.c                     |   9 +-
 drivers/gpio/gpio-tegra186.c                  |   9 +-
 drivers/gpio/gpio-tqmx86.c                    |  10 +-
 drivers/gpio/gpio-vf610.c                     |   2 +-
 drivers/gpio/gpio-ws16c48.c                   |   4 +-
 drivers/gpio/gpio-xgs-iproc.c                 |   2 +-
 drivers/gpio/gpio-xilinx.c                    |   9 +-
 drivers/gpio/gpio-xlp.c                       |   3 +-
 drivers/gpio/gpio-zynq.c                      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c      |  15 +--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c     |   3 +-
 drivers/gpu/ipu-v3/ipu-common.c               |  11 +-
 drivers/irqchip/exynos-combiner.c             |  10 +-
 drivers/irqchip/irq-al-fic.c                  |   7 +-
 drivers/irqchip/irq-armada-370-xp.c           |  19 ++-
 drivers/irqchip/irq-aspeed-i2c-ic.c           |   8 +-
 drivers/irqchip/irq-aspeed-scu-ic.c           |   6 +-
 drivers/irqchip/irq-ath79-misc.c              |   2 +-
 drivers/irqchip/irq-bcm2835.c                 |   2 +-
 drivers/irqchip/irq-bcm2836.c                 |   2 +-
 drivers/irqchip/irq-bcm7038-l1.c              |   6 +-
 drivers/irqchip/irq-bcm7120-l2.c              |   6 +-
 drivers/irqchip/irq-brcmstb-l2.c              |   2 +-
 drivers/irqchip/irq-dw-apb-ictl.c             |   3 +-
 drivers/irqchip/irq-gic.c                     |  13 +-
 drivers/irqchip/irq-goldfish-pic.c            |   5 +-
 drivers/irqchip/irq-i8259.c                   |   4 +-
 drivers/irqchip/irq-idt3243x.c                |   6 +-
 drivers/irqchip/irq-imgpdc.c                  |  11 +-
 drivers/irqchip/irq-imx-intmux.c              |   9 +-
 drivers/irqchip/irq-imx-irqsteer.c            |   9 +-
 drivers/irqchip/irq-ingenic-tcu.c             |   2 +-
 drivers/irqchip/irq-ingenic.c                 |   3 +-
 drivers/irqchip/irq-keystone.c                |  14 +--
 drivers/irqchip/irq-loongson-htpic.c          |   2 +-
 drivers/irqchip/irq-loongson-htvec.c          |   4 +-
 drivers/irqchip/irq-loongson-liointc.c        |   2 +-
 drivers/irqchip/irq-lpc32xx.c                 |   2 +-
 drivers/irqchip/irq-ls-scfg-msi.c             |   6 +-
 drivers/irqchip/irq-ls1x.c                    |   2 +-
 drivers/irqchip/irq-mips-gic.c                |  21 ++--
 drivers/irqchip/irq-mscc-ocelot.c             |   2 +-
 drivers/irqchip/irq-mvebu-pic.c               |   7 +-
 drivers/irqchip/irq-mvebu-sei.c               |  13 +-
 drivers/irqchip/irq-nvic.c                    |   4 +-
 drivers/irqchip/irq-orion.c                   |   2 +-
 drivers/irqchip/irq-partition-percpu.c        |   9 +-
 drivers/irqchip/irq-pruss-intc.c              |   9 +-
 drivers/irqchip/irq-realtek-rtl.c             |   2 +-
 drivers/irqchip/irq-renesas-irqc.c            |   2 +-
 drivers/irqchip/irq-sifive-plic.c             |   8 +-
 drivers/irqchip/irq-stm32-exti.c              |  10 +-
 drivers/irqchip/irq-sunxi-nmi.c               |   3 +-
 drivers/irqchip/irq-tb10x.c                   |   2 +-
 drivers/irqchip/irq-ti-sci-inta.c             |   9 +-
 drivers/irqchip/irq-ts4800.c                  |   3 +-
 drivers/irqchip/irq-versatile-fpga.c          |   2 +-
 drivers/irqchip/irq-vic.c                     |   2 +-
 drivers/irqchip/irq-xilinx-intc.c             |  22 +---
 drivers/irqchip/qcom-irq-combiner.c           |   6 +-
 drivers/mfd/db8500-prcmu.c                    |   2 +-
 drivers/mfd/fsl-imx25-tsadc.c                 |   4 +-
 drivers/mfd/ioc3.c                            |  11 +-
 drivers/mfd/qcom-pm8xxx.c                     |  10 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |  14 +--
 drivers/pci/controller/dwc/pci-keystone.c     |   5 +-
 .../pci/controller/dwc/pcie-designware-host.c |   9 +-
 drivers/pci/controller/dwc/pcie-uniphier.c    |   6 +-
 .../controller/mobiveil/pcie-mobiveil-host.c  |  15 +--
 drivers/pci/controller/pci-aardvark.c         |   5 +-
 drivers/pci/controller/pci-ftpci100.c         |   2 +-
 drivers/pci/controller/pci-tegra.c            |   8 +-
 drivers/pci/controller/pci-xgene-msi.c        |   9 +-
 drivers/pci/controller/pcie-altera-msi.c      |  10 +-
 drivers/pci/controller/pcie-altera.c          |  10 +-
 drivers/pci/controller/pcie-brcmstb.c         |   9 +-
 drivers/pci/controller/pcie-iproc-msi.c       |   4 +-
 drivers/pci/controller/pcie-mediatek-gen3.c   |  13 +-
 drivers/pci/controller/pcie-mediatek.c        |  12 +-
 drivers/pci/controller/pcie-microchip-host.c  |  18 ++-
 drivers/pci/controller/pcie-rcar-host.c       |   8 +-
 drivers/pci/controller/pcie-rockchip-host.c   |   8 +-
 drivers/pci/controller/pcie-xilinx-cpm.c      |   4 +-
 drivers/pci/controller/pcie-xilinx-nwl.c      |  13 +-
 drivers/pci/controller/pcie-xilinx.c          |   9 +-
 drivers/pinctrl/actions/pinctrl-owl.c         |   5 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c         |   4 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c      |   3 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c        |   3 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c      |   7 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c    |   5 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     |   8 +-
 drivers/pinctrl/mediatek/mtk-eint.c           |   5 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |   2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     |   2 +-
 drivers/pinctrl/pinctrl-amd.c                 |   6 +-
 drivers/pinctrl/pinctrl-at91.c                |   6 +-
 drivers/pinctrl/pinctrl-equilibrium.c         |   2 +-
 drivers/pinctrl/pinctrl-ingenic.c             |   2 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c     |   2 +-
 drivers/pinctrl/pinctrl-ocelot.c              |   3 +-
 drivers/pinctrl/pinctrl-oxnas.c               |   2 +-
 drivers/pinctrl/pinctrl-pic32.c               |   2 +-
 drivers/pinctrl/pinctrl-pistachio.c           |   2 +-
 drivers/pinctrl/pinctrl-rockchip.c            |  15 +--
 drivers/pinctrl/pinctrl-single.c              |   4 +-
 drivers/pinctrl/pinctrl-st.c                  |   2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c            |   4 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c      |  15 ++-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c     |  25 ++--
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c     |  17 ++-
 drivers/pinctrl/spear/pinctrl-plgpio.c        |   3 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   8 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                |   1 +
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c      |   1 +
 drivers/staging/octeon-usb/octeon-hcd.c       |   1 +
 drivers/watchdog/octeon-wdt-main.c            |   1 +
 include/linux/irqdesc.h                       |  18 ++-
 include/linux/irqdomain.h                     |  60 +++++-----
 kernel/irq/Kconfig                            |   5 +
 kernel/irq/irqdesc.c                          |  73 +++++++-----
 kernel/irq/irqdomain.c                        | 112 +++++++++++-------
 211 files changed, 658 insertions(+), 847 deletions(-)

-- 
2.30.2

