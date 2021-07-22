Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AFC3D2D74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGVTdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGVTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:33:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD10C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:13:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so6427745otu.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qKsLbl4ftBxDVGL+8Xv3wy3RrHHwlm4ZdwpMuB2e6Zc=;
        b=cy6RGI0upWuDzcIDJDjrUbeixGYdyNHqcCew2PK2EHben9nudlwMPCXkjfSN2o79c3
         ZYmprGRdOn2pLrnxHwntcjZiK4dSTHQWBTPSC0vHgpu0EtmrIFBG2Tj/GPb7QQtAidJ+
         Ud1oETARJqm2UB9Q0wyijdKSyTZkyTI7sbu2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qKsLbl4ftBxDVGL+8Xv3wy3RrHHwlm4ZdwpMuB2e6Zc=;
        b=XOsxUpU31YFNQAvMExIlYwfUxxDGIKKDDNJiiWYbv3SZs53+0ES/WLrveO7U0xgfA/
         L6HIXheN9pAFbxUYb2h2X00k6MJITXq9h05ttiySNg1eNpg1bVfbif3ncLuNpROEc57M
         4U2CcGbmQgvL56PtlOP9xry6M2WK7lK+Hh5hIr/QT2bWuPS6kAyBtpt9uua3vttsQoci
         25w/DUZzUvQi1MAl3AXsfFev6U0afPRcnf+j9dSsHXVPOGeuITcTMB9XVPYfK//H5+z4
         wYBydpfH92kOnzDLAXOT905csbfwFtr0/91Nf3Ne5GqZIQVpdcXSQTQo6ZfbKwSj08IG
         S9NA==
X-Gm-Message-State: AOAM530/R7gwlWUc/bFAKMDg8ZE4gSSSeJnZ1xA4zIpg7h8Deko1JnZa
        Aep3ST8pZ3F6JlNv4j9WnP6Q0UZLuyVX+bm1OMahyA==
X-Google-Smtp-Source: ABdhPJwIl16lQ2mmX4iprXcdHpT0Zqsdlm8fGu+ct18LB1YcWieMT7VWuxhGrTSnANkJ6R8Bx+l5kozaI+tRboNiEPA=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr979364otl.233.1626984827240;
 Thu, 22 Jul 2021 13:13:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jul 2021 20:13:46 +0000
MIME-Version: 1.0
In-Reply-To: <20210722024227.3313096-5-bjorn.andersson@linaro.org>
References: <20210722024227.3313096-1-bjorn.andersson@linaro.org> <20210722024227.3313096-5-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 22 Jul 2021 20:13:46 +0000
Message-ID: <CAE-0n50Lbt0fnhRCnrcaZrM5+sn6giM9meJBEJOZdCS1z98Jzg@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/msm/dp: Store each subblock in the io region
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-21 19:42:26)
> Not all platforms has DP_P0 at offset 0x1000 from the beginning of the
> DP block. So dss_io_data into representing each of the sub-regions, to

"So dss_io_data into" doesn't make sense to me. Is some word or words
missing?

> make it possible in the next patch to specify each of the sub-regions
> individually.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 64 +++++++++--------------------
>  drivers/gpu/drm/msm/dp/dp_parser.c  | 30 ++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_parser.h  | 10 ++++-
>  3 files changed, 54 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
> index e68dacef547c..1a10901ae574 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -11,6 +11,15 @@
>  #include "dp_parser.h"
>  #include "dp_reg.h"
>
> +#define DP_DEFAULT_AHB_OFFSET  0x0000
> +#define DP_DEFAULT_AHB_SIZE    0x0200
> +#define DP_DEFAULT_AUX_OFFSET  0x0200
> +#define DP_DEFAULT_AUX_SIZE    0x0200
> +#define DP_DEFAULT_LINK_OFFSET 0x0400
> +#define DP_DEFAULT_LINK_SIZE   0x0C00
> +#define DP_DEFAULT_P0_OFFSET   0x1000
> +#define DP_DEFAULT_P0_SIZE     0x0400
> +
>  static const struct dp_regulator_cfg sdm845_dp_reg_cfg = {
>         .num = 2,
>         .regs = {
> @@ -48,12 +57,25 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
>         struct dp_io *io = &parser->io;
>         struct dss_io_data *dss = &io->dp_controller;
>
> -       dss->base = dp_ioremap(pdev, 0, &dss->len);
> -       if (IS_ERR(dss->base)) {
> -               DRM_ERROR("unable to remap dp io region: %pe\n", dss->base);
> -               return PTR_ERR(dss->base);
> +       dss->ahb = dp_ioremap(pdev, 0, &dss->ahb_len);

So many layers of gunky goo!

> +       if (IS_ERR(dss->ahb)) {
> +               DRM_ERROR("unable to remap ahb region: %pe\n", dss->ahb);
> +               return PTR_ERR(dss->ahb);
>         }
>
> +       if (dss->ahb_len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
> +               DRM_ERROR("legacy memory region not large enough\n");
> +               return -EINVAL;
> +       }
> +
> +       dss->ahb_len = DP_DEFAULT_AHB_SIZE;
> +       dss->aux = dss->ahb + DP_DEFAULT_AUX_OFFSET;
> +       dss->aux_len = DP_DEFAULT_AUX_SIZE;
> +       dss->link = dss->ahb + DP_DEFAULT_LINK_OFFSET;
> +       dss->link_len = DP_DEFAULT_LINK_SIZE;
> +       dss->p0 = dss->ahb + DP_DEFAULT_P0_OFFSET;
> +       dss->p0_len = DP_DEFAULT_P0_SIZE;
> +
>         io->phy = devm_phy_get(&pdev->dev, "dp");
>         if (IS_ERR(io->phy))
>                 return PTR_ERR(io->phy);
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
> index dc62e70b1640..3266b529c090 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.h
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.h
> @@ -26,8 +26,14 @@ enum dp_pm_type {
>  };
>
>  struct dss_io_data {
> -       size_t len;
> -       void __iomem *base;
> +       void __iomem *ahb;
> +       size_t ahb_len;

Maybe make another struct and have a few of them here

	struct dss_io_region {
		void __iomem *base;
		size_t len;
	};

then the code reads as aux.base and aux.len and we know they're closely
related.

> +       void __iomem *aux;
> +       size_t aux_len;
> +       void __iomem *link;
> +       size_t link_len;
> +       void __iomem *p0;
> +       size_t p0_len;
