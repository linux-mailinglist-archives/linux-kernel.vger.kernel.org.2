Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121F24280F8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhJJL6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231556AbhJJL6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:58:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B5560F43;
        Sun, 10 Oct 2021 11:56:50 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mZXEY-00FqFc-1F; Sun, 10 Oct 2021 12:43:14 +0100
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
Subject: [PATCH v3 10/17] clocksource/arm_arch_timer: Remove any trace of the TVAL programming interface
Date:   Sun, 10 Oct 2021 12:42:59 +0100
Message-Id: <20211010114306.2910453-11-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010114306.2910453-1-maz@kernel.org>
References: <20211010114306.2910453-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, will@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVAL usage is now long gone, get rid of the leftovers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 8 --------
 include/clocksource/arm_arch_timer.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ef3f83865dcd..6e20bc12dc35 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -48,10 +48,8 @@
 #define CNTPCT_LO	0x08
 #define CNTFRQ		0x10
 #define CNTP_CVAL_LO	0x20
-#define CNTP_TVAL	0x28
 #define CNTP_CTL	0x2c
 #define CNTV_CVAL_LO	0x30
-#define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
 static unsigned arch_timers_present __initdata;
@@ -111,9 +109,6 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 		case ARCH_TIMER_REG_CTRL:
 			writel_relaxed((u32)val, timer->base + CNTP_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
-			break;
 		case ARCH_TIMER_REG_CVAL:
 			/*
 			 * Not guaranteed to be atomic, so the timer
@@ -130,9 +125,6 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 		case ARCH_TIMER_REG_CTRL:
 			writel_relaxed((u32)val, timer->base + CNTV_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
-			break;
 		case ARCH_TIMER_REG_CVAL:
 			/* Same restriction as above */
 			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index d59537afb29d..e715bdb720d5 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -24,7 +24,6 @@
 
 enum arch_timer_reg {
 	ARCH_TIMER_REG_CTRL,
-	ARCH_TIMER_REG_TVAL,
 	ARCH_TIMER_REG_CVAL,
 };
 
-- 
2.30.2

