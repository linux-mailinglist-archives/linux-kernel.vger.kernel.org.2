Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D533FE49D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhIAVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238488AbhIAVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 263D860F90;
        Wed,  1 Sep 2021 21:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630530844;
        bh=7z3vWMPPeJNHqr9rK0ISrbSO6GXWv+7nWgnuE5I8epI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9SOLwgnb6ulbLnZb+3QlfFT9bqHEObLXFTlEvJpIQTTAEmX/yKZhCOZs3iG9DPec
         5f5xRmmmy5FKSyO3SsHpVNPqFCw+O1Pag5gAFjXlybdgx0y71NzxL+EcFxOZ0M0iBf
         TIFTeGnXXH4/I/Rzn2U9SBQEUcSUNfWgVeFrdfNE=
Date:   Wed, 1 Sep 2021 23:14:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krish Jain <krishjain02939@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Fix formatting for file "hsdma-mt7621.c" by fixing
 formatting of lines ending with "("
Message-ID: <YS/tGreHTw0XcVs5@kroah.com>
References: <CAPGkw+zcW+mG2hnvQZqPzeS3T2AobYmZkoPKkqHo-KK3MSKTaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPGkw+zcW+mG2hnvQZqPzeS3T2AobYmZkoPKkqHo-KK3MSKTaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 10:58:55PM +0200, Krish Jain wrote:
> From: Krish Jain <krishjain02939@gmail.com>
> 
> This patch fixes the format of the code. It properly formats lines
> that should not end with a '(' as suggested by checkpath.pl.
> 
> Signed-off-by: Krish Jain <krishjain02939@gmail.com>
> 
> ---
>  drivers/staging/mt7621-dma/hsdma-mt7621.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-dma/hsdma-mt7621.c
> b/drivers/staging/mt7621-dma/hsdma-mt7621.c
> index b0ed935de7ac..89b72a802800 100644
> --- a/drivers/staging/mt7621-dma/hsdma-mt7621.c
> +++ b/drivers/staging/mt7621-dma/hsdma-mt7621.c
> @@ -162,8 +162,7 @@ struct mtk_hsdam_engine {
>   struct mtk_hsdma_chan chan[1];
>  };
> 
> -static inline struct mtk_hsdam_engine *mtk_hsdma_chan_get_dev(
> - struct mtk_hsdma_chan *chan)
> +static inline struct mtk_hsdam_engine *mtk_hsdma_chan_get_dev(struct
> mtk_hsdma_chan *chan)
>  {
>   return container_of(chan->vchan.chan.device, struct mtk_hsdam_engine,
>   ddev);
> @@ -174,8 +173,7 @@ static inline struct mtk_hsdma_chan
> *to_mtk_hsdma_chan(struct dma_chan *c)
>   return container_of(c, struct mtk_hsdma_chan, vchan.chan);
>  }
> 
> -static inline struct mtk_hsdma_desc *to_mtk_hsdma_desc(
> - struct virt_dma_desc *vdesc)
> +static inline struct mtk_hsdma_desc *to_mtk_hsdma_desc(struct
> virt_dma_desc *vdesc)
>  {
>   return container_of(vdesc, struct mtk_hsdma_desc, vdesc);
>  }
> @@ -457,9 +455,7 @@ static void mtk_hsdma_issue_pending(struct dma_chan *c)
>   spin_unlock_bh(&chan->vchan.lock);
>  }
> 
> -static struct dma_async_tx_descriptor *mtk_hsdma_prep_dma_memcpy(
> - struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
> - size_t len, unsigned long flags)
> +static struct dma_async_tx_descriptor
> *mtk_hsdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest,
> dma_addr_t src, size_t len, unsigned long flags)
>  {
>   struct mtk_hsdma_chan *chan = to_mtk_hsdma_chan(c);
>   struct mtk_hsdma_desc *desc;
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
