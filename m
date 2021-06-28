Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7E3B5B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhF1JwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhF1JwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:52:01 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281A961A1D;
        Mon, 28 Jun 2021 09:49:36 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lxntW-00ANzM-36; Mon, 28 Jun 2021 10:49:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.14
Date:   Mon, 28 Jun 2021 10:49:14 +0100
Message-Id: <20210628094914.21024-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, agross@kernel.org, biju.das.jz@bp.renesas.com, bjorn.andersson@linaro.org, chunfeng.yun@mediatek.com, geert+renesas@glider.be, john.stultz@linaro.org, krzysztof.kozlowski@canonical.com, prabhakar.mahadev-lad.rj@bp.renesas.com, ilina@codeaurora.org, linus.walleij@linaro.org, mkshah@codeaurora.org, niklas.soderlund+renesas@ragnatech.se, robh@kernel.org, saravanak@google.com, tkjos@google.com, yangyingliang@huawei.com, yoshihiro.shimoda.uh@renesas.com, thunder.leizhen@huawei.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the set of updates from the irqchip department for 5.14.

The bulk of it is a change in the way irqdomain works, now
consistently caching an irqdata instead of a mix of irq numbers and
irqdata. This allows us to simplify the handling of IRQ handling
involving an irqdomain as we can shorten the lookup path.

All the irqchip drivers are updated to this new API when possible. I
have a lot more on the back-burner (GPIO, pinctl, PCI...), but let's
get the fundamentals in first.

Note that this has some impacts on some architectures and
arch-specific drivers (PowerPC and MIPS, mainly), mostly because of
some circular include hell.

Other than that, a couple of driver updates, the usual DT churn, and a
few printk cleanup patches.

Please pull,

	M.

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.14

for you to fetch changes up to c51e96dace68a67f1fcfa49d4ad1577875f50bf1:

  Merge branch irq/irqchip-driver-updates into irq/irqchip-next (2021-06-11 14:50:03 +0100)

----------------------------------------------------------------
irqchip updates for 5.14

- Revamped the irqdomain internals to consistently cache an irqdata

- Expose a new API to simplify IRQ handling involving an irqdomain by
  not using the IRQ number

- Convert all the irqchip drivers to this new API

- Allow the Qualcomm PDC driver to be compiled as a module

- Fix HiSi MBIGEN compile warning when CONFIG_ACPI isn't selected

- Remove a bunch of spurious printks on error paths

- The obligatory couple of DT updates

----------------------------------------------------------------
Chunfeng Yun (1):
      irqchip: gic-pm: Remove redundant error log of clock bulk

Geert Uytterhoeven (1):
      dt-bindings: irqchip: renesas-irqc: Add R-Car M3-W+ support

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: arm,gic-v3: Describe GICv3 optional properties

Marc Zyngier (30):
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
      powerpc: Convert irq_domain_add_legacy_isa use to irq_domain_add_legacy
      powerpc: Drop dependency between asm/irq.h and linux/irqdomain.h
      irqdomain: Kill irq_domain_add_legacy_isa
      irqdomain: Reimplement irq_linear_revmap() with irq_find_mapping()
      powerpc: Move the use of irq_domain_add_nomap() behind a config option
      irqdomain: Make normal and nomap irqdomains exclusive
      irqdomain: Use struct_size() helper when allocating irqdomain
      irqdomain: Cache irq_data instead of a virq number in the revmap
      irqdomain: Protect the linear revmap with RCU
      irqdomain: Introduce irq_resolve_mapping()
      genirq: Use irq_resolve_mapping() to implement __handle_domain_irq() and co
      irqdesc: Fix __handle_domain_irq() comment
      irqchip/nvic: Convert from handle_IRQ() to handle_domain_irq()
      genirq: Add generic_handle_domain_irq() helper
      genirq: Move non-irqdomain handle_domain_irq() handling into ARM's handle_IRQ()
      irqchip: Bulk conversion to generic_handle_domain_irq()
      Merge branch irq/irqchip-spurious-printk into irq/irqchip-next
      Merge branch irq/irqchip-dt-updates into irq/irqchip-next
      Merge branch irq/generic_handle_domain_irq-core into irq/irqchip-next
      Merge branch irq/irqchip-driver-updates into irq/irqchip-next

Saravana Kannan (1):
      irqchip/qcom-pdc: Switch to IRQCHIP_PLATFORM_DRIVER and allow as a module

Yang Yingliang (1):
      irqchip/mbigen: Fix compile warning when CONFIG_ACPI is disabled

Zhen Lei (6):
      irqchip/exynos-combiner: Remove unnecessary oom message
      irqchip/gic-v2m: Remove unnecessary oom message
      irqchip/gic-v3-its: Remove unnecessary oom message
      irqchip/imgpdc: Remove unnecessary oom message
      irqchip/irq-imx-gpcv2: Remove unnecessary oom message
      irqchip/sun4i: Remove unnecessary oom message

 Documentation/core-api/irq/irq-domain.rst          |   1 -
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  13 +++
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 arch/arm/kernel/irq.c                              |  22 +++-
 arch/mips/include/asm/irq.h                        |   1 -
 arch/mips/lantiq/xway/dma.c                        |   1 +
 arch/mips/pci/pci-rt3883.c                         |   1 +
 arch/mips/pci/pci-xtalk-bridge.c                   |   1 +
 arch/mips/sgi-ip27/ip27-irq.c                      |   1 +
 arch/mips/sgi-ip30/ip30-irq.c                      |   1 +
 arch/nios2/include/asm/irq.h                       |   1 -
 arch/nios2/kernel/irq.c                            |   1 +
 arch/powerpc/include/asm/irq.h                     |   5 +-
 arch/powerpc/kernel/mce.c                          |   1 +
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |   1 +
 arch/powerpc/kvm/book3s_xive.c                     |   1 +
 arch/powerpc/kvm/book3s_xive_native.c              |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   1 +
 arch/powerpc/platforms/cell/Kconfig                |   1 +
 arch/powerpc/platforms/cell/pmu.c                  |   1 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   1 +
 arch/powerpc/platforms/powermac/Kconfig            |   1 +
 arch/powerpc/platforms/ps3/Kconfig                 |   1 +
 arch/powerpc/platforms/ps3/interrupt.c             |   5 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   1 +
 arch/powerpc/sysdev/ehv_pic.c                      |   1 +
 arch/powerpc/sysdev/fsl_mpic_err.c                 |   1 +
 arch/powerpc/sysdev/i8259.c                        |   3 +-
 arch/powerpc/sysdev/mpic.c                         |   2 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |   3 +-
 arch/powerpc/sysdev/xics/icp-hv.c                  |   1 +
 arch/powerpc/sysdev/xics/icp-opal.c                |   1 +
 arch/powerpc/sysdev/xics/xics-common.c             |   2 +-
 arch/powerpc/sysdev/xive/Kconfig                   |   1 +
 drivers/irqchip/Kconfig                            |   2 +-
 drivers/irqchip/exynos-combiner.c                  |  14 +--
 drivers/irqchip/irq-al-fic.c                       |   7 +-
 drivers/irqchip/irq-armada-370-xp.c                |  19 ++--
 drivers/irqchip/irq-aspeed-i2c-ic.c                |   8 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |   6 +-
 drivers/irqchip/irq-ath79-misc.c                   |   2 +-
 drivers/irqchip/irq-bcm2835.c                      |   2 +-
 drivers/irqchip/irq-bcm2836.c                      |   2 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |   6 +-
 drivers/irqchip/irq-bcm7120-l2.c                   |   6 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |   2 +-
 drivers/irqchip/irq-dw-apb-ictl.c                  |   3 +-
 drivers/irqchip/irq-gic-pm.c                       |   4 +-
 drivers/irqchip/irq-gic-v2m.c                      |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   8 +-
 drivers/irqchip/irq-gic.c                          |  13 +--
 drivers/irqchip/irq-goldfish-pic.c                 |   5 +-
 drivers/irqchip/irq-i8259.c                        |   4 +-
 drivers/irqchip/irq-idt3243x.c                     |   6 +-
 drivers/irqchip/irq-imgpdc.c                       |  19 ++--
 drivers/irqchip/irq-imx-gpcv2.c                    |   4 +-
 drivers/irqchip/irq-imx-intmux.c                   |   9 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |   9 +-
 drivers/irqchip/irq-ingenic-tcu.c                  |   2 +-
 drivers/irqchip/irq-ingenic.c                      |   3 +-
 drivers/irqchip/irq-keystone.c                     |  14 ++-
 drivers/irqchip/irq-loongson-htpic.c               |   2 +-
 drivers/irqchip/irq-loongson-htvec.c               |   4 +-
 drivers/irqchip/irq-loongson-liointc.c             |   2 +-
 drivers/irqchip/irq-lpc32xx.c                      |   2 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |   6 +-
 drivers/irqchip/irq-ls1x.c                         |   2 +-
 drivers/irqchip/irq-mbigen.c                       |  12 +--
 drivers/irqchip/irq-mips-gic.c                     |  21 ++--
 drivers/irqchip/irq-mscc-ocelot.c                  |   2 +-
 drivers/irqchip/irq-mvebu-pic.c                    |   7 +-
 drivers/irqchip/irq-mvebu-sei.c                    |  13 +--
 drivers/irqchip/irq-nvic.c                         |   4 +-
 drivers/irqchip/irq-orion.c                        |   2 +-
 drivers/irqchip/irq-partition-percpu.c             |   9 +-
 drivers/irqchip/irq-pruss-intc.c                   |   9 +-
 drivers/irqchip/irq-realtek-rtl.c                  |   2 +-
 drivers/irqchip/irq-renesas-irqc.c                 |   2 +-
 drivers/irqchip/irq-sifive-plic.c                  |   8 +-
 drivers/irqchip/irq-stm32-exti.c                   |  10 +-
 drivers/irqchip/irq-sun4i.c                        |   8 +-
 drivers/irqchip/irq-sunxi-nmi.c                    |   3 +-
 drivers/irqchip/irq-tb10x.c                        |   2 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   9 +-
 drivers/irqchip/irq-ts4800.c                       |   3 +-
 drivers/irqchip/irq-versatile-fpga.c               |   2 +-
 drivers/irqchip/irq-vic.c                          |   2 +-
 drivers/irqchip/irq-xilinx-intc.c                  |  23 +---
 drivers/irqchip/qcom-irq-combiner.c                |   6 +-
 drivers/irqchip/qcom-pdc.c                         |   8 +-
 drivers/mfd/ioc3.c                                 |   1 +
 drivers/scsi/ibmvscsi/ibmvfc.c                     |   1 +
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           |   1 +
 drivers/staging/octeon-usb/octeon-hcd.c            |   2 +
 drivers/watchdog/octeon-wdt-main.c                 |   1 +
 include/linux/irqdesc.h                            |  18 ++--
 include/linux/irqdomain.h                          |  65 ++++++-----
 kernel/irq/Kconfig                                 |   5 +
 kernel/irq/irqdesc.c                               |  73 +++++++------
 kernel/irq/irqdomain.c                             | 120 ++++++++++++++-------
 100 files changed, 384 insertions(+), 352 deletions(-)
