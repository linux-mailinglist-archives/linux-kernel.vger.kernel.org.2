Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A761336D1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhD1GBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:01:08 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:55520 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1GBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:01:07 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 02:01:07 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id AA752200CCC;
        Wed, 28 Apr 2021 05:54:45 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D95B0209C5; Wed, 28 Apr 2021 07:54:34 +0200 (CEST)
Date:   Wed, 28 Apr 2021 07:54:34 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 132/190] Revert "net: fujitsu: fix a potential NULL
 pointer dereference"
Message-ID: <YIj4mvE9E08Fu6uJ@light.dominikbrodowski.net>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-133-gregkh@linuxfoundation.org>
 <YIj1YXJ4S2ux+NNJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIj1YXJ4S2ux+NNJ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Apr 28, 2021 at 07:40:49AM +0200 schrieb Greg Kroah-Hartman:
> On Wed, Apr 21, 2021 at 03:00:07PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 9f4d6358e11bbc7b839f9419636188e4151fb6e4.
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
> >  drivers/net/ethernet/fujitsu/fmvj18x_cs.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> > index a7b7a4aace79..dc90c61fc827 100644
> > --- a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> > +++ b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> > @@ -547,11 +547,6 @@ static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id)
> >  	return -1;
> >  
> >      base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
> > -    if (!base) {
> > -	    pcmcia_release_window(link, link->resource[2]);
> > -	    return -ENOMEM;
> > -    }
> > -
> >      pcmcia_map_mem_page(link, link->resource[2], 0);
> >  
> >      /*
> > -- 
> > 2.31.1
> > 
> 
> Original commit looks correct here, I'll drop the revert.

NAK. The only caller of that function checks only for "== -1" as error
condition, so this error is not handled correctly. So this patch was/is
obviously broken.

Thanks,
	Dominik
