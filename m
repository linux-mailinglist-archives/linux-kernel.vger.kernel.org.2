Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF113B2D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhFXLOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:14:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhFXLOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:14:09 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624533110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03qpuH1lkuelnu8wqylUWxMUR5FpJ2mw/6iK+juT3cw=;
        b=zlKanuYoRHfCjssDbaKHEfDUw3/fCs8+Z+JsELHhDrI8TMVrDQPSQ9KpkRGzq29nrXpTpw
        gSobo87jAHxyZ9U2QrYXMN7kKxyr1uot0Gu7D7JKN7Req/9RIAiVGsDBYHPo/b5g1P9f8u
        KnQ9dIFmJpppK2sBgJL4omPzXI/rR450jwiH0CO9cUyx9pHFc1PGQiEpxas0fX5v3Tb5yF
        KV9/S2eL7nP1fTE7EFB33ySqYqDEIe08iXGhr3Mw5UZSum+WCx+ah0jlVm8sPGC7URCMKG
        cBM+MoMsnBuEbLShmepwiMehB5vxbrOxVXNWfQAabOaaQvgO5G2yVK2AmgRbrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624533110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03qpuH1lkuelnu8wqylUWxMUR5FpJ2mw/6iK+juT3cw=;
        b=Muc9gLOhcxpQnYbUeLwdhtWDfKGqbZWBoXSk+3/m0yRulV28jkHYXHMCCoyAlq29JF4cYz
        5sykKer/MjXIs1Dg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH printk v3 1/6] lib/nmi_backtrace: explicitly serialize banner and regs
Date:   Thu, 24 Jun 2021 13:17:43 +0206
Message-Id: <20210624111148.5190-2-john.ogness@linutronix.de>
In-Reply-To: <20210624111148.5190-1-john.ogness@linutronix.de>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the nmi_backtrace is serialized against other CPUs because
the messages are sent to the NMI buffers. Once these buffers are
removed, only the dumped stack will be serialized against other CPUs
(via the printk_cpu_lock).

Also serialize the nmi_backtrace banner and regs using the
printk_cpu_lock so that per-CPU serialization will be preserved even
after the NMI buffers are removed.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 lib/nmi_backtrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 8abe1870dba4..dae233c5f597 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -92,17 +92,24 @@ module_param(backtrace_idle, bool, 0644);
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
+	unsigned long flags;
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
 		} else {
+			/*
+			 * Allow nested NMI backtraces while serializing
+			 * against other CPUs.
+			 */
+			printk_cpu_lock_irqsave(flags);
 			pr_warn("NMI backtrace for cpu %d\n", cpu);
 			if (regs)
 				show_regs(regs);
 			else
 				dump_stack();
+			printk_cpu_unlock_irqrestore(flags);
 		}
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
-- 
2.20.1

