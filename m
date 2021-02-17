Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E7231E161
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhBQVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhBQVaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:30:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD9A464EB4;
        Wed, 17 Feb 2021 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613597365;
        bh=SmIYgmsUQG0n/vxAVS2m4pDj/rA3t7iUn7rbmbpTHZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnZBTM08LWvgZ/V3UYGCzqTMLH1ozy+2b96UDkl86740Ts39ocvMFbqPUzayqY4Gb
         QSb7ebHoX63ZH8q186OmZpcOf+ZrF78Jl63QQDk5TV93PqgzQhNwPRmfcSf55aLBjT
         b1vj2AgW1SUVSwM2+27dQym/AVU+SzM9PkQfdYDjnk6Iei5nrEaVEJVHmICBEg2OGW
         zhoBT5gleeP/NfokMwEIwqn8Br5ZUJlwdJhem+Ugli0V3KBh8/gtQAEU5G/vdR8zDK
         +1+QaYZgrFrpkvfIDbtopfk3qFQtxbUV4T9Kw9ev/9/WcAd0MdWpHPPPBTaeYhn16j
         7NiWr5Zggo8UQ==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, ak@linux.intel.com, clm@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH clocksource 4/5] clocksource: Provide a module parameter to fuzz per-CPU clock checking
Date:   Wed, 17 Feb 2021 13:29:22 -0800
Message-Id: <20210217212923.21418-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210217212814.GA14952@paulmck-ThinkPad-P72>
References: <20210217212814.GA14952@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Code that checks for clock desynchronization must itself be tested, so
this commit creates a new clocksource.inject_delay_shift_percpu= kernel
boot parameter that adds or subtracts a large value from the check read,
using the specified bit of the CPU ID to determine whether to add or
to subtract.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Apply Randy Dunlap feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++++++++
 kernel/time/clocksource.c                       | 10 +++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9965266..628e87f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -593,6 +593,22 @@
 			times the value specified for inject_delay_freq
 			of consecutive non-delays.
 
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
index 663bc53..df48416 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -190,6 +190,8 @@ static int inject_delay_freq;
 module_param(inject_delay_freq, int, 0644);
 static int inject_delay_run = 1;
 module_param(inject_delay_run, int, 0644);
+static int inject_delay_shift_percpu = -1;
+module_param(inject_delay_shift_percpu, int, 0644);
 static int max_read_retries = 3;
 module_param(max_read_retries, int, 0644);
 
@@ -219,8 +221,14 @@ static cpumask_t cpus_behind;
 static void clocksource_verify_one_cpu(void *csin)
 {
 	struct clocksource *cs = (struct clocksource *)csin;
+	s64 delta = 0;
+	int sign;
 
-	__this_cpu_write(csnow_mid, cs->read(cs));
+	if (inject_delay_shift_percpu >= 0) {
+		sign = ((smp_processor_id() >> inject_delay_shift_percpu) & 0x1) * 2 - 1;
+		delta = sign * NSEC_PER_SEC;
+	}
+	__this_cpu_write(csnow_mid, cs->read(cs) + delta);
 }
 
 static void clocksource_verify_percpu_wq(struct work_struct *unused)
-- 
2.9.5

