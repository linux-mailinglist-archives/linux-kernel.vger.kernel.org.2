Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603433E492A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhHIPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235742AbhHIPsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:48:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D76561056;
        Mon,  9 Aug 2021 15:48:21 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD7B5-003qjI-2h; Mon, 09 Aug 2021 16:26:59 +0100
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
Subject: [PATCH 10/13] clocksource/arm_arch_timer: Drop unnecessary ISB on CVAL programming
Date:   Mon,  9 Aug 2021 16:26:48 +0100
Message-Id: <20210809152651.2297337-11-maz@kernel.org>
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
index f014630259cb..787a98ed0716 100644
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
@@ -40,14 +41,13 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
 			break;
 		}
 	}
-
-	isb();
 }
 
 static __always_inline
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 861cafc4aca5..b2f056db1225 100644
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
@@ -104,14 +105,13 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntv_ctl_el0);
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			write_sysreg(val, cntv_cval_el0);
 			break;
 		}
 	}
-
-	isb();
 }
 
 static __always_inline
-- 
2.30.2

