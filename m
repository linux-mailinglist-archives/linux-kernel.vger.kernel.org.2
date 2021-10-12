Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878B2429CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 06:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhJLEyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 00:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhJLEyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 00:54:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2809CC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 21:52:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j21so64866985lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eguaqqaEvocg16XhRYlmwRB3LITVZC7ytOcijWENE0U=;
        b=EJEHDw8MDWlcDjViuvBxD2G3aXkTevpz/dtCabTJWdXzwSG5X3UXVXtjh4GDMxLDG0
         ZbGEZ1bd0nV637XJzB1XopqQBrOs/j7VbRt8FCUTtjMQ96BIvM8K0aHLu/T9y2WlrObe
         M/B3z6zPd20ff/B2haFkyB4w54BiUVh56dyw7wf9hrzw1CLEJidS5QqK4IftUzOdb31a
         cBfatIbZRFjTcJ4Jj8iLbnShTN5IO+K3cb342cwQ1DLr2hf9aCUlbXa6Jvq8X/KK953Z
         f8WlDD0/A4f21U3kINeu5zbYlAj8Eu0uhtA6JTHed/GzkvHvkpBgTaIYkPiIeiMhmger
         3Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eguaqqaEvocg16XhRYlmwRB3LITVZC7ytOcijWENE0U=;
        b=XIVYSqfOagtnOZ/5Tb7HoZtjdcaHR8cl79A2YYjSU4CDobc2oeGx8UflWRiAc++nCK
         nber8rADCSSwKW074YtNFBTbTVXY1OTDfTA+xDzguIbW2eQIxtfE4jJuLOqPvE/YciQ6
         Rz9cYU45dsQ3RwLVnQ/O5y1BKHCiebmS7+HQWeO9TZpxcm0zMxn/jDoaYqfV614knwTK
         WUsxM+PyxhJYsbkSItOj96GMDBEHRXToE32tT/tsKqmDMR1Lgyz9F8L/ZN3O2uViH1DM
         xHnhxH0Ya0EB2zFocnUbPOYH2cp+YSUasIujIPOqJZ12Az4uV4UDc4xYbz7grsuqRTFR
         RsQg==
X-Gm-Message-State: AOAM530yRus1EAPyubluJ2OdCLqBgjutKIYall3DbuBTDoxbClc5k5/F
        aAAgNQr26nhnFOx2g9C+f6IgDEN+gTZGwCp8NZ5XRw==
X-Google-Smtp-Source: ABdhPJxtUg6ArzDf8obZOLIcqFThlsjDLBOVq82DDyM5iTD1J4eoPBzh0GUwczmY73KQLKkHIE2YxZiFsXZxoQmYGNQ=
X-Received: by 2002:a05:6512:3f86:: with SMTP id x6mr31750475lfa.389.1634014361420;
 Mon, 11 Oct 2021 21:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com> <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com>
In-Reply-To: <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 11 Oct 2021 21:52:29 -0700
Message-ID: <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     brookxu <brookxu.cn@gmail.com>
Cc:     yanghui <yanghui.def@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
>
> hello
>
> John Stultz wrote on 2021/10/9 7:45:
> > On Fri, Oct 8, 2021 at 1:03 AM yanghui <yanghui.def@bytedance.com> wrote:
> >>
> >> clocksource_watchdog is executed every WATCHDOG_INTERVAL(0.5s) by
> >> Timer. But sometimes system is very busy and the Timer cannot be
> >> executed in 0.5sec. For example,if clocksource_watchdog be executed
> >> after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
> >> be enlarged. Then the current clocksource will be misjudged as
> >> unstable. So we add conditions to prevent the clocksource from
> >> being misjudged.
> >>
> >> Signed-off-by: yanghui <yanghui.def@bytedance.com>
> >> ---
> >>  kernel/time/clocksource.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >> index b8a14d2fb5ba..d535beadcbc8 100644
> >> --- a/kernel/time/clocksource.c
> >> +++ b/kernel/time/clocksource.c
> >> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
> >>
> >>  /*
> >>   * Interval: 0.5sec.
> >> + * MaxInterval: 1s.
> >>   */
> >>  #define WATCHDOG_INTERVAL (HZ >> 1)
> >> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> >>
> >>  static void clocksource_watchdog_work(struct work_struct *work)
> >>  {
> >> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
> >>
> >>                 /* Check the deviation from the watchdog clocksource. */
> >>                 md = cs->uncertainty_margin + watchdog->uncertainty_margin;
> >> -               if (abs(cs_nsec - wd_nsec) > md) {
> >> +               if ((abs(cs_nsec - wd_nsec) > md) &&
> >> +                       cs_nsec < WATCHDOG_MAX_INTERVAL_NS &&
> >
> > Sorry, it's been awhile since I looked at this code, but why are you
> > bounding the clocksource delta here?
> > It seems like if the clocksource being watched was very wrong (with a
> > delta larger than the MAX_INTERVAL_NS), we'd want to throw it out.
> >
> >> +                       wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {
> >
> > Bounding the watchdog interval on the check does seem reasonable.
> > Though one may want to keep track that if we are seeing too many of
> > these delayed watchdog checks we provide some feedback via dmesg.
>
> For some fast timeout timers, such as acpi-timer, checking wd_nsec should not
> make much sense, because when wacthdog is called, the timer may overflow many
> times.

Indeed. But in that case we can't tell which way is up. This is what I
was fretting about when I said:
> So I do worry these watchdog robustness fixes are papering over a
> problem, pushing expectations closer to the edge of how far the system
> should tolerate bad behavior. Because at some point we'll fall off. :)

If the timer is delayed long enough for the watchdog to wrap, we're
way out of tolerable behavior. There's not much we can do because we
can't even tell what happened.

But in the case where the watchdog has not wrapped, I don't see a
major issue with trying to be a bit more robust in the face of just
slightly delayed timers.
(And yes, we can't really distinguish between slightly delayed and
watchdog-wrap-interval + slight delay, but in either case we can
probably skip disqualifying the clocksource as we know something seems
off)

thanks
-john
