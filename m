Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D042411E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhJFPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhJFPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:20:14 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58953C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:18:22 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so3212843ilb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vB299wseJn7aDst1Re2iB3jLFV+Je9gQHlrVHJWsvY=;
        b=RuHdKdXakP9BYMunQazq4s9vUXz80/p+CG/6GlJdkiXGN+6jzaPW6OYXX1jsQjBmHI
         nXpbKp37ZZk3ZZpqSYqoYS+whF8s/ao65WRAmEVhc4nigEi8QA9nqOPSIpSIPpmAQCVs
         wc2nb9l55zl/mIifajzScqVAwjYAIOXJb6CLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vB299wseJn7aDst1Re2iB3jLFV+Je9gQHlrVHJWsvY=;
        b=TwkacHWYyvWeGWEulCX1jesjF/xwqSx8eaUZuMmaoDX5nU0HerIchWNX5VJQd7VOQ1
         gir6M3S4HcLKgiWGN+NLQLPdqZMLbQLPpaSoyJizpmvwIF3e/tNAoghQ1B57BX6Zs2qF
         cSRJZluf5M2G4ytP/QOyqi6CxDraib0P36sdDfYgVhnHvftIKzxyEKJ7K626qUGspM7G
         gPQgtxuq5YALZi79cRGxbEb1zP8BEhijRhowJI9J9yf3kFn1sdbQUXaJ0PKv0RSl7Lph
         01Sl7w/iZMOjQfJXbtA+XADF+qGnpRFMEghk+9cV7yL//mT1x7MXYqme5ExWCGDtl9VM
         8vaw==
X-Gm-Message-State: AOAM533P+Th18rWv0MY1Yppmb+9ipYgBHMJBNQR2dMAZ55KOlpX1Cx8S
        u+wCsAWUbs5gIvMM9L9EmPwq29K8F3+8bQ==
X-Google-Smtp-Source: ABdhPJwp1MEakG8MNqd+KR2OPYD/EnzTbjrd3nVLpJ/04gmwEmEm//2qsQ4uWje2jVSjppVsAC8lkw==
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr7694045ili.40.1633533501273;
        Wed, 06 Oct 2021 08:18:21 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id d25sm11570199iod.41.2021.10.06.08.18.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 08:18:21 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id t11so3198675ilf.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:18:21 -0700 (PDT)
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr7874486ilv.180.1633533164871;
 Wed, 06 Oct 2021 08:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210726231351.655302-1-bjorn.andersson@linaro.org>
 <CAD=FV=UGtHXD==Yy8CVCOioYGb=2hqGQOoNWftD1Jj7OiEp51g@mail.gmail.com>
 <YVd3YdfgFVc0Br5T@ripper> <CAD=FV=U=xVLuKOYHbGPTkLjGa8_U+F1ZtEvJt4LGaRuR5SsKFw@mail.gmail.com>
 <YVumL1lHLqtb/HKS@ripper> <CAD=FV=W9uKq00wXn4H1ax0u2D=R8Wn3J-Je43uxcPyDtk7AK7Q@mail.gmail.com>
 <YVyMwsvLl6XalJxB@ripper> <CAD=FV=WY+g38p7--QKZCaQnSqx7VvdwC36jH-VKnrEWoxK=XHQ@mail.gmail.com>
 <YV0KBWxVtKgOp2Cj@ripper>
In-Reply-To: <YV0KBWxVtKgOp2Cj@ripper>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Oct 2021 08:12:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X5JFE3u9BtxxocaUrYNSpYXJN90UJ8HOvXZE6oYiVsDQ@mail.gmail.com>
Message-ID: <CAD=FV=X5JFE3u9BtxxocaUrYNSpYXJN90UJ8HOvXZE6oYiVsDQ@mail.gmail.com>
Subject: Re: [RFC] drm/msm/dp: Allow attaching a drm_panel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vara Reddy <varar@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 5, 2021 at 7:27 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> > > For reference, this is how I thought one is supposed to tie the Type-C
> > > controller to the display driver:
> > > https://lore.kernel.org/all/20211005022451.2037405-1-bjorn.andersson@linaro.org/
> >
> > OK, so I looked at that a bit. Fair warning that I've never looked at
> > the type C code before today so anything I say could be totally wrong!
> > :-)
> >
> > ...but I _think_ you're abusing the "mux" API for this. I think a type
> > C port can have exactly 1 mux, right? Right now you are claiming to be
> > _the_ mux in the DP driver, but what about for other alt modes? If
> > those wanted to be notified about similar things it would be
> > impossible because you're already _the_ mux, right?
> >
>
> I actually don't think so, because I acquire the typec_mux handle by the
> means of:
>
> mux_desc.svid = USB_TYPEC_DP_SID;
> mux_desc.mode = USB_TYPEC_DP_MODE;
> alt_port->mux = fwnode_typec_mux_get(fwnode, &mux_desc);

Hrm, I guess I need to go find that code. Ah, I see it in your WIP
tree, but not posted anywhere. :-P The only code I can see calling
fwnode_typec_mux_get() is `drivers/platform/chrome/cros_ec_typec.c`.
In that code it passes NULL for the mux_desc and I'm nearly certain
that it just handles one "mux" per connector despite the fact that it
handles lots of different types of alternate modes. That doesn't mean
that the cros_ec implementation is correct / finalized, but it's a
reference point.


> And in the DisplayPort node I provide svid = /bits/ 16 <0xff01>;
>
> So I will be able to reference multiple different altmode
> implementors using this scheme.

OK, so I'm trying to grok this more. Let's see.

I'm looking at ucsi_glink_probe() and looking at the matching dts in
your WIP tree [1] in "sc8180x-lenovo-flex-5g.dts" OK, so:

1. It's looping once per _connector_ by looping with
`device_for_each_child_node(dev, fwnode)`.

2. For each connector, it has exactly one `alt_port` structure.

3. For each `alt_port` structure it has exactly one `mux`.

...so currently with your WIP tree there is one "mux" per type C connector.


Perhaps what you're saying, though, is that the UCSI code in your WIP
tree can/should be changed to support more than one mux per port. Then
I guess it would have logic figuring out what muxes to notify about
which things? ...and I guess that would mean that it's currently a bug
that the ucsi_altmode_enable_usb() notifies "the DP type C mux" about
USB changes?


> > I _think_ a mux is supposed to be something more like
> > `drivers/phy/rockchip/phy-rockchip-typec.c` (though that code predates
> > the type C framework we're looking at here). There the phy can do all
> > the work of remuxing things / flipping orientation / etc. I don't
> > think it's a requirement that every SoC be able to do this remuxing
> > itself but (if memory serves) rk3399 implemented it so we didn't have
> > to do it on the TCPC and could use a cheaper solution there.
> >
>
> I'm afraid I don't see how this interacts with a display controller.

This was actually kinda my point. ;-) Specifically I think
`phy-rockchip-typec.c` is the thing that's supposed to be a "mux". I
think your display controller isn't a mux. Yeah, it's handy that muxes
get told about DP HPD status, but that doesn't mean it's the right
abstraction for you to implement. In my mental model, it's the same as
implementing your "i2c" controller with a "pinctrl" driver. :-P


> It
> seems more like it's the phy side of things, what we have split between
> the Type-C controller and the QMP phy to set the pins in the right
> state.
>
> > In any case, my point is that I think there is supposed to be a
> > _single_ mux per port that handles reassigning pins and that's what
> > this API is for.
> >
>
> If that's the case things such as typec_mux_match() is just completely
> backwards.

Yeah, I have no explanation for typec_mux_match(). Let me see if I can
lure some type C folks into this discussion.


> > ...so I will still assert that the right thing to do is to have a
> > drm_bridge for the type c connector and _that's_ what should be
> > sending HPD.
> >
>
> That still implies that all the current typec_mux code got it all wrong
> and should be thrown out. If you instead consider that you have a Type-C
> controller that upon switching DisplayPort on/off calls typec_mux_set()
> to inform the functions that things has changed then all the current
> code makes sense.
>
> It also maps nicely to how the TypeC controller would call
> typec_switch_set() to inform, in our case the QMP phy that the
> orientation has switched.
>
>
> It seems reasonable to have some common helper code that registers the
> typec_mux and turn its notifications into HPD notifications to the
> display code, but I still think that should live in the DRM framework,
> separate from the USB code.

I think I'm going to step back and hope that the experts can chime in.


[1] https://github.com/andersson/kernel/commits/wip/sc8180x-next-20210819

-Doug
