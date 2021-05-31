Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B037396713
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhEaRbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhEaRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472AC08EB1C
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:20:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622478053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOZCoZ84vqfcrJ50xNhKrjdqtRbtRglmSUOTO8Ugyi8=;
        b=C2U1+g8yU5w7Mmkvi8OaKVaCWcYh7CRJf3JrwSOjqDW/qFCXUsDy+aiLG0F8xPQbAQXr6X
        keHa2oqZR5DOrrf+5wrErhuYP1kgQaFPA9v62apBXvx29XN8ViWVsvJQLm7e3YHRxG3YnQ
        Pdims4h3G4jobDtGkZYVd0Udsp8CitxR6mGKzvnSpgJqZRss1kVqie13ueCDi6EA0IQMHB
        jVknPUr29nBP7Z25Y/7jV066VCULUmT3fYEB92YSEl0VrmUYiMVgIruKjt5hLOqOPR/7+O
        1KWHKFbZ03wUtSyqIYdEC34hfPmzlj+Y2yikIGKsZEEg+cnqTGSZnm1LfaYjhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622478053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOZCoZ84vqfcrJ50xNhKrjdqtRbtRglmSUOTO8Ugyi8=;
        b=bTSA+Y2UEKuhVOPJ0CjXdE2/gUzbBe/nGDVspDvkDq0M/Kts3LqmMOlc7j6Rta1pgR58pk
        xh3YX2z212HDdeDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v1 2/2] nmi_backtrace: use the printk cpu lock for show_regs()
Date:   Mon, 31 May 2021 18:20:51 +0200
Message-Id: <20210531162051.2325-3-john.ogness@linutronix.de>
In-Reply-To: <20210531162051.2325-1-john.ogness@linutronix.de>
References: <20210531162051.2325-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_stack() uses the printk cpu lock to synchronize the stacktrace,
but this can also be used for dumping the banner and regs.

Since the cpu lock allows recursive locking, it is not an issue to
call dump_stack() with the printk cpu lock held.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 lib/nmi_backtrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 8abe1870dba4..9ed02c2d77be 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -92,17 +92,21 @@ module_param(backtrace_idle, bool, 0644);
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
+	unsigned int cpu_store;
+	unsigned long flags;
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
 		} else {
+			printk_cpu_lock(&cpu_store, &flags);
 			pr_warn("NMI backtrace for cpu %d\n", cpu);
 			if (regs)
 				show_regs(regs);
 			else
 				dump_stack();
+			printk_cpu_unlock(cpu_store, flags);
 		}
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
-- 
2.20.1

