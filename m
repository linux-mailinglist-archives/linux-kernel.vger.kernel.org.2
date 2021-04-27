Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06136C721
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhD0NkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235652AbhD0NkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:40:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE4B9613DA;
        Tue, 27 Apr 2021 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530781;
        bh=lI9d8ARghF9RGVClk192sA0t0hX6qCTc7XXvYxLH6Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feQbJ9g/qoQaNVjadH0YKHtTUmImW65q39k3I8ZI4Bp/vjirWCpjU29+IWJfWopQU
         CMnpVerHL5UprIVdRNVAj1Wj5QL174VoRJhkpBtfVTtSiRTosunTE1utIAgUqyPWMK
         i/Z3dcE+7EdbY02MxGKtQtyrzHMNJE+uSIYByswM=
Date:   Tue, 27 Apr 2021 15:39:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 084/190] Revert "net: ieee802154: fix missing checks for
 regmap_update_bits"
Message-ID: <YIgUGtzV6GSYhCqb@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-85-gregkh@linuxfoundation.org>
 <4e9dad99-8a88-a617-33be-0cb17824bc62@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9dad99-8a88-a617-33be-0cb17824bc62@datenfreihafen.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:23:06PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 21.04.21 14:59, Greg Kroah-Hartman wrote:
> > This reverts commit 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4.
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
> > Cc: Mukesh Ojha <mojha@codeaurora.org>
> > Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/net/ieee802154/mcr20a.c | 6 ------
> >   1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> > index 8dc04e2590b1..2ce5b41983f8 100644
> > --- a/drivers/net/ieee802154/mcr20a.c
> > +++ b/drivers/net/ieee802154/mcr20a.c
> > @@ -524,8 +524,6 @@ mcr20a_start(struct ieee802154_hw *hw)
> >   	dev_dbg(printdev(lp), "no slotted operation\n");
> >   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
> >   				 DAR_PHY_CTRL1_SLOTTED, 0x0);
> > -	if (ret < 0)
> > -		return ret;
> >   	/* enable irq */
> >   	enable_irq(lp->spi->irq);
> > @@ -533,15 +531,11 @@ mcr20a_start(struct ieee802154_hw *hw)
> >   	/* Unmask SEQ interrupt */
> >   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
> >   				 DAR_PHY_CTRL2_SEQMSK, 0x0);
> > -	if (ret < 0)
> > -		return ret;
> >   	/* Start the RX sequence */
> >   	dev_dbg(printdev(lp), "start the RX sequence\n");
> >   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
> >   				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
> > -	if (ret < 0)
> > -		return ret;
> >   	return 0;
> >   }
> > 
> 
> 
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

Thanks for the review, but in re-reviewing this, I'll drop the revert as
it looks correct to me.

thanks,

greg k-h
