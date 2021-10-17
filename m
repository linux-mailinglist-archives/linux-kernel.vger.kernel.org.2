Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D60430908
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbhJQMpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237716AbhJQMpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:45:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E466661245;
        Sun, 17 Oct 2021 12:42:50 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V3-00HKfO-61; Sun, 17 Oct 2021 13:42:49 +0100
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
Subject: [PATCH v4 05/17] clocksource/arm_arch_timer: Move drop _tval from erratum function names
Date:   Sun, 17 Oct 2021 13:42:13 +0100
Message-Id: <20211017124225.3018098-6-maz@kernel.org>
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

The '_tval' name in the erratum handling function names doesn't
make much sense anymore (and they were using CVAL the first place).

Drop the _tval tag.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 322165468edf..8afe8c814eba 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -369,7 +369,7 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
 static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
 
-static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
+static void erratum_set_next_event_generic(const int access, unsigned long evt,
 						struct clock_event_device *clk)
 {
 	unsigned long ctrl;
@@ -390,17 +390,17 @@ static void erratum_set_next_event_tval_generic(const int access, unsigned long
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-static __maybe_unused int erratum_set_next_event_tval_virt(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
 					    struct clock_event_device *clk)
 {
-	erratum_set_next_event_tval_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
 
-static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_phys(unsigned long evt,
 					    struct clock_event_device *clk)
 {
-	erratum_set_next_event_tval_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
 
@@ -412,8 +412,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "Freescale erratum a005858",
 		.read_cntpct_el0 = fsl_a008585_read_cntpct_el0,
 		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_HISILICON_ERRATUM_161010101
@@ -423,8 +423,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "HiSilicon erratum 161010101",
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 	{
 		.match_type = ate_match_acpi_oem_info,
@@ -432,8 +432,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "HiSilicon erratum 161010101",
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
@@ -452,8 +452,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "Allwinner erratum UNKNOWN1",
 		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
 		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1418040
-- 
2.30.2

