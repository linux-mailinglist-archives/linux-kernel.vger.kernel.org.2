Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA224280FF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhJJL7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbhJJL7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:59:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F65F60555;
        Sun, 10 Oct 2021 11:57:04 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mZXEZ-00FqFc-9x; Sun, 10 Oct 2021 12:43:15 +0100
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
Subject: [PATCH v3 13/17] clocksource/arch_arm_timer: Move workaround synchronisation around
Date:   Sun, 10 Oct 2021 12:43:02 +0100
Message-Id: <20211010114306.2910453-14-maz@kernel.org>
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

We currently handle synchronisation when workarounds are enabled
by having an ISB in the __arch_counter_get_cnt?ct_stable() helpers.

WHile this works, this prevents us from relaxing this synchronisation.

Instead, move it closer to the point where the synchronisation is
actually needed. Further patches will subsequently relax this.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arch_timer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index b8000ef71a2c..519ac1f7f859 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -32,7 +32,7 @@
 	({								\
 		const struct arch_timer_erratum_workaround *__wa;	\
 		__wa = __this_cpu_read(timer_unstable_counter_workaround); \
-		(__wa && __wa->h) ? __wa->h : arch_timer_##h;		\
+		(__wa && __wa->h) ? ({ isb(); __wa->h;}) : arch_timer_##h; \
 	})
 
 #else
@@ -64,11 +64,13 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 
 static inline notrace u64 arch_timer_read_cntpct_el0(void)
 {
+	isb();
 	return read_sysreg(cntpct_el0);
 }
 
 static inline notrace u64 arch_timer_read_cntvct_el0(void)
 {
+	isb();
 	return read_sysreg(cntvct_el0);
 }
 
@@ -163,7 +165,6 @@ static __always_inline u64 __arch_counter_get_cntpct_stable(void)
 {
 	u64 cnt;
 
-	isb();
 	cnt = arch_timer_reg_read_stable(cntpct_el0);
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
@@ -183,7 +184,6 @@ static __always_inline u64 __arch_counter_get_cntvct_stable(void)
 {
 	u64 cnt;
 
-	isb();
 	cnt = arch_timer_reg_read_stable(cntvct_el0);
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
-- 
2.30.2

