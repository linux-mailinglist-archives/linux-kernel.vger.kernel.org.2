Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295663680A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhDVMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhDVMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:38:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE28C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RN2xAIABvOnqEJsdwF8TfHxkP9RCd0zxgZN5JQF4LOw=; b=lZAII9l4B5HwyMFZ+xBYtMHb/S
        TlZvCzKqZXXSJbkqzY67/MaeHBWOOgMFLwaOSJzXOK7DXLRblNWBpi5LTQ9b0IgCx1/YxIAeYNsQE
        UGuAaU8T0LEbXdla6jB5ZH4sdXrqdqtMPgJTLfxO0FHFpr1vn3x18Up7NiyfziWjL6Me9pMn3KFbu
        kf0c5iWORlUfjygUOS1GKjQ3r5oi76XwzI7arnYqM7vUzQZmKskYs/nOM/Wlq/sa+tFCQBKfmAHCD
        5gSpAExKdWWZZYy6FXhmxiWZOqFdsQknCDmqARsBsOA1LVTBRPldZHGaQSGavyFAbc/7nXLzhd36s
        8PdX32ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZM-000IDb-T2; Thu, 22 Apr 2021 12:36:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81F6930032A;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 776B42C67A906; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.980003687@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 17/19] sched: Inherit task cookie on fork()
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that sched_core_fork() is called from under tasklist_lock, and
not from sched_fork() earlier. This avoids a few races later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h     |    2 ++
 kernel/fork.c             |    3 +++
 kernel/sched/core_sched.c |    6 ++++++
 3 files changed, 11 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2172,8 +2172,10 @@ const struct cpumask *sched_trace_rd_spa
 
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
+extern void sched_core_fork(struct task_struct *p);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
+static inline void sched_core_fork(struct task_struct *p) { }
 #endif
 
 #endif
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2249,6 +2249,8 @@ static __latent_entropy struct task_stru
 
 	klp_copy_process(p);
 
+	sched_core_fork(p);
+
 	spin_lock(&current->sighand->siglock);
 
 	/*
@@ -2336,6 +2338,7 @@ static __latent_entropy struct task_stru
 	return p;
 
 bad_fork_cancel_cgroup:
+	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p, args);
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -100,6 +100,12 @@ static unsigned long sched_core_clone_co
 	return cookie;
 }
 
+void sched_core_fork(struct task_struct *p)
+{
+	RB_CLEAR_NODE(&p->core_node);
+	p->core_cookie = sched_core_clone_cookie(current);
+}
+
 void sched_core_free(struct task_struct *p)
 {
 	sched_core_put_cookie(p->core_cookie);


