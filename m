Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2F36D9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbhD1Og7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235864AbhD1Og6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C1976143E;
        Wed, 28 Apr 2021 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619620573;
        bh=xXLfHLEkPPw+BpHVObwqLRh2LCVht6DaSQKFZT8ytBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhLBMGBB3x1KK8EZc6W4RH0pd4l0VNULE78vFjrlA3zMYHrofSJ8Q427hhnI2VJx9
         GadCiFfViyUnKrVEht0qeGxesW/Y1SqXOm4ro1BK7ksvy6mTQwJATwE6EAZqrp7l3K
         0lG9VxkkVPHJXVupY1cC1rhtg+GjjEPoTTJ08gZA=
Date:   Wed, 28 Apr 2021 16:36:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 131/190] Revert "net: 8390: fix potential NULL pointer
 dereferences"
Message-ID: <YIly2xRf7LAM2d6D@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-132-gregkh@linuxfoundation.org>
 <YIhZMvRebkNu/B8C@kroah.com>
 <20210428100844.GA20947@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428100844.GA20947@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:08:47AM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Apr 27, 2021 at 08:34:26PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 21, 2021 at 03:00:06PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit c7cbc3e937b885c9394bf9d0ca21ceb75c2ac262.
> > > 
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > 
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > > 
> > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/net/ethernet/8390/pcnet_cs.c | 10 ----------
> > >  1 file changed, 10 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
> > > index 9d3b1e0e425c..0a408fa2b7a4 100644
> > > --- a/drivers/net/ethernet/8390/pcnet_cs.c
> > > +++ b/drivers/net/ethernet/8390/pcnet_cs.c
> > > @@ -289,11 +289,6 @@ static struct hw_info *get_hwinfo(struct pcmcia_device *link)
> > >  
> > >      virt = ioremap(link->resource[2]->start,
> > >  	    resource_size(link->resource[2]));
> > > -    if (unlikely(!virt)) {
> > > -	    pcmcia_release_window(link, link->resource[2]);
> > > -	    return NULL;
> > > -    }
> > > -
> > >      for (i = 0; i < NR_INFO; i++) {
> > >  	pcmcia_map_mem_page(link, link->resource[2],
> > >  		hw_info[i].offset & ~(resource_size(link->resource[2])-1));
> > > @@ -1430,11 +1425,6 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
> > >      /* Try scribbling on the buffer */
> > >      info->base = ioremap(link->resource[3]->start,
> > >  			resource_size(link->resource[3]));
> > > -    if (unlikely(!info->base)) {
> > > -	    ret = -ENOMEM;
> > > -	    goto failed;
> > > -    }
> > > -
> > >      for (i = 0; i < (TX_PAGES<<8); i += 2)
> > >  	__raw_writew((i>>1), info->base+offset+i);
> > >      udelay(100);
> > > -- 
> > > 2.31.1
> > > 
> > 
> > This change causes a memory leak on the error path, so I will keep the
> > revert.
> > 
> > But really, a pcmcia card with a failed ioremap() call?  That can never
> > happen here, so I'll just keep it reverted, it's not worth touching
> > again.
> 
> I'm afraid that I have to disagree with your analysis.
> 
> However, first thing is, it would help immensely if you actually said
> where the memory leak is, rather than using this boiler plate and
> rushing through the changes.
> 
> On IRC, you mentioned it was due to the change in setup_shmem_window(),
> specifically "no call to pcmcia_release_window()". This seems to imply
> that you have no problem with the change to get_hwinfo(), and indeed
> that part of the original change looks fully correct to me. So,
> concentrating on the setup_shmem_window() change in this patch:

<snip>

Fair enough, I'll drop this revert from my tree as you feel the original
commit was correct.

thanks for the review.

greg k-h
