Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06794235DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhJFCiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJFCiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:38:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E854C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 19:36:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c6-20020a9d2786000000b005471981d559so1319846otb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PUaogci+E8slFPuLg1zPQavYoBTOPvmlLYC949h1bM0=;
        b=PAJh9/LcsjPtkeAw6onJj+36bNx8DyVWWoEJIW7ziACNt/3Fu/i5mETl+kPXIbahWn
         0SYP4PAYySi7Dy4guaJNvC+9MoXbdHYCgLZ+jRxYquNjgsATAcZn/zG6mFabTdkEqHUW
         xXuuMNN4mTKzw5MJ5/msb/mdzMdGnlZSGbLTD8BLNFXMAFJPkwLaw/30Y3HMGhBd7Ky6
         rm/cad+t0S1788RW0pOqbiDxdP1j66qtVGd3M5g4OqwnCWh3DeTkdVzoOIfYi6GztQ37
         u53MZW/vRp5RMXWDk+Wevxp0ejVPA5MmsnZL9zgiArf2eXvmDklF5FY4U2qHM0eN9Row
         Ce8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PUaogci+E8slFPuLg1zPQavYoBTOPvmlLYC949h1bM0=;
        b=2fW62ZjsSfSgg6897M0qD/XkwupI5VocVQ4OPLWDVmlxwjOlffXQTG39wbVhfeaGaa
         fZblSnvG9XvqTNzuzFFr7qLewanJkfQfrSjucdQ08ckYnoiNx1b6DHYeoZv16tsoOZId
         7DYZQ4j7XtS+V6WJO0dOj3PCzZeAfqlBsTnVZrSrPAn5B7Upy18Wjkjur5BgZp3h+Vwo
         SXnolMiqdNLoeNgtrTmsBJHWSL5oG9STzJ+Gv1h73GxLKZVDt4zBJfQiTVjrXRGERam6
         cD45QkC9mry3Rey8JET2BLspT1PDJTwG4uXg2DwL33BfZzSLw3Dlhu6GNsaGQ/1i/EUK
         7qng==
X-Gm-Message-State: AOAM530Y2fdNVK7fAMXNpHELgFIFAJqgFZF/LTeA23fJTo8LKBcvbPzv
        41sPT227OOn/749ofW4wW+Xr5g==
X-Google-Smtp-Source: ABdhPJz/3g8YzH7LGwCz6xc5q5nZbj/erIBrs1aNRt5JfpqM/U1faWXCUVW1Ki4QnkEz0zpj/9yHhA==
X-Received: by 2002:a9d:6c91:: with SMTP id c17mr17211234otr.114.1633487771714;
        Tue, 05 Oct 2021 19:36:11 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id m26sm3950642otf.12.2021.10.05.19.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 19:36:11 -0700 (PDT)
Date:   Tue, 5 Oct 2021 19:37:52 -0700
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
Message-ID: <YV0MAF/Y5BR1e6My@ripper>
References: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
 <20211005231323.2663520-6-bjorn.andersson@linaro.org>
 <CAE-0n52gOCC8bUfMFnNHRKFoq2=q4Ho8a-UYH5JKgumguhUD2A@mail.gmail.com>
 <YVz/NOL3AFn2zBA0@ripper>
 <CAE-0n513cs282Dh_YFMHK2uKCVFSWxtNyfRaFwWGyUvpfShixw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n513cs282Dh_YFMHK2uKCVFSWxtNyfRaFwWGyUvpfShixw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 19:06 PDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-10-05 18:43:16)
> > On Tue 05 Oct 17:43 PDT 2021, Stephen Boyd wrote:
> >
> > > Quoting Bjorn Andersson (2021-10-05 16:13:21)
> > > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > index bdaf227f05dc..674cddfee5b0 100644
> > > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > @@ -1233,7 +1239,7 @@ static int dp_display_probe(struct platform_device *pdev)
> > > >         if (!dp)
> > > >                 return -ENOMEM;
> > > >
> > > > -       desc = dp_display_get_desc(pdev);
> > > > +       desc = dp_display_get_desc(pdev, &dp->id);
> > >
> > > I'm sad that dp->id has to match the number in the SoC specific
> > > dpu_intf_cfg array in drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > > still. Is there any way we can avoid that? Also, notice how those arrays
> > > already have INTF_DP macros, which makes me think that it may be better
> > > to connect this to those arrays instead of making an msm_dp_desc
> > > structure and then make sure the 'type' member matches a connector
> > > type number. Otherwise this code is super fragile.
> > >
> >
> > I'm afraid I don't understand what you're proposing. Or which part you
> > consider fragile, the indices of the INTF_DP instances aren't going to
> > move around...
> >
> > I have N instances of the DP driver that I need to match to N entries
> > from the platform specific intf array, I need some stable reference
> > between them. When I started this journey I figured I could rely on the
> > of_graph between the DPU and the interface controllers, but the values
> > used there today are just bogus, so that was a no go.
> >
> > We can use whatever, as long as _dpu_kms_initialize_displayport() can
> > come up with an identifier to put in h_tile_instance[0] so that
> > dpu_encoder_setup_display() can find the relevant INTF.
> >
> 
> To make it more concrete we can look at sc7180
> 
> static const struct dpu_intf_cfg sc7180_intf[] = {
>         INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24,
> INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>                                                      ^
>                                                      |
> 
> intf0 is irrelevant. Also the address is irrelevant. But here we have a
> zero, the number after INTF_DP, and that is very relevant. That number
> needs to match the dp->id. Somewhere we have a match between
> controller_id and dp->id in the code.

That number (the 0, not INTF_0) is what the code matches against dp->id
in _dpu_kms_initialize_displayport(), in order to figure out that this
is INTF_0 in dpu_encoder_setup_display().

I.e. look at the sc8180x patch:

INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
/* INTF_3 is for MST, wired to INTF_DP 0 and 1, use dummy index until this is supported */
INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 999, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
INTF_BLK("intf_4", INTF_4, 0x6C000, INTF_DP, 1, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
INTF_BLK("intf_5", INTF_5, 0x6C800, INTF_DP, 2, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 22, 23),

Where the DP driver defines the 3 controllers with dp->id of 0, 1 and 2,
which the DPU code will match against to INTF_0, INTF_4 and INTF_5.

Regards,
Bjorn
