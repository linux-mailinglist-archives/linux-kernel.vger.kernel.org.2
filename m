Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED0368098
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhDVMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhDVMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9EC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xl87/Ue7tFX3S4O8U1a0BO5yF1FSNCP/Q+HkHsMp2BE=; b=r0SKiu6MsWDylXGRigUsrgdsua
        05hiXXzp6iTn5dvMKC5Gfj36CGtDgl9K3klxwneq/ls3YBofYM68uOpS2x66chVIgOvyXIdm0X+ty
        izi83vK0qj785dh+fnY9pDZqB6CrZijdnj0PEiP+zft6AB5qFVttNNHz/GZKbTgUA8ufAkYmutf/K
        BHFfQ5tTXJisP3/a5a5UE4GOE6x3tHTG+LsVmVOhFtn+KklTz02gSSUKGx+cqYTGUCNpqJcCHXJxm
        om1qUcux+cG6rNKeOxbkr6Dy6Kue8H0NzQtpydxoOJHBVLCS6Xs7YZNAHi8EtKq8/nTxtPqYg8cWk
        98D5xqmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYYF-000I8y-AR; Thu, 22 Apr 2021 12:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69943300103;
        Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2A85A2C18940F; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.075967879@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 02/19] sched: Provide raw_spin_rq_*lock*() helpers
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepration for playing games with rq->lock, add some rq_lock
wrappers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   15 +++++++++++++++
 kernel/sched/sched.h |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -184,6 +184,21 @@ int sysctl_sched_rt_runtime = 950000;
  *
  */
 
+void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
+{
+	raw_spin_lock_nested(rq_lockp(rq), subclass);
+}
+
+bool raw_spin_rq_trylock(struct rq *rq)
+{
+	return raw_spin_trylock(rq_lockp(rq));
+}
+
+void raw_spin_rq_unlock(struct rq *rq)
+{
+	raw_spin_unlock(rq_lockp(rq));
+}
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1113,6 +1113,56 @@ static inline bool is_migration_disabled
 #endif
 }
 
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	return &rq->lock;
+}
+
+static inline void lockdep_assert_rq_held(struct rq *rq)
+{
+	lockdep_assert_held(rq_lockp(rq));
+}
+
+extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
+extern bool raw_spin_rq_trylock(struct rq *rq);
+extern void raw_spin_rq_unlock(struct rq *rq);
+
+static inline void raw_spin_rq_lock(struct rq *rq)
+{
+	raw_spin_rq_lock_nested(rq, 0);
+}
+
+static inline void raw_spin_rq_lock_irq(struct rq *rq)
+{
+	local_irq_disable();
+	raw_spin_rq_lock(rq);
+}
+
+static inline void raw_spin_rq_unlock_irq(struct rq *rq)
+{
+	raw_spin_rq_unlock(rq);
+	local_irq_enable();
+}
+
+static inline unsigned long _raw_spin_rq_lock_irqsave(struct rq *rq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	raw_spin_rq_lock(rq);
+	return flags;
+}
+
+static inline void raw_spin_rq_unlock_irqrestore(struct rq *rq, unsigned long flags)
+{
+	raw_spin_rq_unlock(rq);
+	local_irq_restore(flags);
+}
+
+#define raw_spin_rq_lock_irqsave(rq, flags)	\
+do {						\
+	flags = _raw_spin_rq_lock_irqsave(rq);	\
+} while (0)
+
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 


