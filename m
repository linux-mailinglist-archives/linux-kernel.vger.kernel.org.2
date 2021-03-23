Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191D1345627
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCWDSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCWDR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:17:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8EEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:17:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 11so12826233pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Sde9ubYnM8N//wckrwjNnkeTvAXS6rg5mS6gvl/pZUo=;
        b=jBlLfJSVhdqoxsXpMG/sMoK5YHZ1gBShMw9pEb9RzY7dO5pwDig0eePdPiyHMnfoMw
         FKlNy4bz+8Nm6djUH96zOE8ri9oVufANooL0qI+4kdTiI0WS44Mc0lrPwt6d8IXAPtpF
         layi2llxziU9FDsdewA5UvMjO2xFy59K+sOdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Sde9ubYnM8N//wckrwjNnkeTvAXS6rg5mS6gvl/pZUo=;
        b=RHYQImMffT7yE8MjtycT/eLvlnuMFAhuzxycwaWGK/r0Gc3yivE/P8eNVz26IBI+IK
         +m2cZZaj8EhjosW097aOE3x5JEXz+u2zB6aXlG7MHWZvZVx4OptM39us03+bDNse+5ZX
         0ghM7CZBPBd23Erl7UNL1ul4jCUEfbpFnQWfJxmvsx0wXYP7H3qHFQ5vjghE5gfNbHam
         t8JTuWm5cNzTRzudckLE+wB3Sw2emrRsG+wDrRS98kHQ+wTvOhxMRZz3UiVbYE4Ejzzv
         rrmvNRnPWyrz/gAfD+/xEbuIpNtOop/OzpQVNzfb//imAJgm4A4QdwzbC8H8/2bx3U5x
         FFEg==
X-Gm-Message-State: AOAM530cFR3hDuXcPleeibtP+XZLr+NDr/IDoZVqZ1lEJ/cNS+fx94fF
        d+4YfqLeS86JrLZnzNsv2sDcQCI+LuQrjQ==
X-Google-Smtp-Source: ABdhPJzio4eIHsMr16l9KdlFKhVOamp64XhFRSBMJ5Bb1buPTL7wbW9YLkwV9VXhGXU2Fjy8GUhDww==
X-Received: by 2002:a63:d7:: with SMTP id 206mr2228693pga.30.1616469477218;
        Mon, 22 Mar 2021 20:17:57 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e90d:d453:87ae:2e10])
        by smtp.gmail.com with ESMTPSA id v134sm14944494pfc.182.2021.03.22.20.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 20:17:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YFKc23MwUQAosCs8@pendragon.ideasonboard.com>
References: <20201102181144.3469197-1-swboyd@chromium.org> <20201102181144.3469197-4-swboyd@chromium.org> <YFKc23MwUQAosCs8@pendragon.ideasonboard.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Mon, 22 Mar 2021 20:17:55 -0700
Message-ID: <161646947526.2972785.6883720652669260316@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2021-03-17 17:20:43)
> Hi Stephen,
>=20
> Reviving a bit of an old thread, for a question.
>=20
> On Mon, Nov 02, 2020 at 10:11:43AM -0800, Stephen Boyd wrote:
> > @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *co=
nnector)
> >  static int ti_sn_bridge_connector_get_modes(struct drm_connector *conn=
ector)
> >  {
> >       struct ti_sn_bridge *pdata =3D connector_to_ti_sn_bridge(connecto=
r);
> > +     struct edid *edid =3D pdata->edid;
> > +     int num, ret;
> > +
> > +     if (!edid) {
> > +             pm_runtime_get_sync(pdata->dev);
> > +             edid =3D pdata->edid =3D drm_get_edid(connector, &pdata->=
aux.ddc);
> > +             pm_runtime_put(pdata->dev);
>=20
> Is there any specific reason to use the indirect access method, compared
> to the direct method that translates access to an I2C ancillary address
> to an I2C-over-AUX transaction (see page 20 of SLLSEH2B) ? The direct
> method seems it would be more efficient.
>=20

No I don't think it matters. I was just using the existing support code
that Sean wrote instead of digging into the details. Maybe Sean ran into
something earlier and abandoned that approach?
