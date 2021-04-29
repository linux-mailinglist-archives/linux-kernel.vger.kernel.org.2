Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFE36EB86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhD2Nr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232867AbhD2Nrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:47:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5264D6143A;
        Thu, 29 Apr 2021 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619704027;
        bh=nEj5ApFsa05rNr3edqc+iuuZeqpPkKOq8myr5Uh93pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMzeK9w35hZmAxzPn2Od8x3u6jOSa3X0AOjBnNPHhia2O/xtF4lsWufox79JtzPlZ
         k3wyGBpiKyb0ImfjYLsaKyMhezxWPtAf1+HcL1xDcfd8EEIJpun+stbebaqqanQB2p
         WX1gwRJCPCYuBYxVdIZl+WpKkZdoI7MmnBp/u4EQ=
Date:   Thu, 29 Apr 2021 15:47:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] Revert "regulator: tps65910: fix a missing check of
 return value"
Message-ID: <YIq42bcPgic3y6iQ@kroah.com>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-6-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429130811.3353369-6-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:08:09PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit cd07e3701fa6a4c68f8493ee1d12caa18d46ec6a.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper submitted to the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota) but later
> withdrawn.
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/tps65910-regulator.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
> index 1d5b0a1b86f7..8ad1ecc1559f 100644
> --- a/drivers/regulator/tps65910-regulator.c
> +++ b/drivers/regulator/tps65910-regulator.c
> @@ -1098,10 +1098,8 @@ static int tps65910_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, pmic);
>  
>  	/* Give control of all register to control port */
> -	err = regmap_set_bits(pmic->mfd->regmap, TPS65910_DEVCTRL,
> +	regmap_set_bits(pmic->mfd->regmap, TPS65910_DEVCTRL,
>  				DEVCTRL_SR_CTL_I2C_SEL_MASK);
> -	if (err < 0)
> -		return err;
>  
>  	switch (tps65910_chip_id(tps65910)) {
>  	case TPS65910:
> -- 
> 2.31.1
> 

This looks correct to me, I'll drop the revert.

thanks,

greg k-h
