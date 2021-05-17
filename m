Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D580386B54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhEQUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbhEQUZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:25:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:23:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t7so5866622qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4npjzmtC1fi2rBbQF51lCYO1znRO3Y5vzRV2CUdYnQc=;
        b=mo4MtdIdBaqbn0rvbr8Al9VDijDLMpxhpo1BvG5iLNvjR/wDHjiz9muEDpBrRiJwhq
         40AbhDao1bx3W+JWbGgI5nfwUcteM8Zd+n+cdxkHNVLJIhCrfPxsrrDyOXCzkoFa631r
         y569Dmf48XwRvjZOlRusp5uwaGn3EwmBMfYdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4npjzmtC1fi2rBbQF51lCYO1znRO3Y5vzRV2CUdYnQc=;
        b=ruAWcqQPQBnpIzCAtiExizXEahCCK69hm3xCgmQVt2IF+IkXgaOp7vDaJQK1jE+urU
         LRHy8xTZysoB+Hr5NSG8jGEteTxWBGu6pRcwceT9NWBBiUNP+sN8WxJcx07rmEkVBE6s
         BYubnb+oS3rrH1fJg4+YuGLgZYwCxFXkNChqtd6r9Xu6Jjeq6CjbU1uSQO8goIe3gRgP
         nJRqBXqPsPMux1OCCW0mfuyuaMWGc+9SuhImOZ+FHR2aAUHNCKSsXjj6ZGTqNxstd3KU
         9ZecxqW7yFltJ3qnTjT8SphD1cTyL0Zb+aggkWYmoGismKo8FvrATnxME98W4jsfkc8j
         40YA==
X-Gm-Message-State: AOAM531oDbpHaaDZCh9zI4oigK3k9gXagu/j/222mIYGXd83FGnizzza
        W+jwkgteaNvuj4aNhSdpg5jwGkbUh8t5iQ==
X-Google-Smtp-Source: ABdhPJw7k2h2ylqUOr2WzaAcEkOxohEazseJNK76xyxOe50UaxFE24yCA0b7oZItYpTjrDFEYFblZg==
X-Received: by 2002:ac8:5199:: with SMTP id c25mr1239600qtn.265.1621283029337;
        Mon, 17 May 2021 13:23:49 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id i10sm11321086qko.68.2021.05.17.13.23.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 13:23:49 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id e190so10211244ybb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:23:49 -0700 (PDT)
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr2203165ybt.79.1621282684676;
 Mon, 17 May 2021 13:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210503215844.2996320-1-dianders@chromium.org>
 <20210503145750.v6.2.Iff8f2957d86af40f2bfcfb5a7163928481fccea4@changeid>
 <8eedeb02dc56ecaed5d2f3cb8d929a3675b2c3da.camel@redhat.com>
 <20210507220036.GI2484@yoga> <22632aba5bc118f5e96e155f240445b1547733c7.camel@redhat.com>
 <871ra9tvje.fsf@intel.com>
In-Reply-To: <871ra9tvje.fsf@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 May 2021 13:17:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VkwMjXz_vrMHOk1ZOx-gg5yq8cDbRWA-iXojUf+Ffddg@mail.gmail.com>
Message-ID: <CAD=FV=VkwMjXz_vrMHOk1ZOx-gg5yq8cDbRWA-iXojUf+Ffddg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drm/dp: Allow an early call to register DDC i2c bus
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@redhat.com>,
        Ville Syrjala <ville.syrjala@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 14, 2021 at 4:16 AM Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Fri, 07 May 2021, Lyude Paul <lyude@redhat.com> wrote:
> > On Fri, 2021-05-07 at 17:00 -0500, Bjorn Andersson wrote:
> >> On Fri 07 May 16:18 CDT 2021, Lyude Paul wrote:
> >>
> >> > Adding ville from Intel to also get their take on this.
> >> >
> >> > In general we've been trying to move DRM to a design where we don't expose
> >> > any
> >> > devices until everything is ready. That's pretty much the main reason that
> >> > we
> >> > register things during bridge attach time. Note though that even before
> >> > the
> >> > DDC bus is registered it should still be usable, just things like
> >> > get_device()
> >> > won't work.
> >> >
> >> > This isn't the first time we've run into a problem like the one you're
> >> > trying
> >> > to solve though, Tegra currently has a similar issue. Something we
> >> > discussed
> >> > as a possible long-term solution for this was splitting i2c_add_adapter()
> >> > into
> >> > a minimal initialization function and a registration function. Linux's
> >> > device
> >> > core already allows for this (device_initialize() and device_add(), which
> >> > are
> >> > called together when device_register() is called). Would this be a
> >> > solution
> >> > that might work for you (and even better, would you possibly be willing to
> >> > write the patches? :)
> >> >
> >>
> >> It's not enough that the adapter is half-baked, because the bridge's
> >> initialization depends on that the panel device is done probing, and the
> >> panel driver will only complete its probe if it can find it's resources.
> >>
> >> So we need a mechanism to fully create the resources exposed by the
> >> bridge chip (i2c bus, gpio chip and (soon) a pwm chip), then allow the
> >> panel to probe and after that initialize the bridge.
> >>
> >> We did discuss possible ways to register these resources and then
> >> "sleep for a while" before resolving the panel, but what we came up with
> >> was definitely suboptimal - and ugly.
> >
> > Sigh, I'm really starting to wonder if we should reconsider the rules on
> > exposing ddc adapters early...
> >
> > Danvet, Jani, and/or airlied: can I get your take on this?
>
> Granted, I did not study this in detail, but it sounds like we'd need to
> be able to add and use an i2c adapter in kernel, before deciding to
> register it with the userspace. But that does not seem to be as trivial
> as making it possible to call the now-static i2c_register_adapter()
> separately.

To close the loop: I think the point is now moot in v7. Now crossing
my fingers that approach can gain momentum. If not, I might come back
here. ;-)

-Doug
