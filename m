Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60B363AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhDSEyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhDSExm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:53:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E259161151;
        Mon, 19 Apr 2021 04:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618807981;
        bh=je6c556KilReBKLpC1E7UuomazAk6Zb8d6A/VdOT8Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpnM97qpaKlP/q3AvjRa3kwrKYRegAbHSGl05brXFaCscd33ciXW7UFNo3s87v2Q2
         JPkXc/tSJyyg9j/noOyH8QGhbSFCwJFDKrVDLSLl5YDfEMyEE3v1DaKQYKKSI3psdJ
         zH2bG5yASEmH9kPWgj3OV9bD6GMHlQRLdRKr5ZG9h0HMHeZqyGstNSr7d1SgMTGJap
         BUkFHwiBoCS43uJu8TUlEbsIV35Xz856dgPLmuHNMImKncQHAUqqk7129fiEHjA0Y3
         E7Co/LevOTzSY5WiCMwuyVOK8AL7l4EejqAanPDHmnVkC59rXHYaHf+HtmVxCrrja8
         jeEzXb3brrHtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E5885C0170; Sun, 18 Apr 2021 21:53:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v9 clocksource 4/6] clocksource: Provide a module parameter to fuzz per-CPU clock checking
Date:   Sun, 18 Apr 2021 21:52:58 -0700
Message-Id: <20210419045300.596332-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1>
References: <20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1>
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
index 7fff95bd5504..03a8c88a6bb9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -599,6 +599,22 @@
 			will be five delay-free reads followed by three
 			delayed reads.
 
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
index ee33f14be44d..edcff9fc3f44 100644
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

