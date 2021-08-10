Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3083DB63D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbhG3Jpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhG3Jpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:45:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCFC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:45:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d3so4865525qvq.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpP6fJ5qS4z9U5Mk/yGz9pYoYzJS2iFy7VnajEmatcg=;
        b=jpGwQ3MOZMKdioaOV5hA5tHyKgYIO9urmn/aw0qWsrlXO7I81+PIfSCA+9NM5nvoZU
         oLwxxOscaPNPRKhu4KENjr2qgaGOkfU6NlyqsrRmHOLQFwS9YwUMh9taPwxh2uKfx/54
         wj+Wa+5TX8DtPzflkIN7xLjawS33skikaknuTVp2fI39yMm52dTX9BhrVOg9bdCVRnIc
         l/FSUm3vwzzuVvSqvXBqrloAW9PkuV7gZEVzSd7SAiLaPKBN7HD8RSwUbvItfPO9d2W9
         F/ClPcW279D2Q16uV6s+bwTuZ9bgYbTn1r6o0zIuKZxKjhsr2fiG319/Fp03gVy7vTsL
         e1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpP6fJ5qS4z9U5Mk/yGz9pYoYzJS2iFy7VnajEmatcg=;
        b=TgLxfjvcoHlqHqGmjj/y8a/7dOIGCFokDRrAHfLX3i7SyRQ932ppuNUCWpxkyLeaQo
         8PjIVK8XtxzzOyr4qMukDZWH+EE8fzdxn9QjMm/yqNYAeXUxQ1zITyMkvSZsu7elMvQS
         auy/kSa1p6452cZ2VrXwMJ+fDsJHGfJXNixRyDuzg3j6rpL0qrbFevranXmm+ZWS/68V
         OLSW5SbgWVVCHNVwj5Fja7T4muVDK5Zm30tqwYSjeh8YdyZ+itbGtsTEI3jqXevQxNbr
         2neMae7wUZJzbTfGAllqHW9SemWLa3Z4g4txc7tqovbSu12TmQ+bPgQhZSen6lPIywvu
         paTA==
X-Gm-Message-State: AOAM531SD+JI+GcCQYoVoJ3Ta6mnOeH7zewqGH3Jgmnlh7py0yyq8pMx
        h7Z+SeZ9+S8DT/PzLaGqjDLhCuseNICumvqx3nFRxw==
X-Google-Smtp-Source: ABdhPJw0YuA+LbmSP5phGohjXTllv6VPDLme3t9Ljod597Ufo8L1db10TQjQfGLo2cduBjgCa+Je8+K1qzv/6zpWAlo=
X-Received: by 2002:a05:6214:1882:: with SMTP id cx2mr1874675qvb.2.1627638332568;
 Fri, 30 Jul 2021 02:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210730061301.32492-1-zhaoxiao@uniontech.com>
In-Reply-To: <20210730061301.32492-1-zhaoxiao@uniontech.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 30 Jul 2021 12:45:21 +0300
Message-ID: <CAA8EJpq79QFUjAMQXgo-1XavN6ZQmw3SdKP3P5+p6ODhqFuJ1Q@mail.gmail.com>
Subject: Re: [PATCH] drm:This patch fixes the checkpatch.pl error to msm_drv.c
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 at 09:13, zhaoxiao <zhaoxiao@uniontech.com> wrote:
>
> ERROR: do not initialise statics to false
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

Could you please resend this patch following the style of the rest of
patches being submitted to this area? Subject, more detailed patch
description, etc.

> ---
>  drivers/gpu/drm/msm/msm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 9b8fa2ad0d84..d9ca4bc9620b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -59,7 +59,7 @@ static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
>  };
>
>  #ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
> -static bool reglog = false;
> +static bool reglog;
>  MODULE_PARM_DESC(reglog, "Enable register read/write logging");
>  module_param(reglog, bool, 0600);
>  #else
> @@ -76,7 +76,7 @@ static char *vram = "16m";
>  MODULE_PARM_DESC(vram, "Configure VRAM size (for devices without IOMMU/GPUMMU)");
>  module_param(vram, charp, 0);
>
> -bool dumpstate = false;
> +bool dumpstate;
>  MODULE_PARM_DESC(dumpstate, "Dump KMS state on errors");
>  module_param(dumpstate, bool, 0600);
>
> --
> 2.20.1
>
>
>


-- 
With best wishes
Dmitry
