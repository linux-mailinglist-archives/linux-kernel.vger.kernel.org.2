Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926B74369F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhJUSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:05:14 -0400
Received: from foss.arm.com ([217.140.110.172]:45846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232404AbhJUSFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A89BE1474;
        Thu, 21 Oct 2021 11:02:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C93A13F70D;
        Thu, 21 Oct 2021 11:02:49 -0700 (PDT)
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
Subject: [PATCH 02/15] irq: mips: stop (ab)using handle_domain_irq()
Date:   Thu, 21 Oct 2021 19:02:23 +0100
Message-Id: <20211021180236.37428-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MIPS, the only user of handle_domain_irq() is octeon_irq_ciu3_ip2(),
which is called from the platform-specific plat_irq_dispatch() function
invoked from the early assembly code.

No other irqchip relevant to arch/mips uses handle_domain_irq():

* No other plat_irq_dispatch() function transitively calls
  handle_domain_irq().

* No other vectored IRQ dispatch function registered with
  set_vi_handler() calls handle_domain_irq().

* No chained irqchip handlers call handle_domain_irq(), which makes
  sense as this is meant to only be used by root irqchip handlers.

Currently octeon_irq_ciu3_ip2() passes NULL as the `regs` argument to
handle_domain_irq(), and as handle_domain_irq() will pass this to
set_irq_regs(), any invoked IRQ handlers will erroneously see a NULL
pt_regs if they call get_pt_regs().

Fix this by calling generic_handle_domain_irq() directly, and performing
the necessary irq_{enter,exit}() logic directly in
octeon_irq_ciu3_ip2(). At the same time, deselect HANDLE_DOMAIN_IRQ,
which subsequent patches will remove.

Other than the corrected behaviour of get_pt_regs(), there should be no
functional change as a result of this patch.

Fixes: ce210d35bb93c2c5 ("MIPS: OCTEON: Add support for OCTEON III interrupt controller.")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig                    | 1 -
 arch/mips/cavium-octeon/octeon-irq.c | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 771ca53af06d..7b004c5bd796 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -47,7 +47,6 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
-	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB if MIPS_FP_SUPPORT
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index be5d4afcd30f..844f882096e6 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2609,7 +2609,10 @@ static void octeon_irq_ciu3_ip2(void)
 		else
 			hw = intsn;
 
-		ret = handle_domain_irq(domain, hw, NULL);
+		irq_enter();
+		ret = generic_handle_domain_irq(domain, hw);
+		irq_exit();
+
 		if (ret < 0) {
 			union cvmx_ciu3_iscx_w1c isc_w1c;
 			u64 isc_w1c_addr = ciu3_addr + CIU3_ISC_W1C(intsn);
-- 
2.11.0

