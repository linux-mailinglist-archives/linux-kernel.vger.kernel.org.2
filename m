Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE135C3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbhDLKV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbhDLKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:21:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FEEC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DVr6AdWf0dfcOahv7rHFw+OVePL/754OELAMdtX7rWk=; b=o/mZPLVY7mLh3BEYqyrezTd20T
        rZtxr9SOafGa5oc3pQw+IkkqQ8YcWyxWRE3oD6YdSVdaIh/zWFzBU03HZdffEqPuA/ZLnVrQLmLSg
        0Yi1gjI9Ru7cu3+Zku2pqnPNWmH1T+6QcUmm9c7MfySEhkK35r8HQirmOpRbNo8KDW025U46ERO7T
        bhFXjt+w7ONAIRy4Rgux5t7RxM3Kr+qT8ZMyBvhnxjImruAgd6Xk5X3eyJGqytokkxqESPq5OZJT1
        mGiVaYzBi6YGHDn3WHa7jJJOgHPMERjFeYObO8K1GPGD5MzkBSC5RLpKD097Nwp9tmBJp3axFBuHF
        xgtaTAqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtgi-004BDR-Pk; Mon, 12 Apr 2021 10:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B4F6300209;
        Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B514720224209; Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Message-ID: <20210412102001.092817439@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 12:14:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
Subject: [PATCH v2 1/9] sched/numa: Allow runtime enabling/disabling of NUMA balance without SCHED_DEBUG
References: <20210412101421.609526370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


