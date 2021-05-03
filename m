Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F64371E10
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhECRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbhECRHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:07:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B375C061763
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 09:55:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso5639606otb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTaPZJJAb+agZFdITzeXOjZnWTBVRqn0ZvSBSvsqyj8=;
        b=KPPMi8esPiixHTvAdzjM1N0qW/guYzs1KzH9fDZI4345Xh0a+0njo5pRHf/sVYbNfp
         PabktArLEDIdcVFhAkDgyadtRbNJDn4dafcTG2RtZl+LsjdNdxrriJeg5Ss619IEeUSn
         rzhLOppLZScRfHHm9uhyiGH4PoNuoziso7orE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTaPZJJAb+agZFdITzeXOjZnWTBVRqn0ZvSBSvsqyj8=;
        b=RHcU6+v4NVniDk6d7T43HZm20pycv4/jOeHrt1lr6gg+OWZzscyQcHYwIisLuwJzRd
         ZAks2o2z4/w/gEjD3J5V7UNv8ZcViZUGXkyJ3AM1Wiy5IChVevaMbNIsOulh8UPuwYRw
         5eK4sAbME03irie0EVE3cSyDk0uRABsXFZA9+lomRVFl1e+fcuhi8eJ+9skt/ZQjQSXe
         xgBixMUlaV2W+su/BBSd6ewAKWf3klfK62JdzxuVxi4mZ05QNK3R5sK5ReoUqGZI5UXL
         WE5gFgUhC+Fq1p7/MwUD1GGG1Ad5ar3hphO6jDy8/HIYM8vGyDDfBCx5l0Yd5HmOSlNt
         4w0g==
X-Gm-Message-State: AOAM533BrWzdiEi6QIF3M6pzjI9mU9EfpG0fTTKPwNdKSJjxYxCjYtZ6
        MhthZsj6ANus5Uvu2F1/KQ6t6mTJYStyvg==
X-Google-Smtp-Source: ABdhPJwhYhd04c3ibVW1areY7p1mhE+WFKOLLkUoz12mwU2Z5w+CvdOGHdiIOva1/O5MN+iIEEviSQ==
X-Received: by 2002:a9d:7e91:: with SMTP id m17mr15481404otp.192.1620060944406;
        Mon, 03 May 2021 09:55:44 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id w85sm77754oif.42.2021.05.03.09.55.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 09:55:44 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso5674063otv.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 09:55:44 -0700 (PDT)
X-Received: by 2002:a25:d9ce:: with SMTP id q197mr15755336ybg.276.1620060932851;
 Mon, 03 May 2021 09:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210423165906.2504169-1-dianders@chromium.org>
 <20210423095743.v5.9.I3e68fa38c4ccbdbdf145cad2b01e83a1e5eac302@changeid> <CACRpkdbZxauBFLvR_MMx4WD+K6DftK19Fivt_mkE=+Xr2EPUvQ@mail.gmail.com>
In-Reply-To: <CACRpkdbZxauBFLvR_MMx4WD+K6DftK19Fivt_mkE=+Xr2EPUvQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 May 2021 09:55:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGYHNasnqaFopUnuZNaBn+Nbf4+ak7vUoERaA8pRBTsw@mail.gmail.com>
Message-ID: <CAD=FV=XGYHNasnqaFopUnuZNaBn+Nbf4+ak7vUoERaA8pRBTsw@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] drm/bridge: ti-sn65dsi86: Break GPIO and
 MIPI-to-eDP bridge into sub-drivers
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 1, 2021 at 4:59 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Apr 23, 2021 at 6:59 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> > Let's use the newly minted aux bus to break up the driver into sub
> > drivers. We're not doing a full breakup here: all the code is still in
> > the same file and remains largely untouched. The big goal here of
> > using sub-drivers is to allow part of our code to finish probing even
> > if some other code needs to defer. This can solve some chicken-and-egg
> > problems. Specifically:
> > - In commit 48834e6084f1 ("drm/panel-simple: Support hpd-gpios for
> >   delaying prepare()") we had to add a bit of a hack to simpel-panel
> >   to support HPD showing up late. We can get rid of that hack now
> >   since the GPIO part of our driver can finish probing early.
> > - We have a desire to expose our DDC bus to simple-panel (and perhaps
> >   to a backlight driver?). That will end up with the same
> >   chicken-and-egg problem. A future patch to move this to a sub-driver
> >   will fix it.
> > - If/when we support the PWM functionality present in the bridge chip
> >   for a backlight we'll end up with another chicken-and-egg
> >   problem. If we allow the PWM to be a sub-driver too then it solves
> >   this problem.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Fix module compile problems (Bjorn + kbuild bot)
> > - Remove useless MODULE_DEVICE_TABLE (Bjorn).
>
> This is generally a good idea. I have no idea when to use
> auxbus or MFD

It was a bit hard for me to figure out too. I think historically this
could have been implemented by MFD but I believe that the point of
introducing the AUX bus was that MFD wasn't a great fit for things
like this. It's talked about a bit in
"Documentation/driver-api/auxiliary_bus.rst". For me the important
thing here is that we think of the bridge chip as one device, not a
collection of IP blocks glued together in one package. As some
evidence, the DT bindings don't have sub-nodes for this. There's a
single DT node that says that this one device is the bridge, is a GPIO
controller, and can provide a PWM.


> but I trust that you researched that so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks! I'll land it then to whittle the patch stack down to just the
controversial EDID one.

-Doug
