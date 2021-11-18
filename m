Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB9C455E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhKROjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhKROiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:38:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0113C06175A;
        Thu, 18 Nov 2021 06:35:01 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftHn/eyM3C1hrqOOZnMeMhznkMf6ZPy1i+z33ccOsr0=;
        b=C9TLIfCa19zjCqfsrwXFhojlnIiXcyyXS2cCTM9Rx+JBenzDaL2rS57rOERLzhzjwAG9tM
        BvxBmgh0zdN03FYUNJwFaGtKWtJR1OIMrrd6UCj8AHwamEO/gNQbZHzNLTMKNFiDHwAGkQ
        sjgc5XL3qxtVoLs23ND2JMyC7ahZ7Q4ucrd0BUpx06fsDi1XaRaS8C58nInVBbg2xAmqCN
        neUXnYjNE+voUQ61NUQcJTGRR8SD/k/vBEa4kNMsZp1evhQ3rCiuYe9L390ib4ZEmfHyXv
        4L68dZeYDEjmX0mC2geCPz0XJw52FNgYVINka9tTOpFBnrMf1hFoQm9Ej7AKPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftHn/eyM3C1hrqOOZnMeMhznkMf6ZPy1i+z33ccOsr0=;
        b=slRVUn5blF1bKokbRsxFzzn2D7WkYIC49GyBKZtSuejL/4NsRZ8EW/rX5ryHzTHMJE2D36
        e/3LPXpwQvFF1PBA==
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
Subject: [PATCH 3/8] kernel/fork, IA64: Provide a alloc_thread_stack_node() for IA64.
Date:   Thu, 18 Nov 2021 15:34:47 +0100
Message-Id: <20211118143452.136421-4-bigeasy@linutronix.de>
In-Reply-To: <20211118143452.136421-1-bigeasy@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a generic alloc_thread_stack_node() for IA64/
CONFIG_ARCH_THREAD_STACK_ALLOCATOR which returns stack pointer and sets
task_struct::stack so it behaves exactly like the other implementations.

Rename IA64's alloc_thread_stack_node() and add the generic version to
the fork code so it is in one place _and_ to drastically lower chances
of fat fingering the IA64 code.
Do the same for free_thread_stack().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/ia64/include/asm/thread_info.h |  6 +++---
 kernel/fork.c                       | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/th=
read_info.h
index 51d20cb377062..1684716f08201 100644
--- a/arch/ia64/include/asm/thread_info.h
+++ b/arch/ia64/include/asm/thread_info.h
@@ -55,15 +55,15 @@ struct thread_info {
 #ifndef ASM_OFFSETS_C
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *) ((char *) current + =
IA64_TASK_SIZE))
-#define alloc_thread_stack_node(tsk, node)	\
+#define arch_alloc_thread_stack_node(tsk, node)	\
 		((unsigned long *) ((char *) (tsk) + IA64_TASK_SIZE))
 #define task_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA=
64_TASK_SIZE))
 #else
 #define current_thread_info()	((struct thread_info *) 0)
-#define alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
+#define arch_alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
 #define task_thread_info(tsk)	((struct thread_info *) 0)
 #endif
-#define free_thread_stack(tsk)	/* nothing */
+#define arch_free_thread_stack(tsk)	/* nothing */
 #define task_stack_page(tsk)	((void *)(tsk))
=20
 #define __HAVE_THREAD_FUNCTIONS
diff --git a/kernel/fork.c b/kernel/fork.c
index ce320d4b8e1f4..d1681a415cdf1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -329,6 +329,22 @@ void thread_stack_cache_init(void)
 }
=20
 # endif /* THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
+
+static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+{
+	unsigned long *stack;
+
+	stack =3D arch_alloc_thread_stack_node(tsk, node);
+	tsk->stack =3D stack;
+	return stack;
+}
+
+static void free_thread_stack(struct task_struct *tsk, bool cache_only)
+{
+	arch_free_thread_stack(tsk);
+}
+
 #endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
=20
 /* SLAB cache for signal_struct structures (tsk->signal) */
--=20
2.33.1

