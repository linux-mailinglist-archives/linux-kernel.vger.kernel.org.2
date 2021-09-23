Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36C4163AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbhIWQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbhIWQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:13 -0400
Message-ID: <20210923165358.117496067@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o4SG0aU4i46UE8lo7jM+xZhAWSjmVaKSzhlIrFKq2xU=;
        b=fBYJ49+HQZe6CKwIryFwfFG8t0OMPjpzooJEtAYR24p1qmoM/QV0XEJQ2c2zWXWz+lrXHN
        wKgt0sZCDhKVZTR9MQIV40HGK0HVTYEpqhFTM68NC/JLwZCJsdsA6y/NrW/NvkIACcP5N5
        dwbhzyIASOitey5Vh4qlzQirMCEAJCCS74mLj9SGL9z0gPmjGeANuTdZARmnBPI1XcQ1Ux
        aSLsPs5t6DOr/lWwTTiV6QHSpAP9CDf/n6fuHzaQNmPhSLDi+QQZqHp7zpkd3k6QSaT6cR
        GU0/TDIqcqIriDi5AXEDe1zyb3AkdAgOi8rZ7KJFoeVg2GDqX4ZGKh/JcgF9xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o4SG0aU4i46UE8lo7jM+xZhAWSjmVaKSzhlIrFKq2xU=;
        b=3aSlwzoPIaJeXyXeHWuVC90QapUmpeJrJ3dO5kAHnJqOYIgaGjRoMYmWKna+5SonfS6VGJ
        /9MISAGyO6Hqq8Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 4/8] sched: Cleanup might_sleep() printks
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:40 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert them to pr_*(). No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9473,16 +9473,14 @@ void __might_resched(const char *file, i
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	printk(KERN_ERR
-		"BUG: sleeping function called from invalid context at %s:%d\n",
-			file, line);
-	printk(KERN_ERR
-		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
-			in_atomic(), irqs_disabled(), current->non_block_count,
-			current->pid, current->comm);
+	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
+	       file, line);
+	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
+	       in_atomic(), irqs_disabled(), current->non_block_count,
+	       current->pid, current->comm);
 
 	if (task_stack_end_corrupted(current))
-		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
+		pr_emerg("Thread overran stack, or stack corrupted\n");
 
 	debug_show_held_locks(current);
 	if (irqs_disabled())

