Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A259377D02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhEJHTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:19:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE75C061573;
        Mon, 10 May 2021 00:18:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y124-20020a1c32820000b029010c93864955so10513947wmy.5;
        Mon, 10 May 2021 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQi+bRBMv4fOOAJ235DSC4hwnnlkf5xGo58Xk+7PACU=;
        b=YL/EdIRIYOkEXfGuBjjYNtziDmn2ouTprFKLzs5EjGDSabi8i4a3IELHgzcyC6wfau
         ZUHIRkZ/shYrGTRVrsUlF5Z3XNAmhsGrhnHJgimkRa0viPRaMnU+UN1sekmgMDNL3DMa
         FlCMfjor4rWZb6GEA1VZNjLpeikmtXY9kHBfHfGIuPcq5CyS0kBxLLLBjkK/T8zfljA1
         WgVV48BM7gMT8Co5VdLpvV38tjoH86m8737GEJgXqU3lCiMpPGpXKau8Dvu6PWKQBIsD
         IVFnLY4Tcyo3ETLmqkNGXhI/eEMTGCt7KNNuVbmMnFJA6+LLmn71N+x3MRLlug+SFkrI
         7Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQi+bRBMv4fOOAJ235DSC4hwnnlkf5xGo58Xk+7PACU=;
        b=jNNFonVtSzksuSGYLKszK62l4XYIgXlq3NMboy4koFxMKqSdD50a0A+ygS3VzLqDNM
         Km3GzB5MzGEPTAgLjt+Z3U/SovmL6ohq64oMXo7V6iK0GLMGqhj4DXfr7m0k2/J/m6i9
         P/OQTVMkRz+dZQh0se0KsdOCQwqEWUmuvqPLwJWCYuPXAbHWpL8OyiHnvrEkX/179KDV
         UKisKuPv4AjJGWbp2VAM0Rcr0lImW0p2gLWxNSe8vFA+fj8ZMGTc/VagoHrXsbLxTUSC
         JF9SwFytdV3/en3pSMZgK8AkGHQq4ZSIukp5iux2uyTwDWES0ib21KJDhBbH645+ZuPS
         +cOw==
X-Gm-Message-State: AOAM533KwYbkG7f7TIBlM3SuKnr0beGnXAXwOzJGKBBvURNIOauMuoqJ
        kGofsgeywLAbIwK7BuPKlMtr1Wiao630eBHCuIs=
X-Google-Smtp-Source: ABdhPJyAft8oEdwcpUU4jeAq1mi8jafO5mM6ccrJHn089XvwF5iNQODf2vlcI11L4c+FfjO+yVsboVVIy8hhmjj8ChY=
X-Received: by 2002:a1c:b002:: with SMTP id z2mr24635672wme.26.1620631124118;
 Mon, 10 May 2021 00:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <5bc44aace2fe7e1c91d8b35c8fe31e7134ceab2c.1620406852.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <5bc44aace2fe7e1c91d8b35c8fe31e7134ceab2c.1620406852.git.christophe.jaillet@wanadoo.fr>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 10 May 2021 15:18:07 +0800
Message-ID: <CAAfSe-srh_3S-AStLe7f+KuKQ2MY07OyhZ22nnEumE+uE8gUyA@mail.gmail.com>
Subject: Re: [PATCH] nvmem: sprd: Fix an error message
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Freeman Liu <freeman.liu@unisoc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 at 01:02, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'ret' is known to be 0 here.
> The expected error status is stored in 'status', so use it instead.
>
> Also change %d in %u, because status is an u32, not a int.
>
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks.
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>


> ---
>  drivers/nvmem/sprd-efuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index 5d394559edf2..e3e721d4c205 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>         status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>         if (status) {
>                 dev_err(efuse->dev,
> -                       "write error status %d of block %d\n", ret, blk);
> +                       "write error status %u of block %d\n", status, blk);
>
>                 writel(SPRD_EFUSE_ERR_CLR_MASK,
>                        efuse->base + SPRD_EFUSE_ERR_CLR);
> --
> 2.30.2
>
