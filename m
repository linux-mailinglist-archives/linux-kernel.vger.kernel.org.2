Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F73D31091A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhBEKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBEK3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:29:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05908C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:28:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so9158058lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ut5w3sEc9hpF1chIAyKfkbdLvXIYwNF0gEBfB+9NKBA=;
        b=ROhax9Ft04xX+Lk1KMXuWtelonqpeeMR24hOzCCKHhEJUCW2dv5jOgupUtqO05LArp
         eChcFjnJrfhunOZVe8algQdpBMErnDNk705x89KJWz8r2ZXQWxXX1tsgh0Pu7DqS75PT
         rsX/SsdQ1qSplsz6KFLNmeLoYKytRcpiDNRWVS7UaBXV4wHBVdJZ1C3C1vznU1B6Uiye
         cxQSFO0GlxA3casvrSkFJ1NEWLXTdbB9bmQz5VMMKvXGsS3IJqFJBJjPyb/BQwks5Oig
         oBJSJ/uyySeZvqXx+Pi+xyGmPaLVz5qUWRI1SUZv3nClkC69jQfWnrWqwjM4+7cAKINs
         1GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ut5w3sEc9hpF1chIAyKfkbdLvXIYwNF0gEBfB+9NKBA=;
        b=CMU1xsY+OJrny/twyin4WuovN3bV2ZvTdhXy0YJwOziGX9B06xjYS6wq17rZJdDEax
         33h8NqU3hLnehiZySnXrPfEymIWhs/HnX1Q49etvGGh5B6joDU/1wT7EGvMLfA5ByjQ0
         75JNUjsGzGk9L2KE01MVp0pN8RBYkM24PvPrH77W12xMvhQyMU2ho8WD5Xmq9+uGJUid
         Ij1jhPyjubF/0LqM8SJsasLhZ5KWb3SSnbyS3HJrW1RgL/gwbv+B8kDORXgUx+R69klt
         Zom2A1RZysNfr9VpIspnstrhXmh3V23gBikc+Qv/JljnSeahjopLd+Drn528inCkO8hn
         zVUQ==
X-Gm-Message-State: AOAM531xYtjsvGgDl9wE1KcK85cokURzGJUS5NbxmAcak/Qfua+8ZB3T
        b7zxThT2S/jucb/q8BYo1i7ZVvMbUm/7Qmp3b9s6xyoPsRaJxQ==
X-Google-Smtp-Source: ABdhPJzq5Cqye83YCcJaeQjiWSXb6FkijXZMuJd2Qy0Zxh/Q08jdLRtBVHTKQBRgc/z0mtlzuKc7FsS06zLu/vGsMnk=
X-Received: by 2002:a05:6512:2004:: with SMTP id a4mr2166450lfb.212.1612520911496;
 Fri, 05 Feb 2021 02:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20210129082726.19406-1-ruifeng.zhang0110@gmail.com>
 <YBPNAoitmgnTxiqQ@kroah.com> <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
 <CAJZ5v0gh1y14mipnwJKE+-7FKzasMMTTzZY_dTpuepHGjyK-xg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gh1y14mipnwJKE+-7FKzasMMTTzZY_dTpuepHGjyK-xg@mail.gmail.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Fri, 5 Feb 2021 18:27:53 +0800
Message-ID: <CAG7+-3N=vonV+8y0bTXXh72vJGUqMrjyu_d4sztzpPkrPj7KeQ@mail.gmail.com>
Subject: Re: [PATCH] RFC syscore: add suspend type to syscore
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, ruifeng.zhang1@unisoc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>, ke.wang@unisoc.com,
        nianfu.bai@unisoc.com, orson.zhai@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2021=E5=B9=B42=E6=9C=884=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 4, 2021 at 10:07 AM Ruifeng Zhang
> <ruifeng.zhang0110@gmail.com> wrote:
> >
> > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > > > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > > >
> > > > Suspend type contains s2ram and s2idle, but syscore is only
> > > > available for S2RAM.
> > >
> > > Who else needs this?
> > In the s2idle suspend and resume, some vendors want to do some
> > things, for example the vendor implemented the watchdog driver.
>
> Do that in the platform operations then.
>
> Adding the syscore stuff to the suspend-to-idle flow is not an option, so=
rry.
Excause me, I really still want to know the reason.
My requirement is that the watchdog need disable when the system s2idle.
If don't, the watchdog will bark when system resume.
>
> > The GKI requires that no modification of the kernel source is allowed,
> > so an syscore_s2idle is added for use.
>
> The GKI rules are not a mainline kernel concern.
>
> > The reason device_suspend was not chosen was that I wanted it to
> > monitor for longer periods, such as between device_suspend and
> > syscore_suspend.
> > >
> > > > S2idle requires a similar feature, so a new parameter
> > > > "enum suspend_type" is added to distinguish it.
> > >
> > > Who requires this export?
> > >
> > > I don't see a user of this new code/api in this patch, so why would i=
t
> > > be accepted?
> > >
> > > Also, you are doing many different things in the same patch, please
> > > break this up into a patch series where you only do one logical chang=
e
> > > at a time.
> > I think it's only one things in patch
> > 0001-RFC-syscore-add-suspend-type-to-syscore.patch,
> > add a new s2ildle type for syscore.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > From 1abd09045639dafdbf713514d4f1323b572dd2ec Mon Sep 17 00:00:00 2001
> > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > Date: Thu, 4 Feb 2021 13:29:56 +0800
> > Subject: [PATCH 2/2] RFC time: add syscore suspend ops to s2idle
> >
> > Some vendors need do more things when s2idle.
> >
> > The required GKI does not allow modification of the
> > kernel source code, so provide the syscore operation
> > interface.
>
> No, this absolutely is a bad idea.
>
> > Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > ---
> >  kernel/time/tick-common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> > index 9d3a22510bab..8c4509250456 100644
> > --- a/kernel/time/tick-common.c
> > +++ b/kernel/time/tick-common.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/err.h>
> >  #include <linux/hrtimer.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/list.h>
> >  #include <linux/nmi.h>
> >  #include <linux/percpu.h>
> >  #include <linux/profile.h>
> > @@ -528,6 +529,7 @@ void tick_freeze(void)
> >         trace_suspend_resume(TPS("timekeeping_freeze"),
> >                      smp_processor_id(), true);
> >         system_state =3D SYSTEM_SUSPEND;
> > +       syscore_suspend(SUSPEND_S2IDLE);
> >         sched_clock_suspend();
> >         timekeeping_suspend();
> >     } else {
> > @@ -553,6 +555,7 @@ void tick_unfreeze(void)
> >     if (tick_freeze_depth =3D=3D num_online_cpus()) {
> >         timekeeping_resume();
> >         sched_clock_resume();
> > +       syscore_resume(SUSPEND_S2IDLE);
> >         system_state =3D SYSTEM_RUNNING;
> >         trace_suspend_resume(TPS("timekeeping_freeze"),
> >                      smp_processor_id(), false);
> > --
> > 2.17.1
> >
> > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > > > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > > >
> > > > Suspend type contains s2ram and s2idle, but syscore is only
> > > > available for S2RAM.
> > >
> > > Who else needs this?
> > >
> > > > S2idle requires a similar feature, so a new parameter
> > > > "enum suspend_type" is added to distinguish it.
> > >
> > > Who requires this export?
> > >
> > > I don't see a user of this new code/api in this patch, so why would i=
t
> > > be accepted?
> > >
> > > Also, you are doing many different things in the same patch, please
> > > break this up into a patch series where you only do one logical chang=
e
> > > at a time.
> > >
> > > thanks,
> > >
> > > greg k-h
