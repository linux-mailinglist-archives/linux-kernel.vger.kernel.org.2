Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E7A423CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhJFLhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhJFLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:37:33 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA63C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 04:35:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b16so2163949qtt.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpd3jdV9Ywj/INu9icrCWOgQz9TG3sjirde2+WE+zhE=;
        b=c2roWpVqwdpcWn5AE39gKv+0/Khwap6UoAuiy6NfaZqDgedxpN0PxAYAOIlKEC2qPb
         e1qtB3E81QftOs72xrT9ZI1xs8QdGRTjFuH+qPJkREeWEoxQyVdBVP1xPxIFK7YKdFi6
         Jj0sDdVxsel1OEMJgdLexgaLE0TNgB2PEgBLr0E9A3GBRp1tHwXGGJrBuo1JIf5oRDrL
         hTBSqNkZJu6bRwkcUqCSJK1n4bT8wALGaqXiYZ/p0sXOv5WSrAsR9AuO2cMKu7QAA9V4
         kelQ+6nb4REu5RZoYwqOsjDZk/85XAtB00X1u8DRr0e0EJMV0vLgz+Z+8/YHSMCJC8yA
         gpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpd3jdV9Ywj/INu9icrCWOgQz9TG3sjirde2+WE+zhE=;
        b=bWZ0thwNsr9qWKe5p3kynDQhr7T60n17kf6IRvcuBaUFA80lcgciLj297uKzqFbABy
         cQ2ih73J468w2nESWjZFxXX0NEJ9yvTSj/cToP1XX2Rcf1lnHh1xT/xA5wFLfQ6ycjZB
         JE8D9+694FQ73Ki70z5S64ENC4TdqsQ6fzC/I41fuz1xsxxVynffZTtohb9qFeOM5ECe
         aPsBBZkrzrzrxsSe9VCoC4xB5jYzSKXUUih3VcXScj6+alkhjM7C5meL4yHAE9lMb5eL
         OZbzMStVwtd6RXPe8S+WSAupfUNOOx4OXZRz8iZ5iC3Sz3Tfbfbd4Wwhl9i4e8ISSXh+
         U+hw==
X-Gm-Message-State: AOAM531JUSXwVjCtNVVvOxdcFG3bEE5dHKJQcuQVN9t9+37OHKv6gmc4
        3LH8pQjSGXiqPpDcIWREyisS9Hqyw+2rmrhHLWyHkmKncSY=
X-Google-Smtp-Source: ABdhPJzzR+2kfHwR2KjITqsCZh6KhF8o32hjDia0N3xy4u0rg5EetS6fvFTVg52fKqVP8G1DEZ8Ek/X1FfNPRmWOelM=
X-Received: by 2002:ac8:1011:: with SMTP id z17mr26242757qti.388.1633520139911;
 Wed, 06 Oct 2021 04:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
 <20211005231323.2663520-6-bjorn.andersson@linaro.org> <CAE-0n52gOCC8bUfMFnNHRKFoq2=q4Ho8a-UYH5JKgumguhUD2A@mail.gmail.com>
 <YVz/NOL3AFn2zBA0@ripper> <CAE-0n513cs282Dh_YFMHK2uKCVFSWxtNyfRaFwWGyUvpfShixw@mail.gmail.com>
 <YV0MAF/Y5BR1e6My@ripper> <CAE-0n53TwEyycpAaWVpRUKPpos4z-gqwrvyUdgobh1V88VUsXg@mail.gmail.com>
 <CAA8EJpou8ssBD2VGqfKKg43Gu031X-Bm+eirS_AL3Dr2AcdOJg@mail.gmail.com> <CAE-0n51S+DRXfJPWY93DS+4MMqVadfuP0bg0dJMH10pDvtabBg@mail.gmail.com>
In-Reply-To: <CAE-0n51S+DRXfJPWY93DS+4MMqVadfuP0bg0dJMH10pDvtabBg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Oct 2021 14:35:28 +0300
Message-ID: <CAA8EJpqMOG8NASXkcimpNOnkSXfTqeYHuaKg1ApC0sFuwYzx=w@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drm/msm/dp: Support up to 3 DP controllers
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi,

On Wed, 6 Oct 2021 at 10:06, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Dmitry Baryshkov (2021-10-05 23:10:22)
> > On Wed, 6 Oct 2021 at 07:26, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Bjorn Andersson (2021-10-05 19:37:52)
> > > > On Tue 05 Oct 19:06 PDT 2021, Stephen Boyd wrote:
> > > >
> > > > > Quoting Bjorn Andersson (2021-10-05 18:43:16)
> > > > > > On Tue 05 Oct 17:43 PDT 2021, Stephen Boyd wrote:
> > > > > >
> > > > > > > Quoting Bjorn Andersson (2021-10-05 16:13:21)
> > > > > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > > index bdaf227f05dc..674cddfee5b0 100644
> > > > > > > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > > @@ -1233,7 +1239,7 @@ static int dp_display_probe(struct platform_device *pdev)
> > > > > > > >         if (!dp)
> > > > > > > >                 return -ENOMEM;
> > > > > > > >
> > > > > > > > -       desc = dp_display_get_desc(pdev);
> > > > > > > > +       desc = dp_display_get_desc(pdev, &dp->id);
> > > > > > >
> > > > > > > I'm sad that dp->id has to match the number in the SoC specific
> > > > > > > dpu_intf_cfg array in drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > > > > > > still. Is there any way we can avoid that? Also, notice how those arrays
> > > > > > > already have INTF_DP macros, which makes me think that it may be better
> > > > > > > to connect this to those arrays instead of making an msm_dp_desc
> > > > > > > structure and then make sure the 'type' member matches a connector
> > > > > > > type number. Otherwise this code is super fragile.
> > > > > > >
> > > > > >
> > > > > > I'm afraid I don't understand what you're proposing. Or which part you
> > > > > > consider fragile, the indices of the INTF_DP instances aren't going to
> > > > > > move around...
> > > > > >
> > > > > > I have N instances of the DP driver that I need to match to N entries
> > > > > > from the platform specific intf array, I need some stable reference
> > > > > > between them. When I started this journey I figured I could rely on the
> > > > > > of_graph between the DPU and the interface controllers, but the values
> > > > > > used there today are just bogus, so that was a no go.
> > > > > >
> > > > > > We can use whatever, as long as _dpu_kms_initialize_displayport() can
> > > > > > come up with an identifier to put in h_tile_instance[0] so that
> > > > > > dpu_encoder_setup_display() can find the relevant INTF.
> > > > > >
> > > > >
> > > > > To make it more concrete we can look at sc7180
> > > > >
> > > > > static const struct dpu_intf_cfg sc7180_intf[] = {
> > > > >         INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24,
> > > > > INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> > > > >                                                      ^
> > > > >                                                      |
> > > > >
> > > > > intf0 is irrelevant. Also the address is irrelevant. But here we have a
> > > > > zero, the number after INTF_DP, and that is very relevant. That number
> > > > > needs to match the dp->id. Somewhere we have a match between
> > > > > controller_id and dp->id in the code.
> > > >
> > > > That number (the 0, not INTF_0) is what the code matches against dp->id
> > > > in _dpu_kms_initialize_displayport(), in order to figure out that this
> > > > is INTF_0 in dpu_encoder_setup_display().
> > > >
> > > > I.e. look at the sc8180x patch:
> > > >
> > > > INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> > > > INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> > > > INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
> > > > /* INTF_3 is for MST, wired to INTF_DP 0 and 1, use dummy index until this is supported */
> > > > INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 999, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
> > > > INTF_BLK("intf_4", INTF_4, 0x6C000, INTF_DP, 1, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
> > > > INTF_BLK("intf_5", INTF_5, 0x6C800, INTF_DP, 2, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
> > > >
> > > > Where the DP driver defines the 3 controllers with dp->id of 0, 1 and 2,
> > > > which the DPU code will match against to INTF_0, INTF_4 and INTF_5.
> > > >
> > >
> > > Yep. I'm saying that having to make that number in this intf array match
> > > the order of the register mapping descriptor array is fragile. Why can't
> > > we indicate the interface is DP or eDP with INTF_DP or INTF_EDP and then
> > > map from the descriptor array to this intf array somehow so that the
> > > order of the descriptor array doesn't matter? Then we don't have to put
> > > the connector type in the descriptor array, and we don't have to keep
> > > the order of the array a certain way to match this intf descriptor.
> >
> > The order of the descriptor array does not matter currently (or we do
> > not understand fully your concern).
> > The encoder is mapped to intf using type + controller_id (next field
> > after INTF_foo).
> > Also having the controller_id in the descs array allows us to simplify
> > DSI code (where DSI_0 is master and DSI_1 is slave, no matter which
> > INTF they are associated with).
>
> The order seems to matter for me. Otherwise I get various vblank
> timeouts and the eDP panel doesn't light up. I'm using the previous
> version of this patch series though so maybe something got fixed in the
> meantime. If I change the controller_id to match my new ordering of the
> descriptor array then it works again. So somehow controller_id needs to
> match dp->id?

Yes, controller_id should match. However the order of entries in the
array should not matter. If it does, it's clearly an issue somewhere.

>
> >
> > Last, but not least, maybe I'd point you to one of the proposed
> > cleanup patches:
> > https://lore.kernel.org/linux-arm-msm/20210515225757.1989955-5-dmitry.baryshkov@linaro.org/
> > It removes one extra level of indirection in interface association.
> >
>
> Thanks for the link.



-- 
With best wishes
Dmitry
