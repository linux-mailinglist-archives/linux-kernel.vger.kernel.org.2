Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1B38137E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhENWIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhENWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:08:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 15:07:32 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t7so725024qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbrQjxkb0K3z7ZkPDbwumBPr7QnDKgJDV9MYg72KtXI=;
        b=dx1Df5/yzY+AeZz/rdkuLnqLf65GYwH3dHIFCdSBqpHR3fWG5VtvM11+v8Pz0I424K
         /CTN93UfyjlVQMv7eSajh07I4QztMYX0OMg0CHIOA2eA2JA68b/3utBkLzotkWwEGMYo
         pnph5wO/Gl8XUyBVgaIP6DIgLVnP/tHjlk/sY1uNq1c5iAz2ltn/TpK+gz9uARdDWfNz
         KE0Nouw9d71fwOyDTx1rde2xAF4byNR1HtLY4UzwVp7KueySru6gKGgLUrpUX49QoMAW
         qLKZzxO74ljfE8ocXZcXcgy7UgDj2/GzwxBgMcm3+7UlIM8aqyxYD+tC5H2LRLvBx7cp
         eZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbrQjxkb0K3z7ZkPDbwumBPr7QnDKgJDV9MYg72KtXI=;
        b=gqBnF9t8vNUubhaB9A3OEC0KjnHDcHXOGv+5myXCdbrIdMkV0I3Qrf/eBjhEESKDXE
         RcvTtr7WRde6fNM/8VWgWVMhT46Q6ywCQDk4BgrsK1exOEEY9H1PbgGTPxRKmELYBuCI
         NDQOUZ9g3ttxMa+iZgIZMveoqDZEFHpa8CKSs2YnlwOfxSw6asOmj3vSsKa49rNe8/55
         l37Wqg6u6PwqSA09VYc248tVidlpniEe2aiwltakibxc0xe4O6MC5hg5JjchJtWLH6QB
         0qocByzcT8Y4P+oGDcOnycYqwnxSe1MN4jUZDe3dqVAZe2JszgIP/lTvX6eDeEIeVoya
         oScw==
X-Gm-Message-State: AOAM530g4CZRvfiHHOa+hTezdOwey7x4LOVumbcCsRfy1UBFt76U5UoT
        abb/kOWiUlQc8fWZmHq8LUf6UI8yjgbQa4401QC1aQ==
X-Google-Smtp-Source: ABdhPJxaEbRftY4lIHCyF5Rw8nvdMm5/lCdHTk5LXSje8/I/5yu/Xzt4icnH9N8EPP/ne043QHlIxNTO/PeJv6d+lKQ=
X-Received: by 2002:ac8:5810:: with SMTP id g16mr44371397qtg.135.1621030052188;
 Fri, 14 May 2021 15:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210514213032.575161-1-arnd@kernel.org>
In-Reply-To: <20210514213032.575161-1-arnd@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 15 May 2021 01:07:21 +0300
Message-ID: <CAA8EJpoo=VS1Nk-3CpyraDFzF+0xe3SWxkVt7M=8aBNhbdh_hQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: fix 32-bit clang warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2021 at 00:31, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang is a little overzealous with warning about a constant conversion
> in an untaken branch of a ternary expression:
>
> drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c:975:48: error: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 5000000000 to 705032704 [-Werror,-Wconstant-conversion]
>         .max_pll_rate = (5000000000ULL < ULONG_MAX) ? 5000000000UL : ULONG_MAX,
>                                                       ^~~~~~~~~~~~
>
> Rewrite this to use a preprocessor conditional instead to avoid the
> warning.
>
> Fixes: 076437c9e360 ("drm/msm/dsi: move min/max PLL rate to phy config")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> As found with another patch, using __builtin_choose_expr() would
> likely also work here, but doesn't seem any more readable.
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> index e76ce40a12ab..accd6b4eb7c2 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> @@ -972,7 +972,11 @@ const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs = {
>                 .restore_pll_state = dsi_7nm_pll_restore_state,
>         },
>         .min_pll_rate = 600000000UL,
> -       .max_pll_rate = (5000000000ULL < ULONG_MAX) ? 5000000000ULL : ULONG_MAX,
> +#ifdef CONFIG_64BIT
> +       .max_pll_rate = 5000000000UL,
> +#else
> +       .max_pll_rate = ULONG_MAX,
> +#endif
>         .io_start = { 0xae94400, 0xae96400 },
>         .num_dsi_phy = 2,
>         .quirks = DSI_PHY_7NM_QUIRK_V4_1,
> --
> 2.29.2
>


-- 
With best wishes
Dmitry
