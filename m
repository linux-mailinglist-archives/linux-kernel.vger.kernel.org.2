Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA09D35C3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhDLKWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbhDLKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:21:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A027C06138F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=q70SvIsWRSi0y/IGTSrZkyVCZtoeNStuHXG3kerf80M=; b=ijp1uPyp+P9eTuNJojroqiDpNg
        j1k2I7Co6EXHRBemvkZX24FDBKQ4gf5kJsNTSM/lA2jjhf+5gbzYxeEjmnEtXnc2hQwWwe9ywzr9j
        bSyDi3GX3M1rLtAOl4eM6nPaMy6EH4sgeJLyqzYyFVQ2r4XZ7e8vmQVOivafC5n89diOFsk3gvFK+
        hAlsxmb5X7yooHPo6la3r0qXXMyRPi3GHV3pVdCQz9RB/rkCEILpllpjpbC7GqJ65Igh+zVfiKdor
        6NFwfCijQB/ywOoiIbXkX1ySV5IebSAjEDHIbBNrwdizeVpGctzH8dd20lIwcXP3ScmDZGLfkuMJV
        jpSvO/kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtgj-004BDV-HM; Mon, 12 Apr 2021 10:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D14923002C4;
        Mon, 12 Apr 2021 12:20:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D5C5129D8B775; Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Message-ID: <20210412102001.548833671@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 12:14:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 8/9] sched: Move /proc/sched_debug to debugfs
References: <20210412101421.609526370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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


