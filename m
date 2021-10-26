Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD543AFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhJZKS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbhJZKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E9C061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:16:08 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XivtZtLFB9ts8ghXEesTtU/ZTmLqHM4VKsOcUwgiG/Y=;
        b=af5dwmyR6cS09eKlOZOW21yg4lU+Cu1w4if9b6pL7aZ6Jsh3Sew0EX4lsv9qOCypYmf6HQ
        mb/bygXJm5XfCinGqV9fktbzFy1zqsEWfW4Q+XjDvS1sKPAOkaVpQLXLcq/HaVeTDH3ruy
        5B8YkNuue+0ltsumr2Rur3L//TLSDEmKBfr7+xRju9eSNS27bLbv2DNF0QbYxG1mJlC0vF
        vL1H5yaL/4umeOwom4IIGAoiSyGv0Lv5fYNlGMUbAGiIAg9qDR1hkOMfF139yuelHNTZn3
        P6bapj12ryVmwwSbdJ5A1eNpY7RbYRARMlc+dTT1M4qZQjOZWf3M0UntSbFi2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XivtZtLFB9ts8ghXEesTtU/ZTmLqHM4VKsOcUwgiG/Y=;
        b=08D5GFB19sKYdZhwXBGxlgvpUZn4CuBBgjxN3880HqtPYzmFsi4CY18JHezqqfrT9hTI3H
        rj69ztbUFA3xGmBA==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: add generic_handle_arch_irq()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336611.626.17746724275974667854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a1b09501971435ef213251891753afb0d7f3d27a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a1b09501971435ef213251891753afb0d7f3d27a
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 11:24:06 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:27 +01:00

irq: add generic_handle_arch_irq()

Several architectures select GENERIC_IRQ_MULTI_HANDLER and branch to
handle_arch_irq() without performing any entry accounting.

Add a generic wrapper to handle the common irqentry work when invoking
handle_arch_irq(). Where an architecture needs to perform some entry
accounting itself, it will need to invoke handle_arch_irq() itself.

In subsequent patches it will become the responsibilty of the entry code
to set the irq regs when entering an IRQ (rather than deferring this to
an irqchip handler), so generic_handle_arch_irq() is made to set the irq
regs now. This can be redundant in some cases, but is never harmful as
saving/restoring the old regs nests safely.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |  1 +
 kernel/irq/handle.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c8293c8..988c225 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1261,6 +1261,7 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *));
  * top-level IRQ handler.
  */
 extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+asmlinkage void generic_handle_arch_irq(struct pt_regs *regs);
 #else
 #ifndef set_handle_irq
 #define set_handle_irq(handle_irq)		\
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 221d80c..2718200 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -14,6 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/irq_regs.h>
+
 #include <trace/events/irq.h>
 
 #include "internals.h"
@@ -226,4 +228,20 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 	handle_arch_irq = handle_irq;
 	return 0;
 }
+
+/**
+ * generic_handle_arch_irq - root irq handler for architectures which do no
+ *                           entry accounting themselves
+ * @regs:	Register file coming from the low-level handling code
+ */
+asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	handle_arch_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit();
+}
 #endif
