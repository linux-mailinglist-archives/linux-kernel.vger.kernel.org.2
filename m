Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEF395943
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhEaK4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaK4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:56:03 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:54:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 11so1541696plk.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cfy6DRXq6ljOfq2YCBqTmPMGCh7cF1e+Nv6/xZRuDY8=;
        b=fSg6clnVpmsaZhiKs1gJHe2zyGeJAcUON85LO3uJz/8hxZi5GWGW4/kYyuZN6UdrOu
         BDu0Q32uT2uspePyuicSfsx49R6yV9oR9vqrCA4OrMd0zuxEyQLeqKCpOg921AMHmuAV
         PP7/6hfbkyNYPv7OUYTuJNXYKLsZIvAMABpqCQGQ0tcSBUW8NeDGuurEU/frcQe0yMiv
         Q/hPJnxGVp6KPsLsiIGcPwWMqi/leMRIBwbKtVk564ar/IaR8RiapZYSeDnd3DC+wRcC
         U2BoN9TgEh//yoI2YEJZ9WvrCYxbR7RhKwKBywyVRc0gK+7COtFRVXJUqH452Yc31CW/
         8kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cfy6DRXq6ljOfq2YCBqTmPMGCh7cF1e+Nv6/xZRuDY8=;
        b=clR1FC2S2YM1ErJ3ba5WLiM1xRUGIedEYS4xygAVsFERyjKpIZyh7TVUqGdleFpxVh
         u1JxbfhRF55GKJ1ERAZLxpD5hZ54MonUDg28cZ2XtYB99vCXoKgoyB0oue+kMpZPSNYy
         1EDMcXf7njlOpMSEgwXEAKrheDSHxSuRe7AWXMbD8EnG9exoaIjP0ebtHcvaLuOK9WxX
         10C85g9sxThEtBfBDqqyZLiduAKS/BU0smCQRIeeiM0WZIACQL2+hlXvQNgee9/q+guL
         ldzZkaLSFzex/RpjdvlBFQrL8WdmttHa0Yz0gCxL5Eq+Jz2DCNRnUGyBSYMTF/PVUMAi
         UyEQ==
X-Gm-Message-State: AOAM5339V+StSKkvUZidYR6vaXuab+5MY/nRtdX7Vd92fQ8CbNwT7TxI
        WimGt2wgSGx07FFo57FsDMWxMlDSj79GWpq7SZ97e35mS/cB0AO2
X-Google-Smtp-Source: ABdhPJxDz2gIW1DZ83c0oElXPz5eTXwhSHNC3N8sUAP9Y6Mq9a9NDfbXGhgvPsGiUFlkWWMmrLXCQlGW+6jsuypk+6c=
X-Received: by 2002:a17:90b:308:: with SMTP id ay8mr19003707pjb.19.1622458463982;
 Mon, 31 May 2021 03:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210517081601.1563193-1-yukuai3@huawei.com> <20210529095554.3150362-1-yukuai3@huawei.com>
In-Reply-To: <20210529095554.3150362-1-yukuai3@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 May 2021 12:54:13 +0200
Message-ID: <CAG3jFyt53-MhwgGGcmMVSap3xCE_cQOmN26Rj3TvHtWFeVLZWg@mail.gmail.com>
Subject: Re: [PATCH V2] drm: bridge: cdns-mhdp8546: Fix PM reference leak in cdns_mhdp_probe()
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yu,

I'm not finding your this patch with the correct tags. I'd expect the subject:
[PATCH v2] drm: bridge: cdns-mhdp8546: Fix PM reference leak in
cdns_mhdp_probe()

Can you please resubmit using this title, just to be sure I merge the
right version of this code.

On Sat, 29 May 2021 at 11:46, Yu Kuai <yukuai3@huawei.com> wrote:
>
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> changes in V2:
>  - change error message.
>
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 0cd8f40fb690..eab959a59214 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2478,9 +2478,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>         clk_prepare_enable(clk);
>
>         pm_runtime_enable(dev);
> -       ret = pm_runtime_get_sync(dev);
> +       ret = pm_runtime_resume_and_get(dev);
>         if (ret < 0) {
> -               dev_err(dev, "pm_runtime_get_sync failed\n");
> +               dev_err(dev, "pm_runtime_resume_and_get failed\n");
>                 pm_runtime_disable(dev);
>                 goto clk_disable;
>         }
> --
> 2.25.4
>
