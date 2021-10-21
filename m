Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BB2436C38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 22:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhJUUgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhJUUgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:36:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DD3C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:34:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z69so2590623iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qc5yk2ewhoH94OoX+tRZuXvqhmyfRbN00IiOr1tb4iU=;
        b=OoTa6UG/eMXeKDGTA4sYKl0TkjpkdP9n7fq2xELyADWB9E8Sd4SygwGy4lyHjmsbhB
         Bd6YZ37c8AOWr9YIV9NxUstNzaNqopKTj/6cOldCh4pvfQR0qR+Hq6dvvWxmCiEnm/mW
         vOyjzuLvJ8JrH0pMnzo9oA25IQVb/OjHBe9d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qc5yk2ewhoH94OoX+tRZuXvqhmyfRbN00IiOr1tb4iU=;
        b=UgXhT5zOWSmi69woRegdNpCOFhHrILjkxOl/NHKYoLd0KoabNDM3f7tPJHiuMXnwm0
         OcfHLkhy/siFyCP1Ky6NJ0ix8JiHLo4v/mvPxtBSZWtTOYo6Kr9dfwIMPI5QgJ9BBBy9
         Z46WsitxL3HEfLMJ16HKuUummhuwn1PUDKp/gMVT3HFTGY3eurxsu4JZE138E6S+1Z9s
         s+O3OIyZRfbmyN4G/yg0IiSCwEhaji20C9AqpE5RoZKl98aERN/upSaK85AuTyxtcPGp
         qoLJqdp0c63aXyk+ay8cUoeiLDHMgqJ59/iAfr5BWRWOJszm356drnskVLnKlTyJDDHw
         g5NQ==
X-Gm-Message-State: AOAM532KbunRxrM38mmgtHatt2wwtxRyh8Trk6ZaGR0/QfyXqwqN+50p
        gMmroj4frI8rV+qrySH9N5/WPe/fGHVH7g==
X-Google-Smtp-Source: ABdhPJzDgd9J6M34d43ZxeethkPJ+tcohnL7o9+yptTxbJl1PuuaVW3YI9GyRNm5t0nKQjsaNE6vYQ==
X-Received: by 2002:a05:6638:134f:: with SMTP id u15mr5377378jad.145.1634848446764;
        Thu, 21 Oct 2021 13:34:06 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id k83sm3266527iof.12.2021.10.21.13.34.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 13:34:06 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id y17so2021455ilb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:34:06 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b09:: with SMTP id i9mr4972431ilv.142.1634848445568;
 Thu, 21 Oct 2021 13:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211021122719.1.I56d382006dea67ed8f30729a751fbc75434315b2@changeid>
 <YXHLrnAliqxmrrho@ravnborg.org>
In-Reply-To: <YXHLrnAliqxmrrho@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Oct 2021 13:33:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U3_q-Y7QArYkGabrNEYMT0D3uuh-_O+D4DjF_bYmpPiA@mail.gmail.com>
Message-ID: <CAD=FV=U3_q-Y7QArYkGabrNEYMT0D3uuh-_O+D4DjF_bYmpPiA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Fix the bridge chain order for pre_enable / post_disable
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Philip Chen <philipchen@chromium.org>,
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

Hi,

On Thu, Oct 21, 2021 at 1:21 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas,
>
> On Thu, Oct 21, 2021 at 12:29:01PM -0700, Douglas Anderson wrote:
> > Right now, the chaining order of
> > pre_enable/enable/disable/post_disable looks like this:
> >
> > pre_enable:   start from connector and move to encoder
> > enable:       start from encoder and move to connector
> > disable:      start from connector and move to encoder
> > post_disable: start from encoder and move to connector
> >
> > In the above, it can be seen that at least pre_enable() and
> > post_disable() are opposites of each other and enable() and disable()
> > are opposites. However, it seems broken that pre_enable() and enable()
> > would not move in the same direction. In other parts of Linux you can
> > see that various stages move in the same order. For instance, during
> > system suspend the "early" calls run in the same order as the normal
> > calls run in the same order as the "late" calls run in the same order
> > as the "noirq" calls.
> >
> > Let fix the above so that it makes more sense. Now we'll have:
> >
> > pre_enable:   start from encoder and move to connector
> > enable:       start from encoder and move to connector
> > disable:      start from connector and move to encoder
> > post_disable: start from connector and move to encoder
> >
> > This order is chosen because if there are parent-child relationships
> > anywhere I would expect that the encoder would be a parent and the
> > connector a child--not the other way around.
>
> This makes good sense as you describe it. I hope others can add more
> useful feedback.
> Added Andrzej Hajda <andrzej.hajda@intel.com> to the mail, as he have
> expressed concerns with the chain of bridges before.
>
> >
> > This can be important when using the DP AUX bus to instantiate a
> > panel. The DP AUX bus is likely part of a bridge driver and is a
> > parent of the panel. We'd like the bridge to be pre_enabled before the
> > panel and the panel to be post_disabled before the
> > bridge. Specifically, this allows pm_runtime_put_sync_suspend() in a
> > bridge driver's post_suspend to work properly even a panel is under
> > it.
> >
> > NOTE: it's entirely possible that this change could break someone who
> > was relying on the old order. Hopefully this isn't the case, but if
> > this does break someone it seems like it's better to do it sonner
> > rather than later so we can fix everyone to handle the order that
> > makes the most sense.
> >
> > A FURTHER NOTE: Looking closer at commit 4e5763f03e10 ("drm/bridge:
> > ti-sn65dsi86: Wrap panel with panel-bridge") you can see that patch
> > inadvertently changed the order of things. The order used to be
> > correct (panel prepare was at the tail of the bridge enable) but it
> > became backwards. We'll restore the original order with this patch.
> >
> > Fixes: 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with panel-bridge")
> > Fixes: 05193dc38197 ("drm/bridge: Make the bridge chain a double-linked list")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> To make the patch complete the descriptions in drm_bridge_funcs
> need to be updated to reflect the new reality.

Ah, oops! Sure, I'll plan on a v2 with this but I'll wait for more feedback.



> >  drivers/gpu/drm/drm_bridge.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index c96847fc0ebc..98808af59afd 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -583,18 +583,14 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_set);
> >  void drm_bridge_chain_pre_enable(struct drm_bridge *bridge)
>
> If you, or someone else, could r-b or ack the pending patches to remove
> this function, this part of the patch would no longer be needed.

OK. I will likely be able to take a look next week. Given that I'm
helping Philip bringup a board with ps8640 it looks like your patch
series will be quite relevant! I guess it would be good to figure out
what would be the best order to land them. In my case we need this fix
to be easy to pick back to fix the behavior on the Chrome OS 5.4 tree.
My fix is easy to pick back, but perhaps yours is as well. Of course
we could also just make a local divergent change in our tree if need
be, too.


> >  {
> >       struct drm_encoder *encoder;
> > -     struct drm_bridge *iter;
> >
> >       if (!bridge)
> >               return;
> >
> >       encoder = bridge->encoder;
> > -     list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> > -             if (iter->funcs->pre_enable)
> > -                     iter->funcs->pre_enable(iter);
> > -
> > -             if (iter == bridge)
> > -                     break;
> > +     list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
> > +             if (bridge->funcs->pre_enable)
> > +                     bridge->funcs->pre_enable(bridge);
> >       }
> >  }
> >  EXPORT_SYMBOL(drm_bridge_chain_pre_enable);
> > @@ -684,26 +680,30 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
> >                                         struct drm_atomic_state *old_state)
> >  {
> >       struct drm_encoder *encoder;
> > +     struct drm_bridge *iter;
> s/iter/bridge/ would make the patch simpler
> And then the bridge argument could be last_bridge or something.
> This would IMO increase readability of the code and make the patch smaller.

Yeah, I debated this too. I was trying to match
drm_bridge_chain_disable() and in my mind keeping the two functions
matching is more important than keeping this patch small. Certainly I
could add another patch in the series to rename "bridge" to
"last_bridge" and "iter" to "bridge" in that function, but that
defeats the goal of reducing churn... ...and clearly whoever wrote
drm_bridge_chain_disable() liked "iter" better. :-P

In any case, I'll change it as you say if everyone likes it better,
but otherwise I'll leave it as I have it.


> >       if (!bridge)
> >               return;
> >
> >       encoder = bridge->encoder;
> > -     list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
> > -             if (bridge->funcs->atomic_post_disable) {
> > +     list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> > +             if (iter->funcs->atomic_post_disable) {
> >                       struct drm_bridge_state *old_bridge_state;
> >
> >                       old_bridge_state =
> >                               drm_atomic_get_old_bridge_state(old_state,
> > -                                                             bridge);
> > +                                                             iter);
> >                       if (WARN_ON(!old_bridge_state))
> >                               return;
> >
> > -                     bridge->funcs->atomic_post_disable(bridge,
> > -                                                        old_bridge_state);
> > -             } else if (bridge->funcs->post_disable) {
> > -                     bridge->funcs->post_disable(bridge);
> > +                     iter->funcs->atomic_post_disable(iter,
> > +                                                      old_bridge_state);
> > +             } else if (iter->funcs->post_disable) {
> > +                     iter->funcs->post_disable(iter);
> >               }
> > +
> > +             if (iter == bridge)
> > +                     break;
> I cannot see why this is needed, we are at the end of the list here
> anyway.

It's because you can start at something that's not the first bridge in
the chain. See commit bab5cca7e609 ("drm/bridge: Fix the stop
condition of drm_bridge_chain_pre_enable()")
