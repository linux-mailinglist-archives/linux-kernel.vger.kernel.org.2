Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC7422CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhJEPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhJEPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:50:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D784C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:48:30 -0700 (PDT)
Date:   Tue, 5 Oct 2021 17:48:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633448908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VSZyxM2r/CBcFXTQ9wKe2flyiU3VGPai8WyWlx7Gs5U=;
        b=kj3t6RU18pFKtLYgHf7PB6U2Lb9/HC3oVKido8zAa9G2HUmVtII0nRiqTSM1a0VYVFqN2J
        RD/zE3xxV6XqD8ZeblS+47h/gPNk5jx+bng4W2lTir2jgXZFjejuBBtqawuaEpf8tFVMYP
        ZejavDKuj/Yuh1iWcuA7q6X30yqZfowg62d5K/6hpayBm34/XxQolTM0/R8SEHRXqd66om
        QTcZsHZVOBtjdcN4UBXtdcHa/JBUGC0J6jEZAFQPbD4Wl/hhr7iG3vAYXUsG53JY6LzOM/
        Ux9nYItAyAlFwfVUYoRiGFWViTEr0+gEKFtC2liKkN9Hv/Vbnwi86X2i/PoOcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633448908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VSZyxM2r/CBcFXTQ9wKe2flyiU3VGPai8WyWlx7Gs5U=;
        b=NBTS35qgiE9YQpiXRC4GMGGDgswGdgl2G1klJWOdjedCmqdy4OKMf/h8oEWVN2BRhnWPnd
        vLL2JNRsaoGXhODA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/5] irq_work: Ensure that irq_work runs in in-IRQ
 context.
Message-ID: <20211005154827.h2pna3vfqbo7icjn@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210927211919.310855-3-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-27 23:19:16 [+0200], To linux-kernel@vger.kernel.org wrote:
> The irq-work callback should be invoked in hardirq context and some
> callbacks rely on this behaviour. At the time irq_work_run_list()
> interrupts should be disabled but the important part is that the
> callback is invoked from a in-IRQ context.
> The "disabled interrupts" check can be satisfied by disabling interrupts
> from a kworker which is not the intended context.
> 
> Ensure that the callback is invoked from hardirq context and not just
> with disabled interrupts.

As noted by lkp, this triggers from smpcfd_dying_cpu().
Do we care enough to change this or should I rather drop this one?

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/irq_work.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index db8c248ebc8c8..caf2edffa20d5 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -167,7 +167,7 @@ static void irq_work_run_list(struct llist_head *list)
>  	struct irq_work *work, *tmp;
>  	struct llist_node *llnode;
>  
> -	BUG_ON(!irqs_disabled());
> +	BUG_ON(!in_hardirq());
>  
>  	if (llist_empty(list))
>  		return;

Sebastian
