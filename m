Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9113040CADE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhIOQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhIOQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:43:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766BFC0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:41:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id r18so2247059qvy.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjpBgJ5HfO+4BrgdAu5b88x18vTZeJi+0175gTo291k=;
        b=TcSDXTiIwo3qfC7Iqb4wt8GaDIj+NGvTOnIJaDmlIOorZv2N3WNJdEtyPnp5iubGK8
         3a4hhj99GhIym/Ypf20Ol/NDlcuoMb11sNUg3Hqd+X5JnhWVP+NcSEV8g9yh3xYJXc+U
         Wx50EQkdG/jg+AOpJHyc9QLporFjfdaNYCkgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjpBgJ5HfO+4BrgdAu5b88x18vTZeJi+0175gTo291k=;
        b=dZ9u8t1YRuLrLdamNYsalfuQTXBiypCfSywUnlOgDFLEN57R4QFxEMEs6T+1YG6T3D
         /cTIBboUatsJLhRr8amA0YPsGF7DE44o65HVex19PNZF0ar4X++jd1GF5JjThy5mHklq
         FftBUgZEu8u+OQw3Jcn3W0MvPjq6Muc7x0K5qB2rVsGOdblf7wmCFd3PiEGP4XbEmT76
         RSV7qo4k+YQs7csy9CjBHvagemiWaDcktBrwty+DqPUnmyTS1kV3Lk1qh57jgtVHv3ka
         cdIG2079YVgY57R42sLmrKkZXuQiqCqPxTz+tFYA/gyQd//B/avSz/nEhsavt79FRLpB
         AUHw==
X-Gm-Message-State: AOAM532E/UelEd1HkggcN/lOl+rdtWErefaL7mhxCn5oGBWN6V3F+cU1
        zJjCNF2+QPMWrmsJXzXeUoVrueX1kekF1Q==
X-Google-Smtp-Source: ABdhPJzF442q11pxeoKVfGFqygnMbPh1RlvEhT0W0q7gSew3uOP5GeV4UXnRMcft+IZjsGiE+B+3DA==
X-Received: by 2002:a05:6214:146d:: with SMTP id c13mr854147qvy.46.1631724116081;
        Wed, 15 Sep 2021 09:41:56 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id j2sm318808qtr.4.2021.09.15.09.41.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:41:55 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id a93so7038989ybi.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:41:55 -0700 (PDT)
X-Received: by 2002:a5b:f4b:: with SMTP id y11mr1117041ybr.352.1631724114813;
 Wed, 15 Sep 2021 09:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid>
 <CAE-0n53BXh3_6jEW5oTbPA-V=MSaN=RvqaU8uoY9GNOm-0Pv_g@mail.gmail.com>
 <CAD=FV=WKQg-fU1jaSOh3RTa5HpSAiTzt2-Sycwt59uv1WemYxg@mail.gmail.com> <CAE-0n539tJLLWHdL65ZU_1qOzA-RsEqGqVi-19VLHz_W5dT6VA@mail.gmail.com>
In-Reply-To: <CAE-0n539tJLLWHdL65ZU_1qOzA-RsEqGqVi-19VLHz_W5dT6VA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Sep 2021 09:41:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_FX_Rg=h+w0yzpzi7fcUCg0Thn2_nXixsCRVsYFUGHQ@mail.gmail.com>
Message-ID: <CAD=FV=U_FX_Rg=h+w0yzpzi7fcUCg0Thn2_nXixsCRVsYFUGHQ@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 7:50 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2021-09-14 19:17:03)
> > Hi,
> >
> > On Tue, Sep 14, 2021 at 5:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Philip Chen (2021-09-14 16:28:44)
> > > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > index e340af381e05..8d3e7a147170 100644
> > > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > @@ -368,6 +396,12 @@ static int ps8640_probe(struct i2c_client *client)
> > > >
> > > >         ps_bridge->page[PAGE0_DP_CNTL] = client;
> > > >
> > > > +       ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
> > > > +       if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL])) {
> > > > +               return dev_err_probe(dev, PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]),
> > > > +                                    "Error initting page 0 regmap\n");
> > >
> > > This one also doesn't return -EPROBE_DEFER? The dev_err_probe() should
> > > really only be used on "get" style APIs that can defer.
> >
> > Any reason why you say that dev_err_probe() should only be used on
> > "get" style APIs that can defer? Even if an API can't return
> > -EPROBE_DEFER, using dev_err_probe() still (IMO) makes the code
> > cleaner and should be used for any error cases like this during probe.
> > Why?
> >
> > * It shows the error code in a standard way for you.
> > * It returns the error code you passed it so you can make your error
> > return "one line" instead of 2.
>
> I'd rather see any sort of error message in getter APIs be pushed into
> the callee so that we reduce the text size of the kernel by having one
> message instead of hundreds/thousands about "failure to get something".
> As far as I can tell this API is designed to skip printing anything when
> EPROBE_DEFER is returned, and only print something when it isn't that
> particular error code. The other benefit of this API is it sets the
> deferred reason in debugfs which is nice to know why some device failed
> to probe. Of course now with fw_devlink that almost never triggers so
> the feature is becoming useless.

I guess we need to split this apart into two issues. One (1) is
whether we should be printing errors like this in probe() and the
other (2) is the use of dev_err_probe() for cases where err could
never be -EPROBE_DEFER.

So the argument about reducing the text size for thousands of slightly
different errors is all about (1), right? In other words, you'd be
equally opposed to a change that added a normal error print with
dev_err(), right? IMO, this is a fair debate to have and it comes down
to a choice that has pros and cons. Yes the error messages are not
needed in the normal case and yes they bloat the kernel size, but when
something inevitably goes wrong then you have a way to track it down
instead of trying to guess or having to recompile the code to add
prints everywhere. Often this can give you a quick clue about a
missing Kconfig or a wrongly coded device tree file without tons of
time adding prints and recompiling code. That seems like it's worth
something...

One could also make the argument that if you don't care about all
these similar errors bloating the text segment that it would be pretty
easy to create a new Kconfig: "CONFIG_I_THINK_PROBE_ERRORS_ARE_BLOAT".
If that config is set then it could throw away the strings for every
dev_err_probe() that you compile in.


I'm not so convinced about the argument (2) that dev_err_probe()
should only be used if the error code could be -EPROBE_DEFER. Compare
these two:

Old:
  ret = do_something_that_cant_defer();
  if (ret < 0) {
    dev_err(dev, "The foo failed to bar (%pe)\n", ERR_PTR(ret));
    return ret;
  }

New:
  ret = do_something_that_cant_defer();
  if (ret < 0)
    return dev_err_probe(dev, ret, "The foo failed to bar\n");

It seems clear to me that the "New" case is better. The error code is
printed in a consistent fashion compared to all other error prints and
the fact that it returns the error code makes it cleaner. It's fine
that the error could never be -EPROBE_DEFER. Certainly we could add a
new function called dev_err_with_code() that worked exactly like
dev_err_probe() except that it didn't have special logic for
-EPROBE_DEFER but why?

Also note that the current function is dev_err_probe(), not
dev_err_might_defer(). By the name, it should be useful / OK to use
for any errors that come up in the probe path.


> > Is there some bad thing about dev_err_probe() that makes it
> > problematic to use? If not then the above advantages should be a net
> > win, right?
> >
>
> I view it as an anti-pattern. We should strive for driver probe to be
> fairly simple so that it's basically getting resources and registering
> with frameworks. The error messages in probe may help when you're trying
> to get the driver to work and the resource APIs don't make any sense but
> after that it's basically debug messages hiding as error messages.
> They're never supposed to happen in practice, because the code is
> tested, right?

IMO they happen even after initial driver bringup. You can trip error
cases from device tree problems and config problems pretty easily. It
could also be that you're bringing up an old / tested / tried and true
driver but on new hardware where some other thing (clock, regulators,
etc) is returning an error. Being able to track these down easily can
justify the error messages long term.

...or maybe what you're saying is that if it's clear that the only
case that an error could be returned is due to a driver error then we
should skip the error message? I guess, so, but only if it's somehow
built-in to the concept of the function that the only error case is a
driver error. Otherwise the function may change to check for more
errors in the future and you're back to where you started with.

In the case of devm_regmap_init_i2c(), the driver could be fine but
you might be trying to instantiate it on a system whose i2c bus lacks
the needed functionality. That's not a bug in the bridge driver but an
error in system integration. Yeah, after bringup of the new system you
probably don't need the error, but it will be useful during people's
bringups year after year.


-Doug
