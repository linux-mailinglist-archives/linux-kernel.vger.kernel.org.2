Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24235EF12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349905AbhDNIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbhDNIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:07:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF85C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:06:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so12066334pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q9984cqzokao90tfGIrsxyiVIENON1Jfg91EKnCdof8=;
        b=fW80R42TJsY77DRXQCzB9SKLcnXcPGFlu4lBTxcOlTPXkbLueFvuA39mPoRWpgxGZF
         S+MadSGXRh3tyq8byLtrkINS+a+tgsH/0sKoMiriG08wQrsSYXAbSTuA44AsiZo2eTDz
         Br0zZj/hKm98rMUtUxyKbXKWVkAZs2TO8sqPzTbPAAQweb1J4V7Ru0N+JZJzWQswIriJ
         c0PEB7f1qsOVjGQnAob6UMrvph7Av6/H3wvhbGJ6JOqVFMVS+eN8/A3Ls08fVv7+eGPR
         eCEjlpmZnaFrBvb0FE0xNx3ybIoJX81tLvuEEQKXjiUf4kS6dau3jWUQFtgjBGemH8CB
         1whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q9984cqzokao90tfGIrsxyiVIENON1Jfg91EKnCdof8=;
        b=KrX4i6uvHrsmoJkQOtvYYwK4aXPnM336gN6TER/+0S0usDsTpX1ESC49jA0b+r8yz+
         05L/A1WWwmgwHGhW2hHUQTM9OPiWR75+gPzh3ku8c2bJJxfne676+RDdhlyH/NgnJNCe
         IxOX9NGP79GmC20brFwP2O9sY6oO4mTlOwrFtlSmlopdQbIeDwOohb4WpFzYESQOWLVf
         TGqTBTokY0in86Ds8jtLXqhOO7cMcwhjVZJxfpeGzvCiLHUiSRvHqIJ2mkND08GZjm6A
         NU+MWlu5OmD4SsjzpLENav5q5kZ/8grJ27PMZSX3Nkcwaf3VLct0Q55Ke4ODDsHylLLP
         e0fA==
X-Gm-Message-State: AOAM532E9sC52LUafWHPmyaqBcyyQ/OqjEPh0G1RRzobKJQEXgQtZ22f
        g4cs2YrrDF0ghQN03dbrQfCKt9h/ydZ1vvPFlutpXg==
X-Google-Smtp-Source: ABdhPJzEWdIhOr7juz3mZ7xnpTDpVDqoUyigBSUjrTKxFSeTivxg/jTYsNfrdGnGl+vl1J1spSTLtTsmuk227wJ+yOk=
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr2306382pjh.19.1618387608629;
 Wed, 14 Apr 2021 01:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-3-narmstrong@baylibre.com> <CAG3jFysFb+y6ymXsBQatuwtPEYRTBnWTku0EpmNyR2gR5a=Y2w@mail.gmail.com>
 <3266977b-9d19-c81d-6fd7-b6fa0714b1ef@baylibre.com>
In-Reply-To: <3266977b-9d19-c81d-6fd7-b6fa0714b1ef@baylibre.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 14 Apr 2021 10:06:37 +0200
Message-ID: <CAG3jFysp+3__TfEyvKSf47q3nYsdRSbkb9LxX2pcJr356yAgKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm: bridge: add it66121 driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        paul@crapouillou.net, Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phong LE <ple@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 at 08:13, Neil Armstrong <narmstrong@baylibre.com> wrot=
e:
>
> Hi Rob,
>
> Le 13/04/2021 =C3=A0 22:21, Robert Foss a =C3=A9crit :
> > Hey Neil & Phong,
> >
> > Thanks for submitting this series!
> >
> >> +
> >> +static const struct drm_bridge_funcs it66121_bridge_funcs =3D {
> >> +       .attach =3D it66121_bridge_attach,
> >> +       .enable =3D it66121_bridge_enable,
> >> +       .disable =3D it66121_bridge_disable,
> >> +       .mode_set =3D it66121_bridge_mode_set,
> >> +       .mode_valid =3D it66121_bridge_mode_valid,
> >> +       .detect =3D it66121_bridge_detect,
> >> +       .get_edid =3D it66121_bridge_get_edid,
> >> +       .atomic_get_output_bus_fmts =3D it66121_bridge_atomic_get_outp=
ut_bus_fmts,
> >> +       .atomic_get_input_bus_fmts =3D it66121_bridge_atomic_get_input=
_bus_fmts,
> >> +};
> >
> > I would like to see an implementation of HPD, since it is supported by
> > the hardware[1] (and required by the documentation). IRQ status bit 0
> > seems to be the responsible for notifying us about hot plug detection
> > events.
>
> It's implemented in the IRQ handler with the IT66121_INT_STATUS1_HPD_STAT=
US event.
>

I didn't even get that far :)

Either way, the HPD support should be exposed in drm_bridge_funcs
(.hpd_enable, .hpd_disable (and possibly .hpd_notify)) and
drm_bridge.ops (DRM_BRIDGE_OP_HPD).
