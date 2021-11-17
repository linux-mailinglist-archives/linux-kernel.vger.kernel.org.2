Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A04545BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhKQLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234500AbhKQLio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:38:44 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C813C61BD3;
        Wed, 17 Nov 2021 11:35:45 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mnJE7-0063nm-Ht; Wed, 17 Nov 2021 11:35:43 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Force inlining of erratum_set_next_event_generic()
Date:   Wed, 17 Nov 2021 11:35:32 +0000
Message-Id: <20211117113532.3895208-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@android.com, gregkh@linuxfoundation.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, samitolvanen@google.com, ndesaulniers@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some specific kernel configuration and Clang, the kernel fails
to like with something like:

ld.lld: error: undefined symbol: __compiletime_assert_200
>>> referenced by arch_timer.h:156 (./arch/arm64/include/asm/arch_timer.h:156)
>>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a

ld.lld: error: undefined symbol: __compiletime_assert_197
>>> referenced by arch_timer.h:133 (./arch/arm64/include/asm/arch_timer.h:133)
>>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a
make: *** [Makefile:1161: vmlinux] Error 1

These are due to the BUILD_BUG() macros contained in the low-level
accessors (arch_timer_reg_{write,read}_cp15) being emitted, as the
access type wasn't known at compile time.

Fix this by making erratum_set_next_event_generic() __force_inline,
resulting in the 'access' parameter to be resolved at compile time,
similarly to what is already done for set_next_event().

Fixes: 4775bc63f880 ("Add build-time guards for unhandled register accesses")
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/clocksource/arm_arch_timer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a04eacc4412..1ecd52f903b8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -394,8 +394,13 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
 static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
 
-static void erratum_set_next_event_generic(const int access, unsigned long evt,
-						struct clock_event_device *clk)
+/*
+ * Force the inlining of this function so that the register accesses
+ * can be themselves correctly inlined.
+ */
+static __always_inline
+void erratum_set_next_event_generic(const int access, unsigned long evt,
+				    struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 	u64 cval;
-- 
2.30.2

