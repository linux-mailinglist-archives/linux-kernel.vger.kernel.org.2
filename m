Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC0382846
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhEQJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhEQJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:29:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71709C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:27:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so4214513pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwRMoqcaR++/qsLAMyEgC+MY+iTWFtr0y91F+kn7q8k=;
        b=Z8swXdkk+dKfh+aLLxhLi8lWlp4mkbfMy/81Cjd4MDnE64ZghW9ZueJEk6L84nQFA6
         krBrRuJPLVECGL2IL+Pf+70BMzd2l9DshYECpaD+MbqUho81FRck40Nf9k9R2ifYg4Zc
         k4evgSLsNrwHG6f5yfnZu+YwptE5N7AGmXlBTk1135zokyikVgbHGlT6XbVOJK/5oyTZ
         FoCiPmAEIMuS9CMOZJg5CaNe8QYbxV8zkeAcbJLI+H+jXju78FuAwBGLhNYbRvmo2cnN
         Q3uNMB4x8bi45RqbF55ZR1ZcG9eETFmNpYRbrY41TsFGjDtY/NzK+GZhbi2MwfSABUwi
         CkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwRMoqcaR++/qsLAMyEgC+MY+iTWFtr0y91F+kn7q8k=;
        b=qMWs+ISfcbrILpL2tEWrOzauvsmFGzt2PfN6qhZ5TWy0XeXfk6OHNP4NlKRR6onHNV
         L1VLkC3srIQ8UIjWyLrFfYKdW6n3oF97Nls0f83izC2poflpEWuMiTTir+L6/4pkdmBI
         ZzwQrO92MMb+Gvl3CFLgfjnvfu1G/IuU2sZLftIptFJaZFfbBX16Z49ejq86iLbHbrnQ
         wf+CTWlCS1F6kXHNHo4PT7NzvV0BG094nahQ1HUc9j60EBWjk7zacN96PPMvph48S/8e
         4NUjgg2K7dDVtcKHG98EZAST9GLfSs6HfBn8/rE3SYroDKEIsIFzeMxKK2YY0c0NrnZs
         e+/g==
X-Gm-Message-State: AOAM533juN406KVPP28Pxd8a/pLIjJpP/l2u+jRSjlL7EQWvXECG7ado
        XTbLCDvNSUD59jAqXgJMh2fVtQ36mFqmafN2Bf4HZA==
X-Google-Smtp-Source: ABdhPJydTvFkg9dPdtjhuUxgGffLzT1pa4jhJl8umCT+4dwADgxZnkhU5/LAv8lw46BvzqEzkVDm+zHeE9Ii18tTSYg=
X-Received: by 2002:a17:902:4:b029:ee:8f40:ecbf with SMTP id
 4-20020a1709020004b02900ee8f40ecbfmr58725953pla.28.1621243669932; Mon, 17 May
 2021 02:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210517081601.1563193-1-yukuai3@huawei.com>
In-Reply-To: <20210517081601.1563193-1-yukuai3@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 17 May 2021 11:27:38 +0200
Message-ID: <CAG3jFyvjD+Gf5C+sWA8Qi9Hp-tJHeCjqbWX5Fds3m41nCLreyA@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix PM reference leak in cdns_mhdp_probe()
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

On Mon, 17 May 2021 at 10:08, Yu Kuai <yukuai3@huawei.com> wrote:
>
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 0cd8f40fb690..305489d48c16 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2478,7 +2478,7 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>         clk_prepare_enable(clk);
>
>         pm_runtime_enable(dev);
> -       ret = pm_runtime_get_sync(dev);
> +       ret = pm_runtime_resume_and_get(dev);
>         if (ret < 0) {
>                 dev_err(dev, "pm_runtime_get_sync failed\n");
>                 pm_runtime_disable(dev);

The code is correct as it is. If pm_runtime_get_sync() fails and
increments[1] the pm.usage_count variable, that isn't a problem since
pm_runtime_disable() disables pm, and resets pm.usage_count variable
to zero[2].

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/pm_runtime.h#L384
[2] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/runtime.c#L1383
