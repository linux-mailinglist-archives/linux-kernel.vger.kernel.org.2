Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB431AC53
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 15:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBMOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 09:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBMOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 09:35:44 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B03C061756
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 06:35:03 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k9so1153447vsr.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOR9IfKzh/aAizYitDZAhS1BYlLKD2WQaQZDVSqy5Lc=;
        b=XdYg5H9pL7KUN8K68Y+z5M210rVlu9kiD9RbDbB25+aBZbIkegIMvNIpeeK6Uu4mHP
         5BbANhxXsDIvzXxcTGbTyenpeNNf7cSLsNiW/YNoHvMv3+1ZVMcPxVqKZqMz+Zq59hY2
         e3kN1AMUdfAgcFBeF5r7OPQ4I1vE1KHxHiYwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOR9IfKzh/aAizYitDZAhS1BYlLKD2WQaQZDVSqy5Lc=;
        b=Nw5g/isGFHYuUcnKJrcvmkKcWFyVL3u2lPYDRXVDVFGR75e0n54g8S2dzeMmcsL7Uz
         f9cOovHDENLwaSyf+fBHQabiSpT65lEbeFZ7zsImjTmLTg9d/93p9o8n/kmt3DN5yswa
         1ECGmOXn/G8/piNyYFMLPgmyjG4AZUQDWP+o/f6qVpaoiPDaODu3L9kN+NlFqboEO7pK
         thW+e+1edyK5rHWs5eK6AFXBK62WBbii4iK2i4gyXV/RRm2flgwT2SG55gv50BMIvD6J
         Ld0+ovNnCE5riq4gt/Bm5NdDEoMsxgqjX9rCzwQiL9JctUjgATNBgvU7nnqMsYco440z
         lq2w==
X-Gm-Message-State: AOAM532e/Ju/pR+cpmyTRML325ZkIOVsNsoP1XI7e4SMfhEnADtoDhXY
        S6hvxSBvVNFfNozt77KoX2Wlt34KnbQeypElKbpiqg==
X-Google-Smtp-Source: ABdhPJyk4HyZZcnu7E233puNxgMJ3TX4LD6d+a/RN/+Gh5/K+LPRHVkshJy2ck1e3TKMLuVZdSM8SnsIPQJuc3sCiH0=
X-Received: by 2002:a67:e119:: with SMTP id d25mr4747759vsl.16.1613226902062;
 Sat, 13 Feb 2021 06:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20210208014221.196584-1-jitao.shi@mediatek.com> <20210208014221.196584-2-jitao.shi@mediatek.com>
In-Reply-To: <20210208014221.196584-2-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 13 Feb 2021 22:34:51 +0800
Message-ID: <CANMq1KD7upJarxXJsX0ue4doT3=P_n+tcTyS7o6E-XvXGyRe1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/mediatek: mtk_dpi: Add check for max clock
 rate in mode_valid
To:     Jitao Shi <jitao.shi@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        shuijing.li@mediatek.com, David Airlie <airlied@linux.ie>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Pi-Hsun Shih

On Mon, Feb 8, 2021 at 9:42 AM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Add per-platform max clock rate check in mtk_dpi_bridge_mode_valid.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

I believe this patch (and the following) were actually authored by
Pi-Hsun: https://crrev.com/c/2628812 . Would be best to keep the
author information (unless I'm missing something of course).


> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 52f11a63a330..ffa4a0f1989f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -118,6 +118,7 @@ struct mtk_dpi_yc_limit {
>  struct mtk_dpi_conf {
>         unsigned int (*cal_factor)(int clock);
>         u32 reg_h_fre_con;
> +       u32 max_clock_khz;
>         bool edge_sel_en;
>  };
>
> @@ -555,9 +556,22 @@ static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
>         mtk_dpi_set_display_mode(dpi, &dpi->mode);
>  }
>
> +static enum drm_mode_status
> +mtk_dpi_bridge_mode_valid(struct drm_bridge *bridge,
> +                         const struct drm_display_mode *mode)
> +{
> +       struct mtk_dpi *dpi = bridge_to_dpi(bridge);
> +
> +       if (dpi->conf->max_clock_khz && mode->clock > dpi->conf->max_clock_khz)
> +               return MODE_CLOCK_HIGH;
> +
> +       return MODE_OK;
> +}
> +
>  static const struct drm_bridge_funcs mtk_dpi_bridge_funcs = {
>         .attach = mtk_dpi_bridge_attach,
>         .mode_set = mtk_dpi_bridge_mode_set,
> +       .mode_valid = mtk_dpi_bridge_mode_valid,
>         .disable = mtk_dpi_bridge_disable,
>         .enable = mtk_dpi_bridge_enable,
>  };
> @@ -673,17 +687,20 @@ static unsigned int mt8183_calculate_factor(int clock)
>  static const struct mtk_dpi_conf mt8173_conf = {
>         .cal_factor = mt8173_calculate_factor,
>         .reg_h_fre_con = 0xe0,
> +       .max_clock_khz = 300000,
>  };
>
>  static const struct mtk_dpi_conf mt2701_conf = {
>         .cal_factor = mt2701_calculate_factor,
>         .reg_h_fre_con = 0xb0,
>         .edge_sel_en = true,
> +       .max_clock_khz = 150000,
>  };
>
>  static const struct mtk_dpi_conf mt8183_conf = {
>         .cal_factor = mt8183_calculate_factor,
>         .reg_h_fre_con = 0xe0,
> +       .max_clock_khz = 100000,
>  };
>
>  static int mtk_dpi_probe(struct platform_device *pdev)
> --
> 2.25.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
