Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B436C77F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhD0OF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhD0OFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4844361002;
        Tue, 27 Apr 2021 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619532304;
        bh=HMi6HrRXHk8bHy6djyZb8hW7KqmxFiXxGNi0XpqtCUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3cTz0NNNnEHLSW9VtITwepbDizI18pC+N/eeST530vw39cEeQ4H8Nc4qHewXJiu2
         VNy98QYW5wBrXaaXVUuGqA/dP0ui40NK/uGX5TmJmb4pHPVCtj6hpbNXBgEOe+7RzO
         g1po3hqdheX135rdTqcJVKLP4j5L6LlKCXyky0eE=
Date:   Tue, 27 Apr 2021 16:05:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 084/190] Revert "net: ieee802154: fix missing checks for
 regmap_update_bits"
Message-ID: <YIgaDu0PdkDvEC9D@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-85-gregkh@linuxfoundation.org>
 <4e9dad99-8a88-a617-33be-0cb17824bc62@datenfreihafen.org>
 <YIgUGtzV6GSYhCqb@kroah.com>
 <c878e7bc-c9f2-e2d1-8d4f-bc3557fb7991@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c878e7bc-c9f2-e2d1-8d4f-bc3557fb7991@datenfreihafen.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:46:27PM +0200, Stefan Schmidt wrote:
> Hello Greg.
> 
> On 27.04.21 15:39, Greg Kroah-Hartman wrote:
> > On Wed, Apr 21, 2021 at 03:23:06PM +0200, Stefan Schmidt wrote:
> > > Hello.
> > > 
> > > On 21.04.21 14:59, Greg Kroah-Hartman wrote:
> > > > This reverts commit 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4.
> > > > 
> > > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > > faith" to try to test the kernel community's ability to review "known
> > > > malicious" changes.  The result of these submissions can be found in a
> > > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > > 
> > > > Because of this, all submissions from this group must be reverted from
> > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > change to ensure that no problems are being introduced into the
> > > > codebase.
> > > > 
> > > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > > Cc: Mukesh Ojha <mojha@codeaurora.org>
> > > > Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >    drivers/net/ieee802154/mcr20a.c | 6 ------
> > > >    1 file changed, 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> > > > index 8dc04e2590b1..2ce5b41983f8 100644
> > > > --- a/drivers/net/ieee802154/mcr20a.c
> > > > +++ b/drivers/net/ieee802154/mcr20a.c
> > > > @@ -524,8 +524,6 @@ mcr20a_start(struct ieee802154_hw *hw)
> > > >    	dev_dbg(printdev(lp), "no slotted operation\n");
> > > >    	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
> > > >    				 DAR_PHY_CTRL1_SLOTTED, 0x0);
> > > > -	if (ret < 0)
> > > > -		return ret;
> > > >    	/* enable irq */
> > > >    	enable_irq(lp->spi->irq);
> > > > @@ -533,15 +531,11 @@ mcr20a_start(struct ieee802154_hw *hw)
> > > >    	/* Unmask SEQ interrupt */
> > > >    	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
> > > >    				 DAR_PHY_CTRL2_SEQMSK, 0x0);
> > > > -	if (ret < 0)
> > > > -		return ret;
> > > >    	/* Start the RX sequence */
> > > >    	dev_dbg(printdev(lp), "start the RX sequence\n");
> > > >    	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
> > > >    				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
> > > > -	if (ret < 0)
> > > > -		return ret;
> > > >    	return 0;
> > > >    }
> > > > 
> > > 
> > > 
> > > Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> > 
> > Thanks for the review, but in re-reviewing this, I'll drop the revert as
> > it looks correct to me.
> 
> It is correct. We missed the return checking when the driver came in
> initially.
> 
> My Acked-by was really not about if the reverted patch was a security risk,
> but about the fact that you wanted to sort them out individually due to the
> Hypocrite Commits paper before getting them back in.
> 
> If you are happy to change the approach to only revert patches you are in
> doubt (this one is really not one of them) I am happy to keep this patch in.

My first step was "revert them all so we know what to review", and now
I'm going back and reviewing them all (and taking the review comments
from everyone else who was nice enough to help out)"

So it's easy for me to drop this from the series now, thanks!

greg k-h
