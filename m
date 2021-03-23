Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23712346888
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhCWTH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhCWTHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:07:42 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA87CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:07:41 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j7so15776435qtx.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWYImPY4n0R9yJQuBqYSMZiXrLY8rwBZGNs7mWEym+0=;
        b=M027G/yP3c70cu2GpI+RP+QTZP0mhijfWu1cvjIwMFh6l7wgfNCUFIoXEyhw7nCGH+
         s/7MSjEM48e5TKupVxNEDfe48pnDkxiKL7H8UWexaS5IuC4qC6WB34LJJBI2vZUT+QuF
         tjqn5QGlMqmusOdIEpzZcyy9wdvnRE+HnVKJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWYImPY4n0R9yJQuBqYSMZiXrLY8rwBZGNs7mWEym+0=;
        b=pAoTBgeFtJAXZQsBf6WaKTrMDGEvvUYnw6jF3MJXik/Tdn874Y3QGOgUhcwzKKI1/F
         FIB1MTGNOLyHP5xWYKb5NraHtdJOGaWOZgWvYmE7AGfA4Td01tlJImFQWJ3O6Nh66ghK
         YQT0BesrwjAe/FJBIn1SXrHqavJjIRO8bZnss6qVauLLX3wHG7I9kdGvOMJMmUQWurFG
         YFFEeAAjUFOYlcoR5bjHONBB2yqswISbiZ8IFzI1M4fmvIjdfKg4RYY07Ga2Ier/9ycm
         3NFfLHT/7kaCN9vEOCTBKdslfrN+0o2F6ab9zLWU+WTyIK4EUoa4SEPYH80g2DDDs55I
         2RjA==
X-Gm-Message-State: AOAM531DmQnWliJXosUatKEIE02tTt5nV1uiKGhIsAtLXEUmqFc6uQwy
        HMcvDr9bHZp5VoKiOH8nNnaXOGr5tZM4IQ==
X-Google-Smtp-Source: ABdhPJx0z1WIJTOmYhwhECkThMQkUbQspQ/Ay9lBSYZhnhZCVohp9fO25wmV0tbhGqoMyN3SJgUIfw==
X-Received: by 2002:ac8:7768:: with SMTP id h8mr5698158qtu.185.1616526460696;
        Tue, 23 Mar 2021 12:07:40 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 85sm4081894qke.55.2021.03.23.12.07.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:07:39 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id z1so11480676ybf.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:07:39 -0700 (PDT)
X-Received: by 2002:a25:69c1:: with SMTP id e184mr7553038ybc.345.1616526459117;
 Tue, 23 Mar 2021 12:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201102181144.3469197-1-swboyd@chromium.org> <20201102181144.3469197-4-swboyd@chromium.org>
 <YFKc23MwUQAosCs8@pendragon.ideasonboard.com> <161646947526.2972785.6883720652669260316@swboyd.mtv.corp.google.com>
In-Reply-To: <161646947526.2972785.6883720652669260316@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Mar 2021 12:07:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+-spmAxFeDNxhCuB6O=gUvO_==ozg-OGn=2vkUWgL4Q@mail.gmail.com>
Message-ID: <CAD=FV=U+-spmAxFeDNxhCuB6O=gUvO_==ozg-OGn=2vkUWgL4Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 22, 2021 at 8:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Laurent Pinchart (2021-03-17 17:20:43)
> > Hi Stephen,
> >
> > Reviving a bit of an old thread, for a question.
> >
> > On Mon, Nov 02, 2020 at 10:11:43AM -0800, Stephen Boyd wrote:
> > > @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
> > >  static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
> > >  {
> > >       struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
> > > +     struct edid *edid = pdata->edid;
> > > +     int num, ret;
> > > +
> > > +     if (!edid) {
> > > +             pm_runtime_get_sync(pdata->dev);
> > > +             edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
> > > +             pm_runtime_put(pdata->dev);
> >
> > Is there any specific reason to use the indirect access method, compared
> > to the direct method that translates access to an I2C ancillary address
> > to an I2C-over-AUX transaction (see page 20 of SLLSEH2B) ? The direct
> > method seems it would be more efficient.
> >
>
> No I don't think it matters. I was just using the existing support code
> that Sean wrote instead of digging into the details. Maybe Sean ran into
> something earlier and abandoned that approach?

From reading the docs, it sounds as if there _could_ be a reason to
use the indirect method. Specifically if the i2c host that the bridge
is on doesn't support clock stretching then the direct method wouldn't
work according to the docs. Is that something that we'd have to
reasonably worry about?

-Doug
