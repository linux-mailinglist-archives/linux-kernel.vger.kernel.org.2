Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A8455E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhKROih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhKROiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:38:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC3C06175D;
        Thu, 18 Nov 2021 06:35:03 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rjX3urIg51JSSh3dstIMYOJ9ExE30ftcMDZcbT3MRM=;
        b=b8jjQZkIbUEl8oLfykU7OByBmMkAT6zEZKT5tUlKApHJeAJV/X9fTHwVFgSaFsf2IRMomo
        dvT7x1tZ6JfWng6cAxeda9OuZ5BoRcUL7iN8EEm7GpleryYWVm+jVHnJkY/a526uA4cEov
        Uhpmnb5y+eQj5ck0z9dzZoT8BYteGKgInhic8QM60891rkMfPAxBlrOMuigVKCxfVkRv8p
        2qOwsv007Zh+qUrhvHGT4gO0RPOqqF+hw6apSTbVgxiExdXKG+Oe/dx/Q/LxwUAepxaYuv
        dX2IblE3zWU/imQ5N+WuY/WZjastireFku/goLW7rTgO/nBdsxgNEmnbJgAprA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rjX3urIg51JSSh3dstIMYOJ9ExE30ftcMDZcbT3MRM=;
        b=2p6KTJ6IwW3dSRGGmRRD0OwGmS7vfGMlEiC/oMQigYylJSMHnt+VzAvpwRyIB57CIeqVfM
        6FDy7yjRVwTGwFDg==
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
Subject: [PATCH 8/8] kernel/fork: Use IS_ENABLED() in account_kernel_stack().
Date:   Thu, 18 Nov 2021 15:34:52 +0100
Message-Id: <20211118143452.136421-9-bigeasy@linutronix.de>
In-Reply-To: <20211118143452.136421-1-bigeasy@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not strickly needed but checking CONFIG_VMAP_STACK instead of
task_stack_vm_area()' result allows the compiler the remove the else
path in the CONFIG_VMAP_STACK case where the pointer can't be NULL.

Check for CONFIG_VMAP_STACK in order to use the proper path.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0aa079e56e3b4..15286e469cf2e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -465,16 +465,16 @@ void vm_area_free(struct vm_area_struct *vma)
=20
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
-	void *stack =3D task_stack_page(tsk);
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-
-	if (vm) {
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm =3D task_stack_vm_area(tsk);
 		int i;
=20
 		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
 			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
+		void *stack =3D task_stack_page(tsk);
+
 		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
--=20
2.33.1

