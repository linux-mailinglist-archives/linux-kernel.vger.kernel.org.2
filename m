Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469F44369F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhJUSFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:05:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhJUSFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616EAED1;
        Thu, 21 Oct 2021 11:02:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 819423F70D;
        Thu, 21 Oct 2021 11:02:41 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paulmck@kernel.org, paul.walmsley@sifive.com,
        peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: [PATCH 00/15] irq: remove handle_domain_{irq,nmi}()
Date:   Thu, 21 Oct 2021 19:02:21 +0100
Message-Id: <20211021180236.37428-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handle_domain_{irq,nmi}() functions were oringally intended as a
convenience, but recent rework to entry code across the kernel tree has
demonstrated that they cause more pain than they're worth and prevent
architectures from being able to write robust entry code.

This series reworks the irq code to remove them, handling the necessary
entry work consistently in entry code (be it architectural or generic).

The gory details are in the thread starting at:

  https://lore.kernel.org/r/20211011104729.GB1421@C02TD0UTHF1T.local

... which can be summarized as:

* At entry time, entry code needs to poke lockdep, RCU, and irqflag
  tracing in a specific order due to interdependencies, before most
  other C code can run. Part of this involves calling rcu_irq_enter().

  Currently, arm64 is the only architecture which uses
  handle_domain_irq() and performs the nominally correct sequence
  (which is aligned with the generic entry code we aim to move to in
  future).

* RCU relies on rcu_irq_enter() being called precisely once per IRQ
  exception, or rcu_is_cpu_rrupt_from_idle() may fail to identify
  wakeups from idle, and RCU may not trigger a reschedule when
  necessary, leading to RCU stalls.

* The handle_domain_irq() helper, which is called from irqchip code
  between the entry code and interrupt handlers, calls rcu_irq_enter(), 
  consequently causing problems for RCU on arm64.

In the thread Linus decreed:

  I really think that if the rule is "we can't do accounting in
  handle_domain_irq(), because it's too late for arm64", then the fix
  really should be to just not do that.

  Move the irq_enter()/irq_exit() to the callers - quite possibly far up
  the call chain to the root of it all, and just say "architecture code
  needs to do this in the low-level code before calling
  handle_arch_irq".

This series does so, making entry code responsible for the IRQ entry
work, and removing the handle_domain_{irq,nmi}() functions entirely so
we're not tempted to reintroduce similar problems in future.

The rework fixes a couple of latent bugs for MIPS, fixes the problem
originally diagnosed for arm64, and should make it easier for the other
architectures using handle_domain_irq() to move to nominally correct
entry sequencing (e.g. by moving to the generic entry code).

I've added a couple of checks to generic_handle_irq() and
generic_handle_domain_irq() to verify that architectures are correctly
performing the required entry work (which fingers crossed, shouldn't
fire). Other than the above, there should be no functional change as
result of these changes (except that previously erroneous usage of RCU
in irqchip code will have become correct by virtue of RCU starting to
watch earlier).

I've given the series some light build and boot testing so far.

Thanks,
Mark.

Mark Rutland (15):
  irq: mips: avoid nested irq_enter()
  irq: mips: stop (ab)using handle_domain_irq()
  irq: mips: simplify do_domain_IRQ()
  irq: simplify handle_domain_{irq,nmi}()
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

 Documentation/core-api/irq/irq-domain.rst |  3 --
 arch/arc/Kconfig                          |  1 -
 arch/arc/kernel/irq.c                     | 10 +++-
 arch/arm/Kconfig                          |  1 -
 arch/arm/kernel/entry-armv.S              |  5 +-
 arch/arm/kernel/irq.c                     | 14 +++---
 arch/arm/mach-imx/avic.c                  |  2 +-
 arch/arm/mach-imx/tzic.c                  |  2 +-
 arch/arm/mach-omap1/irq.c                 |  2 +-
 arch/arm/mach-s3c/irq-s3c24xx.c           |  2 +-
 arch/arm64/Kconfig                        |  1 -
 arch/arm64/kernel/entry-common.c          | 52 ++++++++++++--------
 arch/csky/Kconfig                         |  1 -
 arch/csky/kernel/entry.S                  |  2 +-
 arch/csky/kernel/irq.c                    |  5 --
 arch/mips/Kconfig                         |  1 -
 arch/mips/cavium-octeon/octeon-irq.c      |  5 +-
 arch/mips/kernel/irq.c                    |  6 +--
 arch/nds32/Kconfig                        |  1 -
 arch/openrisc/Kconfig                     |  1 -
 arch/openrisc/kernel/entry.S              |  4 +-
 arch/openrisc/kernel/irq.c                |  5 --
 arch/riscv/Kconfig                        |  1 -
 arch/riscv/kernel/entry.S                 |  3 +-
 arch/riscv/kernel/smp.c                   |  9 +---
 drivers/irqchip/irq-apple-aic.c           | 20 ++++----
 drivers/irqchip/irq-armada-370-xp.c       | 13 ++---
 drivers/irqchip/irq-aspeed-vic.c          |  2 +-
 drivers/irqchip/irq-ativic32.c            | 22 ++++++++-
 drivers/irqchip/irq-atmel-aic.c           |  2 +-
 drivers/irqchip/irq-atmel-aic5.c          |  2 +-
 drivers/irqchip/irq-bcm2835.c             |  2 +-
 drivers/irqchip/irq-bcm2836.c             |  2 +-
 drivers/irqchip/irq-bcm6345-l1.c          |  2 +-
 drivers/irqchip/irq-clps711x.c            |  8 +--
 drivers/irqchip/irq-csky-apb-intc.c       |  2 +-
 drivers/irqchip/irq-csky-mpintc.c         |  4 +-
 drivers/irqchip/irq-davinci-aintc.c       |  2 +-
 drivers/irqchip/irq-davinci-cp-intc.c     |  2 +-
 drivers/irqchip/irq-digicolor.c           |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c         |  2 +-
 drivers/irqchip/irq-ftintc010.c           |  2 +-
 drivers/irqchip/irq-gic-v3.c              |  4 +-
 drivers/irqchip/irq-gic.c                 |  2 +-
 drivers/irqchip/irq-hip04.c               |  2 +-
 drivers/irqchip/irq-ixp4xx.c              |  4 +-
 drivers/irqchip/irq-lpc32xx.c             |  2 +-
 drivers/irqchip/irq-mmp.c                 |  4 +-
 drivers/irqchip/irq-mxs.c                 |  2 +-
 drivers/irqchip/irq-nvic.c                | 19 +++++++-
 drivers/irqchip/irq-omap-intc.c           |  2 +-
 drivers/irqchip/irq-or1k-pic.c            |  2 +-
 drivers/irqchip/irq-orion.c               |  4 +-
 drivers/irqchip/irq-rda-intc.c            |  2 +-
 drivers/irqchip/irq-riscv-intc.c          |  2 +-
 drivers/irqchip/irq-sa11x0.c              |  4 +-
 drivers/irqchip/irq-sun4i.c               |  2 +-
 drivers/irqchip/irq-versatile-fpga.c      |  2 +-
 drivers/irqchip/irq-vic.c                 |  2 +-
 drivers/irqchip/irq-vt8500.c              |  2 +-
 drivers/irqchip/irq-wpcm450-aic.c         |  2 +-
 drivers/irqchip/irq-zevio.c               |  2 +-
 include/linux/irqdesc.h                   |  9 +---
 kernel/irq/Kconfig                        |  3 --
 kernel/irq/handle.c                       | 18 +++++++
 kernel/irq/irqdesc.c                      | 81 +++++++------------------------
 66 files changed, 193 insertions(+), 215 deletions(-)

-- 
2.11.0

