Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3194235AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhJFCIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhJFCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:08:40 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB71C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 19:06:48 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so1254851ota.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ygdBg5v9z3rYt7f+SorUymeJHWYZ7XFFOY+CoI2r094=;
        b=X09yiDZu+NmXs/J7sxBhVVL9C5JgVknbW03r3SYOiMMOqPjouDXMSUdikcP9e4uwLN
         r/9VcdLxpenpEUV92v77aXVheImMPidhD2ENfRRTGcOmaB6LnOnzHlpQDTgsrZqkO3Xo
         9RJ/l3qdPDeXRUmQU0cXbSvWS6c9k0/jG+W30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ygdBg5v9z3rYt7f+SorUymeJHWYZ7XFFOY+CoI2r094=;
        b=W7CqWKIWvjvmTDauidk9JWfXOkFT5YgDWaM10ZpCr+pF23Mq9k+UVT3Q09Y78TuTgF
         1x82wimHoqTzCJQGJ1IoKX6mxza3zQRdt2R6SS3rT4OKl5W4R9ZoDl+yogJEKZkDmquB
         r3R6oBJXA+895DziPmW8UpSOobFAjpbg9slIJlfWpvAqz5i1t8eSj1xDFm4xJk/mGWiP
         qo1scWyrk1adywXH5z/Ua+7bGERyHrx46jrW5JvcXwr4GHQkBqxmbMgPGnJhoANewoKh
         bT9+sE1Hip5+uBAZgT1wbazl9xQVbZzNytNPUJeXnPCAHnTGoE7I+S1KKjs1MyKXBAU4
         3qsw==
X-Gm-Message-State: AOAM531Zz3/nO+gZ6wDNhAckdXE8x/S2/omwEqVs5O7w635DWHQbny+i
        a6XsXcBkpSl7Fnd02P1aPI3vJTgJE34iW8MAMSx2Ag==
X-Google-Smtp-Source: ABdhPJyfhXFHaIkT2rOzAObeZHtTUmgesKHEKfTgHB7ru8P3HDY5a3hsvNI5fYpbpt4+TCl8psKbUVF3dsxhMWFFFOQ=
X-Received: by 2002:a9d:1f4:: with SMTP id e107mr17054559ote.77.1633486008240;
 Tue, 05 Oct 2021 19:06:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 19:06:47 -0700
MIME-Version: 1.0
In-Reply-To: <YVz/NOL3AFn2zBA0@ripper>
References: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
 <20211005231323.2663520-6-bjorn.andersson@linaro.org> <CAE-0n52gOCC8bUfMFnNHRKFoq2=q4Ho8a-UYH5JKgumguhUD2A@mail.gmail.com>
 <YVz/NOL3AFn2zBA0@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 19:06:47 -0700
Message-ID: <CAE-0n513cs282Dh_YFMHK2uKCVFSWxtNyfRaFwWGyUvpfShixw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drm/msm/dp: Support up to 3 DP controllers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-05 18:43:16)
> On Tue 05 Oct 17:43 PDT 2021, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2021-10-05 16:13:21)
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index bdaf227f05dc..674cddfee5b0 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -1233,7 +1239,7 @@ static int dp_display_probe(struct platform_device *pdev)
> > >         if (!dp)
> > >                 return -ENOMEM;
> > >
> > > -       desc = dp_display_get_desc(pdev);
> > > +       desc = dp_display_get_desc(pdev, &dp->id);
> >
> > I'm sad that dp->id has to match the number in the SoC specific
> > dpu_intf_cfg array in drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > still. Is there any way we can avoid that? Also, notice how those arrays
> > already have INTF_DP macros, which makes me think that it may be better
> > to connect this to those arrays instead of making an msm_dp_desc
> > structure and then make sure the 'type' member matches a connector
> > type number. Otherwise this code is super fragile.
> >
>
> I'm afraid I don't understand what you're proposing. Or which part you
> consider fragile, the indices of the INTF_DP instances aren't going to
> move around...
>
> I have N instances of the DP driver that I need to match to N entries
> from the platform specific intf array, I need some stable reference
> between them. When I started this journey I figured I could rely on the
> of_graph between the DPU and the interface controllers, but the values
> used there today are just bogus, so that was a no go.
>
> We can use whatever, as long as _dpu_kms_initialize_displayport() can
> come up with an identifier to put in h_tile_instance[0] so that
> dpu_encoder_setup_display() can find the relevant INTF.
>

To make it more concrete we can look at sc7180

static const struct dpu_intf_cfg sc7180_intf[] = {
        INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24,
INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
                                                     ^
                                                     |

intf0 is irrelevant. Also the address is irrelevant. But here we have a
zero, the number after INTF_DP, and that is very relevant. That number
needs to match the dp->id. Somewhere we have a match between
controller_id and dp->id in the code.
