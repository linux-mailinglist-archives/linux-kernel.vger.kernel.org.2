Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8BE36C971
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhD0Q2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236320AbhD0Q2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFC6B61027;
        Tue, 27 Apr 2021 16:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540868;
        bh=W5pR/71DZ/WXJxkbx3oO+qOOtw4XbCmoiSmRbZsN1Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iqgwz6K2rSTB0IffkAwMNVGj2ZKfPkp9yomqvZlScPdRztRLOrObRtK7SVJGWie+u
         fZinibWHhrrFIx9vPhME4u2klb3SzkxFLDSWq5ANN6z9NTRJ952I00eQ6PIHZCSM0A
         0jQS8itAXaD71gazs4/U+PRFDjFih8daimK/fceM=
Date:   Tue, 27 Apr 2021 18:27:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 027/190] Revert "ASoC: rockchip: Fix a reference count
 leak."
Message-ID: <YIg7gWWkgqnj1S/K@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-28-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-28-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:22PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit f141a422159a199f4c8dedb7e0df55b3b2cf16cd.
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
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: https
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  sound/soc/rockchip/rockchip_pdm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
> index 9295d648624e..c52e1dbf6dbe 100644
> --- a/sound/soc/rockchip/rockchip_pdm.c
> +++ b/sound/soc/rockchip/rockchip_pdm.c
> @@ -590,10 +590,8 @@ static int rockchip_pdm_resume(struct device *dev)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	ret = regcache_sync(pdm->regmap);
>  
> -- 
> 2.31.1
> 

Looks correct, dropping.

greg k-h
