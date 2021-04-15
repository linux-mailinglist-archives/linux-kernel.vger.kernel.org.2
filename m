Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10B5360C36
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhDOOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhDOOtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:49:13 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E63C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:48:50 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id p206so2695150vkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQFFIM7pSZ3rNVADx3v3MXfqo0UYnXyfAUTQM2K5W9I=;
        b=YqgXOwr2Mt6Lvo/hqtmAeXPCGz6u5wu+SrcecmjKDQyC9GQaTDWQnPOyH2k0mtcoYP
         SASBrNZwIWRJ+0dEC/2PIl51tsk9Y5EvAh5TCAuBRYYfg+qfJ3ESXVTDrCbNGPaJAIXd
         G+E8vdMCY9dWUF8rh+b/jhgukZDc3iNNEg/+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQFFIM7pSZ3rNVADx3v3MXfqo0UYnXyfAUTQM2K5W9I=;
        b=EtpZWktOqBkESHNh5eW/b+mMPRSt2CJTnEeRztY5JzwZ4/u7K3Rcy1xGYIl1Wp0d1m
         3mk0noixOy/l8i+nZcbQuYSXk2USXd/psWHsbwbaqZVwGV5OF67qlTwQ5TjptL5CUqBN
         QDNh1hjB37sBnWxDQ3lhQltXqlF1+eQ563KslUuATfZ5kjMz0WM9rtgYw/Fz2SDN2AlM
         YmnQ+f6hzRu6yDs3eLcHanxmd4X+KcQbEx4P1DNVHpHke/2n2EWxi2G+baOIaIP7LgQr
         KPnYQgdJ19yxARktQqPHZ3odFTIcEiN49aCeGEFingdHKf1fjbZz0Gc2PzgKmFjpjge4
         n4ug==
X-Gm-Message-State: AOAM533ySL0S6TmuGkHYzTW8VUCVwjz7Qe+hn1/ZW/hnHtxMwEE+K1Ul
        qo+uj+IW/7egAu8YeSG6pKhq0P6E17el2Q==
X-Google-Smtp-Source: ABdhPJwP+3BpYc8b/gfMYVuc2gM+WAT6oyI8QwtQ3SGjBrHL2TWoeHps3RLGgvnG6bPx6FENqeXcHA==
X-Received: by 2002:a1f:b652:: with SMTP id g79mr2337342vkf.21.1618498129446;
        Thu, 15 Apr 2021 07:48:49 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id b11sm249554vsj.18.2021.04.15.07.48.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 07:48:49 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id z15so2102004uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:48:49 -0700 (PDT)
X-Received: by 2002:a25:d847:: with SMTP id p68mr4882363ybg.345.1618498117948;
 Thu, 15 Apr 2021 07:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210402222846.2461042-1-dianders@chromium.org>
 <20210402152701.v3.1.If62a003f76a2bc4ccc6c53565becc05d2aad4430@changeid>
 <YGpeo9LV4uAh1B7u@pendragon.ideasonboard.com> <CAD=FV=UN38EiYMiwNjysBS6dReKDaf+g2GcgaVt9iF1mTRKg7A@mail.gmail.com>
 <YHedYnUrcnhRDnie@pendragon.ideasonboard.com>
In-Reply-To: <YHedYnUrcnhRDnie@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Apr 2021 07:48:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhqCe1r1kqVdmYOmy75j_v73RSjP0d0MX0q5zq2GVJoQ@mail.gmail.com>
Message-ID: <CAD=FV=UhqCe1r1kqVdmYOmy75j_v73RSjP0d0MX0q5zq2GVJoQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] drm/bridge: Fix the stop condition of drm_bridge_chain_pre_enable()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 14, 2021 at 6:56 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Doug,
>
> On Wed, Apr 14, 2021 at 06:19:13PM -0700, Doug Anderson wrote:
> > On Sun, Apr 4, 2021 at 5:50 PM Laurent Pinchart wrote:
> > > On Fri, Apr 02, 2021 at 03:28:35PM -0700, Douglas Anderson wrote:
> > > > The drm_bridge_chain_pre_enable() is not the proper opposite of
> > > > drm_bridge_chain_post_disable(). It continues along the chain to
> > > > _before_ the starting bridge. Let's fix that.
> > > >
> > > > Fixes: 05193dc38197 ("drm/bridge: Make the bridge chain a double-linked list")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  drivers/gpu/drm/drm_bridge.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > > > index 64f0effb52ac..044acd07c153 100644
> > > > --- a/drivers/gpu/drm/drm_bridge.c
> > > > +++ b/drivers/gpu/drm/drm_bridge.c
> > > > @@ -522,6 +522,9 @@ void drm_bridge_chain_pre_enable(struct drm_bridge *bridge)
> > > >       list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> > > >               if (iter->funcs->pre_enable)
> > > >                       iter->funcs->pre_enable(iter);
> > > > +
> > > > +             if (iter == bridge)
> > > > +                     break;
> > >
> > > This looks good as it matches drm_atomic_bridge_chain_disable().
> > >
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > Thanks for your review here and several of the other patches. Can you
> > suggest any plan for getting them landed? It would at least be nice to
> > get the non-controversial ones landed.
>
> Do you have commit access to drm-misc ? If not, given your
> contributions, I think you qualify for it.

No, I don't have access. I searched for how to get it and read through
the qualifications and, you're right, I think I do. I've hopefully
followed the right flow and created an issue to give me ssh access:

https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/348

Is that something you (or someone else on this CC list) approves?


> > > I'm curious though, given that the bridge passed to the function should
> > > be the one closest to the encoder, does this make a difference ?
> >
> > Yes, that's how I discovered it originally. Let's see. So if I don't
> > have this patch but have the rest of the series then I get a splat at
> > bootup. This shows that dsi_mgr_bridge_pre_enable() must be "earlier"
> > in the chain than my bridge chip. Here's the splat:
>
> Right, I think it's caused by a later patch in the series calling this
> function with a different bridge than the one closest to the encoder.

Yup! I still wanted this patch to be first in the series, though,
since it's a bugfix that we'd want to land even if the later patches
changed in some way.

-Doug
