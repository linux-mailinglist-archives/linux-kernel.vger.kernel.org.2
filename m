Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6809D36E2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 03:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhD2BbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 21:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhD2BbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:31:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DC5561186;
        Thu, 29 Apr 2021 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619659838;
        bh=QP97WTdpxwxqrkG45S7BAe+wssR1FZYqp8iNHHVYn4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwxejnA9vXw/IXiKecQw7AVLVHsHnv5NovWBIHIRRdLCJrv/LOIRw8B/E4NlE2VlL
         bsc5OKtNiad0rxGcMplMD6iT57/K3MFKHkHv3ZU1WNV4Ltd9LzAroC/Alfa8pT4pd4
         4ZZ03mpeE8sFy6JKlfWIzZxQrtQuaii7oUSABitxdIxob5fYQkwTcVX3iyf1lL0T71
         rsz2XgfDtIxaJzRSpzUWSkcZU/nHRPc1Cf9xRUzXWaa7HX4EHyeUr8uWz1TNfXOhDE
         jUbLGiqEWkOKf4qarMdt44ObGNUgWlrgiXSqWgJi8XvfDGR3ymaJ/0WVdGMDvwWYZh
         frgjTni/AOBDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 18DC15C0571; Wed, 28 Apr 2021 18:30:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v11 clocksource 4/6] clocksource: Provide a module parameter to fuzz per-CPU clock checking
Date:   Wed, 28 Apr 2021 18:30:35 -0700
Message-Id: <20210429013037.3958717-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
References: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code that checks for clock desynchronization must itself be tested, so
create a new clocksource.inject_delay_shift_percpu= kernel boot parameter
that adds or subtracts a large value from the check read, using the
specified bit of the CPU ID to determine whether to add or to subtract.

Link: https://lore.kernel.org/lkml/20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210420064934.GE31773@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Apply Randy Dunlap feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++++++++
 kernel/time/clocksource.c                       | 10 +++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index eb40e5332236..babcc9e80fba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -604,6 +604,22 @@
 			from, and complained about, and to larger values
 			to force the clock to be marked unstable.
 
+	clocksource.inject_delay_shift_percpu= [KNL]
+			Clocksource delay injection partitions the CPUs
+			into two sets, one whose clocks are moved ahead
+			and the other whose clocks are moved behind.
+			This kernel parameter selects the CPU-number
+			bit that determines which of these two sets the
+			corresponding CPU is placed into.  For example,
+			setting this parameter to the value 4 will result
+			in the first set containing alternating groups
+			of 16 CPUs whose clocks are moved ahead, while
+			the second set will contain the rest of the CPUs,
+			whose clocks are moved behind.
+
+			The default value of -1 disables this type of
+			error injection.
+
 	clocksource.max_read_retries= [KNL]
 			Number of clocksource_watchdog() retries due to
 			external delays before the clock will be marked
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a8d73e1f9431..584433448226 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -196,6 +196,8 @@ static ulong inject_delay_period;
 module_param(inject_delay_period, ulong, 0644);
 static ulong inject_delay_repeat = 1;
 module_param(inject_delay_repeat, ulong, 0644);
+static int inject_delay_shift_percpu = -1;
+module_param(inject_delay_shift_percpu, int, 0644);
 static ulong max_read_retries = 3;
 module_param(max_read_retries, ulong, 0644);
 
@@ -252,8 +254,14 @@ static cpumask_t cpus_behind;
 static void clocksource_verify_one_cpu(void *csin)
 {
 	struct clocksource *cs = (struct clocksource *)csin;
+	s64 delta = 0;
+	int sign;
 
-	csnow_mid = cs->read(cs);
+	if (inject_delay_shift_percpu >= 0) {
+		sign = ((smp_processor_id() >> inject_delay_shift_percpu) & 0x1) * 2 - 1;
+		delta = sign * NSEC_PER_SEC;
+	}
+	csnow_mid = cs->read(cs) + delta;
 }
 
 static void clocksource_verify_percpu(struct clocksource *cs)
-- 
2.31.1.189.g2e36527f23

