Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02D140F21E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbhIQGNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbhIQGNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:13:42 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A09C061767
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:12:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r26so12587967oij.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RXWpyIk8HPftITWmSDiVWoUK1d8/KTH7AvhCt8kSl/8=;
        b=BauSeOitD8SbRccHVJRu04wr96uzmSU31fT5KnEWpft10gn/8ooClV2lBMARroYXrE
         RT+/4jvCIUpx7RACk55ZfLeU0TsRG/lzJTzdhohRmiSwniQeN+c2wbap3eTsV1TMmpMr
         Rj1rEK5/kl1Cdr6Xov9QnMUw10lY++JyPnYYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RXWpyIk8HPftITWmSDiVWoUK1d8/KTH7AvhCt8kSl/8=;
        b=Vy28jLHN/pOxo1OLpk4Rz6KeIf+9f1hmh9lgAwn0sG+m2jjkS6j6rueDaQsubBnKr9
         CuDmR8XrcQOkrOpuGH76+HoM/NQxbiTqzLz65dkuy6LBv8BhzK7HwS67xF9ovXsNYUp9
         MTAvTZD9bwrHX6vAOEcGNbum5MuMWker98imSPbeq5OWRTsMua1ecHGNX1rre1/K217f
         /P8vb2r/VBtwLZ0kE3xKJRkqURPq1XKJLQsA/CvQihw1uqNSRCVS0Li7Rj+xRO4KZOZI
         0rylmFaM2bN7U6OajdBdLZW34T5/OTqGmJ7qGCf9Ha6shqV6vrTNtx1IkHLT2bKyjlvT
         rleQ==
X-Gm-Message-State: AOAM532JTgDg1PSv6pm6OzjzKyo+GdpxkiqbHvHs7aDqQRS7rNeRNdCR
        rQcjvxE47XwIKOygtW5j60vwu7IESA5FRdGkBVTo/w==
X-Google-Smtp-Source: ABdhPJztAsVH9l3VsP8hJ/glqcCjU0TkUf+DBg3Y+YLGnYQf4BTStcQU7brdNxMDEJWg1er5VtLH1xtj6eSrNBYwaPU=
X-Received: by 2002:a54:4419:: with SMTP id k25mr12299122oiw.32.1631859139507;
 Thu, 16 Sep 2021 23:12:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Sep 2021 23:12:19 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XdN6SLZQ=kAe4S7Z7CjSrqnAQsj2uRiePXKFp07chVBg@mail.gmail.com>
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid>
 <CAE-0n53BXh3_6jEW5oTbPA-V=MSaN=RvqaU8uoY9GNOm-0Pv_g@mail.gmail.com>
 <CAD=FV=WKQg-fU1jaSOh3RTa5HpSAiTzt2-Sycwt59uv1WemYxg@mail.gmail.com>
 <CAE-0n539tJLLWHdL65ZU_1qOzA-RsEqGqVi-19VLHz_W5dT6VA@mail.gmail.com>
 <CAD=FV=U_FX_Rg=h+w0yzpzi7fcUCg0Thn2_nXixsCRVsYFUGHQ@mail.gmail.com>
 <CAE-0n52F6j-qfA_h76BPyMRHi7hJzm6bX8eD5jS-C+ydz=vkBA@mail.gmail.com> <CAD=FV=XdN6SLZQ=kAe4S7Z7CjSrqnAQsj2uRiePXKFp07chVBg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 16 Sep 2021 23:12:18 -0700
Message-ID: <CAE-0n52vqjGgdNMFBjW=7vo5B3wZcbnggpzQS05vb7Rr3dO8Vw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: parade-ps8640: Use regmap APIs
To:     Doug Anderson <dianders@chromium.org>
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

Quoting Doug Anderson (2021-09-16 16:21:12)
> Hi,
>
> On Thu, Sep 16, 2021 at 3:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > TL;DR: Please try to reduce these error messages in drivers and
> > consolidate them into subsystems so that drivers stay simple.
> >
> > Quoting Doug Anderson (2021-09-15 09:41:39)
> > > Hi,
> > >
> > > On Tue, Sep 14, 2021 at 7:50 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > >
> > > > I'd rather see any sort of error message in getter APIs be pushed into
> > > > the callee so that we reduce the text size of the kernel by having one
> > > > message instead of hundreds/thousands about "failure to get something".
> > > > As far as I can tell this API is designed to skip printing anything when
> > > > EPROBE_DEFER is returned, and only print something when it isn't that
> > > > particular error code. The other benefit of this API is it sets the
> > > > deferred reason in debugfs which is nice to know why some device failed
> > > > to probe. Of course now with fw_devlink that almost never triggers so
> > > > the feature is becoming useless.
> > >
> > > I guess we need to split this apart into two issues. One (1) is
> > > whether we should be printing errors like this in probe() and the
> > > other (2) is the use of dev_err_probe() for cases where err could
> > > never be -EPROBE_DEFER.
> > >
> > > So the argument about reducing the text size for thousands of slightly
> > > different errors is all about (1), right? In other words, you'd be
> > > equally opposed to a change that added a normal error print with
> > > dev_err(), right? IMO, this is a fair debate to have and it comes down
> > > to a choice that has pros and cons. Yes the error messages are not
> > > needed in the normal case and yes they bloat the kernel size, but when
> > > something inevitably goes wrong then you have a way to track it down
> > > instead of trying to guess or having to recompile the code to add
> > > prints everywhere. Often this can give you a quick clue about a
> > > missing Kconfig or a wrongly coded device tree file without tons of
> > > time adding prints and recompiling code. That seems like it's worth
> > > something...
> >
> > Agreed. dev_err_probe() does that by putting that into the deferred
> > reason debugfs file. I'm saying that drivers shouldn't really be using
> > this API unless they're doing something exotic. The subsystems that are
> > implementing the 'get' operation that may defer should use this function
> > and then drivers should just return the error value to driver core so
> > that we can consolidate error messages and shrink the kernel size.
> >
> > Maybe we can look for the defer reason in call_driver_probe() and print
> > a warning message if the string is set. Right now -EPROBE_DEFER is
> > handled but it's a dev_dbg() print that probably nobody enables and it
> > doesn't print the reason string.
>
> Actually, in recent versions of the kernel it stashes the reason too.
> I think there's a debugfs file "devices_deferred"

Yep that's what I meant by "putting that into the deferred reason
debugfs file" above.

> > This seems to imply that it's all about EPROBE_DEFER. I'm just
> > reconstructing what I read from kernel-doc. If the intent is to use it
> > outside of probe defer, then please update the documentation to
> > alleviate confusion.
>
> Meh. Yeah, it talks a lot about -EPROBE_DEFER, but it doesn't say it's
> only for that.
>
> Sure, I'll post a patch.
>
> https://lore.kernel.org/r/20210916161931.1.I32bea713bd6c6fb419a24da73686145742b6c117@changeid

Cool thanks.

>
>
> > > In the case of devm_regmap_init_i2c(), the driver could be fine but
> > > you might be trying to instantiate it on a system whose i2c bus lacks
> > > the needed functionality. That's not a bug in the bridge driver but an
> > > error in system integration. Yeah, after bringup of the new system you
> > > probably don't need the error, but it will be useful during people's
> > > bringups year after year.
> > >
> >
> > The point I'm trying to make is that these error messages in probe
> > almost never get printed after the driver is brought up on the hardware
> > that starts shipping out to non-kernel developers. Of course they happen
> > when kernel devs are enabling new hardware year after year on the same
> > tried and tested driver. They're worthwhile messages to have to make our
> > lives easier at figuring out some misconfiguration, etc. The problem is
> > they lead to bloat once the bringup/configuration phase is over.
> >
> > At one point we directed driver authors at dev_dbg() for these prints so
> > that the strings would be removed from the kernel image if debugging
> > wasn't enabled. It looks like dev_err_probe() goes in the opposite
> > direction by printing an error message and passing the string to an
> > exported function, so dev_dbg() won't reduce the image size. Ugh!
>
> So maybe the key here is that "CONFIG_PRINTK=n" is not the same as
> "CONFIG_I_THINK_PROBE_ERRORS_ARE_BLOAT" and it's not just that one has
> a more flippant name than the other. I think your argument about the
> fact that these errors almost never come up in practice is actually
> true for pretty much _all_ probe errors, isn't it? So if you wanted to
> keep non-probe errors in your system (keep PRINTK=y) and just do away
> with these bloat-y probe errors then dev_err_probe() could really be
> the key and there'd be a big benefit for using for all these errors
> during probe, not just ones that have a chance of deferring. ...and
> yes, you could make this config do something fancy like do a stack
> dump or print the return address if you actually hit one of these
> errors once you've thrown away the string.

Yes, but it's also just as important to push similar messages, i.e. "I
failed to get some resource", into the API that hands resources out so
that bloat is minimized further and drivers are kept simple.

>
> I also wouldn't necessarily agree that dev_dbg() was an amazing fit
> for these error messages. They truly were error-level things that were
> happening. These are things that are causing the probe to abort, not
> just extra spammy debug info. Calling them "error" messages rather
> than "debug" messages seems better...
>

Agreed. When all we had was dev_dbg() it was the best option to getting
rid of these types of driver development printks.
