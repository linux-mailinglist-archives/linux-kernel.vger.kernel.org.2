Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE536D249
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhD1Gi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhD1Ghr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:37:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4286B6140C;
        Wed, 28 Apr 2021 06:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619591822;
        bh=CMcJmIK9jMCtaqxya88iQ+ik9bFi5aA7bIUCxMFrTwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ErRCEMW/F8PZRxrkPe3rnR8LEWXLKYa0UHjoPA661+MR2lT8BV82E38WUbyfD54q
         hHQvcX0OPnVFWafbZI1efZSLVjGFl47Vx0mbPyeRdLZh0neDQowiHOlZDjQcHyBj0T
         IVbsHhHi+OivaTNQ8AlE7TwBpuCEoKnzx0wStBQI=
Date:   Wed, 28 Apr 2021 08:36:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 132/190] Revert "net: fujitsu: fix a potential NULL
 pointer dereference"
Message-ID: <YIkChy1Kdw+CRqTU@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-133-gregkh@linuxfoundation.org>
 <YIj1YXJ4S2ux+NNJ@kroah.com>
 <YIj4mvE9E08Fu6uJ@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIj4mvE9E08Fu6uJ@light.dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 07:54:34AM +0200, Dominik Brodowski wrote:
> Am Wed, Apr 28, 2021 at 07:40:49AM +0200 schrieb Greg Kroah-Hartman:
> > On Wed, Apr 21, 2021 at 03:00:07PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 9f4d6358e11bbc7b839f9419636188e4151fb6e4.
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
> > >  drivers/net/ethernet/fujitsu/fmvj18x_cs.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> > > index a7b7a4aace79..dc90c61fc827 100644
> > > --- a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> > > +++ b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> > > @@ -547,11 +547,6 @@ static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id)
> > >  	return -1;
> > >  
> > >      base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
> > > -    if (!base) {
> > > -	    pcmcia_release_window(link, link->resource[2]);
> > > -	    return -ENOMEM;
> > > -    }
> > > -
> > >      pcmcia_map_mem_page(link, link->resource[2], 0);
> > >  
> > >      /*
> > > -- 
> > > 2.31.1
> > > 
> > 
> > Original commit looks correct here, I'll drop the revert.
> 
> NAK. The only caller of that function checks only for "== -1" as error
> condition, so this error is not handled correctly. So this patch was/is
> obviously broken.

Ah, missed that, thanks!  I'll keep the revert and then submit a fix for
this properly.

Many thanks for the re-review.

greg k-h
