Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D142B35BB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhDLHxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhDLHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:53:20 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74791C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:53:02 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id r196so2666011vkd.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEjRzkzGszkYylJXGDtV4r/en+SeT+2kj3aD/Vvt87Y=;
        b=CUEMvkxetbGEQU9YJ9loBMwHEplKBnPwR1VieT4vaAw1qKyLktzFCFCMkK/Uc9diNs
         1dgHEyfERVyD+HQld2b+Sd/W6/lLPjoopx3d1tMJemgCLGkdpZofVcIdP5e4lTM/nf+Z
         9FFmgy1EdcDEsFy2jqrS+CGhGcpu1mZZXxdwoQdjYICzJrZt9J3c7G4vl5efeNJo40rr
         U4HsDYoq9WlTppyDb2Cqb2u9GG0Ma0fsC82z6AvIHTpj3rg8L2px5wDWDk2yBOr//I71
         En3TnWmbK1CAkJtwDpM58/5BkuO7Hk9NkuUw2AOab5ycYWcMYZEVECIslmN1NiFcj5EB
         oxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEjRzkzGszkYylJXGDtV4r/en+SeT+2kj3aD/Vvt87Y=;
        b=sfOdb1v/CWSebfkEznAqHVTKhA9on0kpmYiXPE1xbH9dZeDBgEEjDvVIpc0cMMaGmx
         aZJVLiePY8gbSClPcjJpTP0wrkXhl/r1vZsRODBE3TxXLakY870xVjkp14+SdH43w4px
         n6IcztFGKyJcfP7q8dpnd2Td2z/H/KZc2dRm94DrXQbDEJ/seSlHZwoDO4Vh38kEM8Yi
         zJeND1SUTtKYsVdU2gctzwbe4CbCuHqeTdnq8jayTlN18dP2oonn5a9SszSag+lgrfm7
         kqWY4bVzTVLFOXTWNhdPGq+iDO5yguyHLLeD5DU3kSWqYV5G2M68wSa+yYIe5KbFHBAQ
         Bkpg==
X-Gm-Message-State: AOAM5304tB17wZsoDfINNQjJGBk1l2a/kuvaw14PqXn4QvpwOOwkn4Te
        hrKgS45evYuozfq1ncZ6EdXY6qfphCa3XfnJW44Ydg==
X-Google-Smtp-Source: ABdhPJxD1X9uNNFdKbT8gzQZDyV3755/Viv3xdkUjBAOawlad9eLl4TedcVmmIFywBUo+oQvWWAMUod+Zec2zrL0gts=
X-Received: by 2002:a1f:2c58:: with SMTP id s85mr18470920vks.15.1618213981700;
 Mon, 12 Apr 2021 00:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210409023801.3326572-1-qiulaibin@huawei.com>
In-Reply-To: <20210409023801.3326572-1-qiulaibin@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:25 +0200
Message-ID: <CAPDyKFqbvZot3mFiManMaZtZw8Cuau-4ewOJSVBdR-MeZU-JwA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-st: Remove unnecessary error log
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        patrice.chotard@foss.st.com, YueHaibing <yuehaibing@huawei.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 at 04:28, Laibin Qiu <qiulaibin@huawei.com> wrote:
>
> devm_ioremap_resource() has recorded error log, so it's
> unnecessary to record log again.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-st.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 78941ac3a1d6..d41582c21aa3 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -400,10 +400,8 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>                                            "top-mmc-delay");
>         pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(pdata->top_ioaddr)) {
> -               dev_warn(&pdev->dev, "FlashSS Top Dly registers not available");
> +       if (IS_ERR(pdata->top_ioaddr))
>                 pdata->top_ioaddr = NULL;
> -       }
>
>         pltfm_host->clk = clk;
>         pdata->icnclk = icnclk;
> --
> 2.25.1
>
