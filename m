Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4271639CF2B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhFFMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:47:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFFMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:47 -0400
Date:   Sun, 06 Jun 2021 12:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rIR6k+0nMEJimQGuF7HYCgi7Hg9zXk5RZixQEorZgs4=;
        b=ZljsyO/ANZMUQ9upuVoLKDX2JITb/CCM0WGsqY8Dpd2pLJAdIbW/koUxoBkqNtUmNaX+2Q
        ZF8XZEnhhVIAmOhamouUw4gyLR6uG6NhQBthJTYl++t0tdcsE8+mzFNjnulO88aEvLUm5f
        fNDRwu3EQe+v8JypAwSRmh8yqJGLOdQn/uD+eNaz4BXbETIbQQru2evsPQnGhdHxVg3ww3
        hH5kZ2tGjzwXOzJmUr/JCQm+TXuiwS9666s/UQ3ydqpXiB1d3GG0QoRQM5GnH07MyGMH9E
        AYvNOrv60YeNJlqhruPUWBCEFcmXv/7wDVadOQZpHkJUf6CN3COwh3RFz8patw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rIR6k+0nMEJimQGuF7HYCgi7Hg9zXk5RZixQEorZgs4=;
        b=/RqSsWwgOJt/zoAuowpXPcM8Vd6GNAKD+0QUjZT8vyCx8Scvo0Ro5X5AnihdZs4SLev+t3
        5feKFc4bRSzBrYBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Replace irqaction:irq with a
 pointer to the irqdesc
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343659.29796.6540109093384254587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bb33916b527fbdbe23c93c2b86375590c2fc92e2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bb33916b527fbdbe23c93c2b86375590c2fc92e2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 20 Apr 2021 09:19:54 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:46 +01:00

genirq: Replace irqaction:irq with a pointer to the irqdesc

It is a bit odd that irqaction contains the irq number instead
of a back-pointer to the desc it is attached to, specially considering
it is an internal structure.

Replace the irq field with the backpointer.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/interrupt.h |  2 +-
 kernel/irq/chip.c         |  2 +-
 kernel/irq/manage.c       | 15 +++++++--------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850..7191950 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -119,7 +119,7 @@ struct irqaction {
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
 	struct irqaction	*secondary;
-	unsigned int		irq;
+	struct irq_desc		*desc;
 	unsigned int		flags;
 	unsigned long		thread_flags;
 	unsigned long		thread_mask;
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8cc8e57..764e046 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -479,7 +479,7 @@ void handle_nested_irq(unsigned int irq)
 
 	action_ret = IRQ_NONE;
 	for_each_action_of_desc(desc, action)
-		action_ret |= action->thread_fn(action->irq, action->dev_id);
+		action_ret |= action->thread_fn(irq_desc_get_irq(desc), action->dev_id);
 
 	if (!noirqdebug)
 		note_interrupt(desc, action_ret);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c14356..1e519e2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1144,7 +1144,7 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 	local_bh_disable();
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
-	ret = action->thread_fn(action->irq, action->dev_id);
+	ret = action->thread_fn(irq_desc_get_irq(desc), action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
@@ -1165,7 +1165,7 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 {
 	irqreturn_t ret;
 
-	ret = action->thread_fn(action->irq, action->dev_id);
+	ret = action->thread_fn(irq_desc_get_irq(desc), action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
@@ -1189,12 +1189,11 @@ static void irq_thread_dtor(struct callback_head *unused)
 		return;
 
 	action = kthread_data(tsk);
+	desc = action->desc;
 
 	pr_err("exiting task \"%s\" (%d) is an active IRQ thread (irq %d)\n",
-	       tsk->comm, tsk->pid, action->irq);
+	       tsk->comm, tsk->pid, irq_desc_get_irq(desc));
 
-
-	desc = irq_to_desc(action->irq);
 	/*
 	 * If IRQTF_RUNTHREAD is set, we need to decrement
 	 * desc->threads_active and wake possible waiters.
@@ -1225,7 +1224,7 @@ static int irq_thread(void *data)
 {
 	struct callback_head on_exit_work;
 	struct irqaction *action = data;
-	struct irq_desc *desc = irq_to_desc(action->irq);
+	struct irq_desc *desc = action->desc;
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
 
@@ -1318,7 +1317,7 @@ static int irq_setup_forced_threading(struct irqaction *new)
 		new->secondary->handler = irq_forced_secondary_handler;
 		new->secondary->thread_fn = new->thread_fn;
 		new->secondary->dev_id = new->dev_id;
-		new->secondary->irq = new->irq;
+		new->secondary->desc = new->desc;
 		new->secondary->name = new->name;
 	}
 	/* Deal with the primary handler */
@@ -1444,7 +1443,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
 
-	new->irq = irq;
+	new->desc = desc;
 
 	/*
 	 * If the trigger type is not specified by the caller,
