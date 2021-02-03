Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4230D24C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhBCEDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhBCEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:03:51 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83607C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 20:03:09 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id g5so7871183uak.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 20:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRmcBS+D8ie4DR9UuABqvgaIR3BnrLM49K5MwM/jb2k=;
        b=Cnkmlci4Z9x+W9PJgvly/S+T/Xk7q2JAM0NOGhqlpC7cCWxjELth6QexjoNksXnl6A
         8s+rwaY5mTIEe4ADvKzRHYkx7aSYUlCpD4R4kj0eZ4g0FW05K0f+7JiWwws/L8HU0LbI
         nMCwrt8I+1VHLGlwxeOCno6OZ/UhCde+lxvCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRmcBS+D8ie4DR9UuABqvgaIR3BnrLM49K5MwM/jb2k=;
        b=SzNrBISFXcbBix/aAEr+Ygz6wl7aMPYZ176wTwbzVAmOaIQ9HhasmFcSBlCTeRTcWf
         vrszbs4818uAthGaQu9JXQMMJVbviCySrIGUoySyyJy06jeimpi99YeuSmzuHUxCwSbs
         2dLqa1jRSvIXgIvQwMs0QLLcfcZDxCgY6FtBCKaj5kks8K4Uxqx8UW27loc8nc2yE60G
         bySS+sL0dAHYrXnq7fodLmCrziXsKJtC8qBCX/y1FKNZ1nzV/NgtQWFdZVf8dbaqGYgE
         GSCLSQdHI3iHnIogMUszQJhtu+cjN3FNVtKg1pyK+ygthVMcej5QRtECcLDsrhtagF20
         N8yA==
X-Gm-Message-State: AOAM530L/Hy1Ww7rCy5zovoTaJ31GJxLRHlCRh2DBnXCVSSzRd7F6hqS
        stxKe7lMIWJi+RIlzLLaxe6jGKjfIANmFstYwPDllA==
X-Google-Smtp-Source: ABdhPJzKgdO699d7NEidKkYUFGCitxzY1h0GLirMYgqHTXBy0DPlWTL+v/D9UP+CXksw/KwcJdfdGHR++aPPOFRquR8=
X-Received: by 2002:ab0:3043:: with SMTP id x3mr748227ual.88.1612324988471;
 Tue, 02 Feb 2021 20:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20210201034755.15793-1-jitao.shi@mediatek.com>
In-Reply-To: <20210201034755.15793-1-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 3 Feb 2021 12:02:57 +0800
Message-ID: <CANMq1KA4nXBuy50pANw1MKbOm0DKNBgBTcHTmMoPFEq-GskKxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: fine tune the data lane trail by project dts
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa cheng <cawa.cheng@mediatek.com>, shuijing.li@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 11:48 AM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Some panels or bridges require customized hs_da_trail time.
> So add a property in devicetree for this panels and bridges.

Since this changes the device tree, you also need to upload a binding
document change.

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 8c70ec39bfe1..6e7092fa2fee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -194,6 +194,7 @@ struct mtk_dsi {
>         struct clk *hs_clk;
>
>         u32 data_rate;
> +       u32 da_trail_delta;
>
>         unsigned long mode_flags;
>         enum mipi_dsi_pixel_format format;
> @@ -234,7 +235,7 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
>         timing->da_hs_prepare = (80 * data_rate_mhz + 4 * 1000) / 8000;
>         timing->da_hs_zero = (170 * data_rate_mhz + 10 * 1000) / 8000 + 1 -
>                              timing->da_hs_prepare;
> -       timing->da_hs_trail = timing->da_hs_prepare + 1;
> +       timing->da_hs_trail = timing->da_hs_prepare + 1 + dsi->da_trail_delta;
>
>         timing->ta_go = 4 * timing->lpx - 2;
>         timing->ta_sure = timing->lpx + 2;
> @@ -1094,6 +1095,13 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>                 goto err_unregister_host;
>         }
>
> +       ret = of_property_read_u32_index(dev->of_node, "da_trail_delta", 0,
> +                                        &dsi->da_trail_delta);
> +       if (ret) {
> +               dev_info(dev, "Can't get da_trail_delta, keep it as 0: %d\n", ret);
> +               dsi->da_trail_delta = 0;
> +       }
> +
>         comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>         if (comp_id < 0) {
>                 dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> --
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
