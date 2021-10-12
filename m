Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E76429CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhJLFFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhJLFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:05:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B2C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 22:03:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z11so73683362lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JL1193BBNC3tMMpNZrUIMTSmUY5JjpjCFbidT+ClGHk=;
        b=Ctkefu3yMK9Wsld5vr+iTriNqLloAAzazhIm+QUtS8UiR5aXs7Q2qniovK0VcLlL9m
         20WRU2celSXbho5Ov9i42enIlpuFa8RvplgNFoyHX33/03NR3nkzAjs1k8cJDJNlSXAr
         INDEfa9mVBVV8zKuT/9My6DUp4tBvU34512mL6Abbzg/VYMQkDCFoOEdWp/VFqSPBdPU
         /w83tVTtEVvYVPfKY1ebvh6oop7INWdkjNrryUgsKnbe4gScJkjmk/H6R5A6clmC6uxE
         DJxXXVB5xliXAD3QQKTiSj5rfGb1kWCFe9PzoLu/5IJxFTXkDXeXSJ9ehNC4aUl2euxA
         cmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JL1193BBNC3tMMpNZrUIMTSmUY5JjpjCFbidT+ClGHk=;
        b=RHHmhtalnJdm3xpHCW72tgY1QFU3wxZCChX31HgQOiBENLfbMx0NbFBfaPPfchlZPh
         oxpBBzy8gpaLhaQM4SiaidEaosyvbwXUBKirpPu3R1nqILs7/aRq4tp8ajSOVjDkIYZ+
         91PBZ2F1S8fearPM/1bV4cJHOYdcwqy5FoWX760xU/JkXjo/2PvHXUG0qOT4i9CmWDFt
         z37FEnAD5/ru3xf5KZYdvg48FbDL/mpgcqKu+ry3Oi/eHxTeDWwqBbVXE/JiYo+fERA3
         FHjtHZxNIs6Fjb+Z9UoP/SohfCOysddeJNyaE8YdvTfmAP2K377olOAgr/4eMwqHFkK+
         0SbA==
X-Gm-Message-State: AOAM530n1nPUHopbMajKfMgnGdzm6h24Sg5Z9CqnGz6Vogiz2Ajq7uMr
        bXIHqZyj4YM41n7/Tjqgjg8mxDkdJHTBRhZUt8kLUQ==
X-Google-Smtp-Source: ABdhPJzg3/XhSkHP+3wW5acBD49wP2hijQ7rgFsjvJ4jqgzqU6OrjQszQRzmPNixbOvRA4zx3ubNlXqzeIMRFocSKts=
X-Received: by 2002:a2e:bd86:: with SMTP id o6mr18375561ljq.427.1634014985083;
 Mon, 11 Oct 2021 22:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <665f749e-b71e-a793-d759-87f7cf89677c@bytedance.com> <CALAqxLXWVpxTwEssBBUnS2ZYTpaCr3cue_dw5ZmEm5ZQ8Wf=wg@mail.gmail.com>
 <ad3d7e5d-cac1-5773-95f9-cc8f3cfd63a4@bytedance.com>
In-Reply-To: <ad3d7e5d-cac1-5773-95f9-cc8f3cfd63a4@bytedance.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 11 Oct 2021 22:02:52 -0700
Message-ID: <CALAqxLVn3U=Kj8BOcavQvF86ZZ2HgR_8iLb-zt4z_Fc=-=PSbQ@mail.gmail.com>
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

On Sat, Oct 9, 2021 at 2:02 AM yanghui <yanghui.def@bytedance.com> wrote:
>
>
>
> =E5=9C=A8 2021/10/9 =E4=B8=8A=E5=8D=8811:38, John Stultz =E5=86=99=E9=81=
=93:
> > On Fri, Oct 8, 2021 at 8:22 PM yanghui <yanghui.def@bytedance.com> wrot=
e:
> >> =E5=9C=A8 2021/10/9 =E4=B8=8A=E5=8D=887:45, John Stultz =E5=86=99=E9=
=81=93:
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
> >>>>    kernel/time/clocksource.c | 6 +++++-
> >>>>    1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >>>> index b8a14d2fb5ba..d535beadcbc8 100644
> >>>> --- a/kernel/time/clocksource.c
> >>>> +++ b/kernel/time/clocksource.c
> >>>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct =
clocksource *cs, int rating);
> >>>>
> >>>>    /*
> >>>>     * Interval: 0.5sec.
> >>>> + * MaxInterval: 1s.
> >>>>     */
> >>>>    #define WATCHDOG_INTERVAL (HZ >> 1)
> >>>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> >>>>
> >>>>    static void clocksource_watchdog_work(struct work_struct *work)
> >>>>    {
> >>>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_li=
st *unused)
> >>>>
> >>>>                   /* Check the deviation from the watchdog clocksour=
ce. */
> >>>>                   md =3D cs->uncertainty_margin + watchdog->uncertai=
nty_margin;
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
> >>     Yes, only to check watchdog delta is more reasonable.
> >>     I think Only have dmesg is not enough, because if tsc was be misju=
dged
> >>     as unstable then switch to hpet. And hpet is very expensive for
> >>     performance, so if we want to switch to tsc the only way is to reb=
oot
> >>     the server. We need to prevent the switching of the clock source i=
n
> >>     case of misjudgment.
> >>     Circumstances of misjudgment:
> >>     if clocksource_watchdog is executed after 10sec, the value of wd_d=
elta
> >>     and cs_delta also be about 10sec, also the value of (cs_nsec- wd_n=
sec)
> >>     will be magnified 20 times(10sec/0.5sec).The delta value is magnif=
ied.
> >
> > Yea, it might be worth calculating an error rate instead of assuming
> > the interval is fixed, but also just skipping the check may be
> > reasonable assuming timers aren't constantly being delayed (and it's
> > more of a transient state).
> >
> > At some point if the watchdog timer is delayed too much, the watchdog
> I mean the execution cycle of this function(static void
> clocksource_watchdog(struct timer_list *unused)) has been delayed.
>
> > hardware will fully wrap and one can no longer properly compare
> > intervals. That's why the timer length is chosen as such, so having
> > that timer delayed is really pushing the system into a potentially bad
> > state where other subtle problems are likely to crop up.
> >
> > So I do worry these watchdog robustness fixes are papering over a
> > problem, pushing expectations closer to the edge of how far the system
> > should tolerate bad behavior. Because at some point we'll fall off. :)
>
> Sorry,I don't seem to understand what you mean. Should I send your Patch
> v2 ?

Sending a v2 is usually a good step (persistence is key! :)

I'm sorry for being unclear in the above. I'm mostly just fretting
that the watchdog logic has inherent assumptions that the timers won't
be greatly delayed. Unfortunately the reality is that the timers may
be delayed. So we can try to add some robustness (as your patch does),
but at a certain point, the delays may exceed what the logic can
tolerate and produce correct behavior. I worry that by pushing the
robustness up to that limit, folks may not recognize the problematic
behavior (greatly delayed timers - possibly caused by drivers
disabling irqs for too long, or bad SMI logic, or long virtualization
pauses), and think the system is still working as designed, even
though its regularly exceeding the bounds of the assumptions in the
code. So without any feedback that something is wrong, those bounds
will continue to be pushed until things really break in a way we
cannot be robust about.

That's why I was suggesting adding some sort of printk warning when we
do see a number of delayed timers so that folks have some signal that
things are not as they are expected to be.

thanks
-john
