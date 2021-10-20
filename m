Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB32243550B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJTVOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhJTVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:31 -0400
Date:   Wed, 20 Oct 2021 21:12:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OavyD7pNmN8ZfHY32FR5jV8XhgzTk+b1d8GjTUb2Peo=;
        b=aHbRrOPiT56dfYpp6PmIYlViJBysEbxcgcE6sDHnEZ2gA1DtFzeaerDKym20STx1e6GVqy
        p7WcZaF4otQVspQcH1T3BqtDi3cBTTI4lScIo5UXH4Z0KNA2UAHQhYCaC6HbZ64VTh4pyN
        eFNHrOgneQSyoJPcvbnDFH7056Ts9v8LNz0qRBi/ym+0fyO7jbaeO9Rov3Ii5lpysJKqb7
        1BZbVsYjcoOyHdS7p5Fq0LcmJ+HqMI2UF2ldpTzxGLt+h7nhb1oLWQUfWDNl7IHUvNIbjD
        Hcmoiov6X6vt0F778QACvIJCwHzo0rrtEpzR7qQ8MPLijPdsSXsUE2oWtfmu1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OavyD7pNmN8ZfHY32FR5jV8XhgzTk+b1d8GjTUb2Peo=;
        b=TBvN8Fr1y5iK3/157emuAmDJx6NT2sXeoUkDJ4bksXrCM47v4Rjia4TKSp6K/Pmua00YRS
        V8h3unYftY55h1Dg==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-bcm7038-l1: Gate use of CPU
 logical map to MIPS
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-5-f.fainelli@gmail.com>
References: <20211020184859.2705451-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433522.25758.3857226141259616241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     35eb2ef5df42d3c3d2186ae6dab5622a31e6ceee
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/35eb2ef5df42d3c3d2186ae6dab5622a31e6ceee
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:50 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:33 +01:00

irqchip/irq-bcm7038-l1: Gate use of CPU logical map to MIPS

The use of the cpu_logical_map[] array is only relevant for MIPS based
platform where this driver is used as a first level interrupt controller
and contains multiple register groups to map with an associated CPU.

On ARM/ARM64 based systems this interrupt controller is present and used
as a second level interrupt controller hanging off the ARM GIC. That
copy of the interrupt controller contains a single group, resulting in
the intc->cpus[] array to be of size 1.

Things happened to work in that case because we install that interrupt
controller as a chained handler which does not allow it to be affine to
any CPU but the boot CPU which happens to be 0, therefore we never
de-reference past intc->cpus[] but with the current code in place, we do
leave a chance of de-referencing the array past its bounds.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-5-f.fainelli@gmail.com
---
 drivers/irqchip/irq-bcm7038-l1.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 14caf32..3c4e348 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -28,9 +28,6 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/syscore_ops.h>
-#ifdef CONFIG_ARM
-#include <asm/smp_plat.h>
-#endif
 
 #define IRQS_PER_WORD		32
 #define REG_BYTES_PER_IRQ_WORD	(sizeof(u32) * 4)
@@ -127,7 +124,7 @@ static void bcm7038_l1_irq_handle(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
 #else
 	cpu = intc->cpus[0];
@@ -301,7 +298,7 @@ static int bcm7038_l1_suspend(void)
 	u32 val;
 
 	/* Wakeup interrupt should only come from the boot cpu */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	boot_cpu = cpu_logical_map(0);
 #else
 	boot_cpu = 0;
@@ -325,7 +322,7 @@ static void bcm7038_l1_resume(void)
 	struct bcm7038_l1_chip *intc;
 	int boot_cpu, word;
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	boot_cpu = cpu_logical_map(0);
 #else
 	boot_cpu = 0;
