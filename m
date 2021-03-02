Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17532A49D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446435AbhCBKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbhCBKkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:40:13 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC70C0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:39:22 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id t15so6603910ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Umhvl4bq+upwhpgsDahvWiFLVfJYEzzIi8Pp8HB1UCU=;
        b=OQG3lH5wODLrZdv+wguq1ZV0/ouPrqhe3yjBzS5zIDZ9Z3IP+ASIFxVf+INdGRUEKQ
         2/twk8qhoUJem5qqPWeeh5b74/yj2selF5wiJ4HmR9mo8H0T50wrgDxAqWRrGVgfcvUV
         VngPYDvdzNKKI71OQE1LDYEt9UQyRTASDZTYp6vXooGlDnbSU4rNy9sHsEX4eORftUHY
         YnCyFFsI1E+85nKfV4oehVPQEgcBTOfUJzuXn+8QpCKNsJVsgjL+wAmq9XmN8LVmZQdq
         Ke/iqI6p0/62buAnjIu5ZAAFafN8r/gikx0YnzlmndlYxofqONVdOr86VCFm4G998eQi
         g2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Umhvl4bq+upwhpgsDahvWiFLVfJYEzzIi8Pp8HB1UCU=;
        b=M/+qyPClEXx9lcmqWoc3an9/aAvHTWJgZrl/IKR/QkU//0ySn6pLYhLP0OF71BzbNA
         5y2kyM9lQZx3LfeXH4eCz/KXpkvEclGh2IscpeTX7cZLmRST62aJjv3a5OexzFjpL3jO
         nimCFSEnfSQ7yw7sQ8D4T887gC5bowXQ9yDgQ7bfKxcEFvlnjtRnzDVj1Fc/AtaQWPiY
         FVKLPZ40IyYrCUUt19dzDcsP79Fg4Lf5t3bI5Azs082W6vRKW9bmv/DQSc88FufBM2qH
         VNzLA50kNC6e0Zj3ihLcLXwvOUasufmYURNTbOW/mNDkGxHKD6410NNSu2mpNusmkWb2
         C6wg==
X-Gm-Message-State: AOAM531J55ieOMzoytc0wymEL3bADE4A8lpN1AhA80rjvkCqhQ2KelUn
        u536UozroxRYnHDJCWf6e2n2Jn80UAimB6f6YWNBLA==
X-Google-Smtp-Source: ABdhPJzEyACksmZlApWoBwwWgL7AzKp9cesm9Vy9z6W3q1lFtagYm5gc2fmXlNs/auwZp9RnR9QdnP8r6zx/hInmD3k=
X-Received: by 2002:ab0:6045:: with SMTP id o5mr10027474ual.100.1614681562074;
 Tue, 02 Mar 2021 02:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20210215015116.1355-1-zbestahu@gmail.com>
In-Reply-To: <20210215015116.1355-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:38:44 +0100
Message-ID: <CAPDyKFrNBPUdU772EFhcodbu6Mnhv+KmfV6E1oNau1xOooNf8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Reduce code duplication to mmc_spi_send_{csd|cid}
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
        zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 at 02:51, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> mmc_spi_send_{csd|cid} have similar function body. Let's remove the
> duplicated part to simplify the code, just add opcode to distinguish
> them in changed mmc_spi_send_cxd().
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_ops.c | 39 +++++++++------------------------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 265d95e..f413474 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -296,61 +296,40 @@ int mmc_set_relative_addr(struct mmc_card *card)
>         return 0;
>  }
>
> -static int mmc_spi_send_csd(struct mmc_host *host, u32 *csd)
> +static int mmc_spi_send_cxd(struct mmc_host *host, u32 *cxd, u32 opcode)
>  {
>         int ret, i;
> -       __be32 *csd_tmp;
> +       __be32 *cxd_tmp;
>
> -       csd_tmp = kzalloc(16, GFP_KERNEL);
> -       if (!csd_tmp)
> +       cxd_tmp = kzalloc(16, GFP_KERNEL);
> +       if (!cxd_tmp)
>                 return -ENOMEM;
>
> -       ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CSD, csd_tmp, 16);
> +       ret = mmc_send_cxd_data(NULL, host, opcode, cxd_tmp, 16);
>         if (ret)
>                 goto err;
>
>         for (i = 0; i < 4; i++)
> -               csd[i] = be32_to_cpu(csd_tmp[i]);
> +               cxd[i] = be32_to_cpu(cxd_tmp[i]);
>
>  err:
> -       kfree(csd_tmp);
> +       kfree(cxd_tmp);
>         return ret;
>  }
>
>  int mmc_send_csd(struct mmc_card *card, u32 *csd)
>  {
>         if (mmc_host_is_spi(card->host))
> -               return mmc_spi_send_csd(card->host, csd);
> +               return mmc_spi_send_cxd(card->host, csd, MMC_SEND_CSD);
>
>         return mmc_send_cxd_native(card->host, card->rca << 16, csd,
>                                 MMC_SEND_CSD);
>  }
>
> -static int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
> -{
> -       int ret, i;
> -       __be32 *cid_tmp;
> -
> -       cid_tmp = kzalloc(16, GFP_KERNEL);
> -       if (!cid_tmp)
> -               return -ENOMEM;
> -
> -       ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid_tmp, 16);
> -       if (ret)
> -               goto err;
> -
> -       for (i = 0; i < 4; i++)
> -               cid[i] = be32_to_cpu(cid_tmp[i]);
> -
> -err:
> -       kfree(cid_tmp);
> -       return ret;
> -}
> -
>  int mmc_send_cid(struct mmc_host *host, u32 *cid)
>  {
>         if (mmc_host_is_spi(host))
> -               return mmc_spi_send_cid(host, cid);
> +               return mmc_spi_send_cxd(host, cid, MMC_SEND_CID);
>
>         return mmc_send_cxd_native(host, 0, cid, MMC_ALL_SEND_CID);
>  }
> --
> 1.9.1
>
