Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB443091C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbhJQMtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343511AbhJQMsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:48:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5031F60F48;
        Sun, 17 Oct 2021 12:46:44 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V5-00HKfO-64; Sun, 17 Oct 2021 13:42:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v4 11/17] clocksource/arm_arch_timer: Drop unnecessary ISB on CVAL programming
Date:   Sun, 17 Oct 2021 13:42:19 +0100
Message-Id: <20211017124225.3018098-12-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211017124225.3018098-1-maz@kernel.org>
References: <20211017124225.3018098-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching from TVAL to CVAL has a small drawback: we need an ISB
before reading the counter. We cannot get rid of it, but we can
instead remove the one that comes just after writing to CVAL.

This reduces the number of ISBs from 3 to 2 when programming
the timer.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_timer.h   | 4 ++--
 arch/arm64/include/asm/arch_timer.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 9f4b895b78f7..bb129b6d2366 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -31,6 +31,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			asm volatile("mcrr p15, 2, %Q0, %R0, c14" : : "r" (val));
@@ -42,6 +43,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
@@ -52,8 +54,6 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 	} else {
 		BUILD_BUG();
 	}
-
-	isb();
 }
 
 static __always_inline
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 4f4aa13dd01e..b8000ef71a2c 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -95,6 +95,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntp_ctl_el0);
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			write_sysreg(val, cntp_cval_el0);
@@ -106,6 +107,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntv_ctl_el0);
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			write_sysreg(val, cntv_cval_el0);
@@ -116,8 +118,6 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 	} else {
 		BUILD_BUG();
 	}
-
-	isb();
 }
 
 static __always_inline
-- 
2.30.2

