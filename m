Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38C35AD1F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhDJL6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhDJL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:58:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E209DC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:58:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618055883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pHYFXEChv6Htvp3HQ7FC8gn5lUrPLu0kOJz5ufo6QA=;
        b=peqqnQiz8hMi/0ascvP90sOEfnAIMvBMf7Fq0h+szQb/WYqftZYOc4VkZMRU1HQTct6PeY
        dLTsVHqVCgV8dF8Q8l60n/hgrxq4neDzlZ7ZJDE5jx0chmy++sDq2f3qJ4DDX2EAaXqtA5
        739e5CBwDD3fLO9vX61aHPKq1PyEDRCAwSXrKov+EVk+jKlhLIG+F3oceFt0gxQLdnYtgA
        UxZgCxCgeKqE4F7prlnwa8QTGLhnsCHELqbb3uq+euu+OUd1TYLUSJMCH/LJy2DX7mCIPC
        /IFc8932Rfo3Jsir9d07rpjmxvjLUBAIdK+G5dthsB3zDLj216NKcOyxltuVJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618055883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pHYFXEChv6Htvp3HQ7FC8gn5lUrPLu0kOJz5ufo6QA=;
        b=8rEYA6m7vc+IXpWxbItstUTYz53rkn3kmeV9DrDYgMJesz8PiwDpoDqz0Fem7+dzKBZ/1S
        dd9TNCb7m3bBhrCQ==
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: reduce irqdebug bouncing cachelines
In-Reply-To: <20210402132037.574661-1-npiggin@gmail.com>
References: <20210402132037.574661-1-npiggin@gmail.com>
Date:   Sat, 10 Apr 2021 13:58:02 +0200
Message-ID: <87im4u2vxx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas,

On Fri, Apr 02 2021 at 23:20, Nicholas Piggin wrote:
> note_interrupt increments desc->irq_count for each interrupt even for
> percpu interrupt handlers, even when they are handled successfully. This
> causes cacheline bouncing and limits scalability.
>
> Instead of incrementing irq_count every time, only start incrementing it
> after seeing an unhandled irq, which should avoid the cache line
> bouncing in the common path.
>
> This actually should give better consistency in handling misbehaving
> irqs too, because instead of the first unhandled irq arriving at an
> arbitrary point in the irq_count cycle, its arrival will begin the
> irq_count cycle.

I've applied that because it makes sense in general, but I think the whole
call to note_interrupt() can be avoided or return early when interrupts
would be marked accordingly. For IPI handlers which always return
HANDLED the whole procedure is pretty pointless to begin with.

Something like the completely untested below.

Thanks,

        tglx
---
 include/linux/interrupt.h |    3 +++
 include/linux/irq.h       |    2 ++
 kernel/irq/manage.c       |    2 ++
 kernel/irq/settings.h     |   12 ++++++++++++
 kernel/irq/spurious.c     |    2 +-
 5 files changed, 20 insertions(+), 1 deletion(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -64,6 +64,8 @@
  * IRQF_NO_AUTOEN - Don't enable IRQ or NMI automatically when users request it.
  *                Users will enable it explicitly by enable_irq() or enable_nmi()
  *                later.
+ * IRQF_NO_DEBUG - Exclude from runnaway detection for IPI and similar handlers,
+ *		   depends on IRQF_PERCPU.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -78,6 +80,7 @@
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
 #define IRQF_NO_AUTOEN		0x00080000
+#define IRQF_NO_DEBUG		0x00100000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -72,6 +72,7 @@ enum irqchip_irq_state;
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
+ * IRQ_NO_DEBUG			- Exclude from note_interrupt() debugging
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -99,6 +100,7 @@ enum {
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
 	IRQ_HIDDEN		= (1 << 20),
+	IRQ_NO_DEBUG		= (1 << 21),
 };
 
 #define IRQF_MODIFY_MASK	\
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1682,6 +1682,8 @@ static int
 		if (new->flags & IRQF_PERCPU) {
 			irqd_set(&desc->irq_data, IRQD_PER_CPU);
 			irq_settings_set_per_cpu(desc);
+			if (new->flags & IRQF_NO_DEBUG)
+				irq_settings_set_no_debug(desc);
 		}
 
 		if (new->flags & IRQF_ONESHOT)
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -18,6 +18,7 @@ enum {
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
+	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -33,6 +34,7 @@ enum {
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
 #define IRQ_HIDDEN		GOT_YOU_MORON
+#define IRQ_NO_DEBUG		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -174,3 +176,13 @@ static inline bool irq_settings_is_hidde
 {
 	return desc->status_use_accessors & _IRQ_HIDDEN;
 }
+
+static inline void irq_settings_set_no_debug(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_NO_DEBUG;
+}
+
+static inline bool irq_settings_no_debug(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_NO_DEBUG;
+}
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -274,7 +274,7 @@ void note_interrupt(struct irq_desc *des
 	unsigned int irq;
 
 	if (desc->istate & IRQS_POLL_INPROGRESS ||
-	    irq_settings_is_polled(desc))
+	    irq_settings_is_polled(desc) | irq_settings_no_debug(desc))
 		return;
 
 	if (bad_action_ret(action_ret)) {
