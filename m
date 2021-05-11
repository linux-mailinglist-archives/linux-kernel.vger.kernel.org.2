Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE237ACFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhEKRVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:21:24 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46746 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEKRVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:21:22 -0400
Received: by mail-oi1-f178.google.com with SMTP id x15so5937207oic.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ml2PDWbdLX72C7HXwtPmUq3pca/wWJyrCfkk5O/A24g=;
        b=iMi0i7UPZ8fML1cpEcm4XdrzX1vPTbKRiVtcZwsB3c9SA8pItDZKvhNO2cFO4IT+WR
         Ko4jVcwl0lbAa1t0NMNCMYpyCph9qRah149kFbioaPyey0DXgHNXNNhU4cGCpHgq3NrK
         9+AZdT02rpvgBr2JByZl8iGmHBGICR2L3eFzOJ9BQLtnY9xXG4tzV/+c2Cag5fFOvPsd
         tnKK8aX+UGfj26n7HrO52iBykuxkD22+Hu6XgK0/F1Sxm8s5Q/7+c3pY40fAsgOz0564
         K9FTJvmaj3Uj+aD/fadLshKYkIwXLreVcNvGWYrWboxoJ3gYNSVUD9gkKMa81vIv6Dkp
         wbwQ==
X-Gm-Message-State: AOAM530/M0bh2iKPX5sbwoPmbcNt3KESSO0iuAOskhldCXCBYCBK7FOB
        N/sFfE1Pl7eNq7KB3ltRRPtr6gjs5UH0DwIeMaM=
X-Google-Smtp-Source: ABdhPJw6Y/Tk17pjnnPB+8o5Dt+IAryRiDMHlqYjWIXo6Drc3oOeAWSvVeX9hn7ewn9X75cHrcNVlh5iG4w+TQUqzr4=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr8344188oih.71.1620753615904;
 Tue, 11 May 2021 10:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210508074118.1621729-1-swboyd@chromium.org> <YJlZwYS+oH7W5WjO@phenom.ffwll.local>
 <CAE-0n52S=LFRx93qVyWBpF5PmdCEbWH_+HnN0Do9W45kiJLCbQ@mail.gmail.com>
 <CAKMK7uE_yrXNdEYTf-snNU9dS+=6AKOmUxRuLSHLWBTOtVwpmg@mail.gmail.com>
 <CAE-0n50d8_OtZTpBGaz0uhj6AO823_kwHg9+SJK6ar=e+rGxFA@mail.gmail.com>
 <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com> <CAE-0n50WBz6rpbuxw-2=XNi=1fmaf=mYrcWdV88E-0KioKHZDg@mail.gmail.com>
In-Reply-To: <CAE-0n50WBz6rpbuxw-2=XNi=1fmaf=mYrcWdV88E-0KioKHZDg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 19:20:04 +0200
Message-ID: <CAJZ5v0jBPaQCwq0fBxyMFnetg5pxtBvbkhiCaW-bZpfdrt1Bhw@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 7:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2021-05-11 03:52:06)
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
> I don't really know. I'm mostly noting that today the order of suspend
> is to suspend the bridge device first and then the aggregate device. If
> the suspend of the aggregate device is traversing the devices like
> drm_atomic_helper_shutdown() then it would operate on the bridge device
> after it has been suspended, like is happening during shutdown. But it
> looks like that isn't happening. At least for the msm driver we're
> suspending the aggregate device after the bridge, and there are some
> weird usages of prepare and complete in there (see msm_pm_prepare() and
> msm_pm_complete) which makes me think that it's all working around this
> component code.

Well, it looks like the "prepare" phase is used sort-of against the
rules (because "prepare" is not supposed to make changes to the
hardware configuration or at least that is not its role) in order to
work around an ordering issue that is present in shutdown which
doesn't have a "prepare" phase.

> The prepare phase is going to suspend the display pipeline, and then the
> bridge device will run its suspend hooks, and then the aggregate driver
> will run its suspend hooks. If we had a proper device for the aggregate
> device instead of the bind/unbind component hooks we could clean this
> up.

I'm not sufficiently familiar with the component code to add anything
constructive here, but generally speaking it looks like the "natural"
dpm_list ordering does not match the order in which the devices in
question should be suspended (or shut down for that matter), so indeed
it is necessary to reorder dpm_list this way or another.

Please also note that it generally may not be sufficient to reorder
dpm_list if the devices are suspended and resumed asynchronously
during system-wide transitions, because in that case the callbacks of
different devices are only started in the dpm_list order, but they may
be completed in a different order (and of course they may run in
parallel with each other).

Shutdown is simpler, because it runs the callback synchronously for
all devices IIRC.
