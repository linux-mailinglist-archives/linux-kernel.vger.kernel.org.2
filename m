Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8695733680E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhCJXrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhCJXra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:47:30 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22712C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:47:30 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l14so11767950qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LW3ygLOJO4TeqznHJVAd2FSG2faQIgInXSeqKmxiPtM=;
        b=TPKH47gasYhLVZ3uiNyUFA5axyHpDZgCgeGZitPXEivZqj8E6ox2FrazEllNWC4sfA
         lztfY1z4luH7jYDCGt5hJ7vKJMrPvHqocLway7sTmuYduAWaA0pU3RK4OoLawl0wN62K
         XlZfY0nHdOqXZkE+WbZsRRTp3X8HfXM0uyHPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LW3ygLOJO4TeqznHJVAd2FSG2faQIgInXSeqKmxiPtM=;
        b=oVSMUr4ls9AGbid7U5UNw7+WDQl5OMVKkX5fGzGok/9a/1vRYoA9VnBwUWU4NggXcz
         oAUdcSEnFmmYCRebnESJzXOPq8Sz/OHSUnuHmQGynau33GIF31hI17Uu3DGPqiGdsz1w
         54iGBrM2ncKjKQGIA7Wj+jaWf2yNS7LR9N39e8jk/nSbnPMUHzuDOmRJwz3xsLxkJ/72
         +SgnlukvhyTSwXD/mvEX2kAXeteCGOXvCOrV+yfwyYwXH0FAv9lPUIYGwo3brpFEeWft
         yM1dDKtO65/PLNdbXOUBMl5WKizUp8Ca0hFB0uOgPlkEAIjjW7fhy3tn84WEgyQoAW26
         HuFg==
X-Gm-Message-State: AOAM5306j3nK/nI4WgnUNGeE/fhq8fRHV8tOQ0CCFBoa7Ps6LlO8wKjB
        yI98xKNtWZA8+Rmk+RZCn5JVHsKTcoPpXg==
X-Google-Smtp-Source: ABdhPJxDH0zXIrfJRtnOaIAAjIVw9WtXBCvciRPu+NibBoWvS3uFIO259/fEY+LU/vxaTVUBujOGgQ==
X-Received: by 2002:ac8:6708:: with SMTP id e8mr5121078qtp.261.1615420048647;
        Wed, 10 Mar 2021 15:47:28 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id j6sm725519qkm.81.2021.03.10.15.47.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 15:47:27 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id u3so19790060ybk.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:47:27 -0800 (PST)
X-Received: by 2002:a25:aa43:: with SMTP id s61mr8352296ybi.32.1615420046847;
 Wed, 10 Mar 2021 15:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org> <CACRpkdYUs2W3b_u8YrmYwq_kcUCf0DhZ-o2o6O2EmU5rdtv=BA@mail.gmail.com>
In-Reply-To: <CACRpkdYUs2W3b_u8YrmYwq_kcUCf0DhZ-o2o6O2EmU5rdtv=BA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Mar 2021 15:47:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WDVAj+OcVXaTJRUu8tvdDzySW0KOfiGqZHi5YvP42BTA@mail.gmail.com>
Message-ID: <CAD=FV=WDVAj+OcVXaTJRUu8tvdDzySW0KOfiGqZHi5YvP42BTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 10, 2021 at 3:25 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jan 15, 2021 at 11:44 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> > - ("drm/panel-simple: Don't wait longer for HPD...") new for v2.
> > - ("drm/panel-simple: Retry if we timeout waiting for HPD") new for v2.
>
> I couldn't find these patches in my inbox

Doh! Sorry about that. I think get_maintainer tagged you only on the
patches that had the explicit "fixes" in them on something you were
involved in. I tend to rely on get_maintainer heavily unless I think
someone is particularly interested in the whole series. I will make
sure to CC you on the whole series if I post it again. In the meantime
the whole series is on lore:

https://lore.kernel.org/lkml/20210115224420.1635017-1-dianders@chromium.org/

> but my concern would
> be that at some point panel-simple will turn from simple into
> panel-rube-goldberg-machine.

Yes, it's definitely something to watch out for. I guess you're
commenting on the general number of changes I've made to simple-panel
in the last year or two? I guess my comment on those:

* Many of the changes I made were around HPD handling and supporting a
GPIO (and also supporting the "hpd absent delay"). The fact that we
use a GPIO for HPD is actually an attribute of our board design,
though, so if I had forked panel drivers for each of the panels that
needed it then it would have required copying the code lots of places
(or implementing some code sharing). I was specifically asked to do
the HPD handling code at the panel layer.

* The other big change I made recently was around allowing for
relative rather than absolute timings (instead of a fixed delay at a
given stage adding a constraint that enough time had passed since a
previous event). When I proposed that the feedback I got back was that
it was a good improvement for all panels and something that had been
on a TODO list for a while.

...so while it feels like I keep piling crap onto simple-panel, I
_think_ they've been good general improvements that many people will
be able to benefit from and I don't think they've uglified things
lots.

> Given that the talk with the manufacturer may result
> in even more quirks... maybe this should just be a separate
> panel driver?

I don't _think_ this will end up with more quirks. At least I sure
hope not. So far it seems like pure luck that I even noticed it
because only one other device in the whole batch produced had similar
problems. That leads me to believe that there could be other panels
with a similar need.

> (I expect pushback because I see how handy it is, but
> I am the guy writing new panel drivers all the time rather than
> using simple.)

I guess what I'd say in summary is:

* If you object to the retries in simple panel, I still hope the rest
of the series can land.

* If somehow this panel gets out into real users hands and we find
that the retries are necessary and people still don't want the retries
in simple panel, I can fork a special panel driver just for it then.

-Doug
