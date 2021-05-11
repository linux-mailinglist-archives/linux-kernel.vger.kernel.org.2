Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1F37ACFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhEKRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEKRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:20:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:19:11 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso18184007ote.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=go1LaTn+JyfnNbXmuN0CCBxYpt4cKSlPmbuS0BOCjb0=;
        b=J4uvkzvTwPOWZm01x9dBVdARTF4FC3M1Fw6NLUa6fADbc8UGlRb0heggAbMVyzPnw0
         Jv2YMdvUjfg2VbwFHUh0HuQcDmhwyZZvNh2qFFVvKZSiLPl7xweJwXBUGHhRhHOjoY2u
         fHsKABo0FF/V0f5rzvMwCPePdU/bmXJEgfYuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=go1LaTn+JyfnNbXmuN0CCBxYpt4cKSlPmbuS0BOCjb0=;
        b=rmSI2Cn+s3h8hPr38nqI/4hbD7j5z8lQpPJe/90t9Hy4VwBcuihDH//4KB6EK3jrsG
         Afsg6Umv3ZbWZTGHY+XHSXwpu299YNI2bpSKmvNXYnAfnv0szrKMFmgbVcbOaUzeMC6k
         O2dK8gnfvLNOvhp/dQiktgNUMiq6r6q3/+c5JZCCWDbsmbbm56nk+z/63jipN4CSClPl
         YPAm0uSdz/ie8ICvQUvcmDWvI37hTjo235O70FFicHD9mvB/J56MHykfYVYEmfO1AsmS
         0/8/F0e8Q/rSLEMUFmUGu1BiuSiuF1pW6bS4jEOrYZe8aa0oou72n93RZoB0eVv5dOdd
         ehvg==
X-Gm-Message-State: AOAM532Gj4JQbZ8Sudi4B3lLywNvH0iVUKphXMlB2OYWDSojnLTdpz+t
        NDdmW1y9LuE35n2Lr66ryIC9j9e3QBC3GmDkZ72y6w==
X-Google-Smtp-Source: ABdhPJy5ewWyxel0RSu/PYx4gRp0zStcp9SyVtIIlGhKV9pvJMqR7eBy8o8UoORh9nYbniwgUexDAdfjeKDbs958eWY=
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr26940772otp.34.1620753550519;
 Tue, 11 May 2021 10:19:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 May 2021 10:19:09 -0700
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHXon=k0AxF5fagz1_PW1WONppAZP1cbM72ujYN=pXn+A@mail.gmail.com>
References: <20210508074118.1621729-1-swboyd@chromium.org> <YJlZwYS+oH7W5WjO@phenom.ffwll.local>
 <CAE-0n52S=LFRx93qVyWBpF5PmdCEbWH_+HnN0Do9W45kiJLCbQ@mail.gmail.com>
 <CAKMK7uE_yrXNdEYTf-snNU9dS+=6AKOmUxRuLSHLWBTOtVwpmg@mail.gmail.com>
 <CAE-0n50d8_OtZTpBGaz0uhj6AO823_kwHg9+SJK6ar=e+rGxFA@mail.gmail.com>
 <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com> <CAKMK7uHXon=k0AxF5fagz1_PW1WONppAZP1cbM72ujYN=pXn+A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 11 May 2021 10:19:09 -0700
Message-ID: <CAE-0n53AcL807G3WLp7phQUNN6umuwUikiz_5bNfcHdRbThu=Q@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2021-05-11 06:39:36)
> On Tue, May 11, 2021 at 12:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, May 10, 2021 at 9:08 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > [cut]
> >
> > >
> > > >
> > > > > I will try it, but then I wonder about things like system wide
> > > > > suspend/resume too. The drm encoder chain would need to reimplement the
> > > > > logic for system wide suspend/resume so that any PM ops attached to the
> > > > > msm device run in the correct order. Right now the bridge PM ops will
> > > > > run, the i2c bus PM ops will run, and then the msm PM ops will run.
> > > > > After this change, the msm PM ops will run, the bridge PM ops will run,
> > > > > and then the i2c bus PM ops will run. It feels like that could be a
> > > > > problem if we're suspending the DSI encoder while the bridge is still
> > > > > active.
> > > >
> > > > Yup suspend/resume has the exact same problem as shutdown.
> > >
> > > I think suspend/resume has the exact opposite problem. At least I think
> > > the correct order is to suspend the bridge, then the encoder, i.e. DSI,
> > > like is happening today. It looks like drm_atomic_helper_shutdown()
> > > operates from the top down when we want bottom up? I admit I have no
> > > idea what is supposed to happen here.
> >
> > Why would the system-wide suspend ordering be different from the
> > shutdown ordering?
>
> At least my point was that both shutdown and suspend/resume have the
> same problem, and the righ fix is (I think at least) to add these
> hooks to the component.c aggregate ops structure. Hence just adding
> new callbacks for shutdown will be an incomplete solution.

To add proper hooks to component.c we'll need to make the aggregate
device into a 'struct device' and make a bus for them that essentially
adds the aggregate device to the bus once all the components are
registered. The bind/unbind can be ported to probe/remove, and then the
aggregate driver can get PM ops that run before the component devices
run their PM ops.

Let me go try it out and see if I can make it minimally invasive so that
the migration path is simple.

>
> I don't feel like changing the global device order is the right
> approach, since essentially that's what component was meant to fix.
> Except it's incomplete since it only provides a solution for
> bind/unbind and not for shutdown or suspend/resume as other global
> state changes. I think some drivers "fixed" this by putting stuff like
> drm_atomic_helper_shutdown/suspend/resume into early/late hooks, to
> make sure that everything is ready with that trick. But that doesn't
> compose very well :-/

Yeah it looks like msm is using prepare/complete for this so that it can
jump in early and suspend the display pipeline before the components
suspend themselves. The shutdown path only has one callback so we can't
play the same games.
