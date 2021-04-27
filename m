Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9736CAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbhD0SPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0SPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B99F613EA;
        Tue, 27 Apr 2021 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619547286;
        bh=p9VYaptoIh7qUXpbZLLRQsuXGmczzPkzM8cN3UCnuUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgmIMoHUa6FeBEEZtPQkp101shNytCAmGV4+18SLe9AmN00KNbL8RV30emx+P6osY
         o/dnGgyKngAoxIta1rage2Vqoo542Oz+iPHwz0ZYg2cYrAdK0ih7bo9shfynR0GQg+
         vPC6BxdbWSBwORfdPzZGSPnaoNB597PJ+07Ooeu4=
Date:   Tue, 27 Apr 2021 20:14:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 163/190] Revert "dmaengine: mv_xor: Fix a missing check
 in mv_xor_channel_add"
Message-ID: <YIhUlJ/06/A8m9Ft@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-164-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-164-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:38PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 7c97381e7a9a5ec359007c0d491a143e3d9f787c.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/dma/mv_xor.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 23b232b57518..78bd52565571 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1144,10 +1144,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  		 dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "cpy " : "",
>  		 dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
>  
> -	ret = dma_async_device_register(dma_dev);
> -	if (ret)
> -		goto err_free_irq;
> -
> +	dma_async_device_register(dma_dev);
>  	return mv_chan;
>  
>  err_free_irq:
> -- 
> 2.31.1
> 

The original commit here is correct, I will drop this revert.

greg k-h
