Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73541A65D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhI1ESY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhI1ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:18:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:16:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b20so87198283lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eL8IYhkBbLYcNm7LWC+avj2icvoXrApd/DMgvG7Twyg=;
        b=Eg8E7WnVcCUfLf8Ic979XRm2k2bRRRS5cfcByGjlYk3mZw++clN8E9Mu0gCn2g6jlc
         DvNLz5lv3HRmcDkWz/2pi56Sq9GD884uDlV0wwmN8zU1fcmA/urMrQR6/KXxqYfP7/v0
         mQoGiTMoWWRKzKyYckYDAauVPWpN/zkm1al4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eL8IYhkBbLYcNm7LWC+avj2icvoXrApd/DMgvG7Twyg=;
        b=fU91nP2+aMZLz1fcOZ2JJJlTQdtrPVP5+5PXgPgSMV5A/ZLJ8ygmvTt+7G/mjxPy6y
         6LcJYzlzcJR01XJBhYOI+ymK744THYnGZeThOmvoFk1EQWNTM8S6blUVGALgsUgWNcMU
         PKq2+HCg4jdfS1MCeG49wsoH3anSsZ3WxeUN45/I1pvWJWiQbNMCCxTveJyrHzchzT5/
         bYcUglAEXZtrIyMpQp8aOGbStLhfAXX82l9uGozSKGQ5lCxHXjxD7skDpE14IrTehbON
         Nh9g3pLt3xOuu+AtKVBlH44XM/QWWKv6dgFJms7nK6gqtnoptKmVvzGezrADySCBORkH
         D9hQ==
X-Gm-Message-State: AOAM533ui4qTg6J29y4kQgIkMOZ6S6J+bi9IOzg4BTE/TZZ/oa0qmrom
        EGMgO36IvmSyu1PrMYAtvFpHsLNnptTVqwBp2q1arS1RkrA=
X-Google-Smtp-Source: ABdhPJx8KGnrGRNzuf6NG48x9cD+ZD+NRNaWIdRd4p9u7i9UtAdmAM8/xxrYlRzBWfIl36gUQk5oYDUYQcbS4fqjI5U=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr3397436lfq.597.1632802602866;
 Mon, 27 Sep 2021 21:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210927175944.3381314-1-briannorris@chromium.org> <20210927105928.v2.3.I8bb7a91ecc411d56bc155763faa15f289d7fc074@changeid>
In-Reply-To: <20210927105928.v2.3.I8bb7a91ecc411d56bc155763faa15f289d7fc074@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 28 Sep 2021 12:16:31 +0800
Message-ID: <CAGXv+5GxCHJM_CewS8dPTLc7NPC6jcKZvrUFat0nemzZpu8PUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: dsi: Disable PLL clock on bind error
To:     Brian Norris <briannorris@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Thomas Hebb <tommyhebb@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 2:00 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Fix some error handling here noticed in review of other changes.
>
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi
bridge driver")

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Additionally, I would move patch 2 and this patch before the first patch,
as these two fix a commit introduced in v5.0, while the first patch fixes
something introduced in v5.14. This would make automatic backporting cleaner.

> ---
>
> Changes in v2:
> - New
>
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> index fa4080176719..0ed13d81fe60 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -943,7 +943,7 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
>         ret = clk_prepare_enable(dsi->grf_clk);
>         if (ret) {
>                 DRM_DEV_ERROR(dsi->dev, "Failed to enable grf_clk: %d\n", ret);
> -               goto out_pm_runtime;
> +               goto out_pll_clk;
>         }
>
>         dw_mipi_dsi_rockchip_config(dsi);
> @@ -955,17 +955,19 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
>         ret = rockchip_dsi_drm_create_encoder(dsi, drm_dev);
>         if (ret) {
>                 DRM_DEV_ERROR(dev, "Failed to create drm encoder\n");
> -               goto out_pm_runtime;
> +               goto out_pll_clk;
>         }
>
>         ret = dw_mipi_dsi_bind(dsi->dmd, &dsi->encoder);
>         if (ret) {
>                 DRM_DEV_ERROR(dev, "Failed to bind: %d\n", ret);
> -               goto out_pm_runtime;
> +               goto out_pll_clk;
>         }
>
>         return 0;
>
> +out_pll_clk:
> +       clk_disable_unprepare(dsi->pllref_clk);
>  out_pm_runtime:
>         pm_runtime_put(dsi->dev);
>         if (dsi->slave)
> --
> 2.33.0.685.g46640cef36-goog
>
