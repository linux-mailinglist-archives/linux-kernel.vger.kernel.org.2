Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B5366C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbhDUNVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242319AbhDUNTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:19:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8F7C06138F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:19:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A6FE4AE;
        Wed, 21 Apr 2021 15:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619011151;
        bh=0EfBFH+QDa9aFjZXgekxgzLUl8eCQm5+srD8VzcpAVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqExv32nuQhJq8BbpZ7EzyjuY+MakuMyGfwagLmGodCLUHH7X8muoYlTIfRtHYtFf
         Tj452a1YtJgj0TJhkeGm1JUjSTsq0ZX0NQTEoiSiVSi91hehEtWS4Bh7sbW+rJp+vS
         w4R2SAmiYS/5a4+tnIuwnga03Lq7dZBmdKNNofJw=
Date:   Wed, 21 Apr 2021 16:19:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 088/190] Revert "mmc_spi: add a status check for
 spi_sync_locked"
Message-ID: <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-89-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-89-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the patch.

On Wed, Apr 21, 2021 at 02:59:23PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 611025983b7976df0183390a63a2166411d177f1.
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
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I don't spot an obvious issue with the original patch though.

> ---
>  drivers/mmc/host/mmc_spi.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 02f4fd26e76a..cc40b050e302 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -800,10 +800,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>  	}
>  
>  	status = spi_sync_locked(spi, &host->m);
> -	if (status < 0) {
> -		dev_dbg(&spi->dev, "read error %d\n", status);
> -		return status;
> -	}
>  
>  	if (host->dma_dev) {
>  		dma_sync_single_for_cpu(host->dma_dev,

-- 
Regards,

Laurent Pinchart
