Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAE36264C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhDPRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:06:08 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21384 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhDPRGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618592729; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=l9tCr5oF9NwX0NexZHlzplp9pNXEBjdsbW0xWY6ITR0ERnujW5y6Vk2L7PhmVcGTJbuRcNDc4jUkKRQrM0ui2XKUF0fA1LGQ1T1+f74rE4ZbuJWQHhpMpB6ez3NXk8CPJXKch6F9IjeXAlh9kWhPmKIK55JR19QlD8Ve2HiBdi0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618592729; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8iAmLaMWDNgUTIJfFBVOrF/tJoLM3YU3lAg8lHACIsE=; 
        b=LgOsSZ8vRxrlNdlLT5jmsCjkpsy3G7VLjAN1UPMPT/dtHahWoNMXwxkQcMj2Lik+HOyY+yH6hqqjLjuqtrZaoQ2C8f78OmLMQ7qWsZYBdLlGwUkZ46UCLOebHgn2V+NyGy33i2KcCRoo3SlBOjA6jVbw/iji1Azt82Zk+RUziQs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618592729;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=8iAmLaMWDNgUTIJfFBVOrF/tJoLM3YU3lAg8lHACIsE=;
        b=fSU+i1kQFXNbFh/PaXcPKNkyGUk4UnJSurPgTju4LYKKLSBtBkZWVK+l5AL6cY0P
        WicPfJK5o8iFK8LgAu7IPP/WCjcCMoyVIkf5xM3/XOtM4e/PYMgaDU7KQkhBva2yTeQ
        nSafb08+dLRYMc+axTVa9ztCGYYsmPy78HmW2jKM=
Received: from anirudhrb.com (49.207.216.151 [49.207.216.151]) by mx.zohomail.com
        with SMTPS id 161859272672633.015416626727756; Fri, 16 Apr 2021 10:05:26 -0700 (PDT)
Date:   Fri, 16 Apr 2021 22:35:20 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <YHnD0AVXiwdsw46L@anirudhrb.com>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu>
 <YHkjUwhlCYIxCUYt@anirudhrb.com>
 <20210416152734.GB42403@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416152734.GB42403@rowland.harvard.edu>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:27:34AM -0400, Alan Stern wrote:
> On Fri, Apr 16, 2021 at 11:10:35AM +0530, Anirudh Rayabharam wrote:
> > On Tue, Apr 13, 2021 at 12:13:11PM -0400, Alan Stern wrote:
> > > Maybe we can test this reasoning by putting a delay just before the call 
> > > to dum->driver->setup.  That runs in the timer handler, so it's not a 
> > > good place to delay, but it may be okay just for testing purposes.
> > > 
> > > Hopefully this patch will make the race a lot more likely to occur.  Is 
> > 
> > Hi Alan, 
> > 
> > Indeed, I was able to reproduce this bug easily on my machine with your
> > delay patch applied and using this syzkaller program:
> > 
> > syz_usb_connect$cdc_ncm(0x1, 0x6e, &(0x7f0000000040)={{0x12, 0x1, 0x0, 0x2, 0x0, 0x0, 0x8, 0x525, 0xa4a1, 0x40, 0x1, 0x2, 0x3, 0x1, [{{0x9, 0x2, 0x5c, 0x2, 0x1, 0x0, 0x0, 0x0, {{0x9, 0x4, 0x0, 0x0, 0x1, 0x2, 0xd, 0x0, 0x0, {{0x5}, {0x5}, {0xd}, {0x6}}, {{0x9, 0x5, 0x81, 0x3, 0x200}}}}}}]}}, &(0x7f0000000480)={0x0, 0x0, 0x0, 0x0, 0x3, [{0x0, 0x0}, {0x0, 0x0}, {0x0, 0x0}]})
> > 
> > I also tested doing the synchronize_irq emulation in dummy_pullup and it
> > fixed the issue. The patch is below.
> 
> That's great!  Thanks for testing.
> 
> > Thanks!
> > 
> > 	- Anirudh.
> > 
> > diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> > index ce24d4f28f2a..931d4612d859 100644
> > --- a/drivers/usb/gadget/udc/dummy_hcd.c
> > +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> > @@ -903,6 +903,12 @@ static int dummy_pullup(struct usb_gadget *_gadget, int value)
> >  	spin_lock_irqsave(&dum->lock, flags);
> >  	dum->pullup = (value != 0);
> >  	set_link_state(dum_hcd);
> > +	/* emulate synchronize_irq(): wait for callbacks to finish */ 
> > +	while (dum->callback_usage > 0) {
> > +		spin_unlock_irqrestore(&dum->lock, flags);
> > +		usleep_range(1000, 2000);
> > +		spin_lock_irqsave(&dum->lock, flags);
> > +	}
> 
> We should do this only if value == 0.  No synchronization is needed when 
> the pullup is turned on.
 
Oh right! My bad.

> Also, there should be a comment explaining that this is necessary 
> because there's no other place to emulate the call made to 
> synchronize_irq() in core.c:usb_gadget_remove_driver().

Will do.

> >  	spin_unlock_irqrestore(&dum->lock, flags);
> >  
> >  	usb_hcd_poll_rh_status(dummy_hcd_to_hcd(dum_hcd));
> > @@ -1005,13 +1011,6 @@ static int dummy_udc_stop(struct usb_gadget *g)
> >  	dum->ints_enabled = 0;
> >  	stop_activity(dum);
> >  
> > -	/* emulate synchronize_irq(): wait for callbacks to finish */
> > -	while (dum->callback_usage > 0) {
> > -		spin_unlock_irq(&dum->lock);
> > -		usleep_range(1000, 2000);
> > -		spin_lock_irq(&dum->lock);
> > -	}
> > -
> >  	dum->driver = NULL;
> >  	spin_unlock_irq(&dum->lock);
> 
> Actually, I wanted to move this emulation code into a new subroutine and 
> then call that subroutine from _both_ places.  Would you like to write 

Does it really need to be called from both places?

> and submit a patch that does this?

Sure! I will do that.

Thanks!

	- Anirudh.
