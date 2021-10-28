Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF843E6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJ1RPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhJ1RPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:15:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE0CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:13:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so5282420pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihNITYXch0CmhgbMtbhS2pI0TvQrTLYx98YvdI9FUVc=;
        b=EdL6MUJNz7MbBAaLavfbV5N4ZZpnR6wLJt0KyNLegxJSKL6KajXtDynIFp45Q2x0UG
         OG7wxB6NS2WW4JEgkSrJ2EcVuUfTcq9TigvYBYjAkKb1BUF+Np2Ky0fTtgGI+2PmkFDU
         xAjW3XNBMzDFjFkARbe7bjIYLxn9lCXVqxWCMHQOVt71aFLKzefyfbR8PIj6s/2t9D0g
         Y8asy+pzOssVRM4F9w4Yz1gAdH8ZpAEajCsQRwSmSEVsICjwSwxzrBzvN8LHbOqDGErS
         180Vn8bdzYoqr8a4kYqX3d1UAcmMyhG4xmRZnf/mq9QM8WA74iKxPzFF1ZHaP0AlyX3i
         wXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihNITYXch0CmhgbMtbhS2pI0TvQrTLYx98YvdI9FUVc=;
        b=46fIcOmVm+I/1Y+581LknSlajo5vnwWOnzT/73AA8yh5+MS7E1gAdPJRFiafwtO/3d
         bDytw9Xk//XBnTBjnM9NqJ8qcXrXbRC2QgBTAeDRG4zLdyZydxwhE54YZqcOuUyq5XMh
         8iRqnLeLG0rHUDeehHaHO9R7HAE7FBTJnOs0deU3PNkdgnFZfRy4xZmo9PAiTrDEfUSY
         aQaEkY5fMoDgYCTMRlxaV/nR9XV7UkW+6vs0KhW/+Tmv7ptW/xyPHi2u6kxvb5w63lEX
         Ki9Hf4bXW1kd2KqW19q//jXQ2Kuip8e0TLhnnJhigihSr1RhJDZHza68iOn1l0mNvJIS
         XDcQ==
X-Gm-Message-State: AOAM530CSgNg5t1BS1Xy3nJAErBfThCk/i6c0KaOO+adQrso/Pag45EJ
        LQGSfB/oOHnXbBAwGuKFwILqkYopp6dQadKZz5VJPg==
X-Google-Smtp-Source: ABdhPJw7ESwHIqokQQbmXx3DD8/pVlD8WqXsPbO/N6d2om1KjN/f+z/UHGTkVyGGxJ96JNgTw6h3OSqxDlDj758uCl4=
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr5859313pjb.232.1635441189807;
 Thu, 28 Oct 2021 10:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211028163548.273736-1-bjorn.andersson@linaro.org>
In-Reply-To: <20211028163548.273736-1-bjorn.andersson@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 28 Oct 2021 19:12:58 +0200
Message-ID: <CAG3jFyuxsJ_bWppw=2K0dTxheqDdVuFwojka8VMZH_p9Fmo4FA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: sn65dsi86: ti_sn65dsi86_read_u16() __maybe_unused
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,

Thanks for fixing this quickly.

On Thu, 28 Oct 2021 at 18:33, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> When built without CONFIG_PWM there are no references to
> ti_sn65dsi86_read_u16(), avoid the W=1 build warning by marking the
> function as __maybe_unused.
>
> __maybe_unused is used insted of a #ifdef guard as it looks slighly
> cleaner and it avoids issues if in the future other permutations of the
> config options would use the function.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Robert, I believe you pushed out the driver patch introducing this issue
> yesterday. Can you please add the relevant Fixes?

Added fixes & r-b tags.

Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next

>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 430067a3071c..e1f43b73155b 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -215,8 +215,8 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
>         .cache_type = REGCACHE_NONE,
>  };
>
> -static int ti_sn65dsi86_read_u16(struct ti_sn65dsi86 *pdata,
> -                                unsigned int reg, u16 *val)
> +static int __maybe_unused ti_sn65dsi86_read_u16(struct ti_sn65dsi86 *pdata,
> +                                               unsigned int reg, u16 *val)
>  {
>         u8 buf[2];
>         int ret;
> --
> 2.33.1
>
