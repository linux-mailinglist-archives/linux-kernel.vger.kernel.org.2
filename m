Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608AF34A5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCZKnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCZKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:42:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF2C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oJkxraLuGD9mCcthWWqeZp/Kq7NpimgxuYInIUFjyRc=; b=Z8cIIGGsCa+o71cdNasp17VKOb
        Gs6fXOKZVvcvJfc0RR41s6Pv3ADKGx48/gzl5rHeInj7NN0oNLfXmw4bHhAUwYZy0q0fDpiArqwrt
        iS3v1Rym8VHXyPytTnTEi/dNBXiKO/ZnHp24EwXLsTg4tPDxlUhPR+yzPy/T4ZvuACb8JQk0096bf
        7T69gzN09pABeOHBCM13I/g2i9PCAuukb3v6X51a1AmsQJpTY+rA3KTmsAnNvCTmK7cgpUY9n8nLI
        i/KjxvJZtNHVGoyFlh7xrZyy6MhxlGDJ6wXLrBEPeyJs9ZkWONW/Vczablw+MR4DQT1USuWYrPoEC
        QRDqaNMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvE-003L6F-Tp; Fri, 26 Mar 2021 10:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB005304D58;
        Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A61FF2BCA7ED2; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103934.865460002@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 2/9] sched: Remove sched_schedstats sysctl out from under SCHED_DEBUG
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SCHEDSTATS does not depend on SCHED_DEBUG, it is inconsistent
to have the sysctl depend on it.

Suggested-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sysctl.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1711,17 +1711,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_SCHEDSTATS
-	{
-		.procname	= "sched_schedstats",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_schedstats,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SCHEDSTATS */
 #endif /* CONFIG_SMP */
 #ifdef CONFIG_NUMA_BALANCING
 	{
@@ -1755,6 +1744,17 @@ static struct ctl_table kern_table[] = {
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
+#ifdef CONFIG_SCHEDSTATS
+	{
+		.procname	= "sched_schedstats",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_schedstats,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SCHEDSTATS */
 #ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing",


