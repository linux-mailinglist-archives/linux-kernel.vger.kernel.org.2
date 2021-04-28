Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7650A36D571
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhD1KKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhD1KJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:09:55 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB15C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=unSSwoTtc4UBraSnCvFaYLPp8h51SktOETipm4XdjtY=; b=ya+I6PpXGlUCYh0jAIAOKHstT
        t5xgmNP9LoAs9Ge/x9Da1aRY5dau577FRHjdFhvb2dY1zjAU9eTy6v0jucsOYEjqCHcWIn2d1AoO9
        hICEy6XEMY6rMp9geBzbprWR/2mG21I9CdB0GDhq6xN5KEvucpI8gAdNyq4v1FioSX+JBjeIaJJgT
        0Mg1Hyd3lLbDTLDxkWKFCpGhheVMrwN345aXi+UuKXIjm6n/4bzo+UUZjdc0y0BR9/Cz5b6SYYx5Y
        VrsqfVuytaYOrrH5ydFVLq2ljXQcrUtVx44wV3I8euV+cUs1Vib5DX0Y1vyP5u7zaKkbKX0ENWLhl
        SggQbdyWw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52816)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lbh7k-00032b-2B; Wed, 28 Apr 2021 11:08:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lbh7f-0005S5-Ig; Wed, 28 Apr 2021 11:08:47 +0100
Date:   Wed, 28 Apr 2021 11:08:47 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 131/190] Revert "net: 8390: fix potential NULL pointer
 dereferences"
Message-ID: <20210428100844.GA20947@shell.armlinux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-132-gregkh@linuxfoundation.org>
 <YIhZMvRebkNu/B8C@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIhZMvRebkNu/B8C@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:34:26PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 03:00:06PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit c7cbc3e937b885c9394bf9d0ca21ceb75c2ac262.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/ethernet/8390/pcnet_cs.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
> > index 9d3b1e0e425c..0a408fa2b7a4 100644
> > --- a/drivers/net/ethernet/8390/pcnet_cs.c
> > +++ b/drivers/net/ethernet/8390/pcnet_cs.c
> > @@ -289,11 +289,6 @@ static struct hw_info *get_hwinfo(struct pcmcia_device *link)
> >  
> >      virt = ioremap(link->resource[2]->start,
> >  	    resource_size(link->resource[2]));
> > -    if (unlikely(!virt)) {
> > -	    pcmcia_release_window(link, link->resource[2]);
> > -	    return NULL;
> > -    }
> > -
> >      for (i = 0; i < NR_INFO; i++) {
> >  	pcmcia_map_mem_page(link, link->resource[2],
> >  		hw_info[i].offset & ~(resource_size(link->resource[2])-1));
> > @@ -1430,11 +1425,6 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
> >      /* Try scribbling on the buffer */
> >      info->base = ioremap(link->resource[3]->start,
> >  			resource_size(link->resource[3]));
> > -    if (unlikely(!info->base)) {
> > -	    ret = -ENOMEM;
> > -	    goto failed;
> > -    }
> > -
> >      for (i = 0; i < (TX_PAGES<<8); i += 2)
> >  	__raw_writew((i>>1), info->base+offset+i);
> >      udelay(100);
> > -- 
> > 2.31.1
> > 
> 
> This change causes a memory leak on the error path, so I will keep the
> revert.
> 
> But really, a pcmcia card with a failed ioremap() call?  That can never
> happen here, so I'll just keep it reverted, it's not worth touching
> again.

I'm afraid that I have to disagree with your analysis.

However, first thing is, it would help immensely if you actually said
where the memory leak is, rather than using this boiler plate and
rushing through the changes.

On IRC, you mentioned it was due to the change in setup_shmem_window(),
specifically "no call to pcmcia_release_window()". This seems to imply
that you have no problem with the change to get_hwinfo(), and indeed
that part of the original change looks fully correct to me. So,
concentrating on the setup_shmem_window() change in this patch:

First, let's analyse pcmcia_request_window() and pcmcia_release_window().
pcmcia_request_window() allocates some memory for a struct resource,
which pcmcia_release_window() releases. So, on the face of it, calling
the former without a subsequent call to the latter looks like a memory
leak, unless one gets a deeper understanding first.

When pcmcia_request_window() is called and is successful, the resource
is marked with the window number that has been allocated to it, which
is always non-zero:

#define WIN_FLAGS_REQ           0x1c

        /* Configure the socket controller */
        win->map = w+1;
...
        res->flags &= ~WIN_FLAGS_REQ;
        res->flags |= (win->map << 2) | IORESOURCE_MEM;

When a window is released, this is checked:

        w = ((res->flags & IORESOURCE_BITS & WIN_FLAGS_REQ) >> 2) - 1;
        if (w >= MAX_WIN)
                return -EINVAL;

However, there is another path where a driver's resources are released,
which is if the driver makes a call to pcmcia_disable_device():

        for (i = 0; i < MAX_WIN; i++) {
                struct resource *res = p_dev->resource[MAX_IO_WIN + i];
                if (res->flags & WIN_FLAGS_REQ)
                        pcmcia_release_window(p_dev, res);
        }

This walks all the memory resources for the card, releasing any that are
currently requested (have non-zero WIN_FLAGS_REQ bits) at the time of
this call.

pcnet_cs makes a call to pcmcia_disable_device() from pcnet_release()
which is called in two cases: firstly on any probe failure, and secondly
on device removal in pcnet_detach().

Consequently, the best that can be said about the setup_shmem_window()
memory leak is that it is a temporary leak - the allocated memory will
be freed if either the probe eventually fails, or the driver is unbound.


Second point. setup_shmem_window() "failure" itself does not lead to
probe failure. The function returns a value that indicates whether shmem
can be used by the driver or not - it needs a subsequent call to fail.
setup_shmem_window() merely returns a value to indicate whether shmem
should be configured or not.


Third point. setup_shmem_window() can already "leak" this window
allocation. If pcmcia_map_mem_page() fails, then the window is not
released in a timely fashion. So, the "leak" is pre-existing in this
driver, and the "leak" introduced by this patch already exists in
other paths.


Fourth point. If setup_shmem_window() is successful, which means we use
shmem, and we then fail to register the netdev in the subsequent
register_netdev() call, we are reliant on pcmcia_disable_device() to
clean up that allocation. We are also reliant on pcmcia_disable_device()
to clean that up when the driver is unbound. So, this is an entirely
normal state of affairs to rely on the action of this call to clean up
these resources.


Fifth point. The effect of reverting the original patch will be a kernel
oops should this ioremap() fail:

     info->base = ioremap(link->resource[3]->start,
                         resource_size(link->resource[3]));
-    if (unlikely(!info->base)) {
-            ret = -ENOMEM;
-            goto failed;
-    }
-
    for (i = 0; i < (TX_PAGES<<8); i += 2)
        __raw_writew((i>>1), info->base+offset+i);
                             ^^^^^^^^^^^^^^^^^^^^

So, is the patch of net benefit or net harm?

1) it does not introduce any new issue that doesn't already exist. The
   driver has a short-term memory leak in certain circumstances already
   that is cleaned up via the normal action of other pcmcia_* calls.

2) it removes an opportunity for a NULL or close-to-NULL pointer
   dereference.

Therefore, the original patch is of net _benefit_ and should not be
reverted.

It would have been nice to have had a patch that addresses the
temporary leak in the driver, but I really don't see that as any
justification for reverting this patch. Therefore, I NAK your revert of
this change as that will result in more harm than good.

You said on IRC early this morning when you thought there was still a
leak in the probe path: "the leak happens from probe, that is where it
needs to be cleaned up properly, the patch was incorrect.  You owe me
a bottle of wine for even debating this crap..."

I think you now owe me more than just a bottle of wine... and I think
you need to realise that your attitude also needs to be altered. Yes,
I fully understand _why_ you made that comment - it's because you're
swamped. However, we *need* to review and debate your reverts, and that
is something you should DEFINITELY NOT be discouraging with such
comments.  If we discourage review and debate in the way you seem to be
doing when someone raises a concern, we're yet again proving that our
approach to review is broken.

It really concerns me that there seems to be a slap-dash attitude here,
and push-back when one of your fellow kernel developers disagrees with
your abbreviated unexplained analysis.

Are you sure you aren't causing harm?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
