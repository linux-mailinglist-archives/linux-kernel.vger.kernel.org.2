Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9F430903
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbhJQMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234891AbhJQMo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:44:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3CA561054;
        Sun, 17 Oct 2021 12:42:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V2-00HKfO-53; Sun, 17 Oct 2021 13:42:48 +0100
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
Subject: [PATCH v4 02/17] clocksource/arm_arch_timer: Drop CNT*_TVAL read accessors
Date:   Sun, 17 Oct 2021 13:42:10 +0100
Message-Id: <20211017124225.3018098-3-maz@kernel.org>
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

The arch timer driver never reads the various TVAL registers, only
writes to them. It is thus pointless to provide accessors
for them and to implement errata workarounds.

Drop these read-side accessors, and add a couple of BUG() statements
for the time being. These statements will be removed further down
the line.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_timer.h    |  6 ----
 arch/arm64/include/asm/arch_timer.h  | 17 -----------
 drivers/clocksource/arm_arch_timer.c | 44 ----------------------------
 3 files changed, 67 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index a5d27cff28fa..7d757085c61a 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -65,9 +65,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
-			break;
 		default:
 			BUILD_BUG();
 		}
@@ -76,9 +73,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=r" (val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=r" (val));
-			break;
 		default:
 			BUILD_BUG();
 		}
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index fa12ea4a9812..8332fcfb08e8 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -52,8 +52,6 @@ struct arch_timer_erratum_workaround {
 	enum arch_timer_erratum_match_type match_type;
 	const void *id;
 	const char *desc;
-	u32 (*read_cntp_tval_el0)(void);
-	u32 (*read_cntv_tval_el0)(void);
 	u64 (*read_cntpct_el0)(void);
 	u64 (*read_cntvct_el0)(void);
 	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
@@ -64,17 +62,6 @@ struct arch_timer_erratum_workaround {
 DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 		timer_unstable_counter_workaround);
 
-/* inline sysreg accessors that make erratum_handler() work */
-static inline notrace u32 arch_timer_read_cntp_tval_el0(void)
-{
-	return read_sysreg(cntp_tval_el0);
-}
-
-static inline notrace u32 arch_timer_read_cntv_tval_el0(void)
-{
-	return read_sysreg(cntv_tval_el0);
-}
-
 static inline notrace u64 arch_timer_read_cntpct_el0(void)
 {
 	return read_sysreg(cntpct_el0);
@@ -140,8 +127,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntp_ctl_el0);
-		case ARCH_TIMER_REG_TVAL:
-			return arch_timer_reg_read_stable(cntp_tval_el0);
 		default:
 			BUILD_BUG();
 		}
@@ -149,8 +134,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntv_ctl_el0);
-		case ARCH_TIMER_REG_TVAL:
-			return arch_timer_reg_read_stable(cntv_tval_el0);
 		default:
 			BUILD_BUG();
 		}
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3b7d46d9db73..67bdc7288f59 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -144,9 +144,6 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_CTRL:
 			val = readl_relaxed(timer->base + CNTP_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			val = readl_relaxed(timer->base + CNTP_TVAL);
-			break;
 		default:
 			BUILD_BUG();
 		}
@@ -156,9 +153,6 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_CTRL:
 			val = readl_relaxed(timer->base + CNTV_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			val = readl_relaxed(timer->base + CNTV_TVAL);
-			break;
 		default:
 			BUILD_BUG();
 		}
@@ -247,16 +241,6 @@ struct ate_acpi_oem_info {
 	_new;						\
 })
 
-static u32 notrace fsl_a008585_read_cntp_tval_el0(void)
-{
-	return __fsl_a008585_read_reg(cntp_tval_el0);
-}
-
-static u32 notrace fsl_a008585_read_cntv_tval_el0(void)
-{
-	return __fsl_a008585_read_reg(cntv_tval_el0);
-}
-
 static u64 notrace fsl_a008585_read_cntpct_el0(void)
 {
 	return __fsl_a008585_read_reg(cntpct_el0);
@@ -293,16 +277,6 @@ static u64 notrace fsl_a008585_read_cntvct_el0(void)
 	_new;							\
 })
 
-static u32 notrace hisi_161010101_read_cntp_tval_el0(void)
-{
-	return __hisi_161010101_read_reg(cntp_tval_el0);
-}
-
-static u32 notrace hisi_161010101_read_cntv_tval_el0(void)
-{
-	return __hisi_161010101_read_reg(cntv_tval_el0);
-}
-
 static u64 notrace hisi_161010101_read_cntpct_el0(void)
 {
 	return __hisi_161010101_read_reg(cntpct_el0);
@@ -387,16 +361,6 @@ static u64 notrace sun50i_a64_read_cntvct_el0(void)
 {
 	return __sun50i_a64_read_reg(cntvct_el0);
 }
-
-static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
-{
-	return read_sysreg(cntp_cval_el0) - sun50i_a64_read_cntpct_el0();
-}
-
-static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
-{
-	return read_sysreg(cntv_cval_el0) - sun50i_a64_read_cntvct_el0();
-}
 #endif
 
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
@@ -446,8 +410,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_dt,
 		.id = "fsl,erratum-a008585",
 		.desc = "Freescale erratum a005858",
-		.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
 		.read_cntpct_el0 = fsl_a008585_read_cntpct_el0,
 		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
@@ -459,8 +421,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_dt,
 		.id = "hisilicon,erratum-161010101",
 		.desc = "HiSilicon erratum 161010101",
-		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
@@ -470,8 +430,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_acpi_oem_info,
 		.id = hisi_161010101_oem_info,
 		.desc = "HiSilicon erratum 161010101",
-		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
@@ -492,8 +450,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_dt,
 		.id = "allwinner,erratum-unknown1",
 		.desc = "Allwinner erratum UNKNOWN1",
-		.read_cntp_tval_el0 = sun50i_a64_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = sun50i_a64_read_cntv_tval_el0,
 		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
 		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
-- 
2.30.2

