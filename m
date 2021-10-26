Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1D43B4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhJZOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhJZOz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:55:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25F3B60E73;
        Tue, 26 Oct 2021 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635260014;
        bh=XWVXck4BTc3O6D5MfPddpqYC5tdKxec60b3+5QEzROQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhifqTNUtFD8nrTJq+H5e70MsMniLlZ/R4K8HpU02g//8sjFRZVkrqLdWhsjxJRLc
         nfCvXMMz6UkRZZXDGk6CBz9lmbKQieG7B3yY1Ku7OEt68nPb17IWjRF/GAHtmJsRDW
         E9N/mDX2e0Lo9UfJsFYm3hQvg3CUfu9bbJcO+0bM=
Date:   Tue, 26 Oct 2021 16:53:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v7] tty: Fix the keyboard led light display problem
Message-ID: <YXgWbG30THLgS5zJ@kroah.com>
References: <20211026024032.15897-1-changlianzhi@uniontech.com>
 <YXgPZw3eluaaVvRc@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXgPZw3eluaaVvRc@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:23:35PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 26, 2021 at 10:40:32AM +0800, lianzhi chang wrote:
> > Switching from the desktop environment to the tty environment,
> > the state of the keyboard led lights and the state of the keyboard
> > lock are inconsistent. This is because the attribute kb->kbdmode
> > of the tty bound in the desktop environment (xorg) is set to
> 
> Xorg
> 
> I think I already pointed that out.
> 
> > VC_OFF, which causes the ledstate and kb->ledflagstate
> > values of the bound tty to always be 0, which causes the switch
> > from the desktop When to the tty environment, the LED light
> > status is inconsistent with the keyboard lock status.
> 
> ...
> 
> > +static void kbd_update_ledstate(struct input_dev *dev)
> > +{
> > +	if (!!test_bit(LED_NUML, dev->led) !=
> > +	    !!(ledstate & BIT(VC_NUMLOCK)))
> > +		ledstate ^= BIT(VC_NUMLOCK);
> > +	if (!!test_bit(LED_CAPSL, dev->led) !=
> > +	    !!(ledstate & BIT(VC_CAPSLOCK)))
> > +		ledstate ^= BIT(VC_CAPSLOCK);
> > +	if (!!test_bit(LED_SCROLLL, dev->led) !=
> > +	    !!(ledstate & BIT(VC_SCROLLOCK)))
> > +		ledstate ^= BIT(VC_SCROLLOCK);
> 
> This looks ugly.

Agreed, we also have the vc_kbd_led() and friend functions that seem to
be ignored here :(

> 
> Since LED_* are part of uAPI and VC_* are not, perhaps
> makes sense to modify kbd_kern.h and optimize above
> (disclaimer: compile tested only, no locking or other
>  synchronization have been checked / reviewed / etc):
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..2b04eaa5c6fd 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -49,6 +49,11 @@
>  
>  #include <asm/irq_regs.h>
>  
> +/* We rely on these in kbd_update_ledstate() */
> +static_assert(VC_NUMLOCK == LED_NUML);
> +static_assert(VC_CAPSLOCK == LED_CAPSL);
> +static_assert(VC_SCROLLOCK == LED_SCROLLL);

This makes more sense, these should be in sync.

> +
>  /*
>   * Exported functions/variables
>   */
> @@ -1130,6 +1135,15 @@ static void kbd_init_leds(void)
>  
>  #endif
>  
> +static void kbd_update_ledstate(struct input_dev *dev)
> +{
> +	unsigned long leds = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
> +	unsigned long newstate = *dev->led;
> +
> +	newstate ^= ledstate;
> +	ledstate ^= newstate & leds;

You should document the bit twiddling hack you are doing here just to
make it easier to understand :)

Also, ledstate is an unsigned int, not unsigned long, perhaps make them
all u32 for now to make it obvious they are the same?  Or u64?

thanks,

greg k-h
