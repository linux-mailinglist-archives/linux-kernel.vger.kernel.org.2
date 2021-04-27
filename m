Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCCC36CAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhD0SON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0SOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:14:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCC3F61153;
        Tue, 27 Apr 2021 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619547208;
        bh=gg1fbbH9KOQkY9qvlWYHYoiryy8pQ6phcWKS1K/Vtls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUSsNhB8ZuV+ZoEj431UKGGgWIS9C75B17ectdGaDMQmPnPyWjfUp2gUptueypqZa
         NS+Tz+HSybSTwQPAzaMiNCcvpCme+tIzlNbxjHMgyUsUQGu+Y8aBUJjoYuuX0Gf5pf
         ed2IbiKSGnmfJy5zSDZfF8DPn7T+xuFoT1HOPgiI=
Date:   Tue, 27 Apr 2021 20:13:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 169/190] Revert "atl1e: checking the status of
 atl1e_write_phy_reg"
Message-ID: <YIhURb44nXaYDuBG@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-170-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-170-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:44PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit ff07d48d7bc0974d4f96a85a4df14564fb09f1ef.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> index ff9f96de74b8..85f9cb769e30 100644
> --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> @@ -455,9 +455,7 @@ static void atl1e_mdio_write(struct net_device *netdev, int phy_id,
>  {
>  	struct atl1e_adapter *adapter = netdev_priv(netdev);
>  
> -	if (atl1e_write_phy_reg(&adapter->hw,
> -				reg_num & MDIO_REG_ADDR_MASK, val))
> -		netdev_err(netdev, "write phy register failed\n");
> +	atl1e_write_phy_reg(&adapter->hw, reg_num & MDIO_REG_ADDR_MASK, val);
>  }
>  
>  static int atl1e_mii_ioctl(struct net_device *netdev,
> -- 
> 2.31.1
> 

The original change here is a mess, what is a user supposed to do if
this call fails?  I will revert it and properly pass the error value up
to the callers, as that is the correct thing to do here, not paper over
the issue with a commit message that claims this change "fixes"
anything.

thanks,

greg k-h
