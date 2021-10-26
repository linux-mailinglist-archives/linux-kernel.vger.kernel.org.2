Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFBB43BA24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhJZTF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbhJZTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:05:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BB8C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:02:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id b9so127937ybc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5L3NweT3WPaAhbnyD6WsMkziixFdgFckJuSxCTQJug8=;
        b=l0QpRlsuyjAiD2JKUtg4qYGjk/EHm4JDHoWsRaQ6YYdxRC2jJ+SB5MOUuC/fhQBdXR
         iwpP3kdXxKiLLSkXR6os09z73mhZ7ayH+dXNYDCxKexWzUHCnCS2pBgGQCZKYW+GtoUF
         kbRE9ZsqoRNQGY8U+okXUtMSxUo40rG3nKl+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5L3NweT3WPaAhbnyD6WsMkziixFdgFckJuSxCTQJug8=;
        b=16GfyZdKYD/rf61anXai5HzZBmclRPv137xSUJfL2oiYAWyCHWhYK29+xLhBCeagNb
         V+H8CWMspX0oHs1xqkIwR++QvoONNQK69sqaDP01jvQlO5vWne8yU0Pyxfjuqwl7Grnt
         1bNB12H/h8LSsa0m9QbrYwzpoXf3egVVyLAgqfo4ZWEixcAssE3favlEAPZzpgAY67Xq
         iLD6bJ+51yz9nCDgDWqFScptvbLlyNFG95Q6LSpcYVblbXfl/WezgdHBaTPie+ebdMX5
         4KK80LdYzXWAOsQGqxokwqL61wG3P8JQI5YGCT0BcVeqYGCACKu7WE4l1ooxDAhD67ah
         6y2Q==
X-Gm-Message-State: AOAM531opD2riosE6rUWhOhpf0ZcB9YRQ4d4/AR9Xtx37mcXEHevC0O2
        MPV55ksIRVLIisdUZxfWMba79k752EOtwA7TkXaGYA==
X-Google-Smtp-Source: ABdhPJzOBEFRxTBiSQhUxPe/HnGVVKVilz0M99d1Ba9vdf2gbBSJgmrn/SQqYt1r2uNjvGCVNZKyZ+TpxEK1zr8c9JQ=
X-Received: by 2002:a25:cf07:: with SMTP id f7mr25652281ybg.100.1635274977398;
 Tue, 26 Oct 2021 12:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211021140552.v2.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <20211021140552.v2.2.I3ed2a84c58d9e81965f497d587f735eea56c1684@changeid> <CAE-0n52UdhHwM0rViVdyE4wO3sw8DzU5fEFp_aKTQBwLfR-qgA@mail.gmail.com>
In-Reply-To: <CAE-0n52UdhHwM0rViVdyE4wO3sw8DzU5fEFp_aKTQBwLfR-qgA@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 26 Oct 2021 12:02:46 -0700
Message-ID: <CA+cxXh=Rqtqp701rf0c8cVWOWsjrVi-HcoA5H0E_SqxX7B=5NA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dianders@chromium.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 25, 2021 at 1:10 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-10-21 14:06:00)
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index 220ca3b03d24..f99a2e0808b7 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -149,6 +150,23 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
> >         return container_of(aux, struct ps8640, aux);
> >  }
> >
> > +static bool ps8640_of_panel_on_aux_bus(struct device *dev)
> > +{
> > +       struct device_node *bus, *panel;
> > +
> > +       bus = of_get_child_by_name(dev->of_node, "aux-bus");
> > +       if (!bus)
> > +               return false;
> > +       of_node_put(bus);
>
> This should come after the next line...
>
> > +
> > +       panel = of_get_child_by_name(bus, "panel");
>
> here, so that 'bus' can't go away before getting children nodes. It
> doesn't actually matter in this case because 'device' holds the aux-bus,
> but we shouldn't add anti-patterns to the code lest someone copies it
> where it actually matters.
Thanks for pointing it out.
I will fix it in v3.

>
> > +       if (!panel)
> > +               return false;
> > +       of_node_put(panel);
> > +
> > +       return true;
> > +}
> > +
> >  static void ps8640_ensure_hpd(struct ps8640 *ps_bridge)
> >  {
> >         struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
>
> Otherwise
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
