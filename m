Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0F36C9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhD0Q6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237548AbhD0Q6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4639D613F3;
        Tue, 27 Apr 2021 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542640;
        bh=FtwMiMVALkqSaWTuEMx31ALPRtlP3cV9btpOcgB1YiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5EwDrZrzUz8ob1DaX/E9hKknBV+X5IWSFkR2vQZ3+Uz+JqfRbLFmFkkkB1IhJFkK
         lPJAkNtY0Kkjm1xHWbN6UZjU19YrxWsJwEST1zGq/FFBaDThx0BsUu6ekW4lgEEF60
         EDrM96yBhBXzFRzt+E2zrjPYIMEO6Dl5kihzoPU4=
Date:   Tue, 27 Apr 2021 18:57:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 184/190] Revert "yam: fix a missing-check bug"
Message-ID: <YIhCbigynlBTvbZs@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-185-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-185-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:59PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 0781168e23a2fc8dceb989f11fc5b39b3ccacc35.
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
> Cc: Wenwen Wang <wang6495@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/hamradio/yam.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/hamradio/yam.c b/drivers/net/hamradio/yam.c
> index 5ab53e9942f3..616db3a0d2f4 100644
> --- a/drivers/net/hamradio/yam.c
> +++ b/drivers/net/hamradio/yam.c
> @@ -951,8 +951,6 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  				 sizeof(struct yamdrv_ioctl_mcs));
>  		if (IS_ERR(ym))
>  			return PTR_ERR(ym);
> -		if (ym->cmd != SIOCYAMSMCS)
> -			return -EINVAL;
>  		if (ym->bitrate > YAM_MAXBITRATE) {
>  			kfree(ym);
>  			return -EINVAL;
> @@ -968,8 +966,6 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  		if (copy_from_user(&yi, ifr->ifr_data, sizeof(struct yamdrv_ioctl_cfg)))
>  			 return -EFAULT;
>  
> -		if (yi.cmd != SIOCYAMSCFG)
> -			return -EINVAL;
>  		if ((yi.cfg.mask & YAM_IOBASE) && netif_running(dev))
>  			return -EINVAL;		/* Cannot change this parameter when up */
>  		if ((yi.cfg.mask & YAM_IRQ) && netif_running(dev))
> -- 
> 2.31.1
> 

Original looks correct, dropping this revert.

greg k-h
