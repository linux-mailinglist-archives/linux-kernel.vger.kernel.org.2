Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480AE4276F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbhJIDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhJIDkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:40:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F54C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:38:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r19so44858714lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RiWQECJyXrvGibCFo4LTV3Lak3718z6ulvjp/x9FWHg=;
        b=Nr590eGnuTsOzVHVYYId1H7aYmrB/zTCyFqY+2J2JAaCFxf4LoY2yfDwUx5vVkxB/n
         /1Zl1PnhmBmhyPGNciLEPRdwNsyXT1uZnYl5XYsjODBYhq3RRxeIik8CevAfA7j6fHwA
         bF0GBaPfM/wMWZcF1iZx5Ah7KzpBuUTqGemwhEJFymVe6s94e2Vx8dA02vVJqjG6m+Vx
         kSVhTDK1vqCFhbVoiKE+SLNDswvSOM9dXXnQXQ4LKvH5sdrxGyopp2zch22THouaAGfE
         UfXTvfrJlPzmXsm/2B/ZneI/gqZSQLms23dxb/MiVjpf1orS5OfCYF6b3yBqxJxQupIK
         vPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RiWQECJyXrvGibCFo4LTV3Lak3718z6ulvjp/x9FWHg=;
        b=K6XFuaL5b9SaXN7HmiypeYoH3MlJFNvLY1Jt4Yvi9M/XpJqJNX+M0hvmdACT07o8XZ
         y/GO5RnOeuPsDCOCJq2odj6T6oaTvYalypfO60pXlp9eFqPcxO1H7qwS3Z3Wo6o+XCGU
         Ke5xDNhC+hCUSTbkVYV4DTgOi7wOIphQ6yyQmgjK8uXt/x3XD8/eNE4B+cl1DLBMj3nI
         GQOaY1/S5FeKjYo6DB9AM1tEwnrVkxapNxju8IDz8KHKMBKdVrMN+B3LDkj9EFbBxNqU
         Q8tVzg14XKtOJxZjX5mTKw5rkX3NAxWjlAPqqd6JJC7KaCyk1Ui3/o0q265ODMyTlOk4
         EHaw==
X-Gm-Message-State: AOAM532Svf0tnp1fDU6IuXT0ZUM69ns0vJYf8IVxbghXUgPZzyie23yG
        S3a/pQZ5xyZHNdVfN+wjCWtwiX+Tlx5Sh+purXNCLw==
X-Google-Smtp-Source: ABdhPJwVvxzD7OZ8qsi3EVicuBX+DNaQgeL39sYq/YYhHG4GzpfLY69zwA1ly+vzlGS03NWrzjMlfnmKJW0Q2rUvokY=
X-Received: by 2002:a05:6512:1189:: with SMTP id g9mr13955093lfr.661.1633750723302;
 Fri, 08 Oct 2021 20:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com> <665f749e-b71e-a793-d759-87f7cf89677c@bytedance.com>
In-Reply-To: <665f749e-b71e-a793-d759-87f7cf89677c@bytedance.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 8 Oct 2021 20:38:31 -0700
Message-ID: <CALAqxLXWVpxTwEssBBUnS2ZYTpaCr3cue_dw5ZmEm5ZQ8Wf=wg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     yanghui <yanghui.def@bytedance.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 8:22 PM yanghui <yanghui.def@bytedance.com> wrote:
> =E5=9C=A8 2021/10/9 =E4=B8=8A=E5=8D=887:45, John Stultz =E5=86=99=E9=81=
=93:
> > On Fri, Oct 8, 2021 at 1:03 AM yanghui <yanghui.def@bytedance.com> wrot=
e:
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
> >>   kernel/time/clocksource.c | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >> index b8a14d2fb5ba..d535beadcbc8 100644
> >> --- a/kernel/time/clocksource.c
> >> +++ b/kernel/time/clocksource.c
> >> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct cl=
ocksource *cs, int rating);
> >>
> >>   /*
> >>    * Interval: 0.5sec.
> >> + * MaxInterval: 1s.
> >>    */
> >>   #define WATCHDOG_INTERVAL (HZ >> 1)
> >> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> >>
> >>   static void clocksource_watchdog_work(struct work_struct *work)
> >>   {
> >> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list=
 *unused)
> >>
> >>                  /* Check the deviation from the watchdog clocksource.=
 */
> >>                  md =3D cs->uncertainty_margin + watchdog->uncertainty=
_margin;
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
>    Yes, only to check watchdog delta is more reasonable.
>    I think Only have dmesg is not enough, because if tsc was be misjudged
>    as unstable then switch to hpet. And hpet is very expensive for
>    performance, so if we want to switch to tsc the only way is to reboot
>    the server. We need to prevent the switching of the clock source in
>    case of misjudgment.
>    Circumstances of misjudgment:
>    if clocksource_watchdog is executed after 10sec, the value of wd_delta
>    and cs_delta also be about 10sec, also the value of (cs_nsec- wd_nsec)
>    will be magnified 20 times(10sec/0.5sec).The delta value is magnified.

Yea, it might be worth calculating an error rate instead of assuming
the interval is fixed, but also just skipping the check may be
reasonable assuming timers aren't constantly being delayed (and it's
more of a transient state).

At some point if the watchdog timer is delayed too much, the watchdog
hardware will fully wrap and one can no longer properly compare
intervals. That's why the timer length is chosen as such, so having
that timer delayed is really pushing the system into a potentially bad
state where other subtle problems are likely to crop up.

So I do worry these watchdog robustness fixes are papering over a
problem, pushing expectations closer to the edge of how far the system
should tolerate bad behavior. Because at some point we'll fall off. :)

thanks
-john
