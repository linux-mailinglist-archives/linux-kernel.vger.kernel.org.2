Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CDF3502AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhCaOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbhCaOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:48:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:48:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s2so14570052qtx.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lwR7HXndtvl1w7O6ZpDHif+FQe2GlWLZc8UMd7kr0w=;
        b=Q5gB522Cib9/yr2J2bN+e8A1FXsZWvmP2Me2QWawupdm+sCa3WkCW71rbPYdbEelXU
         o3S3qH2G76n8cjtY2HV8faFVosUovgnrTf1IBz9Xn5ajC7Jm8KubPmM93fU+T3oL7RwE
         5BrtIGKHxKZdSxirTzZE+F8UgLfdOrkDS6KjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lwR7HXndtvl1w7O6ZpDHif+FQe2GlWLZc8UMd7kr0w=;
        b=oKh0a2ysltA8mH/kJFWBm7wVUYJdQDvY0JdhCwzMclOdO2LywltxIv+dwpiknd47Dq
         j6doDE4VfUYQZYh0LFKj+a2Ob4RiNPghg9u4KSOUXsKHO+qMK7Z26nAHhEnovQeraqBI
         mtCFUu8oYN646qu3mQ4fAEe77YCLU0UVgU1GTTSptzUBOu3UzU2nolA+5t1Om1DQSwFc
         4+uzVDrQxIeiUrPBk1ilMOr9NYvwPIiDsmYw5/iOit44A+5bVB2O/koV5OHigvxJPsPB
         gZ15dvWw9ZRHs8yHHA+QN9khcvfoxqAhLMH2clsOi+PXiVRXBszwlxInCmJaLgJztnqZ
         oaAw==
X-Gm-Message-State: AOAM533T/UPvRsZmgXhieK5gZQmitqg/oHU1Dqatt6+wSNNxnZxO/3ND
        +Ebfbz11jc8LsZRD/0bU/f4snEd6BOEJFA==
X-Google-Smtp-Source: ABdhPJxxaEvoT5yUyIog/tkofWceM81Hb36E6SXjaZFZPLDg9PSu56iRq1Ch4dCD2aKJlNmGIDW6eA==
X-Received: by 2002:ac8:57c4:: with SMTP id w4mr2618339qta.281.1617202098701;
        Wed, 31 Mar 2021 07:48:18 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id e14sm1417339qte.78.2021.03.31.07.48.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 07:48:17 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id o66so21417823ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:48:17 -0700 (PDT)
X-Received: by 2002:a25:2f4b:: with SMTP id v72mr4829154ybv.79.1617202097234;
 Wed, 31 Mar 2021 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210330025345.3980086-1-dianders@chromium.org>
 <CGME20210330025435eucas1p12b96966451ee0691f6d5d99b64ac2c8b@eucas1p1.samsung.com>
 <20210329195255.v2.11.Ied721dc895156046ac523baa55a71da241cd09c7@changeid> <8887ded7-d1ab-844c-e3a3-f39f6ef6264a@samsung.com>
In-Reply-To: <8887ded7-d1ab-844c-e3a3-f39f6ef6264a@samsung.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 07:48:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJ5qtMDn5B431ObPS0JU3-P3755N7jzLZbbcc6XpqYtg@mail.gmail.com>
Message-ID: <CAD=FV=XJ5qtMDn5B431ObPS0JU3-P3755N7jzLZbbcc6XpqYtg@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] drm/bridge: ti-sn65dsi86: Power things properly
 for reading the EDID
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 4:08 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> W dniu 30.03.2021 o 04:53, Douglas Anderson pisze:
> > eDP panels won't provide their EDID unless they're powered on. Let's
> > chain a power-on before we read the EDID. This roughly matches what
> > was done in 'parade-ps8640.c'.
> >
> > NOTE: The old code attempted to call pm_runtime_get_sync() before
> > reading the EDID. While that was enough to power the bridge chip on,
> > it wasn't enough to talk to the panel for two reasons:
> > 1. Since we never ran the bridge chip's pre-enable then we never set
> >     the bit to ignore HPD. This meant the bridge chip didn't even _try_
> >     to go out on the bus and communicate with the panel.
> > 2. Even if we fixed things to ignore HPD, the EDID still wouldn't read
> >     if the panel wasn't on.
> >
> > One thing that's a bit odd here is taking advantage of the EDID that
> > the core might have cached for us. See the patch ("drm/edid: Use the
> > cached EDID in drm_get_edid() if eDP"). We manage to get at the cache
> > by:
> > - Instantly failing aux transfers if we're not powered.
> > - If the first read of the EDID fails we try again after powering.
> >
> > Fixes: 58074b08c04a ("drm/bridge: ti-sn65dsi86: Read EDID blob over DDC")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Depending on what people think of the other patches in this series,
> > some of this could change.
> > - If everyone loves the "runtime PM" in the panel driver then we
> >    could, in theory, put the pre-enable chaining straight in the "aux
> >    transfer" function.
> > - If everyone hates the EDID cache moving to the core then we can
> >    avoid some of the awkward flow of things and keep the EDID cache in
> >    the sn65dsi86 driver.
>
>
> I wonder if this shouldn't be solved in the core - ie caller of
> get_modes callback should be responsible for powering up the pipeline,
> otherwise we need to repeat this stuff in every bridge/panel driver.
>
> Any thoughts?

Yeah, I did look at this a little bit. Presumably it would only make
sense to do it for eDP connections since:

a) The concept of reading an EDID doesn't make sense for things like MIPI.

b) For something with an external connector (DP and HDMI) you don't
even know they're inserted unless the EDID is ready to read (these
devices are, essentially, always powered).

So I started off trying to do this in the core for eDP, but then it
wasn't completely clear how to write this code in a way that was super
generic. Specifically:

1. I don't think it's a 100% guarantee that everything is powered on
in pre-enable and powered off in post-disable. In this bridge chip
it's true, but maybe not every eDP driver? Would you want me to just
assume this, or add a flag?

2. It wasn't totally clear to me which state to use for telling if the
bridge had already been pre-enabled so I could avoid double-calling
it. I could dig more if need be but I spent a bit of time looking and
was coming up empty. If you have advice I'd appreciate it, though.

3. It wasn't clear to me if I should be using the atomic version
(drm_atomic_bridge_chain_pre_enable) if I put this in the core and how
exactly to do this, though I am a self-admitted DRM noob. I can do
more digging if need be. Again, advice is appreciated.

4. Since I got feedback that the EDID caching belongs in the driver,
not in the core [1] then we might end up powering things up
pointlessly since the core wouldn't know if the driver was going to
return the cache or not.

Given that this patch isn't too much code and not too complicated (and
will be even less complicated if I move the EDID caching back into the
driver), maybe we can land it and if we see the pattern repeat a bunch
more times then think about moving it to the core?


[1] https://lore.kernel.org/dri-devel/YGMvO3PNDCiBmqov@intel.com/

-Doug
