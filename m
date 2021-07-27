Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935FC3D70E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhG0IJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:09:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42100 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhG0IJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:09:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CCF5D22147;
        Tue, 27 Jul 2021 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627373384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l3J5b8QbDgU0K5MZo+qrKZXn6byTBMzPXTKYGNQx9tM=;
        b=hPmHwd4jmLn1ezjnNJ+ZUQGilN6yAuajkmRChQi4/rfEapHVEx6UNBCihN0ucLaOXbztI/
        AGMkliQcbkujlGnwcCV7EAdQQj/MDbybr0QlaiXNKXLR9cFotIfR+6nsE6csFnjJYXSgVC
        SFTOjbwzfcsTO8MkiZMHmDXWO0lC07Y=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 83ED7A3B84;
        Tue, 27 Jul 2021 08:09:44 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] lib/nmi_backtrace: Serialize even messages about idle CPUs
Date:   Tue, 27 Jul 2021 10:09:39 +0200
Message-Id: <20210727080939.27193-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 55d6af1d66885059ffc2a ("lib/nmi_backtrace: explicitly serialize
banner and regs") serialized backtraces from more CPUs using the re-entrant
printk_printk_cpu lock. It was a preparation step for removing the obsolete
nmi_safe buffers.

The single-line messages about idle CPUs were not serialized against other
CPUs and might appear in the middle of backtrace from another CPU,
for example:

[56394.590068] NMI backtrace for cpu 2
[56394.590069] CPU: 2 PID: 444 Comm: systemd-journal Not tainted 5.14.0-rc1-default+ #268
[56394.590071] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[56394.590072] RIP: 0010:lock_is_held_type+0x0/0x120
[56394.590071] NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xb/0x10
[56394.590076] Code: a2 38 ff 0f 0b 8b 44 24 04 eb bd 48 8d ...
[56394.590077] RSP: 0018:ffffab02c07c7e68 EFLAGS: 00000246
[56394.590079] RAX: 0000000000000000 RBX: ffff9a7bc0ec8a40 RCX: ffffffffaab8eb40

It might cause confusion what CPU the following lines belongs to and
whether the backtraces are really serialized.

Prevent the confusion and serialize also the single line message against
other CPUs.

Fixes: 55d6af1d66885059ffc2a ("lib/nmi_backtrace: explicitly serialize banner and regs")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
I have got a bit confused by the bactraces from all CPUs when I pushed
the patchset removing printk_safe buffers and double checked the behavior.

I propose this patch to avoid the confusion. I send it as a separate patch
to avoid another re-spin/delay of the non-trivial patchset.

The patch is against printk/linux.git, branch rework/printk_safe-removal.

 lib/nmi_backtrace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 9813a983d024..f9e89001b52e 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -89,22 +89,22 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 	unsigned long flags;
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
+		/*
+		 * Allow nested NMI backtraces while serializing
+		 * against other CPUs.
+		 */
+		printk_cpu_lock_irqsave(flags);
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
 		} else {
-			/*
-			 * Allow nested NMI backtraces while serializing
-			 * against other CPUs.
-			 */
-			printk_cpu_lock_irqsave(flags);
 			pr_warn("NMI backtrace for cpu %d\n", cpu);
 			if (regs)
 				show_regs(regs);
 			else
 				dump_stack();
-			printk_cpu_unlock_irqrestore(flags);
 		}
+		printk_cpu_unlock_irqrestore(flags);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
2.26.2

