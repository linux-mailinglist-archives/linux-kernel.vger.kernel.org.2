Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C5B34A5C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhCZKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCZKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:44:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71FC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dcbCdE0Hq0mX5p38u6fxhHW9hRIGBNQkPq8T5FZFWH8=; b=dPumBKgaTVb+Teky0iyqh9ZNWy
        RiO9P21jIL/u4NlFr5aVECDWrPmWEBnU4UY7c0NQsXR/R0v/pIGQEJIXViCoAT9Vx/d15vwKIuR4n
        iIZmkjmufzneoz94sLt4im4KTeZ82nqjjWLdyecOITPqKNAKNuylfCBJiU1Y9VhqksvTynQ/MhpAY
        3LxUJWoxlPkFveJpfHiD2PV5nWOXNNXqFYRkDMXaUDBRrlClzCJzVVSa5A075p17CrCK2Gmj3+qXd
        WT4G75dgdlODaQ4nZqH8UufS6CaE1kNChDSkehmp/ubHVt3xUMRoyHmM3WCMrR8QdfKk9v8fD17k0
        rNHd+fHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvF-00EgYR-FX; Fri, 26 Mar 2021 10:42:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB6B8306099;
        Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A40CE2BCA7ED0; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103934.780486173@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 1/9] sched/numa: Allow runtime enabling/disabling of NUMA balance without SCHED_DEBUG
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mgorman@suse.de>

The ability to enable/disable NUMA balancing is not a debugging feature
and should not depend on CONFIG_SCHED_DEBUG.  For example, machines within
a HPC cluster may disable NUMA balancing temporarily for some jobs and
re-enable it for other jobs without needing to reboot.

This patch removes the dependency on CONFIG_SCHED_DEBUG for
kernel.numa_balancing sysctl. The other numa balancing related sysctls
are left as-is because if they need to be tuned then it is more likely
that NUMA balancing needs to be fixed instead.

Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210324133916.GQ15768@suse.de
---
 kernel/sysctl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1753,6 +1753,9 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+#endif /* CONFIG_NUMA_BALANCING */
+#endif /* CONFIG_SCHED_DEBUG */
+#ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing",
 		.data		= NULL, /* filled in by handler */
@@ -1763,7 +1766,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
 		.data		= &sysctl_sched_rt_period,


