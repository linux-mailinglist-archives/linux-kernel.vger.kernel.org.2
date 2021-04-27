Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6736CAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhD0SFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0SFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:05:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A24360BBB;
        Tue, 27 Apr 2021 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619546699;
        bh=OR+iH4W1v5Kg3fqB0TVCptrknTXzGJeZlnHbGR9M0/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJBAnH/K7UKb1y/Fa8vcjHMoN2hNO6zy2jV4RZct5Feua5n3F2HhZU5F0ux+3/B62
         /IPzdujBzJWK4DYV1ZeLDBIO1eUMaYMCYT4mkagGr2z5kkvenPSUdG9E0Uux8NqIlo
         wMYMBwmhesdhKOMb19xsvacYC79RylFk4dH6NBhs=
Date:   Tue, 27 Apr 2021 20:04:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 172/190] Revert "net: (cpts) fix a missing check of
 clk_prepare"
Message-ID: <YIhSSEMnGxZfkG94@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-173-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-173-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:47PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 2d822f2dbab7f4c820f72eb8570aacf3f35855bd.
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
>  drivers/net/ethernet/ti/cpts.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
> index 43222a34cba0..60fde1bb9665 100644
> --- a/drivers/net/ethernet/ti/cpts.c
> +++ b/drivers/net/ethernet/ti/cpts.c
> @@ -778,9 +778,7 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
>  		return ERR_CAST(cpts->refclk);
>  	}
>  
> -	ret = clk_prepare(cpts->refclk);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	clk_prepare(cpts->refclk);
>  
>  	cpts->cc.read = cpts_systim_read;
>  	cpts->cc.mask = CLOCKSOURCE_MASK(32);
> -- 
> 2.31.1
> 

Original looks correct, revert now dropped.

greg k-h
