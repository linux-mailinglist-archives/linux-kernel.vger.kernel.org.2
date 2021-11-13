Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C244F21A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 09:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhKMIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 03:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhKMIFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 03:05:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA37B60EB4;
        Sat, 13 Nov 2021 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636790548;
        bh=QCklIn07a4Q9kSJmzDKlN3UHyVzwJygAHFISjCNIgy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0QMq1/NXq1hjwEBts4ABOzyJ6At+fTHmRdTpVjpF7P2vWEOaCWe3wWFTUO30Ja3ex
         gQZGnnnkDGSI1U/AledGlSktAh8VitaquWaOTrQvCTO6owkIeQkn8pDXoJUKtTc0+O
         mMKfkspT8o/M+zFcw00H/XnZ9JH7HVLSrYzhRUfk=
Date:   Sat, 13 Nov 2021 09:02:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Junqi <liujunqi@pku.edu.cn>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: mt7621-dma: reindent to avoid '(' at the end of
 line
Message-ID: <YY9xD1K0cUpc5iCW@kroah.com>
References: <20211113052815.358793-1-liujunqi@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113052815.358793-1-liujunqi@pku.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 01:28:15PM +0800, Liu Junqi wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Liu Junqi <liujunqi@pku.edu.cn>
> ---
>  drivers/staging/mt7621-dma/hsdma-mt7621.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-dma/hsdma-mt7621.c b/drivers/staging/mt7621-dma/hsdma-mt7621.c
> index 1424d01d434b..282fc807d0de 100644
> --- a/drivers/staging/mt7621-dma/hsdma-mt7621.c
> +++ b/drivers/staging/mt7621-dma/hsdma-mt7621.c
> @@ -455,9 +455,9 @@ static void mtk_hsdma_issue_pending(struct dma_chan *c)
>  	spin_unlock_bh(&chan->vchan.lock);
>  }
>  
> -static struct dma_async_tx_descriptor *mtk_hsdma_prep_dma_memcpy(
> -		struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
> -		size_t len, unsigned long flags)
> +static struct dma_async_tx_descriptor
> +*mtk_hsdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,

No, this is now worse looking.  The original was not pretty, but better
than this.

thanks,

greg k-h
