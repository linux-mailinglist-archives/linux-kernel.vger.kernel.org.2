Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674EB36F6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhD3IHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhD3IHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B29D861186;
        Fri, 30 Apr 2021 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619770012;
        bh=WwcaFyczo1H0haJlGIG06rvrYQmQEvklII1MuwRovvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyLOyP92lS2p2AT5P++VJHVeW1p29hiOO0GBK1Q9BQskN8mY6dfKqjzi7Jq5qTFiJ
         I2lQufVkFEMoNBeF65vgo+IWKQQYzRsU62+qre0XcBEYHIaOXewKP7NHsrTET7LOSL
         NugoPn86rn6DKxrdZcC9My2tRDcizjucFqF0/AwQ=
Date:   Fri, 30 Apr 2021 10:06:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Du Cheng <ducheng2@gmail.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 169/190] Revert "atl1e: checking the status of
 atl1e_write_phy_reg"
Message-ID: <YIu6meOO5SSuCW/D@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-170-gregkh@linuxfoundation.org>
 <YIhURb44nXaYDuBG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIhURb44nXaYDuBG@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:13:25PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 03:00:44PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit ff07d48d7bc0974d4f96a85a4df14564fb09f1ef.
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
> >  drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> > index ff9f96de74b8..85f9cb769e30 100644
> > --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> > +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> > @@ -455,9 +455,7 @@ static void atl1e_mdio_write(struct net_device *netdev, int phy_id,
> >  {
> >  	struct atl1e_adapter *adapter = netdev_priv(netdev);
> >  
> > -	if (atl1e_write_phy_reg(&adapter->hw,
> > -				reg_num & MDIO_REG_ADDR_MASK, val))
> > -		netdev_err(netdev, "write phy register failed\n");
> > +	atl1e_write_phy_reg(&adapter->hw, reg_num & MDIO_REG_ADDR_MASK, val);
> >  }
> >  
> >  static int atl1e_mii_ioctl(struct net_device *netdev,
> > -- 
> > 2.31.1
> > 
> 
> The original change here is a mess, what is a user supposed to do if
> this call fails?  I will revert it and properly pass the error value up
> to the callers, as that is the correct thing to do here, not paper over
> the issue with a commit message that claims this change "fixes"
> anything.

In looking at this further, Du has pointed out to me that the
atl1e_mdio_write function can not easily be changed to return an error
value, because that would require all callbacks for mdio_write in struct
mii_if_info would need to be changed and handled properly.

So the original commit was as correct as is possible at the moment,
making a much larger change like this really isn't needed, so I'll drop
the revert.

thanks to Du Cheng for the additional review, it is much appreciated.

greg k-h
