Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638B53F08E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHRQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:18:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhHRQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:18:30 -0400
Date:   Wed, 18 Aug 2021 18:17:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629303473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COIZjFE+QpiqW1vgmef7bfSA5uIv7ItVkGPh67WOnuI=;
        b=0tq0RyJndnU205fpXjnwy/AajvpF8L/7ellXA2SGrYReE5E8yIxdLYsh5gmH1NJVrIjzaZ
        vYG6Zm2qcqLWlZ87qzTDl/Jy9CCjDIOiLhQcFt6VZWmpVhT9ABxwBI6VuH1nwQ9ibU92y0
        AZuCvEdn9iO4rqQ3jQ9fECg3G2N2ao4Dq325Z04vcZ2pRd6e/GO7oa19k5ALTRYzFavoAQ
        xrihDtMeby4S1F7Bc78N9DfuqV/pLKJuTCHmNmQPeMYF0xz8J+zl34XvbNraVuSWX4ZZJn
        LUHPFSE8lhN062LltrixFTXN2lcvC8CQIAPfbwGqqHMLcwe7Rv/28qBaLi6f6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629303473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COIZjFE+QpiqW1vgmef7bfSA5uIv7ItVkGPh67WOnuI=;
        b=UM8gwUAtzbvGGD8ByCKwJDdMCltoMKTzKUqQX2QMTEL9GuXRt1sKhCCeMeesnRHT6txoLO
        zmJ+s1Xd+W6U3EAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        team-linux@rtst.co.kr, mkbyeon@lselectric.co.kr,
        khchoib@lselectric.co.kr
Subject: Re: [PATCH v2] usb: chipidea: local_irq_save/restore added for
 hw_ep_prime
Message-ID: <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
References: <20210817095313.GA671484@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210817095313.GA671484@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 18:53:13 [+0900], Jeaho Hwang wrote:
> hw_ep_prime sometimes fails if irq occurs while it rus on RT kernel.

How/ why does it fail? Which IRQ occurs? Does it also occur without RT
and with threadirqs enabled?

> local_irq_save/restore is added inside the function to gurantee atomicity.
> only effective for preempt_rt since hw_ep_prime is called inside top half
> or spin_lock_irqsave. No effect is expected for standard linux.

How is that helping?
#1 
  udc_irq() -> isr_tr_complete_handler() -> isr_tr_complete_low ->
   _hardware_dequeue() -> reprime_dtd() -> hw_ep_prime()

udc_irq() acquires ci->lock.

#2 
  ep_queue -> _ep_queue() ->_hardware_enqueue() -> hw_ep_prime()

ep_queue acquires hwep->lock. Which is actually ci->lock.

So if I read this right then hw_ep_prime() may not be interrupted in the
middle of its operation (but preempted) because each path is protected
by the lock.

isr_tr_complete_low() drops hwep->lock and acquires it again so it that
phase another thread may acquire it.

> Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 8834ca613721..a624eddb3e22 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -191,22 +191,31 @@ static int hw_ep_get_halt(struct ci_hdrc *ci, int num, int dir)
>  static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
>  {
>  	int n = hw_ep_bit(num, dir);
> +	unsigned long flags;
> +	int ret = 0;
>  
>  	/* Synchronize before ep prime */
>  	wmb();
>  
> -	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
> +	/* irq affects this routine so irq should be disabled on RT.
> +	 * on standard kernel, irq is already disabled by callers.

The important part is _how_ it is affected. If locking works then
nothing should read/ write the HW register. If the lock is briefly
dropped then another thread _may_ read/ write the registers but not
within this function.

If this function here is sensitive to timing (say the cpu_relax() loop
gets interrupt for 1ms) then it has to be documented as such.

> +	 */
> +	local_irq_save(flags);
> +	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num))) {
> +		local_irq_restore(flags);
>  		return -EAGAIN;
> +	}
>  
>  	hw_write(ci, OP_ENDPTPRIME, ~0, BIT(n));
>  
>  	while (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
>  		cpu_relax();
>  	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
> -		return -EAGAIN;
> +		ret = -EAGAIN;
>  
> +	local_irq_restore(flags);
>  	/* status shoult be tested according with manual but it doesn't work */
> -	return 0;
> +	return ret;
>  }
>  
>  /**

Sebastian
