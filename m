Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0940B66B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhINSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhINSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:01:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F39C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:00:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p2so394754oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abYYEHNJJXsCK9xEzjjhn2BOAEkX0oOtIZ/c7rdmSQY=;
        b=ShQlUJkeBUJYnoXL7YiRgx5PFCMS8+1KMy2xeaUAoNoODQa8epIWl5KrLD8+DtvmgL
         jaUlzzGOpkLQsooGBWFLd1BQoq7DNzCi7EgyUlsWweWR+Thdp4PeBeF0XeQfmkIH+ztl
         ggFmlwv++CTA9cEuEqCmrfd2brymOy/HTnvxlxNi1mcNHJQXD69iILpK92XdTRqVtUHE
         CLuYDtkJ1oQKG4Z96Ks22KOnonlmbVRUI/CUIhEL9jVf0IaPSsZ2rXXJEoS3kTLydMq/
         KUboY6KQQEWyVsc6THelndT7giao4bNA694+EMAy8VrSoTUc12s7wBig4i5D+vSK9dt2
         zO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abYYEHNJJXsCK9xEzjjhn2BOAEkX0oOtIZ/c7rdmSQY=;
        b=7SW87m9RP00k07vuPf2GHEJkOOaeJqFKVzyfYBPDjKUtpWEajvDXZ66aCJ3qgj4uyd
         f4pA72bEPERw9sE6tb9dkSJTbUVTxjOIZ64+okwkrdH6ufnWjKEzRZR8vm0ZUn2zl/J4
         YpP8RphB/ZXQ3C8PtfaLvC/a0xgmHW6Ivh5oZaw5/q0axr+O+MZgvfLuYFv+jbiRutZd
         PK3L0iE5SH4R6VQ65kwVX4j/i2mFDa4U3rz2z5dpyzxR7MuJHiq67wZA8IWTJaExwDK5
         sQyvAn47+BXWaBt3rvKJkD7RZ7AccymqvgBdTfUpq4pdiKmllt3iP+ySgQpCa8TKVnbR
         7L2g==
X-Gm-Message-State: AOAM531ZPnx//0jFyV2Hpa0hPItsBEjnmCcHnKIDaEW5ZEGaZVbkUqc5
        fvupqooTD1ut8fqY38mffIxP9BcYgbtjOaxkU6RRZWG7ySs=
X-Google-Smtp-Source: ABdhPJxWZqU1a9DPLexwrU2G4mMfRa1NIGy5Q0z5CPClYtGU+65QhDe4s146ZXM4OXy/RT91yMuGaX4craoPE/rP3To=
X-Received: by 2002:aca:1109:: with SMTP id 9mr2342557oir.109.1631642415672;
 Tue, 14 Sep 2021 11:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eaacf005ca975d1a@google.com> <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com> <87v933b3wf.ffs@tglx>
In-Reply-To: <87v933b3wf.ffs@tglx>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Sep 2021 20:00:04 +0200
Message-ID: <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sept 2021 at 16:58, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Sep 14 2021 at 20:37, Hillf Danton wrote:
>
> > On Mon, 13 Sep 2021 12:28:14 +0200 Thomas Gleixner wrote:
> >>On Tue, Aug 31 2021 at 15:45, Hillf Danton wrote:
> >>> On Mon, 30 Aug 2021 12:58:58 +0200 Dmitry Vyukov wrote:
> >>>>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
> >>>>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
> >>>>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
> >>>>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
> >>>>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
> >>>>>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
> >>>
> >>> Add debug info only to help kasan catch the timer running longer than 2 ticks.
> >>>
> >>> Is it anything in the right direction, tglx?
> >>
> >>Not really. As Dmitry pointed out this seems to be related to
> >
> > Thanks for taking a look.
> >
> >>mac80211_hwsim and if you look at the above stacktrace then how is
> >>adding something to the timer wheel helpful?
> >
> > Given the stall was printed on CPU1 while the supposedly offending timer was
> > expiring on CPU0, what was proposed is the lame debug info only for kasan to
> > catch the timer red handed.
> >
> > It is more appreciated if the tglx dude would likely spend a couple of minutes
> > giving us a lesson on the expertises needed for collecting evidence that any
> > timer runs longer than two ticks. It helps beyond the extent of kasan.
>
> That tglx dude already picked the relevant part of the stack trace (see
> also above):
>
> >>>>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
> >>>>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
> >>>>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
> >>>>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
> >>>>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
> >>>>>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>
> and then asked the question how a timer wheel timer runtime check
> helps. He just omitted the appendix "if the timer in question is a
> hrtimer" as he assumed that this is pretty obvious from the stack trace.
>
> Aside of that if the wireless timer callback runs in an endless loop,
> what is a runtime detection of that in the hrtimer softirq invocation
> helping to decode the problem if the stall detector catches it when it
> hangs there?
>
> Now that mac80211 hrtimer callback might actually be not the real
> problem. It's certainly containing a bunch of loops, but I couldn't find
> an endless loop there during a cursory inspection.
>
> But that callback does rearm the hrtimer and that made me look at
> hrtimer_run_queues() which might be the reason for the endless loop as
> it only terminates when there is no timer to expire anymore.
>
> Now what happens when the mac80211 callback rearms the timer so it
> expires immediately again:
>
>         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
>                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
>
> bcn is a user space controlled value. Now lets assume that bcn_int is <=1,
> which would certainly cause the loop in hrtimer_run_queues() to keeping
> looping forever.
>
> That should be easy to verify by implementing a simple test which
> reschedules a hrtimer from the callback with a expiry time close to now.
>
> Not today as I'm about to head home to fire up the pizza oven.

This question definitely shouldn't take priority over the pizza. But I
think I saw this "rearm a timer with a user-controlled value without
any checks" pattern lots of times and hangs are inherently harder to
localize and reproduce. So I wonder if it makes sense to add a debug
config that would catch such cases right when the timer is set up
(issue a WARNING)?
However, for automated testing there is the usual question of
balancing between false positives and false negatives. The check
should not produce false positives, but at the same time it should
catch [almost] all actual stalls so that they don't manifest as
duplicate stall reports.

If I understand it correctly the timer is not actually set up as
periodic, but rather each callback invocation arms it again. Setting
up a timer for 1 ns _once_ (or few times) is probably fine (right?),
so the check needs to be somewhat more elaborate and detect "infinite"
rearming.
