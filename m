Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6863734A5C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCZKoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCZKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:44:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B2C0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CPPvwqcPK0g8/AAoxEgyQ3XaBTx0zUl71qbZnX49WRk=; b=IAdNEssCBWqBOjWP/gzzhlqydh
        7rj+eo6QRYMIv3E3AqaZDPxkybd54ZDGwKNgT2pTsAfI4J8izmIdwP51Q8fAWyWiwMzFWYNNfDjYd
        yuTYleCKRm48svOwcHTsFTM6dQMfHWdC3AQek2CnwGCIA0DHFc14k+qXo9Bxv+W5gk362BnjOJfX6
        mvRx+7brCFFLNSG7h2xiXMcTjQl0/X8tFNl7pqtJJFiay7FlLQwVipibjPyN9QZNyj0wgLKoS+Spr
        +b9IxkB5FSq+WW8nno7GlF/cE5qYxYwZZEjZ3qxo4FiGOZ8zFYxdBJwv6TpxeNA/Jecb2yYJoabvv
        F+tZWeCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvF-00EgYW-Rr; Fri, 26 Mar 2021 10:42:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EA7E307697;
        Fri, 26 Mar 2021 11:42:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C58732BCA7EDB; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103935.340951208@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:34:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 8/9] sched: Move /proc/sched_debug to debugfs
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -279,6 +279,20 @@ static const struct file_operations sche
 
 __read_mostly bool sched_debug_enabled;
 
+static const struct seq_operations sched_debug_sops;
+
+static int sched_debug_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &sched_debug_sops);
+}
+
+static const struct file_operations sched_debug_fops = {
+	.open		= sched_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static struct dentry *debugfs_sched;
 
 static __init int sched_init_debug(void)
@@ -316,6 +330,8 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
 #endif
 
+	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
+
 	return 0;
 }
 late_initcall(sched_init_debug);
@@ -854,15 +870,6 @@ static const struct seq_operations sched
 	.show		= sched_debug_show,
 };
 
-static int __init init_sched_debug_procfs(void)
-{
-	if (!proc_create_seq("sched_debug", 0444, NULL, &sched_debug_sops))
-		return -ENOMEM;
-	return 0;
-}
-
-__initcall(init_sched_debug_procfs);
-
 #define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
 #define __P(F) __PS(#F, F)
 #define   P(F) __PS(#F, p->F)


