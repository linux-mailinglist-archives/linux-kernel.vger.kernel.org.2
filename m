Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185F03EA826
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhHLQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhHLQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:00:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E135C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:00:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r72so9089767iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkJ9eY9sNpdQyMVe+0pcG6m3ooB5K5M6INJoQWT+o/s=;
        b=GjuNVqDaRiqBz4zyK3V+2n5ScpxGtvZN3wriHUi73F3HvZgp8MxBgFES6Be6wbG5m0
         GSxHwamV94HZmZTH8PfGJhxOIGpstPYtiq6pZsX0M7UqSaCCe1EiGRggq5unN6IQSwxU
         Jj9XsqDEaiovSVkXYaqxVSyDGOCN4INNyRZ3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkJ9eY9sNpdQyMVe+0pcG6m3ooB5K5M6INJoQWT+o/s=;
        b=j5pMZZ01njJTWGD4hV4JZJVX8zIhZ741+jDQvIA+0KByUhoLOxmUef4E81O095M0l9
         gDXEx8ZvxlXEiq535fWvR39ev7TmxN8kZzUayqWPqJ67XulcK9wIGFwyawO1SYyCXFKZ
         8XkZVyv/c12sniCWwH2KOs5u+D7OmfeRMCyjVM+W1D8VDSXw0K/FZJsc35l66uxEtaeR
         f4Db/n/yHmhnkqjDCR23/LIzMYxNkeAiVdANgQ0zc82enLtICuHtUSxBGK+gDzaMFI8n
         jCDSToJujvp1tuvOkYyfYGod/Rrvz2Oz4NOOx5hQZZJ7g+OhnyhIqYCjvhlae3tlYBKc
         smww==
X-Gm-Message-State: AOAM532uzYxDWpAmcB+KRyv9nvmNaOREbjcwzWaHvCJVOLiKttMsZNOY
        y+KxTynbZyxCMhiyA/+q5H3QcCm6UD7B9w==
X-Google-Smtp-Source: ABdhPJxsrYZvW+xFJX/70YvPrvDlH1T36md1qtR0dtvqf99DiBhoRPHPYL7/pXDXpTZ/jy3qb31alA==
X-Received: by 2002:a05:6638:95:: with SMTP id v21mr4478849jao.80.1628784029036;
        Thu, 12 Aug 2021 09:00:29 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id i2sm1535621iob.13.2021.08.12.09.00.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:00:27 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id a13so9053759iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:00:27 -0700 (PDT)
X-Received: by 2002:a05:6602:713:: with SMTP id f19mr3710787iox.140.1628784026906;
 Thu, 12 Aug 2021 09:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210730212625.3071831-1-dianders@chromium.org>
 <YQmp3mGpLW+ELxAC@ravnborg.org> <CAD=FV=XxOXJEgq7SiOVwSo2eWEbekQqutucFP=MmrrtmStXxog@mail.gmail.com>
 <YRTsFNTn/T8fLxyB@ravnborg.org>
In-Reply-To: <YRTsFNTn/T8fLxyB@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Aug 2021 09:00:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UiATFdiYbrAtinmu3BwO=XoOLaWBkypxRwm+GqfQEhyg@mail.gmail.com>
Message-ID: <CAD=FV=UiATFdiYbrAtinmu3BwO=XoOLaWBkypxRwm+GqfQEhyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] eDP: Support probing eDP panels dynamically
 instead of hardcoding
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 2:38 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Doug,
> On Mon, Aug 09, 2021 at 03:18:03PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Aug 3, 2021 at 1:41 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Douglas,
> > >
> > > On Fri, Jul 30, 2021 at 02:26:19PM -0700, Douglas Anderson wrote:
> > > > The goal of this patch series is to move away from hardcoding exact
> > > > eDP panels in device tree files. As discussed in the various patches
> > > > in this series (I'm not repeating everything here), most eDP panels
> > > > are 99% probable and we can get that last 1% by allowing two "power
> > > > up" delays to be specified in the device tree file and then using the
> > > > panel ID (found in the EDID) to look up additional power sequencing
> > > > delays for the panel.
> > >
> > > Have you considered a new driver for edp panels?
> > > panel-edp.c?
> > >
> > > There will be some duplicate code from pnale-simple - but the same can
> > > be said by the other panel drivers too.
> > > In the end I think it is better to separate them so we end up with two
> > > less complex panel drivers rather than one do-it-all panel driver.
> > >
> > > I have not looked in detail how this would look like, but my first
> > > impression is that we should split it out.
> >
> > I certainly could, but my argument against it is that really it's the
> > exact same set of eDP panels that would be supported by both drivers.
>
> The idea was to move all eDP panels to the new driver.
>
> My hope it that we can make panel-simple handle a more more narrow set
> of panels. eDP capable displays are IMO not simple panels.

Ah! OK, this makes sense. I can work on this, though it might be a
short while before I can. I think moving all eDP panels out of
panel-simple.c to something like panel-simple-edp.c makes sense. It
will be a patch that will be very hard to cherry-pick anywhere since
it will conflict with everything but it should be doable.


> Likewise DSI capable panels could also be pulled out of panel-simple.

At the moment I haven't done much with DSI panels so I might leave
them in panel-simple for now. I'll evaluate to see how nasty it would
be for me to try this.


> This would continue to duplicate some code - but we have a lot of
> duplicated code across the various panels and the best way forward
> would be to implement more helpers that can be used by the drivers.
>
>         Sam - who is trying to recover form the deadly man flu...

Feel better!

-Doug
