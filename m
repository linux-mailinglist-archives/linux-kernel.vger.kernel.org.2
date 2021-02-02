Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A560D30C57D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhBBQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbhBBQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C03C0611BC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:19:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c2so23530519edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMlokKzdK8V+Gvn42ll3ctucK3HqZBs6Jki/pOm978k=;
        b=CJkHp49YHJzedJgJ8H0hrsZdj+gxcN3BAsvOFGka+ihZA4DTtNVEF5t6RKE0TjxW2v
         3VMpxwUMuwbNi+sSTVjV8U9TbMQR0g84EXXXwMnBwLizunO/vn7NmdkDEm3nB97gJTge
         CmQx3qInSpzwbtaBji+YfXyAplBiO9PFpqcoQ0ydL6y+RMvM1c0F3g9IW/lFuwUbT5i2
         qsaxe9NAtjm1ocM5j13weD5kinZM7PA6gEygB1wxycnQH2CQLBM2UcnuYsGyVzyaSeIq
         biGF22X3wYmB4rJilAkhYYsEww8QJ/4taedDev41OVAc/XEl2Hmuu3ClRaJTCidCqhBc
         rsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMlokKzdK8V+Gvn42ll3ctucK3HqZBs6Jki/pOm978k=;
        b=P4oAkMdYFbRqhcPiErvJJWaMC/vXyVbiEhFDWgbsIrZ4ZYiFQ/mFvSuvHxsxRtUFOD
         gr2HU3+0R/JD6hrXPS4d34/xjJ5xa8olLchvBXqZTxP4rBZie4hLkvRM7FXTKBujZ28f
         z5aFIimBZV56NurgwkSrVWGBoUNURZbncG3Qc5fRpAJV7l6e8ShS1RbTHP6obyEk6XLx
         NYCJ/wo3WxPZGYhvt2t31W6aJemmpXV297XoYPmFrNDXzIQGU02Z8t3Krrs5Bj1HTWFz
         S1VbswPnFhC0ilaCmUrjr7iQjJaJ9zwpDIierMzRqyG6o7SkLchpWOFMfdsPgPTd5Uck
         imAg==
X-Gm-Message-State: AOAM530pOy+iCnyq5hiNuLlX8vwCtjwYGoLaAao+iVQ7aiORThPHEUY8
        birP7Us7mu5bQNPNQTTvveIvKniCXFxQrnrK20Zs8Q==
X-Google-Smtp-Source: ABdhPJwCqe/XoviTy7D5nVnoFrHySYWSUZsc5T9i8NY4Drep3y9EoWok5QgcVbshVpZUffyKN2kscyfdEMC4Lz+Xmes=
X-Received: by 2002:a05:6402:202a:: with SMTP id ay10mr3681976edb.93.1612282766286;
 Tue, 02 Feb 2021 08:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20210202123214.15787-1-bernard@vivo.com>
In-Reply-To: <20210202123214.15787-1-bernard@vivo.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 2 Feb 2021 08:19:14 -0800
Message-ID: <CABXOdTePOqMtZ88oTNDc0TT7oH652nLHApuXkbB-44jG5Z8PAg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove unneeded variable: "rc"
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 4:32 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> remove unneeded variable: "rc".
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index d1780bcac8cc..9cc816663668 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -409,7 +409,6 @@ int dp_panel_timing_cfg(struct dp_panel *dp_panel)
>
>  int dp_panel_init_panel_info(struct dp_panel *dp_panel)
>  {
> -       int rc = 0;
>         struct drm_display_mode *drm_mode;
>
>         drm_mode = &dp_panel->dp_mode.drm_mode;
> @@ -436,7 +435,7 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel)
>                                         min_t(u32, dp_panel->dp_mode.bpp, 30));
>         DRM_DEBUG_DP("updated bpp = %d\n", dp_panel->dp_mode.bpp);
>
> -       return rc;
> +       return 0;
>  }
>
>  struct dp_panel *dp_panel_get(struct dp_panel_in *in)
> --
> 2.29.0
>
