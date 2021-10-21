Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B804436D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhJUWPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJUWPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:15:49 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144BBC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:13:33 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 67so2625397yba.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JNbTex7xms2/Cnj1YUiyYIVh0CE0nHjewijLch+82Q=;
        b=FfOx9yi/TuhHQ9MsjLtKqFx9v3fCbngNPzNUinjEIXIi+g+psMA3N6JzeJb/vcTYEm
         vKIQ8ffLQcHHfIzne66oBiISC0EpYFb6Esyjn3RjyE3ciawjLAEdZmVHTR3qiLgpVddG
         iQW6fWjV9U+Wk4O+qXaRrilUGoF1GjHhgUxz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JNbTex7xms2/Cnj1YUiyYIVh0CE0nHjewijLch+82Q=;
        b=Yrzq+rd6d8EnDQ5KYCZFnqdYaOpNB1LYmz483sYsHff3SpCIRPrpXPDglvB1F+7KwZ
         1VJb0K/dzlOc6RvXhUWT9F7myhlnMWOBWPK1Ea6CyxyIVdOMLHpuAOxQ6KBcvSmXPiFR
         1kw82C1C8ws+ieABo29OW4veZr7e5JVZamyiidFHH2FjEEp8t7kMcEK+BKaBlmtVaqUf
         IE2Q8uZ2WhBLom666FEKNvQetitb+1ya3ooIFTEQgA8uEZcxtPvi9LcHTG+LT9M9aaAy
         0WwYJy8quflyu8MsTGnjfbKbQAmGcSnAYrqGG4Fc6Qp+5MGLC/UCPNxv2MPVD4R1+bRZ
         7U8Q==
X-Gm-Message-State: AOAM533TjhyFNSSZfzp6Yx8XkBjZ6KSQ7oLk4prJE/FiU8fdH2HW3kgr
        W+YopZOoLM90KTVZZwu4R6JeZsYmUGtBrCfPP0DCoA==
X-Google-Smtp-Source: ABdhPJxaCktPEOq+UiNW76HQBbiZpM3WakQJwjtwjaPfWuI75ndx7HKMTkeL0YbBpMZqy6VAJJRlMdmA2x2T9C1vcoI=
X-Received: by 2002:a25:cf07:: with SMTP id f7mr9184774ybg.100.1634854412341;
 Thu, 21 Oct 2021 15:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211021122719.1.I56d382006dea67ed8f30729a751fbc75434315b2@changeid>
 <YXHLrnAliqxmrrho@ravnborg.org> <CAD=FV=U3_q-Y7QArYkGabrNEYMT0D3uuh-_O+D4DjF_bYmpPiA@mail.gmail.com>
 <YXHQhMe84ZZKkJik@ravnborg.org>
In-Reply-To: <YXHQhMe84ZZKkJik@ravnborg.org>
From:   Philip Chen <philipchen@chromium.org>
Date:   Thu, 21 Oct 2021 15:13:21 -0700
Message-ID: <CA+cxXhkxEhPcmXgim89yKdhBFR4P96_eNQTKPP6ahnBC1mR9eQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Fix the bridge chain order for pre_enable / post_disable
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

I see this patch fixes the order for
drm_bridge_chain_pre_enable() and drm_atomic_bridge_chain_post_disable().

For completeness, shouldn't we also fix the order for
drm_atomic_bridge_chain_pre_enable() and drm_bridge_chain_post_disable()?

Surely, if Sam's pending patches will land first, there is no need to
fix the non_atomic versions.

On Thu, Oct 21, 2021 at 1:41 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas,
>
> > > >  void drm_bridge_chain_pre_enable(struct drm_bridge *bridge)
> > >
> > > If you, or someone else, could r-b or ack the pending patches to remove
> > > this function, this part of the patch would no longer be needed.
> >
> > OK. I will likely be able to take a look next week. Given that I'm
> > helping Philip bringup a board with ps8640 it looks like your patch
> > series will be quite relevant! I guess it would be good to figure out
> > what would be the best order to land them. In my case we need this fix
> > to be easy to pick back to fix the behavior on the Chrome OS 5.4 tree.
> > My fix is easy to pick back, but perhaps yours is as well. Of course
> > we could also just make a local divergent change in our tree if need
> > be, too.
> I do not mind the order - so whatever works for you guys.
> The only concern here is that we should not gain new users.
>
> >
> > > >  {
> > > >       struct drm_encoder *encoder;
> > > > -     struct drm_bridge *iter;
> > > >
> > > >       if (!bridge)
> > > >               return;
> > > >
> > > >       encoder = bridge->encoder;
> > > > -     list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> > > > -             if (iter->funcs->pre_enable)
> > > > -                     iter->funcs->pre_enable(iter);
> > > > -
> > > > -             if (iter == bridge)
> > > > -                     break;
> > > > +     list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
> > > > +             if (bridge->funcs->pre_enable)
> > > > +                     bridge->funcs->pre_enable(bridge);
> > > >       }
> > > >  }
> > > >  EXPORT_SYMBOL(drm_bridge_chain_pre_enable);
> > > > @@ -684,26 +680,30 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
> > > >                                         struct drm_atomic_state *old_state)
> > > >  {
> > > >       struct drm_encoder *encoder;
> > > > +     struct drm_bridge *iter;
> > > s/iter/bridge/ would make the patch simpler
> > > And then the bridge argument could be last_bridge or something.
> > > This would IMO increase readability of the code and make the patch smaller.
> >
> > Yeah, I debated this too. I was trying to match
> > drm_bridge_chain_disable() and in my mind keeping the two functions
> > matching is more important than keeping this patch small.
> Well, drm_bridge_chain_disable() is about to be deleted. So that the
> wrong one to look at.
>
> > Certainly I
> > could add another patch in the series to rename "bridge" to
> > "last_bridge" and "iter" to "bridge" in that function, but that
> > defeats the goal of reducing churn... ...and clearly whoever wrote
> > drm_bridge_chain_disable() liked "iter" better. :-P
> >
> > In any case, I'll change it as you say if everyone likes it better,
> > but otherwise I'll leave it as I have it.
>
> >
> >
> > > >       if (!bridge)
> > > >               return;
> > > >
> > > >       encoder = bridge->encoder;
> > > > -     list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
> > > > -             if (bridge->funcs->atomic_post_disable) {
> > > > +     list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> > > > +             if (iter->funcs->atomic_post_disable) {
> > > >                       struct drm_bridge_state *old_bridge_state;
> > > >
> > > >                       old_bridge_state =
> > > >                               drm_atomic_get_old_bridge_state(old_state,
> > > > -                                                             bridge);
> > > > +                                                             iter);
> > > >                       if (WARN_ON(!old_bridge_state))
> > > >                               return;
> > > >
> > > > -                     bridge->funcs->atomic_post_disable(bridge,
> > > > -                                                        old_bridge_state);
> > > > -             } else if (bridge->funcs->post_disable) {
> > > > -                     bridge->funcs->post_disable(bridge);
> > > > +                     iter->funcs->atomic_post_disable(iter,
> > > > +                                                      old_bridge_state);
> > > > +             } else if (iter->funcs->post_disable) {
> > > > +                     iter->funcs->post_disable(iter);
> > > >               }
> > > > +
> > > > +             if (iter == bridge)
> > > > +                     break;
> > > I cannot see why this is needed, we are at the end of the list here
> > > anyway.
> I see, please include this change in your changelog and add it to the
> documentation in drm_bridge_h.
>
>         Sam
