Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F963E48D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhHIP1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235757AbhHIP1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:27:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA3661076;
        Mon,  9 Aug 2021 15:26:58 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD7B3-003qjI-A0; Mon, 09 Aug 2021 16:26:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH 05/13] clocksource/arm_arch_timer: Fix MMIO base address vs callback ordering issue
Date:   Mon,  9 Aug 2021 16:26:43 +0100
Message-Id: <20210809152651.2297337-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809152651.2297337-1-maz@kernel.org>
References: <20210809152651.2297337-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, will@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMIO timer base address gets published after we have registered
the callbacks and the interrupt handler, which is... a bit dangerous.

Fix this by moving the base address publication to the point where
we register the timer, and expose a pointer to the timer structure
itself rather than a naked value.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 160464f75017..ca7761d8459a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -54,13 +54,13 @@
 
 static unsigned arch_timers_present __initdata;
 
-static void __iomem *arch_counter_base __ro_after_init;
-
 struct arch_timer {
 	void __iomem *base;
 	struct clock_event_device evt;
 };
 
+static struct arch_timer *arch_timer_mem __ro_after_init;
+
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate __ro_after_init;
@@ -975,9 +975,9 @@ static u64 arch_counter_get_cntvct_mem(void)
 	u32 vct_lo, vct_hi, tmp_hi;
 
 	do {
-		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
-		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
-		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
+		vct_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
+		vct_lo = readl_relaxed(arch_timer_mem->base + CNTVCT_LO);
+		tmp_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
 	} while (vct_hi != tmp_hi);
 
 	return ((u64) vct_hi << 32) | vct_lo;
@@ -1168,25 +1168,25 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 {
 	int ret;
 	irq_handler_t func;
-	struct arch_timer *t;
 
-	t = kzalloc(sizeof(*t), GFP_KERNEL);
-	if (!t)
+	arch_timer_mem = kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
+	if (!arch_timer_mem)
 		return -ENOMEM;
 
-	t->base = base;
-	t->evt.irq = irq;
-	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
+	arch_timer_mem->base = base;
+	arch_timer_mem->evt.irq = irq;
+	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
 
 	if (arch_timer_mem_use_virtual)
 		func = arch_timer_handler_virt_mem;
 	else
 		func = arch_timer_handler_phys_mem;
 
-	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
+	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_mem->evt);
 	if (ret) {
 		pr_err("Failed to request mem timer irq\n");
-		kfree(t);
+		kfree(arch_timer_mem);
+		arch_timer_mem = NULL;
 	}
 
 	return ret;
@@ -1444,7 +1444,6 @@ arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
 		return ret;
 	}
 
-	arch_counter_base = base;
 	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
 
 	return 0;
-- 
2.30.2

