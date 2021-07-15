Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC163CAD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbhGOTyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:54:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbhGOTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:36:56 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626377641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMAxvl8PidPfNR/jqhvvSrMVsmQvHcnDY2vGSEbxR6s=;
        b=e8HyxQwdWhtfj3MC+npYb19hreWKeolDW/NvdsIZzbJKZjUqLwWy49QU800zwdYC/1XBWI
        tU4h48/i/g2vrSpAv2dUsdEWDO/JJWSFajZ9ot9ONaPgQe7MkWZJEaxPr0OKjRjCmNl2C8
        NnzaBTfgVdDyAeXwJMlv5Zo4ptxgJpsYuqUnso8MssoW6CZgsOGZ4VLHwUsUeb1h2hHRei
        zzVXjNhZhZh+pglOnc3NuK00JmNy+L5ZMpeTbIhPgyj3wrKCESiSWgj5xM1rwB3b8wRAaA
        PNj2eaf5/OwP9k6RrTtAwjFk/hF1wLYVhTdPezNC0cBbJTndph+1QHde7cut+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626377641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMAxvl8PidPfNR/jqhvvSrMVsmQvHcnDY2vGSEbxR6s=;
        b=rdMDfZX+bZx4QMJsQrDL/Qmk/cwpnFYZtJpKZFkbDxK9uxLN2/6RkJPoHxap3Z8Cg8//ci
        buS38ZSrhij6cbDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH printk v4 1/6] lib/nmi_backtrace: explicitly serialize banner and regs
Date:   Thu, 15 Jul 2021 21:39:54 +0206
Message-Id: <20210715193359.25946-2-john.ogness@linutronix.de>
In-Reply-To: <20210715193359.25946-1-john.ogness@linutronix.de>
References: <20210715193359.25946-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

