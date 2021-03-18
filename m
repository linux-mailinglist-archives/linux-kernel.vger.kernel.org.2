Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC9340E43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhCRTaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhCRT3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:29:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C835C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:29:45 -0700 (PDT)
Message-Id: <20210318192819.795280387@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616095781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MyrChZScikc3Vj+iBqMdUcIc5sbYRawJcbm85JMUQqg=;
        b=JeFfOOXrr4wTLSd56PyYMBAIzefcAU1o1J0WJA5oJQ04Q7xw4BpH7tYphZc4z8XeR6AbCM
        Vp4A9XEHtBc+Ysg9+kEsZ4iMG3XVtR8CsagaDbx7/5spXzlK4YZLkheAfQ1pwzCF1q/ndO
        i10SoVk/lpxaHTRssiqpFZlD9OeUPThQhn59ieNgvAwh1DoZxa86PBJScgDpdAyTG6COQw
        lQX2sPJn6K4DvGUjsQZaFiXEv2Izr43b1o7YvjWfm59A2+UZMoyNPBrgiCr7z/p6fThKsq
        VRahHpGJYB+RRMwTm1NFGJDbAbrYgPnFgDoG5pDMUDx+gwidyhaPuf3tXrTqcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616095781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MyrChZScikc3Vj+iBqMdUcIc5sbYRawJcbm85JMUQqg=;
        b=3HgKywDsBFiXcQzJ+/uMoIGv/yuspY2egZ/06mJxfCMmok3LwDmykLHvyKfaAjubNUqeoX
        ZVW8CHcjnXhnWjBQ==
Date:   Thu, 18 Mar 2021 20:26:48 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [patch 2/2] x86/vector: Add a sanity check to prevent IRQ2 allocations
References: <20210318192646.868059483@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent another incidental removal of the IRQ2 ignore logic in the
IO/APIC code going unnoticed add a sanity check. Add some commentry at the
other place which ignores IRQ2 while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/vector.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -543,6 +543,14 @@ static int x86_vector_alloc_irqs(struct
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
@@ -745,6 +753,11 @@ void __init lapic_assign_system_vectors(
 
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

