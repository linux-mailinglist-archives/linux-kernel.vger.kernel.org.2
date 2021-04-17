Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A13630F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhDQPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 11:42:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58299 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236377AbhDQPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 11:42:28 -0400
Received: (qmail 73905 invoked by uid 1000); 17 Apr 2021 11:42:00 -0400
Date:   Sat, 17 Apr 2021 11:42:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: dummy_hcd: fix gpf in gadget_setup
Message-ID: <20210417154200.GB73141@rowland.harvard.edu>
References: <20210417125212.6274-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417125212.6274-1-mail@anirudhrb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 06:22:09PM +0530, Anirudh Rayabharam wrote:
> Fix a general protection fault reported by syzbot due to a race between
> gadget_setup() and gadget_unbind() in raw_gadget.
> 
> The gadget core is supposed to guarantee that there won't be any more
> callbacks to the gadget driver once the driver's unbind routine is
> called. That guarantee is enforced in usb_gadget_remove_driver as
> follows:
> 
>         usb_gadget_disconnect(udc->gadget);
>         if (udc->gadget->irq)
>                 synchronize_irq(udc->gadget->irq);
>         udc->driver->unbind(udc->gadget);
>         usb_gadget_udc_stop(udc);
> 
> usb_gadget_disconnect turns off the pullup resistor, telling the host
> that the gadget is no longer connected and preventing the transmission
> of any more USB packets. Any packets that have already been received
> are sure to processed by the UDC driver's interrupt handler by the time
> synchronize_irq returns.
> 
> But this doesn't work with dummy_hcd, because dummy_hcd doesn't use
> interrupts; it uses a timer instead.  It does have code to emulate the
> effect of synchronize_irq, but that code doesn't get invoked at the
> right time -- it currently runs in usb_gadget_udc_stop, after the unbind
> callback instead of before.  Indeed, there's no way for
> usb_gadget_remove_driver to invoke this code before the unbind
> callback.
> 
> To fix this, move the synchronize_irq() emulation code to dummy_pullup
> so that it runs before unbind. Also, add a comment explaining why it is
> necessary to have it there.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Reported-by: syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/usb/gadget/udc/dummy_hcd.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index ce24d4f28f2a..d0dae6406612 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -903,6 +903,21 @@ static int dummy_pullup(struct usb_gadget *_gadget, int value)
>  	spin_lock_irqsave(&dum->lock, flags);
>  	dum->pullup = (value != 0);
>  	set_link_state(dum_hcd);
> +	if (value == 0) {
> +		/*
> +		 * emulate synchronize_irq(): wait for callbacks to finish
> +		 * This seems to be the best to place to emulate the call
> +		 * to synchronize_irq(). Doing it in dummy_udc_stop() would
> +		 * be too late since it is called after the unbind callback.
> +		 * Also, there is no way for core:usb_gadget_remove_driver()
> +		 * to invoke this code before the unbind callback.
> +		 */

This comment could be edited a little better.  It should start with a 
capital letter, and there should be a period at the end of the first 
line.  There is an extra "to" before "place to emulate".  The last 
sentence isn't really needed.

Also, you could be more specific.  The call to synchronize_irq() which 
we want to emulate is the one in usb_gadget_remove_driver().  And the 
reason we want to do it before the unbind callback is because unbind 
shouldn't be invoked until all the other callbacks are finished.

Once those changes are made, you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

> +		while (dum->callback_usage > 0) {
> +			spin_unlock_irqrestore(&dum->lock, flags);
> +			usleep_range(1000, 2000);
> +			spin_lock_irqsave(&dum->lock, flags);
> +		}
> +	}
>  	spin_unlock_irqrestore(&dum->lock, flags);
>  
>  	usb_hcd_poll_rh_status(dummy_hcd_to_hcd(dum_hcd));
> @@ -1004,14 +1019,6 @@ static int dummy_udc_stop(struct usb_gadget *g)
>  	spin_lock_irq(&dum->lock);
>  	dum->ints_enabled = 0;
>  	stop_activity(dum);
> -
> -	/* emulate synchronize_irq(): wait for callbacks to finish */
> -	while (dum->callback_usage > 0) {
> -		spin_unlock_irq(&dum->lock);
> -		usleep_range(1000, 2000);
> -		spin_lock_irq(&dum->lock);
> -	}
> -
>  	dum->driver = NULL;
>  	spin_unlock_irq(&dum->lock);
>  
> -- 
> 2.26.2
> 
