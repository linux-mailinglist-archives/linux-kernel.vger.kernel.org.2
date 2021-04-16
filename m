Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCF3623E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbhDPP2D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Apr 2021 11:28:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48407 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236062AbhDPP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:28:00 -0400
Received: (qmail 43914 invoked by uid 1000); 16 Apr 2021 11:27:34 -0400
Date:   Fri, 16 Apr 2021 11:27:34 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
Message-ID: <20210416152734.GB42403@rowland.harvard.edu>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu>
 <YHkjUwhlCYIxCUYt@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YHkjUwhlCYIxCUYt@anirudhrb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:10:35AM +0530, Anirudh Rayabharam wrote:
> On Tue, Apr 13, 2021 at 12:13:11PM -0400, Alan Stern wrote:
> > Maybe we can test this reasoning by putting a delay just before the call 
> > to dum->driver->setup.  That runs in the timer handler, so it's not a 
> > good place to delay, but it may be okay just for testing purposes.
> > 
> > Hopefully this patch will make the race a lot more likely to occur.  Is 
> 
> Hi Alan, 
> 
> Indeed, I was able to reproduce this bug easily on my machine with your
> delay patch applied and using this syzkaller program:
> 
> syz_usb_connect$cdc_ncm(0x1, 0x6e, &(0x7f0000000040)={{0x12, 0x1, 0x0, 0x2, 0x0, 0x0, 0x8, 0x525, 0xa4a1, 0x40, 0x1, 0x2, 0x3, 0x1, [{{0x9, 0x2, 0x5c, 0x2, 0x1, 0x0, 0x0, 0x0, {{0x9, 0x4, 0x0, 0x0, 0x1, 0x2, 0xd, 0x0, 0x0, {{0x5}, {0x5}, {0xd}, {0x6}}, {{0x9, 0x5, 0x81, 0x3, 0x200}}}}}}]}}, &(0x7f0000000480)={0x0, 0x0, 0x0, 0x0, 0x3, [{0x0, 0x0}, {0x0, 0x0}, {0x0, 0x0}]})
> 
> I also tested doing the synchronize_irq emulation in dummy_pullup and it
> fixed the issue. The patch is below.

That's great!  Thanks for testing.

> Thanks!
> 
> 	- Anirudh.
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index ce24d4f28f2a..931d4612d859 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -903,6 +903,12 @@ static int dummy_pullup(struct usb_gadget *_gadget, int value)
>  	spin_lock_irqsave(&dum->lock, flags);
>  	dum->pullup = (value != 0);
>  	set_link_state(dum_hcd);
> +	/* emulate synchronize_irq(): wait for callbacks to finish */
> +	while (dum->callback_usage > 0) {
> +		spin_unlock_irqrestore(&dum->lock, flags);
> +		usleep_range(1000, 2000);
> +		spin_lock_irqsave(&dum->lock, flags);
> +	}

We should do this only if value == 0.  No synchronization is needed when 
the pullup is turned on.

Also, there should be a comment explaining that this is necessary 
because there's no other place to emulate the call made to 
synchronize_irq() in core.c:usb_gadget_remove_driver().

>  	spin_unlock_irqrestore(&dum->lock, flags);
>  
>  	usb_hcd_poll_rh_status(dummy_hcd_to_hcd(dum_hcd));
> @@ -1005,13 +1011,6 @@ static int dummy_udc_stop(struct usb_gadget *g)
>  	dum->ints_enabled = 0;
>  	stop_activity(dum);
>  
> -	/* emulate synchronize_irq(): wait for callbacks to finish */
> -	while (dum->callback_usage > 0) {
> -		spin_unlock_irq(&dum->lock);
> -		usleep_range(1000, 2000);
> -		spin_lock_irq(&dum->lock);
> -	}
> -
>  	dum->driver = NULL;
>  	spin_unlock_irq(&dum->lock);

Actually, I wanted to move this emulation code into a new subroutine and 
then call that subroutine from _both_ places.  Would you like to write 
and submit a patch that does this?

Alan Stern
