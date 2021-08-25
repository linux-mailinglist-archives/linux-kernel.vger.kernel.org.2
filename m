Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186523F6C72
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 02:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhHYAIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 20:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhHYAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 20:08:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A4C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 17:08:08 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a5so4668155qvq.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dy34Bpa772Ms7Y11k1wGoCbDLkxQgvtHnyVRMjlZLu0=;
        b=F9nMiLn+D95+1WKb6lhWm0igc6Zfw+sTemFxdOegTj+5pfHi2BBs44IaADiOUSx0kR
         tD2Rjur+7CPNp2fLUaASMt/FMEBjO8y2MghMjX3NfzvTSWaSFuS5QDJr/X641j+Oi6NY
         VeVn3md9ggxz4Cx79j8u2Hi+IS6gTsTAva8b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dy34Bpa772Ms7Y11k1wGoCbDLkxQgvtHnyVRMjlZLu0=;
        b=azKSdcEyJHGqcjaP/CAOO553nWFQ8Jq9PiJVHG+vaSzRFKqQ+fyj6lu/D8QMplpTOm
         dGC2Kbax7IlLgF33QwHHGBK2UVS0PPRsLpf22UDn6n6DfvMLjyHvD7KFgaaiQhx8djG+
         WsY4BanteJbNiOCDEFYqi90F5rYxHcjqlkFrCwV3/fUFcvKUvIj0OqZJeiXBanY0zOnj
         dzCYIbm1/SwlKKEcW/pi22W3dgU51K/R2Ussa5lF+cSbsKO5VX575D+YTUpMl62d228I
         Sf2DwUfQmuet67oCxJD9l8XD/pfNhFNCosTcPX/wGzON0AI2whZ8iFvCk+M7H5xeBBqL
         KD2A==
X-Gm-Message-State: AOAM532VgDV4a9NvlX7bBTzWEjvwJ1wIrOFoXxudntWyNRgWt+CdTcoX
        phatJytqJF0CHI/W7kmN083wD0Gar2Cfnt86xL8=
X-Google-Smtp-Source: ABdhPJy1iZ2N3owLASCJrIAxdQb/2bP1MaYxdzyrij7SGAad/j1NBfSzGRrl87bSWJKdaT+YdBjPc4fuPaGDOGwhd7U=
X-Received: by 2002:ad4:5bc8:: with SMTP id t8mr41409487qvt.18.1629850087535;
 Tue, 24 Aug 2021 17:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210824085522.1849410-1-yangyingliang@huawei.com>
In-Reply-To: <20210824085522.1849410-1-yangyingliang@huawei.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 25 Aug 2021 00:07:55 +0000
Message-ID: <CACPK8Xc9kfB1wYPOsitP1PAoF9dZtB-N1c=XTaaS2zPNONnv5w@mail.gmail.com>
Subject: Re: [PATCH -next v2] soc: aspeed-lpc-ctrl: Fix missing
 clk_disable_unprepare() on error in aspeed_lpc_ctrl_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 08:49, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Move syscon_regmap_lookup_by_compatible() above the
> devm_clk_get() to avoid missing clk_disable_unprepare().
>
> Fixes: 2f9b25fa6682 ("soc: aspeed: Re-enable FWH2AHB on AST2600")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks for the patch. I will send it to the soc maintainers for merging.

> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index 6893c5ec3259..72771e018c42 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -295,6 +295,16 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> +       if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl")) {
> +               lpc_ctrl->fwh2ahb = true;
> +
> +               lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
> +               if (IS_ERR(lpc_ctrl->scu)) {
> +                       dev_err(dev, "couldn't find scu\n");
> +                       return PTR_ERR(lpc_ctrl->scu);
> +               }
> +       }
> +
>         lpc_ctrl->clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(lpc_ctrl->clk)) {
>                 dev_err(dev, "couldn't get clock\n");
> @@ -306,16 +316,6 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 return rc;
>         }
>
> -       if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl")) {
> -               lpc_ctrl->fwh2ahb = true;
> -
> -               lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
> -               if (IS_ERR(lpc_ctrl->scu)) {
> -                       dev_err(dev, "couldn't find scu\n");
> -                       return PTR_ERR(lpc_ctrl->scu);
> -               }
> -       }
> -
>         lpc_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
>         lpc_ctrl->miscdev.name = DEVICE_NAME;
>         lpc_ctrl->miscdev.fops = &aspeed_lpc_ctrl_fops;
> --
> 2.25.1
>
