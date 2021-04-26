Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9936B2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhDZMVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:21:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33718 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhDZMVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:21:39 -0400
Date:   Mon, 26 Apr 2021 12:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619439657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r2Uo+iOww4BXxQMIH5xkVfUTKcbBlrR+sZ6ffyuaYrc=;
        b=dth4D0G/Zb4Pbplaz2KnMBOPe3yIohOaRo4kgTPyVw5lu47oKJ2kfA8wvO+KlMZSn+GN39
        ofdc2XUvoOUBaJ6yvFFTEnxWKc90XAos16HYqDOu6PK4UvXwhUprOwtHuZTgy8oj8o6tYN
        K+zcuv7vWFEkMiowSKjNcUmAvLQ8qzuVWOXJ99+DZddhESqS/ZegVSeGVN8WjfSC5WkuAC
        uq/k30WXR4DJIDjXptcPshfXi1Ml5y4VnT0o88fpRS0sIn5RvUuyWUvLwylvZL8mk72clA
        Ow2iK4t4ivWFwy+XqXtyaXjbJRXc8k/Og6US1GlGw/wlXFzA7WQFzxOrXAierg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619439657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r2Uo+iOww4BXxQMIH5xkVfUTKcbBlrR+sZ6ffyuaYrc=;
        b=cMlcit8S9QSGn6bdZdjL6yGNMlbNWT8AvQWVo7cMvZ4n2VWWoFMVpFy5+askRDAK4l+ldN
        2YHcwFju3y4FIPAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for v5.13-rc1
Message-ID: <161943945302.1498.9201552430413038175.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-04-26

up to:  9a98bc2cf08a: x86/vector: Add a sanity check to prevent IRQ2 allocations


A single commit to make the vector allocation code more resilent against an
accidental allocation attempt for IRQ2.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      x86/vector: Add a sanity check to prevent IRQ2 allocations


 arch/x86/kernel/apic/vector.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3c9c7492252f..9b75a70ebf90 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -543,6 +543,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
 		return -ENOSYS;
 
+	/*
+	 * Catch any attempt to touch the cascade interrupt on a PIC
+	 * equipped system.
+	 */
+	if (WARN_ON_ONCE(info->flags & X86_IRQ_ALLOC_LEGACY &&
+			 virq == PIC_CASCADE_IR))
+		return -EINVAL;
+
 	for (i = 0; i < nr_irqs; i++) {
 		irqd = irq_domain_get_irq_data(domain, virq + i);
 		BUG_ON(!irqd);
@@ -745,6 +753,11 @@ void __init lapic_assign_system_vectors(void)
 
 	/* Mark the preallocated legacy interrupts */
 	for (i = 0; i < nr_legacy_irqs(); i++) {
+		/*
+		 * Don't touch the cascade interrupt. It's unusable
+		 * on PIC equipped machines. See the large comment
+		 * in the IO/APIC code.
+		 */
 		if (i != PIC_CASCADE_IR)
 			irq_matrix_assign(vector_matrix, ISA_IRQ_VECTOR(i));
 	}

