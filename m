Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B213A3F8C88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbhHZQ4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhHZQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:56:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132EC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:56:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id c79so5448514oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZG20ra+VbWP4KmRr9Qhru/j/9SFXgkuvtYD4gkTXGMY=;
        b=krelO2npuKNDSGGHREDE9VKuLT4tvL0Olu1s5Vz4ljL6nOXNEyiVKKN4SQDB2u7yFg
         S5VNc+q2nNXgK0qoiyzXytDBHLLmDVM1zKhtS5SugdgQfeKkVXy8PEKNquS3FuA9+f6x
         0Dvhn2qWHpy4jMPjx70LkrHdwb4XEB+2aNG2n1SMTnztc8fi5O+jrXYEvXs/q8YdcA3x
         x4w2jvi35kfTcDg6T5raPvVDRJXzcpZrYGhInp/itKs7S2FLsEcP4isIqooEBl49wyvp
         eegRqDOETeLcXlW7u/oXEoB8NdCy/bR9GxNh4bN+DZduQIqpTBOi1EhOouWGPCHbN2SV
         akVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZG20ra+VbWP4KmRr9Qhru/j/9SFXgkuvtYD4gkTXGMY=;
        b=h818DjaroDw8CbiDi7inWwqGosYJZ6pUaILoY202fo0Y8MlBSUI47YvUA/RRY6OXGp
         IhnrBtyEHJ1fMovNRpPT1XiJGmG/2iAhthar7w6sOc8M0sLJZJ9tkJF4+Irw+VUoMsnA
         laXRdCTe+rfLiPxE4PoEtZVJAJ8iK6S3cAYTZapaL9mArhvUwuvcAOVEemCL3IC8DPH7
         JQPvjRCfk9CBOF/bVf/OW263HsVmBXv9F7Fj1z5xWTstQ9ulLf8ym2rFYdqQ/bsH0UwJ
         Aq7hrtB7Wn+W8msKZpHE8eunJJ9eFoxxXfYu/tLLotq20i5BA98t50Il5ZV37rFm7fGW
         pXSA==
X-Gm-Message-State: AOAM531izDSNaK2pNS+MFCXlXbRijp+3uJl+FE6goXP7sd9XoTE9FL9U
        nDLQ9Pr6CqsvPccaeY1LTCc/Nw==
X-Google-Smtp-Source: ABdhPJxEWy8u8+m2iuBlorhcI8KlAntRXpX4G8jaArnzHtbOyhkhOzakheY5KqVZZC4nkalRMOLTgA==
X-Received: by 2002:aca:3111:: with SMTP id x17mr3274611oix.20.1629996964281;
        Thu, 26 Aug 2021 09:56:04 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m206sm732007oif.23.2021.08.26.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:56:03 -0700 (PDT)
Date:   Thu, 26 Aug 2021 09:57:18 -0700
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
Subject: Re: [PATCH v2 3/5] drm/msm/dp: Support up to 3 DP controllers
Message-ID: <YSfH7j+24OMa3rVE@ripper>
References: <20210825234233.1721068-1-bjorn.andersson@linaro.org>
 <20210825234233.1721068-4-bjorn.andersson@linaro.org>
 <CAE-0n50JXw6KL-u70csWS-9F6YhZy0pNah91h4e9a_9MnjJzmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50JXw6KL-u70csWS-9F6YhZy0pNah91h4e9a_9MnjJzmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Aug 00:13 PDT 2021, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2021-08-25 16:42:31)
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
[..]
> > @@ -203,8 +204,8 @@ static int dpu_kms_debugfs_init(struct msm_kms *kms, struct drm_minor *minor)
> >         dpu_debugfs_vbif_init(dpu_kms, entry);
> >         dpu_debugfs_core_irq_init(dpu_kms, entry);
> >
> > -       if (priv->dp)
> > -               msm_dp_debugfs_init(priv->dp, minor);
> > +       for (i = 0; i < ARRAY_SIZE(priv->dp); i++)
> > +               msm_dp_debugfs_init(priv->dp[i], minor);
> 
> Does this need the same if (!priv->dp) continue check like the other
> loops over priv->dp?
> 
[..]
> > @@ -800,7 +809,8 @@ static int dpu_irq_postinstall(struct msm_kms *kms)
> >         if (!priv)
> >                 return -EINVAL;
> >
> > -       msm_dp_irq_postinstall(priv->dp);
> > +       for (i = 0; i < ARRAY_SIZE(priv->dp); i++)
> > +               msm_dp_irq_postinstall(priv->dp[i]);
> 
> This one too? Or maybe those gained NULL pointer checks.
> 

This already has a NULL check, that's why I added one to the adjacent
msm_dp_debugfs_init() as well.

> >
> >         return 0;
> >  }
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
[..]
> > @@ -1194,6 +1230,10 @@ static int dp_display_probe(struct platform_device *pdev)
> >         if (!dp)
> >                 return -ENOMEM;
> >
> > +       dp->id = dp_display_get_id(pdev);
> 
> Ah ok, it's signed for this error check. Maybe assign dp->id in the
> function and return 0 instead of assigning it here?
> dp_display_assign_id()
> 

I like the fact that the "getter" doesn't have side effects, but making
dp->id unsigned makes sense. So let's pay the price of a local signed
variable here.

> > +       if (dp->id < 0)
> > +               return -EINVAL;
> > +

Thanks for the feedback,
Bjorn
