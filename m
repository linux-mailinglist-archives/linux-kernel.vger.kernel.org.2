Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15740FB02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbhIQPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbhIQPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:04:14 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78765C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:02:52 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s20so3944510ioa.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=of3pzp6ngh1THhlWWwkrDWJfjHn4qZe44WtK5BBm5Bs=;
        b=hNjwfSyRvCw84sKueLQnIlHOzk7sD/liJnudOd0IhLnnowuPUDeyviQGmRg2x0dBZF
         ktS39oeyRZOPLccweWkyZsgR2ur6Tc3YXX7mef4Hm1CphYNd3LbIstIRtlTA24a4KDDy
         Dc1RFNJu6EJaMQfHJUsg7/WhCvieiw5QmwMmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=of3pzp6ngh1THhlWWwkrDWJfjHn4qZe44WtK5BBm5Bs=;
        b=z/VBlfFvjZQc+rmVfkK7UJWPUNkXT8zaJKsYOHuXxBMQMK5MaKfCChb44aqM79OOV4
         QHmcnone21SF44jToH3xqe4NZQKlfmw1J7b/BSIBv8zpV9idwl/EftR4zaevzCDPTOjv
         O75FJ3TzMUvWkxcPX8e0kQZaUHiaP0Ys6smn5PP2wT6kantKcuYfGkg57roY4iNqslXo
         KHtMJIxuDhbflg9/p/WRcRMXtobjxP5eCwBTkOom4bpuwGGCDf9KO7C9Ceb3i6kRUyw9
         gcRRtkeHWZg5zI4E+iF+z4rP0uvXIh5bMxXOdydh2q1LOXev9M+fJSggHcuaA8xp+Soz
         eqqA==
X-Gm-Message-State: AOAM531HP7ZP2ogpFHffBfYe8hmhDfQUD2fxplT+IlP7pKeY73Kdblqt
        oHOCopQZp8CgA+xOE1UZBn6vrUeuVCFJPA==
X-Google-Smtp-Source: ABdhPJzNdqOY0Srxiai9Xb4zrXtvQOFRcPNWS2aiuNGvAxZsLqIwl0PU+6JZH02CnOGIOHMlD6BAlw==
X-Received: by 2002:a6b:ea0f:: with SMTP id m15mr4591368ioc.165.1631890971584;
        Fri, 17 Sep 2021 08:02:51 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id r78sm221100iod.22.2021.09.17.08.02.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 08:02:51 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id s20so3944383ioa.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:02:50 -0700 (PDT)
X-Received: by 2002:a02:6d59:: with SMTP id e25mr9249829jaf.68.1631890969830;
 Fri, 17 Sep 2021 08:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid>
 <CAE-0n53BXh3_6jEW5oTbPA-V=MSaN=RvqaU8uoY9GNOm-0Pv_g@mail.gmail.com>
 <CAD=FV=WKQg-fU1jaSOh3RTa5HpSAiTzt2-Sycwt59uv1WemYxg@mail.gmail.com>
 <CAE-0n539tJLLWHdL65ZU_1qOzA-RsEqGqVi-19VLHz_W5dT6VA@mail.gmail.com>
 <CAD=FV=U_FX_Rg=h+w0yzpzi7fcUCg0Thn2_nXixsCRVsYFUGHQ@mail.gmail.com>
 <CAE-0n52F6j-qfA_h76BPyMRHi7hJzm6bX8eD5jS-C+ydz=vkBA@mail.gmail.com>
 <CAD=FV=XdN6SLZQ=kAe4S7Z7CjSrqnAQsj2uRiePXKFp07chVBg@mail.gmail.com> <CAE-0n52vqjGgdNMFBjW=7vo5B3wZcbnggpzQS05vb7Rr3dO8Vw@mail.gmail.com>
In-Reply-To: <CAE-0n52vqjGgdNMFBjW=7vo5B3wZcbnggpzQS05vb7Rr3dO8Vw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Sep 2021 08:02:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WPOvL5xK+nFtgcyH=99=pMFs2eogO0XTg=32Q4QOU+4g@mail.gmail.com>
Message-ID: <CAD=FV=WPOvL5xK+nFtgcyH=99=pMFs2eogO0XTg=32Q4QOU+4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: parade-ps8640: Use regmap APIs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 16, 2021 at 11:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > > > In the case of devm_regmap_init_i2c(), the driver could be fine but
> > > > you might be trying to instantiate it on a system whose i2c bus lacks
> > > > the needed functionality. That's not a bug in the bridge driver but an
> > > > error in system integration. Yeah, after bringup of the new system you
> > > > probably don't need the error, but it will be useful during people's
> > > > bringups year after year.
> > > >
> > >
> > > The point I'm trying to make is that these error messages in probe
> > > almost never get printed after the driver is brought up on the hardware
> > > that starts shipping out to non-kernel developers. Of course they happen
> > > when kernel devs are enabling new hardware year after year on the same
> > > tried and tested driver. They're worthwhile messages to have to make our
> > > lives easier at figuring out some misconfiguration, etc. The problem is
> > > they lead to bloat once the bringup/configuration phase is over.
> > >
> > > At one point we directed driver authors at dev_dbg() for these prints so
> > > that the strings would be removed from the kernel image if debugging
> > > wasn't enabled. It looks like dev_err_probe() goes in the opposite
> > > direction by printing an error message and passing the string to an
> > > exported function, so dev_dbg() won't reduce the image size. Ugh!
> >
> > So maybe the key here is that "CONFIG_PRINTK=n" is not the same as
> > "CONFIG_I_THINK_PROBE_ERRORS_ARE_BLOAT" and it's not just that one has
> > a more flippant name than the other. I think your argument about the
> > fact that these errors almost never come up in practice is actually
> > true for pretty much _all_ probe errors, isn't it? So if you wanted to
> > keep non-probe errors in your system (keep PRINTK=y) and just do away
> > with these bloat-y probe errors then dev_err_probe() could really be
> > the key and there'd be a big benefit for using for all these errors
> > during probe, not just ones that have a chance of deferring. ...and
> > yes, you could make this config do something fancy like do a stack
> > dump or print the return address if you actually hit one of these
> > errors once you've thrown away the string.
>
> Yes, but it's also just as important to push similar messages, i.e. "I
> failed to get some resource", into the API that hands resources out so
> that bloat is minimized further and drivers are kept simple.

Sure, but this is a slippery slope. If there's any chance that a
caller might want to know about the error but _not_ want the error
message printed then you can't push the error message into the API.
It's really hard to find error cases (even with "get resource" type
functions) where the caller _always_ wants the error reported. Even
kmalloc() has a nod to this with __GFP_NOWARN, though I'm not
advocating adding a "no warn" flag to all APIs. It's always possible
that the caller is expecting some types of errors and handles the case
elegantly.

Let's pop all the way back up to the original point here, which was
about devm_regmap_init_i2c(). What should happen with errors? Let's
look specifically at the errors that could be returned by
regmap_get_i2c_bus() which is the first thing devm_regmap_init_i2c()
tries to do. Those errors have to do with the i2c bus not supporting
the features needed by our regmap.


a) We could return the error without printing anything like the code does today.

No bloat, but during bringup of this bridge chip on a new i2c bus we'd
have to manually add printouts to the probe function to figure out
this error.


b) We could push error reporting into regmap_get_i2c_bus().

No per-driver bloat, but some drivers might have a legitimate reason
not to have an error print here. Perhaps they have a fallback `regmap`
config that they want to be able to use that works with different bus
capabilities. I don't think we can do this.


c) We could use dev_dbg() to print the error

Only bloat if dynamic debug or DEBUG is defined


d) We could use dev_err_probe() to print the error

Extra bloat, though it could be minimized (without sacrificing all
"printk") with a future patch to drop the string from dev_err_probe()
and perhaps replace it with a WARN_ON(). Also handles the fact that
perhaps someday someone might find a reason that regmap_get_i2c_bus()
and/or devm_regmap_init_i2c() should suddenly start returning
-EPROBE_DEFER.


I'm still advocating for "d)" above and I believe you originally
advocated for "a)" or "c)". It's really not such a huge deal, so if
you're adamant about "a)" then I'll shut up. I'm curious if I've
managed to convince you all about "d)" though.

-Doug
