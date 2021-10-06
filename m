Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E2423593
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 03:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhJFBn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 21:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhJFBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 21:43:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51276C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 18:41:36 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y201so1859718oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4niQb+ChjBKk3gz00vShq3HoyKfU91BwX3/Km/PIGIo=;
        b=WnuvGllbpNYhwmxw5wJH6R90ywQmFVY2TD2zedQYjjjnIYruSsy8DQKR8BcgO674j1
         2fmm8toCKD7wo9Y8NjXvNbaZdDR7OrfVwDpGqsLtHfDN6JTqzcbrn10pzWLyxs2KrrHO
         A2YCjoJZuBQUc/0gMnsmV9tL2Kwn2F3oZQFOCCXFuriew/5sHjaN2D8SxYw5/BYGwXB7
         +/cuveeMd6lxALO8uLYdYLB2SjZ1s1MH38mMl4iN6YZ/UxMiKU8aV/+eesFA1uQ0Dq55
         DgXyUuis2p8V3GeEXdQHlE94HuQx0oaGOOvWoEVIC9yC0TCozhyXSKm5PMVH6Vfp43uB
         ErbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4niQb+ChjBKk3gz00vShq3HoyKfU91BwX3/Km/PIGIo=;
        b=6I/kMPJ8FVBbD5nC6ahiDlGnjU364wR13/qXXaBCN+o4vw/vLynqWgg1HHg9pdJgj3
         mKe/O2eIcjaoCsFVYPNrPlR/P64L8NulTK94Y99GssTHA51K9HyD6Tx+a0w5P7J3vh6e
         JCz5vw3Vp6XRM0wRBh/BI6izDwZgEG8FKU9Wa1zqKKSAyZOTGOO+eqUV2DhbJVtG0/S6
         MqEojE95HkR77VwrXNuGxC3ZOIZ7Rzlh1tukwFvMXyEBPYqJArkKlSYHuaZkA5Wy8iR5
         jduh3EDI2uLCZ+OwzEBLj9H1thNUsGl1cEVq4OLBEBp2V5Jz3c9grJ+Ra/0S21CgVNYD
         Rh4A==
X-Gm-Message-State: AOAM5335uaXaqygNMK9G9OxLBe2NxqFsUznZwlEqRChoMDQoCxO4f8Eg
        xSqO+Wq214d3Z4RW0W9hUFc0fQ==
X-Google-Smtp-Source: ABdhPJzB1nVUbcAg2ygDJsbAKfNo2WaOcRBBsiURGSi9TrJdSvekqtP8kP81TeudTC/xznXfzoHzpA==
X-Received: by 2002:aca:f0c3:: with SMTP id o186mr5368496oih.37.1633484494852;
        Tue, 05 Oct 2021 18:41:34 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id a3sm3647321oie.3.2021.10.05.18.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:41:34 -0700 (PDT)
Date:   Tue, 5 Oct 2021 18:43:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] drm/msm/dp: Support up to 3 DP controllers
Message-ID: <YVz/NOL3AFn2zBA0@ripper>
References: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
 <20211005231323.2663520-6-bjorn.andersson@linaro.org>
 <CAE-0n52gOCC8bUfMFnNHRKFoq2=q4Ho8a-UYH5JKgumguhUD2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n52gOCC8bUfMFnNHRKFoq2=q4Ho8a-UYH5JKgumguhUD2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 17:43 PDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-10-05 16:13:21)
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index bdaf227f05dc..674cddfee5b0 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -79,6 +79,8 @@ struct dp_display_private {
> >         char *name;
> >         int irq;
> >
> > +       unsigned int id;
> > +
> >         /* state variables */
> >         bool core_initialized;
> >         bool hpd_irq_on;
> > @@ -229,7 +231,7 @@ static int dp_display_bind(struct device *dev, struct device *master,
> >
> >         dp->dp_display.drm_dev = drm;
> >         priv = drm->dev_private;
> > -       priv->dp = &(dp->dp_display);
> > +       priv->dp[dp->id] = &(dp->dp_display);
> 
> Can we drop the extra parenthesis?
> 

Definitely.

> >
> >         rc = dp->parser->parse(dp->parser, dp->dp_display.connector_type);
> >         if (rc) {
> > @@ -269,7 +271,7 @@ static void dp_display_unbind(struct device *dev, struct device *master,
> >
> >         dp_power_client_deinit(dp->power);
> >         dp_aux_unregister(dp->aux);
> > -       priv->dp = NULL;
> > +       priv->dp[dp->id] = NULL;
> >  }
> >
> >  static const struct component_ops dp_display_comp_ops = {
> > @@ -1233,7 +1239,7 @@ static int dp_display_probe(struct platform_device *pdev)
> >         if (!dp)
> >                 return -ENOMEM;
> >
> > -       desc = dp_display_get_desc(pdev);
> > +       desc = dp_display_get_desc(pdev, &dp->id);
> 
> I'm sad that dp->id has to match the number in the SoC specific
> dpu_intf_cfg array in drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> still. Is there any way we can avoid that? Also, notice how those arrays
> already have INTF_DP macros, which makes me think that it may be better
> to connect this to those arrays instead of making an msm_dp_desc
> structure and then make sure the 'type' member matches a connector
> type number. Otherwise this code is super fragile.
> 

I'm afraid I don't understand what you're proposing. Or which part you
consider fragile, the indices of the INTF_DP instances aren't going to
move around...

I have N instances of the DP driver that I need to match to N entries
from the platform specific intf array, I need some stable reference
between them. When I started this journey I figured I could rely on the
of_graph between the DPU and the interface controllers, but the values
used there today are just bogus, so that was a no go.

We can use whatever, as long as _dpu_kms_initialize_displayport() can
come up with an identifier to put in h_tile_instance[0] so that
dpu_encoder_setup_display() can find the relevant INTF.

Regards,
Bjorn

> >         if (!desc)
> >                 return -EINVAL;
> >
