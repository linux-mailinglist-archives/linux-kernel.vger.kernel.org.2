Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CCD356E10
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352740AbhDGODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbhDGODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:03:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941FCC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:02:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b14so28675862lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+17jFXVfSVa1xzkD+yOD2JJxNoeoPowk4/GrnqnOgP0=;
        b=tbqIMjkSscPvQOqqV3GR+CJbiO0LZOCWdGhAL1qn6AouJzfdHmcLmViEJ64MuUUbgG
         zHJSJPw8Mgyz6aoHMrmdD7Ut84bEARrsJZt0XMw/VEr9XVBaSO5AB5t51D2MK7cBn5DO
         8+3C6gG66IkHY/e8nqxl3G56SsNgMKA1pCd1QwldfjnJaQZutbtDvUkLg6R6cZnZMSZM
         2acJLEON3pbh1Fk4hJmYpmgDZuU71qpNQFBCp6pPQl8FX5qB40ZPqks3RJoEYodnMXVk
         hlWY6b2dXlDE9u4NKljoDEAVsC0uwQ4AAHen+ShbRbeEoZ7Bt7b4slP5U0nhhq08AmwO
         FOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+17jFXVfSVa1xzkD+yOD2JJxNoeoPowk4/GrnqnOgP0=;
        b=orEVIYU+1gPRlRHK41ve4Pu2t87jRmvSOt1sBDzYXQ76TLaoh9AkPrbD/wECSc47uc
         ilUS0mXiRhhWMiB2p8V2lpQaYdU0W93xRsiXOf1luHR9U10bp59shove86KJqft/BDx5
         iXoxur9NAlUkJbKxyvpIcAeXjisSYnJvwvfd7IrZ/VvpEsfWJOJ0eXahpiwtG0fbemVK
         aUn4MXAh2OlV3au0wZI2wB9d9l5LJ6q6LDMy7rViQqf7Lx4tjSRQqQYuaFg+7ZJi5Tl5
         O8GU/s1GiOTyTv3Ov962slOUmXRAVcmIHgTT/oBD1bXJ6LVX0FK+cPAtv9E+ml+xAc5g
         BVMQ==
X-Gm-Message-State: AOAM532DPCXVsWKSzOzcBM82vw0FhRU7984hwr+ot5MtRuIyAPm9/JSU
        OFpC4hG3o/KykeWmvSZLb2hzi2h57mJpCv7d9/LayQ==
X-Google-Smtp-Source: ABdhPJyxkpZuB/fFSn3dWDHHN4He9jWpqo0HNAGqeehLmg84FyfW8Wefz2oTvjbl9qTebbARnASFed2SZemY053dqqM=
X-Received: by 2002:a19:f812:: with SMTP id a18mr2580296lff.254.1617804172692;
 Wed, 07 Apr 2021 07:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book> <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
 <20210324134437.GA17675@vingu-book> <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
In-Reply-To: <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Apr 2021 16:02:41 +0200
Message-ID: <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Wed, 24 Mar 2021 at 17:05, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 3/24/21 6:44 AM, Vincent Guittot wrote:
> > Hi Tim,
>
> >
> > IIUC your problem, we call update_blocked_averages() but because of:
> >
> >               if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> >                       update_next_balance(sd, &next_balance);
> >                       break;
> >               }
> >
> > the for_each_domain loop stops even before running load_balance on the 1st
> > sched domain level which means that update_blocked_averages() was called
> > unnecessarily.
> >
>
> That's right
>
> > And this is even more true with a small sysctl_sched_migration_cost which allows newly
> > idle LB for very small this_rq->avg_idle. We could wonder why you set such a low value
> > for sysctl_sched_migration_cost which is lower than the max_newidle_lb_cost of the
> > smallest domain but that's probably because of task_hot().
> >
> > if avg_idle is lower than the sd->max_newidle_lb_cost of the 1st sched_domain, we should
> > skip spin_unlock/lock and for_each_domain() loop entirely
> >
> > Maybe something like below:
> >
>
> The patch makes sense.  I'll ask our benchmark team to queue this patch for testing.

Do you have feedback from your benchmark team ?

Regards,
Vincent
>
> Tim
>
>
