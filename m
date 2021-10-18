Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3D432393
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhJRQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhJRQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:16:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16232C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:14:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w23so699387lje.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=39kEco6YUPZQeLiBTH5juEbmjZF1/s82FjRHzL/nA70=;
        b=mRjscxU0/V04/PRAzPqrZxXCuXysK06p8VtMGNGNM36W7cwxiTNFl2lrpM3vF7WM4O
         K4l8lwBnmDjCBkHBEGhMy34EqfJ1CfAXRoiKpkcswJOKjiMbJi2PIp6Rp0jdaxVTBkEB
         AvvIhiq0Sba4hVXoKnpPDy4cDRzWeikNjo5wImCPa6YZnSaDOD+gYWDVQV0XTAc0ORq1
         I1kU87aPvdR6eW8xr+sve+P07wy6wNfCaNlFpC6/YH0sLt9idjigmXncnNl6LyZMCsP9
         C0vyRZFxO0rgz6WO9WHp4icR5cUHVoDa/32J469Rn4pfZS2LTTNsW1IiwMqjhfZSDYyK
         dwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=39kEco6YUPZQeLiBTH5juEbmjZF1/s82FjRHzL/nA70=;
        b=OUvfKKbS93JuYfS1IUQVVnVfxg1rxkU6+ulJaOIRdJ4CUDI8KtMO1u0yTLGeI9y5AA
         nCnjDUkb02+jLAlNt/bL0LpuO8oRByaetcvScrg/CLqcTZP+cjyHnyj7M3jNvdEK/rZN
         1F7tBRNNRK+wnqqY2EesJJkd1gMOAwXqR8TUiXolkQL5lttkLuPzqYCpGeQciaHwQaf0
         0tX5jB7JPRssAdWaICW8QPm7cRSgjsluK+mOMtNS/iOxjc875OazhbXZXMnuRKq/BEkh
         MK0jtgIChaFXXrukNJyu9r5PmMCP0gf9CbhoayPK7qX0Gi85aHcYyx3VdOTbi1X2wQn1
         aJyA==
X-Gm-Message-State: AOAM530xck/FVFqOA/Efd0tDqPH/AUcvo+CIipO/DVolZodsxG75aMDf
        m1YGwKb2tRtF5jo6zCB/VIX5RuXoW6mv7a8sJF6XDQ==
X-Google-Smtp-Source: ABdhPJxrT9tI+YztQ/AimZD3Irs7I1GeAkAnj90pm0LU1mraIPQSWD9+esN/6cL7TJ1UIguquJ6yakcuJufGMjVda84=
X-Received: by 2002:a2e:9616:: with SMTP id v22mr715661ljh.25.1634573684439;
 Mon, 18 Oct 2021 09:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com> <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com> <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com>
In-Reply-To: <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 18 Oct 2021 09:14:33 -0700
Message-ID: <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     brookxu <brookxu.cn@gmail.com>
Cc:     yanghui <yanghui.def@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail.com> wrote:
> John Stultz wrote on 2021/10/12 13:29:
> > On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wrote:
> >> John Stultz wrote on 2021/10/12 12:52 =E4=B8=8B=E5=8D=88:
> >>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
> >> If we record the watchdog's start_time in clocksource_start_watchdog()=
, and then
> >> when we verify cycles in clocksource_watchdog(), check whether the clo=
cksource
> >> watchdog is blocked. Due to MSB verification, if the blocked time is g=
reater than
> >> half of the watchdog timer max_cycles, then we can safely ignore the c=
urrent
> >> verification? Do you think this idea is okay?
> >
> > I can't say I totally understand the idea. Maybe could you clarify with=
 a patch?
> >
>
> Sorry, it looks almost as follows:
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index b8a14d2..87f3b67 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -119,6 +119,7 @@
>  static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
>  static DEFINE_SPINLOCK(watchdog_lock);
>  static int watchdog_running;
> +static unsigned long watchdog_start_time;
>  static atomic_t watchdog_reset_pending;
>
>  static inline void clocksource_watchdog_lock(unsigned long *flags)
> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_list *u=
nused)
>         int next_cpu, reset_pending;
>         int64_t wd_nsec, cs_nsec;
>         struct clocksource *cs;
> +       unsigned long max_jiffies;
>         u32 md;
>
>         spin_lock(&watchdog_lock);
> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_list *=
unused)
>                 if (atomic_read(&watchdog_reset_pending))
>                         continue;
>
> +               max_jiffies =3D nsecs_to_jiffies(cs->max_idle_ns);
> +               if (time_is_before_jiffies(watchdog_start_time + max_jiff=
ies))
> +                       continue;
> +

Sorry, what is the benefit of using jiffies here?   Jiffies are
updated by counting the number of tick intervals on the current
clocksource.

This seems like circular logic, where we're trying to judge the
current clocksource by using something we derived from the current
clocksource.
That's why the watchdog clocksource is important, as it's supposed to
be a separate counter that is more reliable (but likely slower) then
the preferred clocksource.

So I'm not really sure how this helps.

The earlier patch by yanghui at least used the watchdog interval to
decide if the watchdog timer had expired late. Which seemed
reasonable, but I thought it might be helpful to add some sort of a
counter so if the case is happening repeatedly (timers constantly
being delayed) we have a better signal that the watchdog and current
clocksource are out of sync.  Because again, timers are fired based on
the current clocksource. So constant delays likely mean things are
wrong.

thanks
-john

thanks
-john
