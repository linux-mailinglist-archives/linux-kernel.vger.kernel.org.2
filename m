Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1830F406
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhBDNkC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Feb 2021 08:40:02 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41901 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhBDNj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:39:28 -0500
Received: by mail-oi1-f174.google.com with SMTP id m13so3692699oig.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6rRzb9E40rKbHmGBhgEXeJjPyHLlcHJuAPRHuZzcDfs=;
        b=Y5/5heaeNgDGlvUg/LWhr3QhiAK7i1ai+qWD15A2N7mv3vnVRKYF8DDFLsoKeKGJdj
         xYpygnd/vSg3uCsYuK6PJij2osJnIKi/DI0qFicNsv/f9pAtWU1pxYsvzNW3YGbSxJz+
         5ezkEYuNKw+YQxKu3t06wauwWweIKKjiceSCLpBxLd0zpdFkZhCLZF/LinfPMjm11jJI
         ksV3pJ+SPKZ7hbJN8ybjp40ZCrnVOawWqQcghXgHySCnk7rmiJdiIkJNzUYiZg3tEOZj
         BTBkeAd+AA0a13pPtw6g30+SLIyPI3C6G1Fwu5YukduDRQ8vSK3PnDI9qI7YOJX1BUNV
         bmOg==
X-Gm-Message-State: AOAM533NxkLkv25GjQ7HlP4dSSl2h16x2H2qoJkjQsrsHAiAuQbXpHDM
        0k56kIXRDMXW5NB3jFKYOimxontpVIfviJU3Ypt9eevY
X-Google-Smtp-Source: ABdhPJywX3CcugHKuARhvIsK0eMlX/r0E+5zzrSoAFUsXYP0EXGanjYq+lYEN0maHiCrxYbfhDA2I5tLe3ndeZm1y4s=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr5275526oii.71.1612445924194;
 Thu, 04 Feb 2021 05:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20210129082726.19406-1-ruifeng.zhang0110@gmail.com>
 <YBPNAoitmgnTxiqQ@kroah.com> <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
In-Reply-To: <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Feb 2021 14:38:32 +0100
Message-ID: <CAJZ5v0gh1y14mipnwJKE+-7FKzasMMTTzZY_dTpuepHGjyK-xg@mail.gmail.com>
Subject: Re: [PATCH] RFC syscore: add suspend type to syscore
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, ruifeng.zhang1@unisoc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 10:07 AM Ruifeng Zhang
<ruifeng.zhang0110@gmail.com> wrote:
>
> Greg KH <gregkh@linuxfoundation.org> 于2021年1月29日周五 下午4:53写道：
> >
> > On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > >
> > > Suspend type contains s2ram and s2idle, but syscore is only
> > > available for S2RAM.
> >
> > Who else needs this?
> In the s2idle suspend and resume, some vendors want to do some
> things, for example the vendor implemented the watchdog driver.

Do that in the platform operations then.

Adding the syscore stuff to the suspend-to-idle flow is not an option, sorry.

> The GKI requires that no modification of the kernel source is allowed,
> so an syscore_s2idle is added for use.

The GKI rules are not a mainline kernel concern.

> The reason device_suspend was not chosen was that I wanted it to
> monitor for longer periods, such as between device_suspend and
> syscore_suspend.
> >
> > > S2idle requires a similar feature, so a new parameter
> > > "enum suspend_type" is added to distinguish it.
> >
> > Who requires this export?
> >
> > I don't see a user of this new code/api in this patch, so why would it
> > be accepted?
> >
> > Also, you are doing many different things in the same patch, please
> > break this up into a patch series where you only do one logical change
> > at a time.
> I think it's only one things in patch
> 0001-RFC-syscore-add-suspend-type-to-syscore.patch,
> add a new s2ildle type for syscore.
> >
> > thanks,
> >
> > greg k-h
>
> From 1abd09045639dafdbf713514d4f1323b572dd2ec Mon Sep 17 00:00:00 2001
> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> Date: Thu, 4 Feb 2021 13:29:56 +0800
> Subject: [PATCH 2/2] RFC time: add syscore suspend ops to s2idle
>
> Some vendors need do more things when s2idle.
>
> The required GKI does not allow modification of the
> kernel source code, so provide the syscore operation
> interface.

No, this absolutely is a bad idea.

> Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> ---
>  kernel/time/tick-common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 9d3a22510bab..8c4509250456 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -11,6 +11,7 @@
>  #include <linux/err.h>
>  #include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
> +#include <linux/list.h>
>  #include <linux/nmi.h>
>  #include <linux/percpu.h>
>  #include <linux/profile.h>
> @@ -528,6 +529,7 @@ void tick_freeze(void)
>         trace_suspend_resume(TPS("timekeeping_freeze"),
>                      smp_processor_id(), true);
>         system_state = SYSTEM_SUSPEND;
> +       syscore_suspend(SUSPEND_S2IDLE);
>         sched_clock_suspend();
>         timekeeping_suspend();
>     } else {
> @@ -553,6 +555,7 @@ void tick_unfreeze(void)
>     if (tick_freeze_depth == num_online_cpus()) {
>         timekeeping_resume();
>         sched_clock_resume();
> +       syscore_resume(SUSPEND_S2IDLE);
>         system_state = SYSTEM_RUNNING;
>         trace_suspend_resume(TPS("timekeeping_freeze"),
>                      smp_processor_id(), false);
> --
> 2.17.1
>
> Greg KH <gregkh@linuxfoundation.org> 于2021年1月29日周五 下午4:53写道：
> >
> > On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > >
> > > Suspend type contains s2ram and s2idle, but syscore is only
> > > available for S2RAM.
> >
> > Who else needs this?
> >
> > > S2idle requires a similar feature, so a new parameter
> > > "enum suspend_type" is added to distinguish it.
> >
> > Who requires this export?
> >
> > I don't see a user of this new code/api in this patch, so why would it
> > be accepted?
> >
> > Also, you are doing many different things in the same patch, please
> > break this up into a patch series where you only do one logical change
> > at a time.
> >
> > thanks,
> >
> > greg k-h
