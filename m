Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD128454970
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhKQPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbhKQPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:02:11 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A7C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:59:12 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o4so6916623oia.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vwEIGRd/k9q1/+y5hcDE349ZZtS7AT1p1s0Zcv7eNE=;
        b=dyMkyVuNdoMZvjI0ierM6RaC+RN6oZin+Sqkd6bM4mvd/cAUZGfbRBwTCXK9XUFmuN
         mXgtExUa30oDoPk+WTTAI1T5ZRYSd4uYAV9c1BwGZRHJRpCT2QgD7iUbSlREZtVlvQpu
         f9TGzhoiu6KJWaCx1V/SDwv+0onqKWgI0s4GDYG4CM8s0KQs8XsTvkgtTQS8i1wu0Oxg
         eeLY9uEKOL+rBGbFB+RpsGTLtaa/G3fnVpgbOmgbQREfHNDM/1cRc5Nc4InEoFfPPAcc
         EXVJO2rTtFu+xrwo8hIQ0lbV2JMwne2ZPX3GA40CtnmJ/VWSD5SoPNV24nZQ6b9HGQzI
         UTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vwEIGRd/k9q1/+y5hcDE349ZZtS7AT1p1s0Zcv7eNE=;
        b=VSmCmG1wwdkU2UUNOs+mUxUWQYIJVKEI0P83QV/7bfT4yzc54w7RRRYm9E0pwNu9ez
         iXJ14NbqWtZZ65Z7EL+EmUzh4Hctard2ugT7VOFQPK6JCt8W0o3se9b0VBUfvliWBPxA
         UAVFUj9AJvw3POc6OzTb3EATe7boP+AUENI0bepNghNzLMZlgcsF0JcG4LiXp0+sgrDa
         QgdY81/biJY/FkGSf6M9hvk7WdHbwrtsATrgABNjqrAAizZzuhCIcGtGlK5HphZeDWpW
         wnUI14eITIa9lO1Ro86ToRRcZdGqTjxZXtqT4c9WL0mKXB3uYwNMl2PhJxzBlWeXNZQz
         nSIA==
X-Gm-Message-State: AOAM532weR+fg/ikAe63RXteX05Z+9+m0gG+0ustIqtR6yPqOvdsY4Yg
        wdwtFoVbKELOcGQZp0lwfiww2Q==
X-Google-Smtp-Source: ABdhPJxm262/4sVs9neZzycZF3skmMRjr0n4bKAnJHM153HG6gX0GlpzV3dRgWlWYAIctxlrkuPVhA==
X-Received: by 2002:aca:b386:: with SMTP id c128mr179202oif.161.1637161152006;
        Wed, 17 Nov 2021 06:59:12 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e21sm15160ote.72.2021.11.17.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:59:11 -0800 (PST)
Date:   Wed, 17 Nov 2021 08:59:07 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v2] remoteproc: use %pe format string to print return
 error code
Message-ID: <YZUYu9Ko1lTgPslz@builder.lan>
References: <20211102141535.28372-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102141535.28372-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Nov 09:15 CDT 2021, Mark-PK Tsai wrote:

> Use %pe format string to print return error code which
> make the error message easier to understand.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 502b6604b757..2242da320368 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -575,8 +575,8 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  					   dma_get_mask(rproc->dev.parent));
>  	if (ret) {
>  		dev_warn(dev,
> -			 "Failed to set DMA mask %llx. Trying to continue... %x\n",
> -			 dma_get_mask(rproc->dev.parent), ret);
> +			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> +			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
>  	}
>  
>  	/* parse the vrings */
> -- 
> 2.18.0
> 
