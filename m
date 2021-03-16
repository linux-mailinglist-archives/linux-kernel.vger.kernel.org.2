Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB933D153
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhCPKCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:02:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40871 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhCPKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:02:09 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM6We-0005dZ-JJ
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 10:02:08 +0000
Received: by mail-ed1-f71.google.com with SMTP id a26so10342776edt.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f583SU6fsI3XN83cROlXWW6nR1CwR6eGQvesUvFa1dI=;
        b=OkA5wYZ5+EjknzFtHovwPk2T0XfFLIjGgH3IVX3o6H5tZpHABEVx3ZpTWbjVIVahwh
         I/6BCCM76+nhKqYzA/GTqnZ7fHVvpFszaIhKcFOYGCmbN/tN6N+lSAZ4D0+G7yjQYO1D
         02bB50AKzhMg46jEOjnjwNWSF9P1NgXHiVtbaYDtLkCb41znFvnySMf89pmKbqmPkZCE
         8WpqdP2U41aYUggqyT3cXyrXwr0BhUpJKvT6Tt4RNXL6IVrEuCu88ISU7WRGWgB2nGUZ
         ExLlfKr8d4hwwcj2k6G6fpijsxC+BHplsUs6J8WdvjDTl22Qq/O19crt+1iXPC3CWcK4
         l8Ug==
X-Gm-Message-State: AOAM532lGawcwq2NXqZ3GRg8SzUVw6bTDxSt8jgoTPVLxYoqxbb9pmhb
        aZfSDOcmxuSbp+G8U0EsouZpO7fOqsbsl8mx4To1BOrSxXwlpp+85hSMHyHTx4DxPKDjfd1P5AH
        kU3c4B3CEQ+vOyF3n4e5boTUnB5bUDZQO6mE1qs5e/g==
X-Received: by 2002:a17:906:f9cc:: with SMTP id lj12mr28074959ejb.544.1615888928185;
        Tue, 16 Mar 2021 03:02:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQeC0xsgUDrzl9nD2MWsLNciY2JKfPxbXSy7aFU4Bu80le/TLRl9VHXEhuggHbejqDxC3P4g==
X-Received: by 2002:a17:906:f9cc:: with SMTP id lj12mr28074926ejb.544.1615888927981;
        Tue, 16 Mar 2021 03:02:07 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id t6sm10066507edq.48.2021.03.16.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 03:02:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] genirq: fix language typos
Date:   Tue, 16 Mar 2021 11:02:05 +0100
Message-Id: <20210316100205.23492-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some language typos and misspellings in comments.  No functional
changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 kernel/irq/chip.c      | 6 +++---
 kernel/irq/ipi.c       | 2 +-
 kernel/irq/manage.c    | 6 +++---
 kernel/irq/matrix.c    | 2 +-
 kernel/irq/migration.c | 2 +-
 kernel/irq/resend.c    | 2 +-
 kernel/irq/timings.c   | 6 +++---
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6d89e33fe3aa..042399cb5caf 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -761,7 +761,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
  *	handle_edge_irq - edge type IRQ handler
  *	@desc:	the interrupt description structure for this irq
  *
- *	Interrupt occures on the falling and/or rising edge of a hardware
+ *	Interrupt occurs on the falling and/or rising edge of a hardware
  *	signal. The occurrence is latched into the irq controller hardware
  *	and must be acked in order to be reenabled. After the ack another
  *	interrupt can happen on the same source even before the first one
@@ -1419,7 +1419,7 @@ EXPORT_SYMBOL_GPL(irq_chip_eoi_parent);
  * @dest:	The affinity mask to set
  * @force:	Flag to enforce setting (disable online checks)
  *
- * Conditinal, as the underlying parent chip might not implement it.
+ * Conditional, as the underlying parent chip might not implement it.
  */
 int irq_chip_set_affinity_parent(struct irq_data *data,
 				 const struct cpumask *dest, bool force)
@@ -1531,7 +1531,7 @@ EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
 #endif
 
 /**
- * irq_chip_compose_msi_msg - Componse msi message for a irq chip
+ * irq_chip_compose_msi_msg - Compose msi message for a irq chip
  * @data:	Pointer to interrupt specific data
  * @msg:	Pointer to the MSI message
  *
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 43e3d1be622c..52f11c791bf8 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -107,7 +107,7 @@ int irq_reserve_ipi(struct irq_domain *domain,
  * @irq:	linux irq number to be destroyed
  * @dest:	cpumask of cpus which should have the IPI removed
  *
- * The IPIs allocated with irq_reserve_ipi() are retuerned to the system
+ * The IPIs allocated with irq_reserve_ipi() are returned to the system
  * destroying all virqs associated with them.
  *
  * Return 0 on success or error code on failure.
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 97c231a5644c..07ed2e4ff9a3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -179,7 +179,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
 
 /**
  *	irq_set_thread_affinity - Notify irq threads to adjust affinity
- *	@desc:		irq descriptor which has affitnity changed
+ *	@desc:		irq descriptor which has affinity changed
  *
  *	We just set IRQTF_AFFINITY and delegate the affinity setting
  *	to the interrupt thread itself. We can not call
@@ -1153,7 +1153,7 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 
 /*
  * Interrupts explicitly requested as threaded interrupts want to be
- * preemtible - many of them need to sleep and wait for slow busses to
+ * preemptible - many of them need to sleep and wait for slow busses to
  * complete.
  */
 static irqreturn_t irq_thread_fn(struct irq_desc *desc,
@@ -2749,7 +2749,7 @@ int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
  *	@which: One of IRQCHIP_STATE_* the caller wants to know about
- *	@state: a pointer to a boolean where the state is to be storeed
+ *	@state: a pointer to a boolean where the state is to be stored
  *
  *	This call snapshots the internal irqchip state of an
  *	interrupt, returning into @state the bit corresponding to
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 651a4ad6d711..7a9465ffe71d 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -356,7 +356,7 @@ void irq_matrix_reserve(struct irq_matrix *m)
  * irq_matrix_remove_reserved - Remove interrupt reservation
  * @m:		Matrix pointer
  *
- * This is merily a book keeping call. It decrements the number of globally
+ * This is merely a book keeping call. It decrements the number of globally
  * reserved interrupt bits. This is used to undo irq_matrix_reserve() when the
  * interrupt was never in use and a real vector allocated, which undid the
  * reservation.
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index def48589ea48..61ca924ef4b4 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -7,7 +7,7 @@
 
 /**
  * irq_fixup_move_pending - Cleanup irq move pending from a dying CPU
- * @desc:		Interrupt descpriptor to clean up
+ * @desc:		Interrupt descriptor to clean up
  * @force_clear:	If set clear the move pending bit unconditionally.
  *			If not set, clear it only when the dying CPU is the
  *			last one in the pending mask.
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index bd1d85c610aa..0c46e9fe3a89 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -128,7 +128,7 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
 	if (!try_retrigger(desc))
 		err = irq_sw_resend(desc);
 
-	/* If the retrigger was successfull, mark it with the REPLAY bit */
+	/* If the retrigger was successful, mark it with the REPLAY bit */
 	if (!err)
 		desc->istate |= IRQS_REPLAY;
 	return err;
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 773b6105c4ae..c31860569931 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -84,7 +84,7 @@ void irq_timings_disable(void)
  * 2. Log interval
  *
  * We saw the irq timings allow to compute the interval of the
- * occurrences for a specific interrupt. We can reasonibly assume the
+ * occurrences for a specific interrupt. We can reasonably assume the
  * longer is the interval, the higher is the error for the next event
  * and we can consider storing those interval values into an array
  * where each slot in the array correspond to an interval at the power
@@ -416,7 +416,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 	 * Copy the content of the circular buffer into another buffer
 	 * in order to linearize the buffer instead of dealing with
 	 * wrapping indexes and shifted array which will be prone to
-	 * error and extremelly difficult to debug.
+	 * error and extremely difficult to debug.
 	 */
 	for (i = 0; i < count; i++) {
 		int index = (start + i) & IRQ_TIMINGS_MASK;
@@ -514,7 +514,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
  *      If more than the array size interrupts happened during the
  *      last busy/idle cycle, the index wrapped up and we have to
  *      begin with the next element in the array which is the last one
- *      in the sequence, otherwise it is a the index 0.
+ *      in the sequence, otherwise it is at the index 0.
  *
  * - have an indication of the interrupts activity on this CPU
  *   (eg. irq/sec)
-- 
2.25.1

