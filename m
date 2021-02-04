Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87E30F329
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhBDM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhBDM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:29:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E387C0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:28:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u15so1699602plf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwJuigtXZN4H8LH97KvEX01KgdYdPsaGxRjAB9+CZ0M=;
        b=M4lnzGnLIjoB1QblxKZYrcWYHjCnlO9Z7EYFDR4Tf2CFAfzm5GCBN2XnvmtVjgbHiD
         MseYcE57KxwQaLzEBywDZGyUAmV/BeSnxb8FKJVzqemnzpkva4RKGHfKzmdUSi0bilja
         DsGLJh6BkSwNUoyjP8CJUuOJMlhZ4RybBLHGA+RGNWi+DhGAfftGgU+4Xj2VSGHiZ0px
         ChRLpy3M1abwbjEbbbQYDVu7ah31n/YzW2uGaFwpoa6LmZ0HIPrD+NpB58ym+PVGUNkG
         dBsxFFiHl4JMhCgqFzeQ4PZvhUz3+BsPg03vf7+OBK7Aodyt/8pqpkbqEXUsQWTMc5Ay
         t8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwJuigtXZN4H8LH97KvEX01KgdYdPsaGxRjAB9+CZ0M=;
        b=OH67QYwF/LJ9klll3iAmmIAutyxiYchice3FHGjb3mihBGX/iHAt3dg8oW315ngnDs
         JVsVjIUcx5Lj2PMyHkdm4WSNIWPzM3+QhF3ManzbjZrfMWRT4xRCRRQIaX3oiYa/0Tjh
         h4e8AXCxhH+HQoQUyivyYBvhZ26UtvqKxZHvY7L7fZ3tvotYihQLDX4HhBbmE4qajURz
         Le9bnaNYdt+fUxIsILUODWubwnKxGlJ2b4+t4L8CJBcdDSHYFSJJGXKHptkbjUr4Ytj9
         bh0+LkQGEtHxo27fbAGyQIkilrZypV1QxZuBIvhi8+nJ37+TMxqTYYxa44r+oIEW7q/0
         TM6g==
X-Gm-Message-State: AOAM533asMcRImWAl0q+ZvDILWmocik5E9eqVeXJNWnquFmYKAXWerwC
        t9zKpszEWsI6Jg3RdO+W78HMinDxYho37N6Q3APHdQ==
X-Google-Smtp-Source: ABdhPJyfBP7u1ZXbobDvu7HK4oR+5/fraMGa2jIKVYVtLc/FPEFhdNdXoTwpgFhddT6Hj6tnFHkEKhbtjNOtDsg/HF0=
X-Received: by 2002:a17:90a:4ecb:: with SMTP id v11mr8453346pjl.75.1612441720976;
 Thu, 04 Feb 2021 04:28:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611802321.git.xji@analogixsemi.com> <23b62a447364a9047f0b1b144557e8d95f6ad7f7.1611802321.git.xji@analogixsemi.com>
In-Reply-To: <23b62a447364a9047f0b1b144557e8d95f6ad7f7.1611802321.git.xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 4 Feb 2021 13:28:30 +0100
Message-ID: <CAG3jFyuAixFQ0L_2zw_8Ze3cF11PFMm-sN6ZQR7=opEjWV1nNw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/bridge: anx7625: fix not correct return value
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Thu, 28 Jan 2021 at 04:12, Xin Ji <xji@analogixsemi.com> wrote:
>
> At some time, the original code may return non zero value, force return 0
> if operation finished

Missing "." at end of line.

Other than that, this patch looks fine. Feel free to add my r-b.
Reviewed-by: Robert Foss <robert.foss@linaro.org>

>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 65cc059..04536cc 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -189,10 +189,10 @@ static int wait_aux_op_finish(struct anx7625_data *ctx)
>                                AP_AUX_CTRL_STATUS);
>         if (val < 0 || (val & 0x0F)) {
>                 DRM_DEV_ERROR(dev, "aux status %02x\n", val);
> -               val = -EIO;
> +               return -EIO;
>         }
>
> -       return val;
> +       return 0;
>  }
>
>  static int anx7625_video_mute_control(struct anx7625_data *ctx,
> --
> 2.7.4
>
