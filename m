Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3469935A062
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhDINxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:53:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50876 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDINxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:53:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617976368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlzmOVxwr4C/QvkXDWcabTiao9Ep+tBVADbOwAhH70o=;
        b=ja4zkQonmkR4bCQuaWge1rljj7nQO8IJFn+niJhCXPkyiJ6oSc7GwE6qScTItiDtdPFvBa
        jegD+lLkHL7uDGvzDdnAUSL0VFCcBr6Hbt58qgZNmkZwsqQBXB5kJVlvQ4DfxYI2xpI5lv
        SPk6NziWvSiXd+FhO0/gy+v4qqgcz/ZzW58j+HDGroGHm+rxDzETojf6xZDqS4V4zD/oum
        c5ODgmSYJX2MkJF8QKai2EzKswhT72ghaWnaFzT+isMRkSZzbu28hBlbw0DqFbx9ICeb/s
        pk/FAdFbXW9cSfL/QoKtkvai5yj6DSH9yJy/8gEemIihraaeyj9ip3PhTlPrnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617976368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlzmOVxwr4C/QvkXDWcabTiao9Ep+tBVADbOwAhH70o=;
        b=xzD+oJ4z+s5lAisCPoFhFJ78JG5yeERdbr9ybk3vTBbUneIoqtXh48jS3BfYLaQxJoGk6g
        yDi/qM8J54+q5CDA==
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH 05/10] genirq: Let purely flow-masked ONESHOT irqs through unmask_threaded_irq()
In-Reply-To: <20210408154326.3988781-6-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com> <20210408154326.3988781-6-valentin.schneider@arm.com>
Date:   Fri, 09 Apr 2021 15:52:48 +0200
Message-ID: <87v98v4lan.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08 2021 at 16:43, Valentin Schneider wrote:
> A subsequent patch will let IRQs end up in irq_finalize_oneshot() without
> IRQD_IRQ_MASKED, but with IRQD_IRQ_FLOW_MASKED set instead. Let such IRQs
> receive their final ->irq_eoi().
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/irq/manage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index e976c4927b25..59c8056d6714 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1076,7 +1076,7 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
>  	desc->threads_oneshot &= ~action->thread_mask;
>  
>  	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
> -	    irqd_irq_masked(&desc->irq_data))
> +	    (irqd_irq_masked(&desc->irq_data) || irqd_irq_flow_masked(&desc->irq_data)))
>  		unmask_threaded_irq(desc);

This creates better code when you have '|' instead of '||' because the
compiler can spare a conditional and combine the bit check into one.

Thanks,

        tglx
