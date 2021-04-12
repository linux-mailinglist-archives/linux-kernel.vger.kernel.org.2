Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACB435BB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhDLHxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbhDLHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:53:17 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD3C06138D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:52:59 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id l1so1193109vkk.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcFlLUBMWxQKE3B4SECGAUhtA2wbG5MqwDkyb7fTUn0=;
        b=u9xumO9kleHHfj6tSe/0iqldeck9GJ6YXUX9u+OOybOasvmwDhemSKlk53mJdYzPqB
         6dMLHAf3fMpPCUYrVubGmBMvmoE4HeL33jFcs8md4Zu0XkXPWEUdm6Qm8HV4gc41ofXz
         sdjtU6pJz0XbmPnY+N+fDRx894+MzWurtJQlEp7ASGW/YjOxWPTwsBUkbt4e41o9qoYj
         p51k2Cex81UlMae7jVc6wJvUzhZU28h3A1XO3Ltod0NqCL4QatsWmcXTwhRr2yJDVU1Z
         QCpTYgc2UGbHeXxwEgIoK0enOe9dG/YEYTpfD7XRY1h4rBZmqk4WPbAi3zTT92SXfKz3
         yDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcFlLUBMWxQKE3B4SECGAUhtA2wbG5MqwDkyb7fTUn0=;
        b=ZP7Fa7RjAMn6T71o/WZi/fXylXCoUOCG34sPkrtGYvO2mDcnkCZyrCUzoSqvhNcEgv
         wCu4s9jRfya9c2+QPTWsh30ZtC6PlobFGd4ZWYdP9P9fBbyJ6PdMr4ensRRdx0zUZ+0N
         BkjX35QXGzvbSnEdkcwIYArcoyQB7C6+usYG6Jv8pHIqsNp6XfPIIzurEWAdu3iU6H9v
         uMFn5P3Z7ODZ9Aels6WZWeuwLiSw4HtDge0AN+88WOMIBaAU7KHU1nUh3rigw54b4VaC
         DA221rfUmwAsIMgHIrDKQhPaTXamfMuWzx9/7cGN8rJO8fwCKjD++ykm1tPUzLXIr1cH
         d+EQ==
X-Gm-Message-State: AOAM533hzJWF/jN2zTp54VjFipLMWAvpQfYgfNo40Pr8OX9mrImVTD1W
        AmJ1v263eEUGMGNS+g9tDDFj/fO4aMOJqh7UeL9Jow==
X-Google-Smtp-Source: ABdhPJyaO4Xd3hVmOLdeg8TevfbirfrXrX5rlO/3ixxXssURkNOxuNhiJ30d/DBpHuoz9T9c3tLdXhKljdhEVV/BYk4=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr18551153vkb.7.1618213978935;
 Mon, 12 Apr 2021 00:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210409023349.3325907-1-qiulaibin@huawei.com>
In-Reply-To: <20210409023349.3325907-1-qiulaibin@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:22 +0200
Message-ID: <CAPDyKFrwp6tbaHt6nctnTgppG5PsS2Hcb-BPhBT6N0-fmcpAWA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: owl-mmc: Remove unnecessary error log
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 at 04:24, Laibin Qiu <qiulaibin@huawei.com> wrote:
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
>  drivers/mmc/host/owl-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 5490962dc8e5..3dc143b03939 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -581,7 +581,6 @@ static int owl_mmc_probe(struct platform_device *pdev)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         owl_host->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(owl_host->base)) {
> -               dev_err(&pdev->dev, "Failed to remap registers\n");
>                 ret = PTR_ERR(owl_host->base);
>                 goto err_free_host;
>         }
> --
> 2.25.1
>
