Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E53F5ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhHXNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbhHXNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:16:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4112AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:16:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q21so37565778ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydTVZ15OhL0mGtwmOd376yklz9JBnBhbEVNdkVMJ/z0=;
        b=XPM3yRqCi4Jh+kJYR3AfSNeIhcwiK9U57g5ukbYv7PRiIEIm93U8ACJ6oGo1TVceQm
         cQQy5M/fQCBoeWm2+pbY66wVkAJEEj0NrV9EkSkkXKOiStCyaMEXmRgdKxTkZhYx+k1W
         5sU/Ons4G7ErJPycd/6adP7IBvdiKwAzhzQ22oPHRW3Z7w7ShMm9AHexTMKAyxvMQjJk
         gxucXOGQBzsUbAx24Xz2XqZbYWWNAf2+g4YLb+MORNdGezqoDWXqjuYay+wW3y9ynPy4
         hNAqDHbCZejWwlU9SZhJtMAx25yZywqbqLrG77zEMjYCK/CgUOFe54PKGukV5l7yuMe7
         N7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydTVZ15OhL0mGtwmOd376yklz9JBnBhbEVNdkVMJ/z0=;
        b=SzKfS/1S80QounCSlJgCSwEXpQ5tZzTTbpnzN4nGWXW/yuGZZo8XIdyHok38i6mv+n
         UrqJoPvuhowhPooJWAgVrX6WQ7x6E22pvl9yGPp/njSpW1Gpy0YAH48zJEm02mEKPrM7
         LKF2Br5NW0TGA8mXqZj8YkIg6gJrHty7ZQJLbcWxp8YBKic0Cgf8jfrtuWoOoH558qOK
         XC1Cd6Ig2BH4or9qadjI1qbdaxNbWt84AF/2VjizHLbowDzVRML5iHMdAwqba8Pl7u0X
         Gcc9dE4Ue42bKD1IYlHGG0U5kOS0zeJxU5+mB5FRqCQ/YdWKicWyZcVeuTUsb4dZrr/5
         XZ2g==
X-Gm-Message-State: AOAM531VDJAeY4AVX0DJu5iiUIyvQ8n67824AgwU8yfJEocv8CjpKpkK
        H8bYwxIZhwgRXG7Xg+PC1za05QpLUlZrVQPPA+mzoQ==
X-Google-Smtp-Source: ABdhPJy753AzVXSSiQfqytntQ08HWRbs8vTdlqrvJAwaJjLm66jH8yB6x80jNU5eEaj/WH62hBiYT5ElWXoHzqleFzk=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr30044554ljn.364.1629810964603;
 Tue, 24 Aug 2021 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210816073813.11715-1-Mason.Zhang@mediatek.com>
In-Reply-To: <20210816073813.11715-1-Mason.Zhang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 15:15:28 +0200
Message-ID: <CAPDyKFpSOcX6End_L0mLRt61s0aS_zT19snM71j9bxgMi1oUuA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: mediatek: fixed clk contrl flow
To:     Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 at 09:39, Mason Zhang <Mason.Zhang@mediatek.com> wrote:
>
> this patch fixed clk contrl flow in set clk rate, no need close clk src,
> gate cg is enough, so no need call clk prepare/unprepare.

No, this isn't the way we should deploy clock support in drivers.

If the driver doesn't need to gate/ungate clocks from atomic context,
the proper thing is to use the slow path APIs, clk_prepare_enable()
and clk_disable_unprepare().

Kind regards
Uffe

>
> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..d9835b272c1f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -895,9 +895,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>          * So if want to only gate src_clk, need gate its parent(mux).
>          */
>         if (host->src_clk_cg)
> -               clk_disable_unprepare(host->src_clk_cg);
> +               clk_disable(host->src_clk_cg);
>         else
> -               clk_disable_unprepare(clk_get_parent(host->src_clk));
> +               clk_disable(clk_get_parent(host->src_clk));
>         if (host->dev_comp->clk_div_bits == 8)
>                 sdr_set_field(host->base + MSDC_CFG,
>                               MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> @@ -907,9 +907,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                               MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
>                               (mode << 12) | div);
>         if (host->src_clk_cg)
> -               clk_prepare_enable(host->src_clk_cg);
> +               clk_enable(host->src_clk_cg);
>         else
> -               clk_prepare_enable(clk_get_parent(host->src_clk));
> +               clk_enable(clk_get_parent(host->src_clk));
>
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> --
> 2.18.0
>
