Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625E6416D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbhIXISD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhIXISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:18:00 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F726C061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:16:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso12060392otb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+yqtLlmqcFfu91J3c6ogGc+y73qtKXPHmt46fo0y6E=;
        b=EYUDuuEoFN9e8BRqPu9TqbhHtJuVTrpaTgglJwtTGl/a3z7anrFxbHJzPJE+LbFAE7
         YU+XoMLfcR1ghoIz9DsmFLHqbKUGY9Jj8QViMsBSTHCDWl7xhqY0pvL+5KF56/OL+eRN
         /61bsmrzvl8mZ5cB8PrAK2gMAJtmFkdLh8JXa85pnZroCtffEOEw9lXGteV+FdmK4oYY
         IgPVMIEczVPurUflC0FYh4NtrIEFEHX78caTv9y7gO+Q/qXm1W5wE0PC7/mj3h/r4/zK
         qUPd5cYBUEH7xTCHrEJmXR7eHbEpnzJeFcTN+JZxnCDRI0jQYTaLvwQb+SoQ1r0dc2Am
         3/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+yqtLlmqcFfu91J3c6ogGc+y73qtKXPHmt46fo0y6E=;
        b=qNNWnDNt/DyCZWUBYhQP3jPHtdhKWnmBvx2VY6C+pBmAJ6PVIZcEjoahXh/uDXcJsr
         iuCZ+/95lNG5zcku4vdMHxCQY3hPNSGZFmjb22H67B/Rt3oaqR5fINPlYsuyV7CeXDBA
         JwkS1ie0zYqdAgD6NTVe97MjwHKjIxbGO9RkdeR0s43XGQteijXoRTbZZu34OudlNVA1
         a1TwKa/7C5e58wETO8B+3FYzXGtpdyatFUEGSSAUDNZLZYVrOO+pCDtF6o9bVKWhMGZo
         pkxhVRKZFUe+BuhPe/DJ9+nbJ6tU554SuU1I7HniKHleAc+nTr7lULH7VSxyxQ5BJ5uk
         NEBw==
X-Gm-Message-State: AOAM532/AgwMVFX5fO9vDY2CDz1NGaMrJJZ80qPzkO0N0UqdOMkUv/Az
        QaYc0XOuPPKDTiuyDlzsT+qTwml+jagallr6Qelmizawaeyfrg==
X-Google-Smtp-Source: ABdhPJyb3HGvHncuLK2vnCKHE1y2AFUJkV048oTAyg0uRDwb8kSLvUyx5cx5qkyBSBdS3yKZfy93EMnIYODrim8lr8g=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr2950091otk.137.1632471386455;
 Fri, 24 Sep 2021 01:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210923153311.225307347@linutronix.de> <20210923153339.437521634@linutronix.de>
In-Reply-To: <20210923153339.437521634@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Sep 2021 10:16:15 +0200
Message-ID: <CACT4Y+aOFxbm6qny_FO0rz0_iSZw04W3Sdqe-zPtGYdvNNzHbw@mail.gmail.com>
Subject: Re: [patch 01/11] hrtimer: Add a mechanism to catch runaway timers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 18:04, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A recent report from syzbot unearthed a problem with self rearming timers
> which fire late and try to catch up to now with a short period. That causes
> the timer to be rearmed in the past until it eventually catches up with
> now. If that rearming happens from the timer callback the hard or soft
> interrupt expiry loop can run for a long time with either interrupts or
> bottom halves disabled which causes RCU stalls and other lockups.
>
> There is no safety net to stop or at least identify such runaway timers.
>
> Detection is trivial. Cache the pointer to the last expired timer. The next
> invocation from the same loop compares the pointer with the next expiring
> hrtimer pointer and if they match 10 times in a row (in the same hard or
> soft interrupt expiry instance) then it's reasonable to declare it as a
> runaway.
>
> In that case emit a warning and skip the callback invocation which stops
> the misbehaving timer right there.
>
> It's obviously incomplete, but it's definitely better than nothing and would
> have caught the reported issue in mac80211_hwsim.
>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/hrtimer.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1714,6 +1714,13 @@ static void __run_hrtimer(struct hrtimer
>         base->running = NULL;
>  }
>
> +static void hrtimer_del_runaway(struct hrtimer_clock_base *base,
> +                               struct hrtimer *timer)
> +{
> +       __remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
> +       pr_warn("Runaway hrtimer %p %ps stopped\n", timer, timer->function);

Thanks for implementing this, Thomas.
Please use some standard kernel bug reporting facility here, e.g. WARN
I think will be appropriate. The ad-hoc format won't be recognized by
any testing system.
Otherwise looks good to me.

> +}
> +
>  static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
>                                  unsigned long flags, unsigned int active_mask)
>  {
> @@ -1722,6 +1729,8 @@ static void __hrtimer_run_queues(struct
>
>         for_each_active_base(base, cpu_base, active) {
>                 struct timerqueue_node *node;
> +               struct hrtimer *last = NULL;
> +               unsigned int cnt = 0;
>                 ktime_t basenow;
>
>                 basenow = ktime_add(now, base->offset);
> @@ -1732,6 +1741,22 @@ static void __hrtimer_run_queues(struct
>                         timer = container_of(node, struct hrtimer, node);
>
>                         /*
> +                        * Catch timers which rearm themself with a expiry
> +                        * time in the past over and over which makes this
> +                        * loop run forever.
> +                        */
> +                       if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_TIMERS)) {
> +                               if (unlikely(last == timer)) {
> +                                       if (++cnt == 10) {
> +                                               hrtimer_del_runaway(base, timer);
> +                                               continue;
> +                                       }
> +                               }
> +                               last = timer;
> +                               cnt = 0;
> +                       }
> +
> +                       /*
>                          * The immediate goal for using the softexpires is
>                          * minimizing wakeups, not running timers at the
>                          * earliest interrupt after their soft expiration.
>
