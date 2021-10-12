Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25564429D21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhJLFcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhJLFb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:31:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF11C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 22:29:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j5so82918046lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 22:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3sAOOe9SIaZNolGPXgCzq40f4v0SkZfPjFZLJWTQJak=;
        b=P/S0G/tvXsvMhH0HjFk85HI/n7Z7Qhh0UWuocrrN7J7kZMXA2SbdbXUp3Pa7dAkgTc
         yGXWJ6o3wqg4ebnIthz87xnxrqsbfcABy9/3EfaFtF9x4O2ijbd0D1TqLdsKmMrYHj0F
         3QsCClRvG/T6vjLII7Tzs+MKvI6iNgJlZ+inyY7Wlir7wh0I395HZHACUfd2W88az0OH
         e9qUkK+P5sQbopnQgpPq5Gevm8MnYMgg2IMDQXmn+0Ta5PdQ4AAgtYtjbTnYjWMMQGih
         o6jWqYnaTJLt/B7+qactfJUyP8vBAdiX6+uJF2ZvwhPBfKKm1ueBSmMfmMYd8tVGM7CD
         YE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3sAOOe9SIaZNolGPXgCzq40f4v0SkZfPjFZLJWTQJak=;
        b=XN28BSY+I3KCGu0oikKihcvVx7W3Ebgi/TRI17+hNq+kxVLUpKRzolHcFx2m4xJUAe
         acF1raflJ8sdt3Z1C1YOhPx4trQ7i7bu1La7SdYS4h3Lvyz1hktGo6ECnFCoWBPxaceJ
         HNwBs9RNNkXDHR7plUMg1EJ8y2sJ0hgrXnrb3lB9IToX1F7+FuVDxTR1idtRNmcVfWL3
         Bnr7PORyz28lx2fPbAj2eOEa8ggLwwV4YY/2/SZAQ7flv5c9IDLiJB91o7bl2I/qQ4Cc
         ENNURMVOzNu2AzReSHC5aNxTvkjL4nZiMYaePthZZoRYR/lXct+7olEoDBUbIkF04SeN
         8jTg==
X-Gm-Message-State: AOAM5333EQkeMa2kKHfBaBIsewvdkQgNhbNpHiao9w46Zx6YleOqBVf2
        U9XhaSH9vi8ZwYDfV4eOfjPtXN3PXT/jqcmvtx4LUA==
X-Google-Smtp-Source: ABdhPJxmsLM3zHXXQeuB/MwtaCsJ5skeZgwDXLHa9GJQqSLSZcZ8KlZieHcbnL0GWbwEx/xEThvcfntmKCphBONFlzU=
X-Received: by 2002:a2e:9790:: with SMTP id y16mr2224530lji.175.1634016595572;
 Mon, 11 Oct 2021 22:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com> <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com>
In-Reply-To: <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 11 Oct 2021 22:29:42 -0700
Message-ID: <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
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

On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wrote:
> John Stultz wrote on 2021/10/12 12:52 =E4=B8=8B=E5=8D=88:
> > On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
> >>
> >> hello
> >>
> >> John Stultz wrote on 2021/10/9 7:45:
> >>> On Fri, Oct 8, 2021 at 1:03 AM yanghui <yanghui.def@bytedance.com> wr=
ote:
> >>>>
> >>>> clocksource_watchdog is executed every WATCHDOG_INTERVAL(0.5s) by
> >>>> Timer. But sometimes system is very busy and the Timer cannot be
> >>>> executed in 0.5sec. For example,if clocksource_watchdog be executed
> >>>> after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
> >>>> be enlarged. Then the current clocksource will be misjudged as
> >>>> unstable. So we add conditions to prevent the clocksource from
> >>>> being misjudged.
> >>>>
> >>>> Signed-off-by: yanghui <yanghui.def@bytedance.com>
> >>>> ---
> >>>>  kernel/time/clocksource.c | 6 +++++-
> >>>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >>>> index b8a14d2fb5ba..d535beadcbc8 100644
> >>>> --- a/kernel/time/clocksource.c
> >>>> +++ b/kernel/time/clocksource.c
> >>>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct =
clocksource *cs, int rating);
> >>>>
> >>>>  /*
> >>>>   * Interval: 0.5sec.
> >>>> + * MaxInterval: 1s.
> >>>>   */
> >>>>  #define WATCHDOG_INTERVAL (HZ >> 1)
> >>>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> >>>>
> >>>>  static void clocksource_watchdog_work(struct work_struct *work)
> >>>>  {
> >>>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_li=
st *unused)
> >>>>
> >>>>                 /* Check the deviation from the watchdog clocksource=
. */
> >>>>                 md =3D cs->uncertainty_margin + watchdog->uncertaint=
y_margin;
> >>>> -               if (abs(cs_nsec - wd_nsec) > md) {
> >>>> +               if ((abs(cs_nsec - wd_nsec) > md) &&
> >>>> +                       cs_nsec < WATCHDOG_MAX_INTERVAL_NS &&
> >>>
> >>> Sorry, it's been awhile since I looked at this code, but why are you
> >>> bounding the clocksource delta here?
> >>> It seems like if the clocksource being watched was very wrong (with a
> >>> delta larger than the MAX_INTERVAL_NS), we'd want to throw it out.
> >>>
> >>>> +                       wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {
> >>>
> >>> Bounding the watchdog interval on the check does seem reasonable.
> >>> Though one may want to keep track that if we are seeing too many of
> >>> these delayed watchdog checks we provide some feedback via dmesg.
> >>
> >> For some fast timeout timers, such as acpi-timer, checking wd_nsec sho=
uld not
> >> make much sense, because when wacthdog is called, the timer may overfl=
ow many
> >> times.
> >
> > Indeed. But in that case we can't tell which way is up. This is what I
> > was fretting about when I said:
> >> So I do worry these watchdog robustness fixes are papering over a
> >> problem, pushing expectations closer to the edge of how far the system
> >> should tolerate bad behavior. Because at some point we'll fall off. :)
> >
> > If the timer is delayed long enough for the watchdog to wrap, we're
> > way out of tolerable behavior. There's not much we can do because we
> > can't even tell what happened.
> >
> > But in the case where the watchdog has not wrapped, I don't see a
> > major issue with trying to be a bit more robust in the face of just
> > slightly delayed timers.
> > (And yes, we can't really distinguish between slightly delayed and
> > watchdog-wrap-interval + slight delay, but in either case we can
> > probably skip disqualifying the clocksource as we know something seems
> > off)
>
> If we record the watchdog's start_time in clocksource_start_watchdog(), a=
nd then
> when we verify cycles in clocksource_watchdog(), check whether the clocks=
ource
> watchdog is blocked. Due to MSB verification, if the blocked time is grea=
ter than
> half of the watchdog timer max_cycles, then we can safely ignore the curr=
ent
> verification? Do you think this idea is okay?

I can't say I totally understand the idea. Maybe could you clarify with a p=
atch?

thanks
-john
