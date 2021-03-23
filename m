Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B134589C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCWHZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhCWHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:25:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:25:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso11758551pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=UKDB4tP1o/qAJ5iZQYJec7JsyNelKTQdItmX1ycjyQk=;
        b=ZETG82JILVxDJCi3qiI1q0/LQNcWe9kN64W1uB852/RlDMI5Yh6PhOnBgKohVs1Xhq
         b2j43WJ1y0Gj/KQt3KYF3WXHWu9xefZzPtfdm40QocAiaK4lE24hDSjYV219L8YJWjol
         dupj1bUlLOxCnPRBRReCjJHZS8pgOjJ51nnXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=UKDB4tP1o/qAJ5iZQYJec7JsyNelKTQdItmX1ycjyQk=;
        b=Q7Bs7ZgpmCjBwkklcaym5KSPkvpJJGyGeeBjFm8zUyaL0GdMwVeB9dQricJWzwTgyN
         nH8ha8/+BCjVT0YcxUlhcuP9QJoxBw49aOZBp4Ley+ATNgkJE1xnKHCTi8pnOgH/aehi
         3g/MQqURKniJQVB+90H1DHKl/p9vzvFKKYhMWT1HZ/nQrfmcrw/5ddxPhl1C8sIoyf+/
         TuK4sBW88XF3eG4iC/GS3ifQCLJVPa1EDbyD65YmVbBlVk6Szk7GveJJCqaLB4ctiggt
         Ae8ALAni14YPJJ+OQKWBJyGvKrVmUVr7fGBBHw2ZQ4P/Kbw1Q9BHpkQhOxv/3haJugH7
         Sk+Q==
X-Gm-Message-State: AOAM533qTvIzIwMkk3YZYcfXqbAu2fADw32uo6nrp7UfyL8DJjRljsxt
        Z4q+d4yzwmy+XHIxsW5OsHGGPA==
X-Google-Smtp-Source: ABdhPJyPgeACfzPrxFvaTFzN2uVCCvcZfR0JEVYNsM780SwaiY1fnBGhInJl6nD7HjGAyflWidV26A==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr3287152pjt.144.1616484342636;
        Tue, 23 Mar 2021 00:25:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e90d:d453:87ae:2e10])
        by smtp.gmail.com with ESMTPSA id z1sm15806362pfn.127.2021.03.23.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 00:25:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YFkvl9tzP5Nj54C4@pendragon.ideasonboard.com>
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201101173741.GA1293305@ravnborg.org> <160436612483.884498.883110130131457033@swboyd.mtv.corp.google.com> <YFkvl9tzP5Nj54C4@pendragon.ideasonboard.com>
Subject: Re: [PATCH v2 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Tue, 23 Mar 2021 00:25:40 -0700
Message-ID: <161648434035.3012082.16414745959476755420@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2021-03-22 17:00:23)
> Hi Stephen,
>=20
> On Mon, Nov 02, 2020 at 05:15:24PM -0800, Stephen Boyd wrote:
> > Quoting Sam Ravnborg (2020-11-01 09:37:41)
> > > Hi Stephen.
> > >=20
> > > On Thu, Oct 29, 2020 at 06:17:34PM -0700, Stephen Boyd wrote:
> > > > This patch series cleans up the DDC code a little bit so that
> > > > it is more efficient time wise and supports grabbing the EDID
> > > > of the eDP panel over the aux channel. I timed this on a board
> > > > I have on my desk and it takes about 20ms to grab the EDID out
> > > > of the panel and make sure it is valid.
> > > >=20
> > > > The first two patches seem less controversial so I stuck them at
> > > > the beginning. The third patch does the EDID reading and caches
> > > > it so we don't have to keep grabbing it over and over again. And
> > > > finally the last patch updates the reply field so that short
> > > > reads and nacks over the channel are reflected properly instead of
> > > > treating them as some sort of error that can't be discerned.
> > > >=20
> > > > Stephen Boyd (4):
> > > >   drm/bridge: ti-sn65dsi86: Combine register accesses in
> > > >     ti_sn_aux_transfer()
> > > >   drm/bridge: ti-sn65dsi86: Make polling a busy loop
> > > >   drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
> > > >   drm/bridge: ti-sn65dsi86: Update reply on aux failures
> > >=20
> > > Series looks good. You can add my a-b on the full series.
> > > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > >=20
> > > I can apply after Douglas have had a look at the patches he did not r=
-b
> > > yet.
> > >=20
> > > Any chance we can convince you to prepare this bridge driver for use =
in
> > > a chained bridge setup where the connector is created by the display
> > > driver and uses drm_bridge_funcs?
> > >=20
> > > First step wuld be to introduce the use of a panel_bridge.
> > > Then add get_edid to drm_bridge_funcs and maybe more helpers.
> > >=20
> > > Then natural final step would be to move connector creation to the
> > > display driver - see how other uses drm_bridge_connector_init() to do=
 so
> > > - it is relatively simple.
> > >=20
> > > Should be doable - and reach out if you need some help.
> >=20
> > I started to look at this and got stuck at ti_sn_bridge_get_bpp(). Where
> > can I get the details of the bpc for the downstream bridge or panel? Is
> > there some function that can tell this bridge what the bpc is for the
> > attached connector?
>=20
> I've posted a patch series to convert to DRM_BRIDGE_ATTACH_NO_CONNECTOR
> yesterday (and have CC'ed you), but I've overlooked this particular
> problem :-S

!

>=20
> You can't get the connector in the .enable() operation, but you can get
> it in .atomic_enable(), with
> drm_atomic_get_new_connector_for_encoder(). This being said, it's
> probably not the right option.
>=20
> What matters here isn't the bpc for the connector, but the format
> expected by the next bridge in the chain. drm_bridge_funcs has two
> operations, .atomic_get_output_bus_fmts() and
> .atomic_get_input_bus_fmts(), to negotiate that format along a chain of
> bridges. The panel bridge driver (drivers/gpu/drm/bridge/panel.c)
> doesn't implement those operations, and neither does
> display-connector.c, so that may be what we should start with.

Ok, makes sense. I'd gladly test things out if you come up with some
solution here.
