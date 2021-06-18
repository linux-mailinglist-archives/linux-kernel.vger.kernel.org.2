Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04B3AC1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFREI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFREI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:08:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F89C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:06:47 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q16so7698842qkm.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duXtN+rEIFsT66oIEjyKPQAJGMrxuzB/7Mw9bfLGaW8=;
        b=lcpCNT3yBGtzwQ2knMYNuJz1k3crt5BscLfc2V9SBnPHJEK+djuDlT3kx2+VAsM1Xg
         WPRzZt8j7UWN6gQufFqJePMxGGKX6BKIHYw8RfD1NcpEIF8q8ePQso6CFyJQIUUy4gSn
         vZOpzF5QvO4IpAA4I0fHrvlXL+yAp8pCcsabA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duXtN+rEIFsT66oIEjyKPQAJGMrxuzB/7Mw9bfLGaW8=;
        b=GL+rLzyfrKoYL1o6pYbFPMGU/RFKO4p8uYx0gMGMbtrfxRXlh+lIfiZMUx2+vYJjvf
         eZUYj15fdSAQSCiUr+rNDITDCR4/HgRPXbC5PxN3/zByZR10/tczmtGy2YzNnf6NCBmV
         UdtdU40xqPCWbXxCVKWKC6owa1etmW38oaZEwBW1URy6hCGn8KSvn1ZkrIFtRglE75cB
         sZ1B3VZCx+BuHbraunNEnZLaV3GBgcnMjNAU8ZmV82kr0AyD/ryXlr64yWrKLg6zJoX2
         RL4gLqammXzeskMi5+4RqggkkzQ/NEnJF/M6LqCLTS8rhUXIQe19wHQPcz7S9TErbx7z
         3OoQ==
X-Gm-Message-State: AOAM5319ELF6NHKkH81r3931pMccxKlhduhlmHhEu/PL+cicJtufwSQE
        AdoU6FKQfuDUaPZw2MTvuuCnUqdIEk2DZA==
X-Google-Smtp-Source: ABdhPJwpv7BHyRhaWuLf6s+RAmzwuW22RQxF7vD9nUTDVsaan2eyBi0B69EoIB3PZ4fhonrAZqM/cA==
X-Received: by 2002:a05:620a:12c3:: with SMTP id e3mr844155qkl.163.1623989206103;
        Thu, 17 Jun 2021 21:06:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:ba57:e854:3bf7:f7af])
        by smtp.gmail.com with ESMTPSA id 85sm3236689qko.14.2021.06.17.21.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 21:06:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Josh Don <joshdon@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, rostedt@goodmis.org
Subject: [RFC] schedutil: Fix iowait boost issues for slow I/O devices
Date:   Fri, 18 Jun 2021 00:06:39 -0400
Message-Id: <20210618040639.3113489-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iowait boost code is currently broken. Following are the issues and
possible solitions:

Issue #1: If a CPU requests iowait boost in a cluster, another CPU can
go ahead and decay it very quickly if it thinks there's no new request
for the iowait boosting CPU in the meanwhile. To fix this, track when
the iowait boost was last applied to a policy.  This happens when
should_update_freq() returns true. I have made the code wait for at
least 10 ticks between 2 different iowait_boost_apply() for any decay to
happen, and made it configurable via sysctl.

Issue #2: If the iowait is longer than a tick, then successive iowait
boost doubling does not happen. So I/O waiting tasks for slow devices
never gets a boost. This is much worse if the tick rate is high since we
use ticks to measure if no new I/O completion happened. To workaround
this, be liberal about how many ticks should elapse before resetting the
boost. I have chosen a conservative number of 20, and made it
configurable via sysctl.

Tested on a 6+2 ARM64 device, running dd:
dd if=zeros of=/dev/null bs=1M count=64 iflag=direct
Throughput improves from 180MB/s to 200MB/s (~5 percent).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
NOTE: This RFC patch is for discussion of the issues and I am posting for
comments. Beata and Vince are also working on an alternate solution.

 include/linux/sched/sysctl.h     |  3 +++
 kernel/sched/core.c              |  3 +++
 kernel/sched/cpufreq_schedutil.c | 22 +++++++++++++++++++---
 kernel/sched/sched.h             |  3 +++
 kernel/sysctl.c                  | 14 ++++++++++++++
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index db2c0f34aaaf..03ac66b45406 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -53,6 +53,9 @@ extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
 #endif
 
+extern unsigned int sysctl_iowait_reset_ticks;
+extern unsigned int sysctl_iowait_apply_ticks;
+
 /*
  *  control realtime throttling:
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index adea0b1e8036..e44985fb6a93 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -76,6 +76,9 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  */
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 
+unsigned int sysctl_iowait_reset_ticks = 20;
+unsigned int sysctl_iowait_apply_ticks = 10;
+
 /*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4f09afd2f321..4e4e1b0aec6c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -27,6 +27,7 @@ struct sugov_policy {
 	struct list_head	tunables_hook;
 
 	raw_spinlock_t		update_lock;
+	u64			last_update;
 	u64			last_freq_update_time;
 	s64			freq_update_delay_ns;
 	unsigned int		next_freq;
@@ -186,9 +187,13 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 			       bool set_iowait_boost)
 {
 	s64 delta_ns = time - sg_cpu->last_update;
+	unsigned int ticks = TICK_NSEC;
+
+	if (sysctl_iowait_reset_ticks)
+		ticks = sysctl_iowait_reset_ticks * TICK_NSEC;
 
-	/* Reset boost only if a tick has elapsed since last request */
-	if (delta_ns <= TICK_NSEC)
+	/* Reset boost only if enough ticks has elapsed since last request. */
+	if (delta_ns <= ticks)
 		return false;
 
 	sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
@@ -260,6 +265,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  */
 static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long boost;
 
 	/* No boost currently required */
@@ -270,7 +276,9 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 	if (sugov_iowait_reset(sg_cpu, time, false))
 		return;
 
-	if (!sg_cpu->iowait_boost_pending) {
+	if (!sg_cpu->iowait_boost_pending &&
+	    (!sysctl_iowait_apply_ticks ||
+	     (time - sg_policy->last_update > (sysctl_iowait_apply_ticks * TICK_NSEC)))) {
 		/*
 		 * No boost pending; reduce the boost value.
 		 */
@@ -449,6 +457,14 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 		if (!sugov_update_next_freq(sg_policy, time, next_f))
 			goto unlock;
 
+		/*
+		 * Required for ensuring iowait decay does not happen too
+		 * quickly.  This can happen, for example, if a neighboring CPU
+		 * does a cpufreq update immediately after a CPU that just
+		 * completed I/O.
+		 */
+		sg_policy->last_update = time;
+
 		if (sg_policy->policy->fast_switch_enabled)
 			cpufreq_driver_fast_switch(sg_policy->policy, next_f);
 		else
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8f0194cee0ba..2b9c6d5091f7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2381,6 +2381,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
+extern unsigned int sysctl_iowait_reset_ticks;
+extern unsigned int sysctl_iowait_apply_ticks;
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0afbfc83157a..83f9c5223ba4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1717,6 +1717,20 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "iowait_reset_ticks",
+		.data		= &sysctl_iowait_reset_ticks,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "iowait_apply_ticks",
+		.data		= &sysctl_iowait_apply_ticks,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.32.0.288.g62a8d224e6-goog

