Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1D341AAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhI1IqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbhI1IqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:46:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZpaWy/+D/OwfXL0c7+8II/rbrDYhknXmTtxq+Ad/ns4=; b=GbbfBEVUSChNHnhBQ/GSIyTcan
        b7/WtWNmKs6EsPx5FI3KFAr/E9iQHoxOiWr7SlDdJEfa9wY3QRY81GYIasYPV6csNhOgQ8F+Xv+Bm
        bvCsI6WVOSzi5vOSc91knl6pkrhBOW+Xeaynq9n1YlaVr9w8y7uyxTHyHtF3JY0+PCIe/gDuOAm58
        ONc0iHjuhBsSIeHI55+Tfj62hjIoCmjsigu4v+RyLn67wAnrfzTVG9xUnZucLUFMPOD2pchtLe26+
        2pglwVTX4zaxOpwJHSJLt6ZNvtnnUbHHrQMzjgeN9MnZD8pLyZ4w6Ge/xcSC9Q8KCboszebywKX/R
        8H6101kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mV8hW-00AgFB-I9; Tue, 28 Sep 2021 08:43:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DE2C3007B8;
        Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C74132C2FF130; Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Message-ID: <20210928084217.908041969@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Sep 2021 10:40:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org, tglx@linutronix.de, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 1/3] rcu: Always inline rcu_dynticks_task*_{enter,exit}()
References: <20210928084020.819856223@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU managed to grow a few noinstr violations:

  vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x0: call to rcu_dynticks_task_trace_enter() leaves .noinstr.text section
  vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0xe: call to rcu_dynticks_task_trace_exit() leaves .noinstr.text section

Fix them by adding __always_inline to the relevant trivial functions.

Also replace the noinstr with __always_inline for the existing
rcu_dynticks_task_*() functions since noinstr would force noinline
them, even when empty, which seems silly.

Fixes: 7d0c9c50c5a1 ("rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree_plugin.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1479,7 +1479,7 @@ static void rcu_bind_gp_kthread(void)
 }
 
 /* Record the current task on dyntick-idle entry. */
-static void noinstr rcu_dynticks_task_enter(void)
+static __always_inline void rcu_dynticks_task_enter(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
@@ -1487,7 +1487,7 @@ static void noinstr rcu_dynticks_task_en
 }
 
 /* Record no current task on dyntick-idle exit. */
-static void noinstr rcu_dynticks_task_exit(void)
+static __always_inline void rcu_dynticks_task_exit(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
@@ -1495,7 +1495,7 @@ static void noinstr rcu_dynticks_task_ex
 }
 
 /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
-static void rcu_dynticks_task_trace_enter(void)
+static __always_inline void rcu_dynticks_task_trace_enter(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
@@ -1504,7 +1504,7 @@ static void rcu_dynticks_task_trace_ente
 }
 
 /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
-static void rcu_dynticks_task_trace_exit(void)
+static __always_inline void rcu_dynticks_task_trace_exit(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))


