Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF637AC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhEKRBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhEKRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:01:52 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB16C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:00:44 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so18109305oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+kc9oZEJ14VtCjgrFBVdOi9/5rD3BSHSZSNV5GjZufU=;
        b=PwB1lvevVfB5Kbm7k/H348W91Tj9WxfX+YOZ70lpfrPoOc2vzHtRmS5rzAxstsVpqY
         Zl0ZnQ2lcLSRGIrkT1mPSfwIH/C9/vw9xKaTCm97G55DwAuj0An0UPbRbckwhMyctHF/
         Zgehk3RmB3QlbD21BR0O3H+D2qgTa39u0LNUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+kc9oZEJ14VtCjgrFBVdOi9/5rD3BSHSZSNV5GjZufU=;
        b=t0SU2lWcnwejiBy4W4N1IL5nqp7w9YdqwPFEEeE/6xv1oGDsR8HMEOMKgy8u3XfrMM
         bcTGUjpP2DssLrdTtlthXKhXnTdzTS2y3+0MU83q3P9zBjPEK1cCW3uSpulyQpBv3BJ+
         xiKODUzbGxtRrCpVQv9kczGT6cTEzemkJnMoItbw9aSVQnjWGkEmzigp9APCmRW+KMB7
         kqD+KP5Gj3l9Hk72GyeqZ3cgpcAREh7VpiHJUbm6/Gr1o5YsQtQMn8VbUktjvbau80Q3
         Xi0U0KR1ThyRdPDAel7y/pLeSHWXT7l27YYEA2cXxcLz18abPtvxhXxWsmY2HVWxcW9m
         vYMA==
X-Gm-Message-State: AOAM530dO6MJNIrnjYk7jCYT++YbtM/cWckQcJApBwx9jIVcftSpfUAu
        gDMExDVrn5pJ16OC//OwCRGZaUjVH197RINPOZkXueMRBwI=
X-Google-Smtp-Source: ABdhPJzW1noUSaOfHP3CiUI7zDa9O8HOgGEUnZzp7SKJNkf/LeqfB00UDdoZldzFkZBlJffiYsv995L7sOx4TuPsCo4=
X-Received: by 2002:a9d:425:: with SMTP id 34mr27097167otc.25.1620752444214;
 Tue, 11 May 2021 10:00:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 May 2021 10:00:43 -0700
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com>
References: <20210508074118.1621729-1-swboyd@chromium.org> <YJlZwYS+oH7W5WjO@phenom.ffwll.local>
 <CAE-0n52S=LFRx93qVyWBpF5PmdCEbWH_+HnN0Do9W45kiJLCbQ@mail.gmail.com>
 <CAKMK7uE_yrXNdEYTf-snNU9dS+=6AKOmUxRuLSHLWBTOtVwpmg@mail.gmail.com>
 <CAE-0n50d8_OtZTpBGaz0uhj6AO823_kwHg9+SJK6ar=e+rGxFA@mail.gmail.com> <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 11 May 2021 10:00:43 -0700
Message-ID: <CAE-0n50WBz6rpbuxw-2=XNi=1fmaf=mYrcWdV88E-0KioKHZDg@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2021-05-11 03:52:06)
> On Mon, May 10, 2021 at 9:08 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> [cut]
>
> >
> > >
> > > > I will try it, but then I wonder about things like system wide
> > > > suspend/resume too. The drm encoder chain would need to reimplement the
> > > > logic for system wide suspend/resume so that any PM ops attached to the
> > > > msm device run in the correct order. Right now the bridge PM ops will
> > > > run, the i2c bus PM ops will run, and then the msm PM ops will run.
> > > > After this change, the msm PM ops will run, the bridge PM ops will run,
> > > > and then the i2c bus PM ops will run. It feels like that could be a
> > > > problem if we're suspending the DSI encoder while the bridge is still
> > > > active.
> > >
> > > Yup suspend/resume has the exact same problem as shutdown.
> >
> > I think suspend/resume has the exact opposite problem. At least I think
> > the correct order is to suspend the bridge, then the encoder, i.e. DSI,
> > like is happening today. It looks like drm_atomic_helper_shutdown()
> > operates from the top down when we want bottom up? I admit I have no
> > idea what is supposed to happen here.
>
> Why would the system-wide suspend ordering be different from the
> shutdown ordering?

I don't really know. I'm mostly noting that today the order of suspend
is to suspend the bridge device first and then the aggregate device. If
the suspend of the aggregate device is traversing the devices like
drm_atomic_helper_shutdown() then it would operate on the bridge device
after it has been suspended, like is happening during shutdown. But it
looks like that isn't happening. At least for the msm driver we're
suspending the aggregate device after the bridge, and there are some
weird usages of prepare and complete in there (see msm_pm_prepare() and
msm_pm_complete) which makes me think that it's all working around this
component code.

The prepare phase is going to suspend the display pipeline, and then the
bridge device will run its suspend hooks, and then the aggregate driver
will run its suspend hooks. If we had a proper device for the aggregate
device instead of the bind/unbind component hooks we could clean this
up.
