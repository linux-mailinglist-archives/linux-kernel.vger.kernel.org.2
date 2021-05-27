Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F0392D54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhE0L66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbhE0L64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:58:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834C8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:57:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f22so434377pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPq95YaXgD7epSPKYKh+PoQmAS0WvOeGkyNJSqR4vfE=;
        b=KgyYbI+wURqp7RUOyfon0odf2iQgm31SpgiwoczSVanp4tgu73c7WJDOHskU9CcdUS
         DMzfIHAC4neEl6GQuBGiji5Kz2wkecqyju4VIMsuUV2cFisE+bon4p6mOcd/QUR4dbfo
         tgOEOfuKA7y6psw3rnw10H/N2r9yuhMjTgAlMfjOLymUrmEvJModSw7VIZiyqIpkWqIy
         6wNHGCcKS9u4wmWSOWW04NBlfEy0XgmkhL2ahTbgNpe7CNii78Y/jeSfM2UNVi+jp17/
         PHrFceUB+4dkuGKImZsySzJD6PsSxAWrCvSNf0fUbnb1QJi7ZlyVAxMbna3lhshwv03M
         3C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPq95YaXgD7epSPKYKh+PoQmAS0WvOeGkyNJSqR4vfE=;
        b=Ughl2bIYzyPdUoU9BIMcC3Wj6Fg95sXf94f1metubTCYEHBvy/S/0TPq5jrbwVErHR
         EMZWq9pd7eADwTjTnt//7UiEKRrWiveWsjw4GYQ1IBrRt7M0Um2OKYsRAbRNy+JINLvi
         hiJNzj0OwS5B+MontDWR1acP3q53GHaOa9/GdBQ9XO0pUTYbf9KYLZsQUbJqES1RSfbr
         1wGMY5bzQjONQSUTwdD5aZCTRLbiA51w1cYb+ST0GRGJev3GHDkhEPExbIZ9GSABVwhY
         ivv1F06IbB5nWtEU652qamKnWmS+eluS+7u916iHpj/m6aAHA/8qGT6lV2D1QXKg6aXV
         Ed3Q==
X-Gm-Message-State: AOAM531Kv28mO5+4q+/kTvZBDYxtf1kgZggbJnk6BcJeBHVhmJMmfsXQ
        ANQfzLLANc7VMFjYTiugptwMEgqc5AZ5GNYq1PnXwQ==
X-Google-Smtp-Source: ABdhPJzMyNEnE3+7dcs6H5EaOjZJ4P4h6vI0oiPf+gjXaxXWtAdjL3uOSdMDSKMqmFqXomxCf1n/LMSuTcP4XmZdSwI=
X-Received: by 2002:a62:a517:0:b029:2dc:9daf:5e91 with SMTP id
 v23-20020a62a5170000b02902dc9daf5e91mr3387708pfm.39.1622116643004; Thu, 27
 May 2021 04:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <1621840862-106024-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1621840862-106024-1-git-send-email-zou_wei@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 27 May 2021 13:57:12 +0200
Message-ID: <CAG3jFys93VO6WhqkntpNuFGCdKNedz3HLpJEJJa=jVPb+SU+uw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: cdns: Fix PM reference leak in cdns_dsi_transfer()
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed & pushed to drm-misc-next.

On Mon, 24 May 2021 at 09:02, Zou Wei <zou_wei@huawei.com> wrote:
>
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index 76373e3..b31281f 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -1028,7 +1028,7 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
>         struct mipi_dsi_packet packet;
>         int ret, i, tx_len, rx_len;
>
> -       ret = pm_runtime_get_sync(host->dev);
> +       ret = pm_runtime_resume_and_get(host->dev);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.6.2
>
