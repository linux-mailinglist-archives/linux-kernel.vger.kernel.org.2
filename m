Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA337AD14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhEKR0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhEKR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:26:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22659C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:25:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so30951820ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NT873CRC73MULIODsKALHoOFZyeiGEpUp1yrXXnTdgQ=;
        b=AGQcAsbF+a+4xzPcqRdR8yzPkOwwDE2BXsPHEw/Z0Db7353BQ4U6TL0Wwz4aAPjHJC
         rvcWddDvcxZGkBgVZowHe5+v7QXMX7ztTzpJIenK+J9RnhlAPha4XMMyvTfwpeOhXnU3
         E4S4s21eB6TqQAX1kMC/D/e/qijeUlTYmGsEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NT873CRC73MULIODsKALHoOFZyeiGEpUp1yrXXnTdgQ=;
        b=QW651TrrI27khnaqh+xVoN9/DWCv4hexCaBxUevoWvzMymfRkutBC1Aks5SzjFXhho
         Nx0lulvDx3wLPIJbEzD/K5NqxfbgIz10llWlQ3XuIY1qTyf+MyvrU+xhYb+k7Y+LKMB/
         r/8nETzBPW/sJd/d0YdcjWXIBZKdcVxwqltVw3iTDd+AlCwo8X8DUnXNjwheqKtAkmZC
         OnHrLdsiWY+hLuymCo8rffY2i7hTWxOziWIPpekb5Zsj98e4vvoaGH+wdTPtZKEYGn3w
         WDRl72f18WattGi5yHHfryDeeP5Ku7SAeSWLE5hhAoIJz4/X/i9tpbPwmhrcnfBfImgD
         8psQ==
X-Gm-Message-State: AOAM532eoQtuGugp0TgmwFaIkGj/Th8cQvDxKFqN8AMEZX/b24wlR2yS
        d0fET+0VuLkXH2ZDB4sm4P4cPA==
X-Google-Smtp-Source: ABdhPJz+b2XkqfFBeuA3pSy1VNY/ZJqtnqOHQL8FoN38aNJfGXGjBON8VqPAN2WQPO9aWIor/rQGmA==
X-Received: by 2002:a17:906:d1d1:: with SMTP id bs17mr4282814ejb.492.1620753935803;
        Tue, 11 May 2021 10:25:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y25sm281749edr.63.2021.05.11.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 10:25:35 -0700 (PDT)
Date:   Tue, 11 May 2021 19:25:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] component: Move host device to end of device lists on
 binding
Message-ID: <YJq+Dd0s0X4J1UeE@phenom.ffwll.local>
Mail-Followup-To: Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20210508074118.1621729-1-swboyd@chromium.org>
 <YJlZwYS+oH7W5WjO@phenom.ffwll.local>
 <CAE-0n52S=LFRx93qVyWBpF5PmdCEbWH_+HnN0Do9W45kiJLCbQ@mail.gmail.com>
 <CAKMK7uE_yrXNdEYTf-snNU9dS+=6AKOmUxRuLSHLWBTOtVwpmg@mail.gmail.com>
 <CAE-0n50d8_OtZTpBGaz0uhj6AO823_kwHg9+SJK6ar=e+rGxFA@mail.gmail.com>
 <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com>
 <CAKMK7uHXon=k0AxF5fagz1_PW1WONppAZP1cbM72ujYN=pXn+A@mail.gmail.com>
 <CAE-0n53AcL807G3WLp7phQUNN6umuwUikiz_5bNfcHdRbThu=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53AcL807G3WLp7phQUNN6umuwUikiz_5bNfcHdRbThu=Q@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:19:09AM -0700, Stephen Boyd wrote:
> Quoting Daniel Vetter (2021-05-11 06:39:36)
> > On Tue, May 11, 2021 at 12:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, May 10, 2021 at 9:08 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > [cut]
> > >
> > > >
> > > > >
> > > > > > I will try it, but then I wonder about things like system wide
> > > > > > suspend/resume too. The drm encoder chain would need to reimplement the
> > > > > > logic for system wide suspend/resume so that any PM ops attached to the
> > > > > > msm device run in the correct order. Right now the bridge PM ops will
> > > > > > run, the i2c bus PM ops will run, and then the msm PM ops will run.
> > > > > > After this change, the msm PM ops will run, the bridge PM ops will run,
> > > > > > and then the i2c bus PM ops will run. It feels like that could be a
> > > > > > problem if we're suspending the DSI encoder while the bridge is still
> > > > > > active.
> > > > >
> > > > > Yup suspend/resume has the exact same problem as shutdown.
> > > >
> > > > I think suspend/resume has the exact opposite problem. At least I think
> > > > the correct order is to suspend the bridge, then the encoder, i.e. DSI,
> > > > like is happening today. It looks like drm_atomic_helper_shutdown()
> > > > operates from the top down when we want bottom up? I admit I have no
> > > > idea what is supposed to happen here.
> > >
> > > Why would the system-wide suspend ordering be different from the
> > > shutdown ordering?
> >
> > At least my point was that both shutdown and suspend/resume have the
> > same problem, and the righ fix is (I think at least) to add these
> > hooks to the component.c aggregate ops structure. Hence just adding
> > new callbacks for shutdown will be an incomplete solution.
> 
> To add proper hooks to component.c we'll need to make the aggregate
> device into a 'struct device' and make a bus for them that essentially
> adds the aggregate device to the bus once all the components are
> registered. The bind/unbind can be ported to probe/remove, and then the
> aggregate driver can get PM ops that run before the component devices
> run their PM ops.
> 
> Let me go try it out and see if I can make it minimally invasive so that
> the migration path is simple.

Thanks for volunteeering. Please cc Greg KH so we make sure we're not
doing this wrongly wrt the device model.
-Daniel

> > I don't feel like changing the global device order is the right
> > approach, since essentially that's what component was meant to fix.
> > Except it's incomplete since it only provides a solution for
> > bind/unbind and not for shutdown or suspend/resume as other global
> > state changes. I think some drivers "fixed" this by putting stuff like
> > drm_atomic_helper_shutdown/suspend/resume into early/late hooks, to
> > make sure that everything is ready with that trick. But that doesn't
> > compose very well :-/
> 
> Yeah it looks like msm is using prepare/complete for this so that it can
> jump in early and suspend the display pipeline before the components
> suspend themselves. The shutdown path only has one callback so we can't
> play the same games.

Yeah there's tons of hacks. i915 component usage with audio has similar
tricks to make suspend/resume work.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
