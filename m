Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93796455E48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhKROjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhKROiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:38:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1EC061574;
        Thu, 18 Nov 2021 06:35:01 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUNMcUshYRp4Dcgj0kO/IyCaRl0KYjlIIE6AZgFbc/A=;
        b=vM9fzQMQJMlPMq7plXP7uVQJVSaegzSiWoEr9WvW5SlueyvOZLAqTqpZGJQqH+ftcYZm6M
        XbqulE3HmyHtOzKv+YlZYUNpwDDQm7rWD8oQK3HmSi6bp4xHi6xxeKTW1qjs0uj1tuq+fc
        OEQKBejpN73RkWG6r61uR8eKAI+1y5PTJ378BfUdDWU0R4MINFSKT5qf4yYFIq7goX1unD
        F86wPnmfNy/fzSIVhLABjnBs0xRXVAl11PQ+yQ8UdGKjrGyZUkVBkkJnzmuVCEhVaOUXOa
        2x4Xj94MN8xUVvCBcZVErJtqp4SkiemEY6Xs684wXXIR9EvbPhOIh9mzFbNzGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUNMcUshYRp4Dcgj0kO/IyCaRl0KYjlIIE6AZgFbc/A=;
        b=Vs0ExN21FF8U6XHJjK/8ckB2ndSgdtPulnaoQRLc1arYjcBPWx9St4ZsA/f8L9ykxRLamm
        i2+yD1Z6RxT293AA==
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/8] kernel/fork: Duplicate task_struct before stack allocation.
Date:   Thu, 18 Nov 2021 15:34:46 +0100
Message-Id: <20211118143452.136421-3-bigeasy@linutronix.de>
In-Reply-To: <20211118143452.136421-1-bigeasy@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_thread_stack_node() already populates the task_struct::stack
member except on IA64. The stack pointer is saved and populated again
because IA64 needs it and arch_dup_task_struct() overwrites it.

Allocate thread's stack after task_struct has been duplicated as a
preparation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bb3f2980f94fb..ce320d4b8e1f4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -887,6 +887,10 @@ static struct task_struct *dup_task_struct(struct task=
_struct *orig, int node)
 	if (!tsk)
 		return NULL;
=20
+	err =3D arch_dup_task_struct(tsk, orig);
+	if (err)
+		goto free_tsk;
+
 	stack =3D alloc_thread_stack_node(tsk, node);
 	if (!stack)
 		goto free_tsk;
@@ -896,8 +900,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
=20
 	stack_vm_area =3D task_stack_vm_area(tsk);
=20
-	err =3D arch_dup_task_struct(tsk, orig);
-
 	/*
 	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
 	 * sure they're properly initialized before using any stack-related
@@ -911,9 +913,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
=20
-	if (err)
-		goto free_stack;
-
 	err =3D scs_prepare(tsk, node);
 	if (err)
 		goto free_stack;
--=20
2.33.1

