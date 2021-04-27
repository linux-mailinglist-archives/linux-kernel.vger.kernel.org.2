Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0200536C973
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhD0Q2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236611AbhD0Q2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:28:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67B68613C3;
        Tue, 27 Apr 2021 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540883;
        bh=/KJYPm/wrYlkkqWrqGN0PXa+Acd6GABMwF2WkDuFnEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8/NDkOnrYCcwgiA3fXUIvkSZSIuHK1pohpJu5ZphcW12ueFR2YUrMs3xroYSwh95
         uOO2Aix8QdmbWlg8sjnweE9wkSPoQk2fDLeP6NC/EgAHOyr3LtCPLWdragKyD4u+5n
         6VDr7/CZRdBYXP1NZsf8VYWU++6s77Rxz6X22kio=
Date:   Tue, 27 Apr 2021 18:28:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Jon Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 030/190] Revert "ASoC: tegra: Fix reference count leaks."
Message-ID: <YIg7kH1X0qk8hidp@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-31-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-31-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:25PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit deca195383a6085be62cb453079e03e04d618d6e.
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
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: https
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  sound/soc/tegra/tegra30_ahub.c | 4 +---
>  sound/soc/tegra/tegra30_i2s.c  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
> index 9ef05ca4f6c4..b116b05e4e72 100644
> --- a/sound/soc/tegra/tegra30_ahub.c
> +++ b/sound/soc/tegra/tegra30_ahub.c
> @@ -657,10 +657,8 @@ static int tegra30_ahub_resume(struct device *dev)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  	ret = regcache_sync(ahub->regmap_ahub);
>  	ret |= regcache_sync(ahub->regmap_apbif);
>  	pm_runtime_put(dev);
> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
> index 6740df541508..3187a0f0c07a 100644
> --- a/sound/soc/tegra/tegra30_i2s.c
> +++ b/sound/soc/tegra/tegra30_i2s.c
> @@ -567,10 +567,8 @@ static int tegra30_i2s_resume(struct device *dev)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  	ret = regcache_sync(i2s->regmap);
>  	pm_runtime_put(dev);
>  
> -- 
> 2.31.1
> 

Looks correct, dropping.

greg k-h
