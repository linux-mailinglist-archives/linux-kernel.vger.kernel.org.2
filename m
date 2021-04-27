Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C918F36CAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhD0SH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235505AbhD0SH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C939061153;
        Tue, 27 Apr 2021 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619546833;
        bh=8x24zzddogj013oYLRSBQe2TVlrwjfhBzEdbJOrDgSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLPkL4/Umw90RxwnDHja17rwmR8wukBNRNDi0ggmNNH+gW3QLwYquU/qAIUWqyzNq
         BcdNRp+lfWlzM4lK9n+xesH1DCP9aKcy7OtaiF9rCsz8W4YKh+TpgU3/LKs5BOoSGa
         6eI8hm5Xy+a462mWJq9cwRuqnAfLgmyuCatD3pKg=
Date:   Tue, 27 Apr 2021 20:07:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 171/190] Revert "net: stmicro: fix a missing check of
 clk_prepare"
Message-ID: <YIhSzrjLbGqPsfRV@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-172-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-172-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:46PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit f86a3b83833e7cfe558ca4d70b64ebc48903efec.
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
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
> index 0e1ca2cba3c7..0e86553fc06f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
> @@ -50,9 +50,7 @@ static int sun7i_gmac_init(struct platform_device *pdev, void *priv)
>  		gmac->clk_enabled = 1;
>  	} else {
>  		clk_set_rate(gmac->tx_clk, SUN7I_GMAC_MII_RATE);
> -		ret = clk_prepare(gmac->tx_clk);
> -		if (ret)
> -			return ret;
> +		clk_prepare(gmac->tx_clk);
>  	}
>  
>  	return 0;
> -- 
> 2.31.1
> 

The original commit here can cause a memory leak so I will keep this
revert and submit a change that fixes this up properly.

thanks,

greg k-h
