Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7635EBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhDNEgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhDNEgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78AF8613C0;
        Wed, 14 Apr 2021 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618374964;
        bh=lmIa+uruV+lO0EpeY/wT19dAGKFnDAl6LwPO/0okFrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNVjWznm3LV7GtEaltJuzbQDrICKTqAp8e7DNOFNtwh4V/pcDIYVOhwBgEHJhdHyA
         WLmq76gdGmUdsMyVtnHDDC6qDK4aEKjnlJ6cgALD/P/SnOkIeqcX2hR73tKtXsMfTD
         3dsHsPdmiC5oduC0T4Dr9GcON6EQZ3PMdCRZ806W2OhTjLpag/v9HbCXFFDn7qCpBe
         eMHEMAx6c4QR7TPvfyTXquQ8aGbgwUrSo6ZjPkqD8RGSc9m35VwCaMD7jEYvfv+wEz
         VeorR6nOJ8tyTh00WkNNQSaP52micNXQaENLiamD6CWtobjZHCMIAzOEGbgd4DqUHI
         8RWPETzscQASg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D0925C26C5; Tue, 13 Apr 2021 21:36:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v8 clocksource 4/5] clocksource: Provide a module parameter to fuzz per-CPU clock checking
Date:   Tue, 13 Apr 2021 21:36:01 -0700
Message-Id: <20210414043602.2812981-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code that checks for clock desynchronization must itself be tested, so
create a new clocksource.inject_delay_shift_percpu= kernel boot parameter
that adds or subtracts a large value from the check read, using the
specified bit of the CPU ID to determine whether to add or to subtract.

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
index fc57952dcba0..f9da90f2791f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -599,6 +599,22 @@
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
index 69311deab428..5f641b15ec6c 100644
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
 
@@ -218,8 +220,14 @@ static cpumask_t cpus_behind;
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
2.25.1

