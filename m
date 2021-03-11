Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9668A33754F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhCKOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhCKOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:18:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFBDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:18:20 -0800 (PST)
Message-Id: <20210311141704.101079841@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615472296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tr/QHK6EO98/6Jbi/V6kHHTycEaZE2XVuVjSeCrgP9M=;
        b=4v+5xOgfnanby0Ahyc/JquqZiepPdlAK+AqhdUfRetz+nKuz9A5OBGYh07fb0sSaVvPCF7
        MJPlzSWRhanV/LqQVLeATf+EI2Uo5525GR/KYIOU1hE5vIL4h49Ze5jjUghUA5zknzAioU
        JUEzs17o3suFncuh0jBtaLhbLJK72gNxpGxjCkFSMYKldyhPRA0XytESUXwyEc6Y4e40uJ
        58JPWubnsHuVUkrZ+qlTQ905XeGi4TAIn8uEwM0L1/ZKuDOQqBlKFxt6WOPkDASIVNcFIg
        t7aqbA+pl3N52iCfrQIoGVPzrelj8ADw2ILvnPzNpk309hjooHlJ7K2Yxboutw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615472296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tr/QHK6EO98/6Jbi/V6kHHTycEaZE2XVuVjSeCrgP9M=;
        b=nKEIfwkv+ZPZVCAlw8BxQ+0U6KVP6e47tsoIaQWyRLQnnpsLNJHiOD3vnCuyIqMCrAIPfq
        LNomXh480nqPIXCw==
Date:   Thu, 11 Mar 2021 14:20:37 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [patch V2 1/3] signal: Provide and use exit_task_sighand()
References: <20210311132036.228542540@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for caching a sigqueue per task, implement a dedicated function
to flush the sigqueue of the exiting task.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/signal.h |    1 +
 kernel/exit.c          |    3 +--
 kernel/signal.c        |    9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -265,6 +265,7 @@ static inline void init_sigpending(struc
 }
 
 extern void flush_sigqueue(struct sigpending *queue);
+extern void exit_task_sighand(struct task_struct *tsk);
 
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -152,8 +152,7 @@ static void __exit_signal(struct task_st
 	 * Do this under ->siglock, we can race with another thread
 	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
 	 */
-	flush_sigqueue(&tsk->pending);
-	tsk->sighand = NULL;
+	exit_task_sighand(tsk);
 	spin_unlock(&sighand->siglock);
 
 	__cleanup_sighand(sighand);
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -471,6 +471,15 @@ void flush_sigqueue(struct sigpending *q
 }
 
 /*
+ * Called from __exit_signal. Flush tsk->pending and clear tsk->sighand.
+ */
+void exit_task_sighand(struct task_struct *tsk)
+{
+	flush_sigqueue(&tsk->pending);
+	tsk->sighand = NULL;
+}
+
+/*
  * Flush all pending signals for this kthread.
  */
 void flush_signals(struct task_struct *t)

