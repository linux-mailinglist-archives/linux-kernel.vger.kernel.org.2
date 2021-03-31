Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB01434D511
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhC2Q0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhC2QZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:25:53 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65365C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:25:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id iu14so1155123qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jztd5AwJm/fvH4fWUcE2uu3MOmcPF16IqdUeZ0+QaXA=;
        b=KajWM90pu4syudeTTfZfPIslohQWrOxBbIFjv7IgjSIugY8agIwogQVVr+5ynnJDmh
         W8H74erJgaG1nfF8YWmLAzwAVoIdAOGgPFUmabr1o5Z6g2BzKM7BM3ymZ0JD/QoOgvI8
         f/6dhynoxw3VHSmbj60YkJB/e3ok7pwDEWJCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jztd5AwJm/fvH4fWUcE2uu3MOmcPF16IqdUeZ0+QaXA=;
        b=FuIPpndPF4WAC4r6M0RQMySuqVpRAZz+RhcJIfp4Q+wMWRD3HzXJETbyzcVfQODYBi
         QUFi1cBANjgNa7yt6qCLhTmOvfSBtI4ya2qrWCnqsYFkFKqJS0wk44G8nt+4+YtKNauP
         Jl1ZX8kD/Yyr9sI7h8lZPLzGKhgmzJKeqtFOw7pmJevajD0pdlqXZyDkM6XrTcEy2MSu
         cWwE9ZCDKeQvgU2t5gQcJ/2uEiaM7EiDyuXl3y+BsqT7YUSXpHfJ4QwkjanDXs/kQpte
         6lxSCUEHGLFVZtA5USn0GNvGX1wdinCFcVjVfnOEp0GQPJgXU98ksFH8bgufgX2NoIJy
         kDhQ==
X-Gm-Message-State: AOAM531QtxH9npRrsTJsFahBHDiuya9YaL5t5QQAVpl97hdwHDWPjgYu
        kVkclfR8M54fLc8EXd2lcqRxJGvVOQwMVw==
X-Google-Smtp-Source: ABdhPJwVdIsfz1B5erJd+hEvHhHz/QAT3r/9xVc/ey3abBQiKnfP1jkRJNo7vUZqsqMzj9+/6NKWuQ==
X-Received: by 2002:a05:6214:165:: with SMTP id y5mr25640114qvs.59.1617035138068;
        Mon, 29 Mar 2021 09:25:38 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id q15sm11047847qtx.47.2021.03.29.09.25.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 09:25:37 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id o66so14322053ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:25:36 -0700 (PDT)
X-Received: by 2002:a25:3741:: with SMTP id e62mr36095324yba.343.1617035136321;
 Mon, 29 Mar 2021 09:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
 <20210326000907.GA1965415@robh.at.kernel.org>
In-Reply-To: <20210326000907.GA1965415@robh.at.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Mar 2021 09:25:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XqG8oH5HCttKSNYJV2eHwLxq-tm1C+UFLn+cAHUrBaHg@mail.gmail.com>
Message-ID: <CAD=FV=XqG8oH5HCttKSNYJV2eHwLxq-tm1C+UFLn+cAHUrBaHg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: simple: Add the panel on sc7180-trogdor-pompom
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 25, 2021 at 5:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 02:08:19PM -0700, Douglas Anderson wrote:
> > The sc7180-trogdor-pompom board might be attached to any number of a
> > pile of eDP panels. At the moment I'm told that the list might include:
> > - KD KD116N21-30NV-A010
> > - KD KD116N09-30NH-A016
> > - Starry 2081116HHD028001-51D
> > - Sharp LQ116M1JW10
> >
> > It should be noted that while the EDID programmed in the first 3
> > panels indicates that they should run with exactly the same timing (to
> > keep things simple), the 4th panel not only needs different timing but
> > has a different resolution.
> >
> > As is true in general with eDP panels, we can figure out which panel
> > we have and all the info needed to drive its pixel clock by reading
> > the EDID. However, we can do this only after we've powered the panel
> > on. Powering on the panels requires following the timing diagram in
> > each panel's datasheet which specifies delays between certain
> > actions. This means that, while we can be quite dynamic about handling
> > things we can't just totally skip out on describing the panel like we
> > could do if it was connected to an external-facing DP port.
>
> Is this a 'standard' eDP connector? AFAICT, there does seem to be
> such a thing.

To answer this one: there's not any "standard" physical plug as far as
I can tell. There's a connector on the board side for the LCD that has
a whole hodgepodge of signals on it. Maybe USB for a camera. Some
power signals. Maybe a PWM for a backlight. Maybe some DMIC signals.
eDP signals which might be anywhere from 1 to 4 lanes. HPD (which is
really a "panel ready" signal for eDP). The size / style of connector
and the exact set of signals (and their ordering) is board specific.
You then get a board-specific cable that splits things out. Some might
go to a camera/MIC sub board. Some go to the panel and hook onto a
panel-specific connector which has pin count and orderings defined by
that panel. :-P


> I've said in the past I'd be okay with a edp-connector
> node. If that needs just the "HPD absent delay" property, I think that
> would be okay. It's just a never ending stream of new properties with
> each new panel that I don't want to see.

Thinking about this we'd need at least one other property right now
which is an enable delay. Specifically at least one panel I've
supported recently lied about HPD for a short period after bootup.
Specifically see commit 667d73d72f31 ("drm: panel: simple: Delay HPD
checking on boe_nv133fhm_n61 for 15 ms"). ...and, of course, the
existing power supply / enable signals that "simple-panel" already
has.

Also: if we weren't going to add the other delay properties in the
device tree, we'd have to add the code right away that used the EDID
to set other delays. That wouldn't be the end of the world, but it
would be code to write.


One last thought to add: I've looked at ~10 panels specs recently.
Though they are all a little different from each other, I will say
that almost every one of them seems to have the exact same timing
diagram in it just with different numbers filled in. To me that backs
up the idea that you can/should do the power sequence with a fairly
standard (parameterized) driver. I can't link the datasheets I have
but searching for "edp panel datasheet" finds me this random
datasheet:

https://www.data-modul.com/sites/default/files/products/NV156QUM-N72_specification_12039472.pdf

See "8.0 POWER SEQUENCE" in that document. All the panels have a
nearly identical diagram with different numbers filled in. You can
kinda tell it was copied from some other panel since some numbers
(like T4) aren't even defined.

-Doug
