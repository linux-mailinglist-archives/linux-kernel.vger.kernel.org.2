Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791EF43F8FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhJ2IgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhJ2IgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:36:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F3D761165;
        Fri, 29 Oct 2021 08:33:52 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mgNKf-002NQ5-SB; Fri, 29 Oct 2021 09:33:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andrew Lunn <andrew@lunn.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greentime Hu <green.hu@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Guo Ren <guoren@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Kevin Hilman <khilman@baylibre.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.16
Date:   Fri, 29 Oct 2021 09:33:32 +0100
Message-Id: <20211029083332.3680101-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, peterz@infradead.org, bp@alien8.de, aou@eecs.berkeley.edu, andrew@lunn.ch, arnd@arndb.de, caihuoqing@baidu.com, catalin.marinas@arm.com, claudiu.beznea@microchip.com, f.fainelli@gmail.com, geert+renesas@glider.be, green.hu@gmail.com, linux@roeck-us.net, guoren@kernel.org, jonas@southpole.se, khilman@baylibre.com, prabhakar.mahadev-lad.rj@bp.renesas.com, lee.jones@linaro.org, linus.walleij@linaro.org, marian-cristian.rotariu.rb@bp.renesas.com, mark.rutland@arm.com, mchehab+huawei@kernel.org, narmstrong@baylibre.com, nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com, kernelfans@gmail.com, robh@kernel.org, linux@armlinux.org.uk, saravanak@google.com, fancer.lancer@gmail.com, shorne@gmail.com, stefan.kristiansson@saunalahti.fi, sudeep.holla@arm.com, tsbogend@alpha.franken.de, deanbo422@gmail.com, vgupta@kernel.org, vladimir.murzin@arm.com, will@kernel.org, yangyingliang@huawei.com, siyanteng@loongson.cn, linux-kernel@vger.kernel.org
 , kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas [+ Peter and Borislav while Thomas is away],

Here's the set of irqchip changes for 5.16. The largest set of changes
is Mark's work to make calling irq_enter()/irq_exit() an architecture
responsibility. This obviously has a lot of impacts all over the shop,
but the changes are pretty nice and a very good cleanup overall.

The rest is the usual churn: one new driver, a bunch of modularized
irqchips, irq_cpu_offline being made Cavium Octeon only, and the usual
minor fixes and improvements.

Please pull,

	M.

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.16

for you to fetch changes up to 11e45471abea1a69dc3a92b1d1632c4d628b3b98:

  Merge branch irq/misc-5.16 into irq/irqchip-next (2021-10-28 21:11:34 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.16

- A large cross-arch rework to move irq_enter()/irq_exit() into
  the arch code, and removing it from the generic irq code.
  Thanks to Mark Rutland for the huge effort!

- A few irqchip drivers are made modular (broadcom, meson), because
  that's apparently a thing...

- A new driver for the Microchip External Interrupt Controller

- The irq_cpu_offline()/irq_cpu_online() API is now deprecated and
  can only be selected on the Cavium Octeon platform. Once this
  platform is removed, the API will be removed at the same time.

- A sprinkle of devm_* helper, as people seem to love that.

- The usual spattering of small fixes and minor improvements.

----------------------------------------------------------------
Arnd Bergmann (1):
      irqchip: Fix compile-testing without CONFIG_OF

Cai Huoqing (5):
      irqchip/irq-mvebu-icu: Make use of the helper function devm_platform_ioremap_resource()
      irqchip/irq-mvebu-pic: Make use of the helper function devm_platform_ioremap_resource()
      irqchip/irq-ts4800: Make use of the helper function devm_platform_ioremap_resource()
      irqchip/stm32: Make use of the helper function devm_platform_ioremap_resource()
      irqchip/ti-sci-inta: Make use of the helper function devm_platform_ioremap_resource()

Claudiu Beznea (2):
      dt-bindings: microchip,eic: Add bindings for the Microchip EIC
      irqchip/mchp-eic: Add support for the Microchip EIC

Florian Fainelli (13):
      irqchip/irq-bcm7038-l1: Remove .irq_cpu_offline()
      irqchip/irq-bcm7038-l1: Use irq_get_irq_data()
      MIPS: BMIPS: Remove use of irq_cpu_offline
      irqchip/irq-bcm7038-l1: Gate use of CPU logical map to MIPS
      irqchip/irq-bcm7038-l1: Restrict affinity setting to MIPS
      irqchip/irq-bcm7038-l1: Switch to IRQCHIP_PLATFORM_DRIVER
      genirq: Export irq_gc_{unmask_enable,mask_disable}_reg
      irqchip/irq-brcmstb-l2: Switch to IRQCHIP_PLATFORM_DRIVER
      genirq: Export irq_gc_noop()
      irqchip/irq-bcm7120-l2: Switch to IRQCHIP_PLATFORM_DRIVER
      arm64: broadcom: Removed forced select of interrupt controllers
      ARM: bcm: Removed forced select of interrupt controllers
      irqchip: Fix kernel-doc parameter typo for IRQCHIP_DECLARE

Marc Zyngier (11):
      irqchip: Provide stronger type checking for IRQCHIP_MATCH/IRQCHIP_DECLARE
      Merge branch irq/devm-churn into irq/irqchip-next
      Merge branch irq/modular-irqchips into irq/irqchip-next
      Merge branch irq/mchp-eic into irq/irqchip-next
      MIPS: loongson64: Drop call to irq_cpu_offline()
      irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()
      genirq: Hide irq_cpu_{on,off}line() behind a deprecated option
      Merge branch irq/remove-handle-domain-irq-20211026 into irq/irqchip-next
      Merge branch irq/irq_cpu_offline into irq/irqchip-next
      h8300: Fix linux/irqchip.h include mess
      Merge branch irq/misc-5.16 into irq/irqchip-next

Marian-Cristian Rotariu (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774e1 bindings

Mark Rutland (17):
      irq: mips: avoid nested irq_enter()
      irq: mips: simplify bcm6345_l1_irq_handle()
      irq: mips: stop (ab)using handle_domain_irq()
      irq: mips: simplify do_domain_IRQ()
      irq: simplify handle_domain_{irq,nmi}()
      irq: unexport handle_irq_desc()
      irq: add generic_handle_arch_irq()
      irq: arc: avoid CONFIG_HANDLE_DOMAIN_IRQ
      irq: nds32: avoid CONFIG_HANDLE_DOMAIN_IRQ
      irq: add a (temporary) CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
      irq: arm: perform irqentry in entry code
      irq: arm64: perform irqentry in entry code
      irq: csky: perform irqentry in entry code
      irq: openrisc: perform irqentry in entry code
      irq: riscv: perform irqentry in entry code
      irq: remove CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
      irq: remove handle_domain_{irq,nmi}()

Mauro Carvalho Chehab (1):
      MAINTAINERS: update arm,vic.yaml reference

Neil Armstrong (2):
      irqchip/meson-gpio: Make it possible to build as a module
      arm64: meson: remove MESON_IRQ_GPIO selection

Yang Yingliang (1):
      irqchip/mchp-eic: Fix return value check in mchp_eic_init()

Yanteng Si (1):
      MIPS: irq: Avoid an unused-variable error

 Documentation/core-api/irq/irq-domain.rst          |   3 -
 .../interrupt-controller/microchip,eic.yaml        |  73 ++++++
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 MAINTAINERS                                        |   8 +-
 arch/arc/Kconfig                                   |   1 -
 arch/arc/kernel/irq.c                              |  10 +-
 arch/arm/Kconfig                                   |   1 -
 arch/arm/kernel/entry-armv.S                       |   5 +-
 arch/arm/kernel/irq.c                              |  14 +-
 arch/arm/mach-bcm/Kconfig                          |   4 -
 arch/arm/mach-imx/avic.c                           |   2 +-
 arch/arm/mach-imx/tzic.c                           |   2 +-
 arch/arm/mach-omap1/irq.c                          |   2 +-
 arch/arm/mach-s3c/irq-s3c24xx.c                    |   2 +-
 arch/arm64/Kconfig                                 |   1 -
 arch/arm64/Kconfig.platforms                       |   4 -
 arch/arm64/kernel/entry-common.c                   |  52 ++--
 arch/csky/Kconfig                                  |   1 -
 arch/csky/kernel/entry.S                           |   2 +-
 arch/csky/kernel/irq.c                             |   5 -
 arch/h8300/include/asm/irq.h                       |   2 -
 arch/h8300/kernel/irq.c                            |   1 +
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/cavium-octeon/octeon-irq.c               |   5 +-
 arch/mips/kernel/irq.c                             |   8 +-
 arch/mips/kernel/smp-bmips.c                       |   3 +-
 arch/mips/loongson64/smp.c                         |   1 -
 arch/nds32/Kconfig                                 |   1 -
 arch/openrisc/Kconfig                              |   1 -
 arch/openrisc/kernel/entry.S                       |   4 +-
 arch/openrisc/kernel/irq.c                         |   5 -
 arch/riscv/Kconfig                                 |   1 -
 arch/riscv/kernel/entry.S                          |   3 +-
 arch/riscv/kernel/smp.c                            |   9 +-
 drivers/irqchip/Kconfig                            |  25 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-apple-aic.c                    |  20 +-
 drivers/irqchip/irq-armada-370-xp.c                |  13 +-
 drivers/irqchip/irq-aspeed-vic.c                   |   2 +-
 drivers/irqchip/irq-ativic32.c                     |  22 +-
 drivers/irqchip/irq-atmel-aic.c                    |   2 +-
 drivers/irqchip/irq-atmel-aic5.c                   |   2 +-
 drivers/irqchip/irq-bcm2835.c                      |   2 +-
 drivers/irqchip/irq-bcm2836.c                      |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |   6 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |  47 +---
 drivers/irqchip/irq-bcm7120-l2.c                   |  21 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |  16 +-
 drivers/irqchip/irq-clps711x.c                     |   8 +-
 drivers/irqchip/irq-csky-apb-intc.c                |   2 +-
 drivers/irqchip/irq-csky-mpintc.c                  |   4 +-
 drivers/irqchip/irq-davinci-aintc.c                |   2 +-
 drivers/irqchip/irq-davinci-cp-intc.c              |   2 +-
 drivers/irqchip/irq-digicolor.c                    |   2 +-
 drivers/irqchip/irq-dw-apb-ictl.c                  |   2 +-
 drivers/irqchip/irq-ftintc010.c                    |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   4 +-
 drivers/irqchip/irq-gic.c                          |   2 +-
 drivers/irqchip/irq-hip04.c                        |   2 +-
 drivers/irqchip/irq-ixp4xx.c                       |   4 +-
 drivers/irqchip/irq-lpc32xx.c                      |   2 +-
 drivers/irqchip/irq-mchp-eic.c                     | 280 +++++++++++++++++++++
 drivers/irqchip/irq-meson-gpio.c                   |  15 +-
 drivers/irqchip/irq-mips-gic.c                     |  37 ++-
 drivers/irqchip/irq-mmp.c                          |   4 +-
 drivers/irqchip/irq-mvebu-icu.c                    |   4 +-
 drivers/irqchip/irq-mvebu-pic.c                    |   4 +-
 drivers/irqchip/irq-mxs.c                          |   2 +-
 drivers/irqchip/irq-nvic.c                         |  17 +-
 drivers/irqchip/irq-omap-intc.c                    |   2 +-
 drivers/irqchip/irq-or1k-pic.c                     |   2 +-
 drivers/irqchip/irq-orion.c                        |   4 +-
 drivers/irqchip/irq-rda-intc.c                     |   2 +-
 drivers/irqchip/irq-riscv-intc.c                   |   2 +-
 drivers/irqchip/irq-sa11x0.c                       |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   |   4 +-
 drivers/irqchip/irq-sun4i.c                        |   2 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   4 +-
 drivers/irqchip/irq-ts4800.c                       |   4 +-
 drivers/irqchip/irq-versatile-fpga.c               |   2 +-
 drivers/irqchip/irq-vic.c                          |   2 +-
 drivers/irqchip/irq-vt8500.c                       |   2 +-
 drivers/irqchip/irq-wpcm450-aic.c                  |   2 +-
 drivers/irqchip/irq-zevio.c                        |   2 +-
 include/linux/irq.h                                |   6 +-
 include/linux/irqchip.h                            |  20 +-
 include/linux/irqdesc.h                            |   9 +-
 kernel/irq/Kconfig                                 |  10 +-
 kernel/irq/chip.c                                  |   2 +
 kernel/irq/generic-chip.c                          |   3 +
 kernel/irq/handle.c                                |  18 ++
 kernel/irq/irqdesc.c                               |  81 ++----
 92 files changed, 684 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
 create mode 100644 drivers/irqchip/irq-mchp-eic.c
