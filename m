Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45E43DF90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhJ1K6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:58:00 -0400
Received: from forward500o.mail.yandex.net ([37.140.190.195]:32998 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhJ1K56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:57:58 -0400
Received: from sas1-900f78e25d27.qloud-c.yandex.net (sas1-900f78e25d27.qloud-c.yandex.net [IPv6:2a02:6b8:c14:39a3:0:640:900f:78e2])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 75611941A89;
        Thu, 28 Oct 2021 13:55:27 +0300 (MSK)
Received: from sas2-1cbd504aaa99.qloud-c.yandex.net (2a02:6b8:c14:7101:0:640:1cbd:504a [2a02:6b8:c14:7101:0:640:1cbd:504a])
        by sas1-900f78e25d27.qloud-c.yandex.net (mxback/Yandex) with ESMTP id q8kJzHGsh3-tQEuCcFV;
        Thu, 28 Oct 2021 13:55:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1635418527;
        bh=udSJvaxIUlBbTSQoZiMCrwbkjTdE+UC73DQGiSmy6yc=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=THXEc31zi9wOb6+7NfBvXlkD2tPknlqjd7xgVKWeiVyTuX40gC8vCIxLBKmODIJA7
         PberpMoWg0C/nwZXbhAKRvowUFdPAs5UKF5f8G6KpReOwoeiHEZeHeleXZSIi+Gfc5
         q01QApuCzjGmmdQXl8MsBYgfz8Eg2DSJDMxQKT6g=
Authentication-Results: sas1-900f78e25d27.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas2-1cbd504aaa99.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id KNJkzVzdNo-tPJWa7sa;
        Thu, 28 Oct 2021 13:55:26 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Thu, 28 Oct 2021 13:55:23 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Marc Zyngier <maz@kernel.org>
Cc:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        tglx@linutronix.de, palmer@dabbelt.com, heiko@sntech.de,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
Message-ID: <20211028135523.5cf4b66b@redslave.neermore.group>
In-Reply-To: <87a6ixbcse.wl-maz@kernel.org>
References: <20211024013303.3499461-1-guoren@kernel.org>
        <20211024013303.3499461-4-guoren@kernel.org>
        <87a6ixbcse.wl-maz@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc and Guo Ren!

On Mon, 25 Oct 2021 11:48:33 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Sun, 24 Oct 2021 02:33:03 +0100,
> guoren@kernel.org wrote:
> > 
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > driver, only the first interrupt could be handled, and continue irq
> > is blocked by hw. Because the thead,c900-plic couldn't complete
> > masked irq source which has been disabled in enable register. Add
> > thead_plic_chip which fix up c906-plic irq source completion
> > problem by unmask/mask wrapper.
> > 
> > Here is the description of Interrupt Completion in PLIC spec [1]:
> > 
> > The PLIC signals it has completed executing an interrupt handler by
> > writing the interrupt ID it received from the claim to the
> > claim/complete register. The PLIC does not check whether the
> > completion ID is the same as the last claim ID for that target. If
> > the completion ID does not match an interrupt source that is
> > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > completion is silently ignored.  
> 
> Given this bit of the spec...
> 
> > +static void plic_thead_irq_eoi(struct irq_data *d)
> > +{
> > +	struct plic_handler *handler =
> > this_cpu_ptr(&plic_handlers); +
> > +	if (irqd_irq_masked(d)) {
> > +		plic_irq_unmask(d);
> > +		writel(d->hwirq, handler->hart_base +
> > CONTEXT_CLAIM);
> > +		plic_irq_mask(d);
> > +	} else {
> > +		writel(d->hwirq, handler->hart_base +
> > CONTEXT_CLAIM);
> > +	}
> > +}
> > +  
> 
> ... it isn't obvious to me why this cannot happen on an SiFive PLIC.

This indeed happens with SiFive PLIC. I am currently tinkering with
da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. However
with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
begins to work fine.

May be these change should be propagated to plic_irq_eoi instead of
making a new function ?

> 
> And it isn't only for threaded interrupts in oneshot mode. Any driver
> can mask an interrupt from its handler after having set the
> IRQ_DISABLE_UNLAZY flag, and the interrupt would need the exact same
> treatment.
> 
> 	M.
> 

---
diff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c index cf74cfa82045..259065d271ef
100644 --- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -163,7 +163,13 @@ static void plic_irq_eoi(struct irq_data *d)
 {
        struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
 
-       writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+       if (irqd_irq_masked(d)) {
+               plic_irq_unmask(d);
+               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+               plic_irq_mask(d);
+       } else {
+               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+       }
 }
 
 static struct irq_chip plic_chip = {
