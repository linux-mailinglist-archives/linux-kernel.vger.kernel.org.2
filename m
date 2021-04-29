Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5769636E5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhD2HNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbhD2HNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:13:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E79C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:12:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l22so67855752ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WbNLgzVbrVpx/2c/s1NzjwYtEIInb7jUS0YQaKGOUA=;
        b=g3OoNN4m7i9nwQSNeFCamQND78UWDlVv4sikr+xLcOtyPi4bvSVdaNvszmOh22bxQY
         RpOCy/7p+MN8HHNfQjCLqIONi/h/kzFIcluYaDYYTB5TjbQSmBt2Vt3TR79yVDzGhogz
         uIu6ZW/nmvU7bc4pV8AMguKSf4nhPXrd1Azle5lN2hNc3AX6PRCBHzG0AHxYWJC0Lu+U
         0wTJAMOSZx+XSPWnexDrM6z3P5kKX6OSRQ6GdBbhMCjuKwmxnRAGzFRLHkzj90WTXyMr
         AUXP4tJQQHXZCVLxtmUZ5w1OxgplNVkvJZMgY4YDQ46/qt+mg7PAVXu4VNJznHJAE47w
         VQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WbNLgzVbrVpx/2c/s1NzjwYtEIInb7jUS0YQaKGOUA=;
        b=NbiZ2YdsU2Pv+DRDisKaiGbH9yHgD1arUj8CNp94zO8IbfM6K2MCfKpEI+fcfpWFLK
         IGNiyH80t7yA6jmQrKRgjBKAXxIOjk3HgpY5iiw7ygA0QFIrb0CpfQV9V61uCkFSmlhg
         AtrJWbGN8b/YGiVuGdXQR3n/6GFuh4iJ/I7efhGpz3ehRQSi0CGLIPsX/LssHpmYTjHU
         ELrzPhqBSv643Y8+p8t25jlSkJw8taMF7LdRJGfihNZ93uCs2WlphPWiIYtT3B4fZMZn
         WGMCnKe3HZhKWa0/VS2dR+qk3l9ToG3P98+5PvdClmEAx94Bs0RE+hiL8JZB+xMyv4UD
         zl4w==
X-Gm-Message-State: AOAM530tFL+ZOhWOel4IvQxwzxQWfoU9jslWkdG5pA8rUGHF5DJ3zmXt
        nGT/6lb9sJ44vo+v6Se2tUrouNR9LJtBKzKkh8jMuA==
X-Google-Smtp-Source: ABdhPJynwwCixdiNsvRc886hSdFjYV7YWBNR5qexh/o9NJoVJDV6etAkxH1II4aYpazq7C0FmcWQ8/Y01bqOl4kv31g=
X-Received: by 2002:a2e:8794:: with SMTP id n20mr22956202lji.401.1619680363850;
 Thu, 29 Apr 2021 00:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210428232821.2506201-1-swood@redhat.com>
In-Reply-To: <20210428232821.2506201-1-swood@redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Apr 2021 09:12:32 +0200
Message-ID: <CAKfTPtBrJNBg3847R_b8A-1c5rb9Fb5FFNMX+z11QGAiO0ofkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] newidle_balance() PREEMPT_RT latency mitigations
To:     Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On Thu, 29 Apr 2021 at 01:28, Scott Wood <swood@redhat.com> wrote:
>
> These patches mitigate latency caused by newidle_balance() on large
> systems when PREEMPT_RT is enabled, by enabling interrupts when the lock
> is dropped, and exiting early at various points if an RT task is runnable
> on the current CPU.
>
> On a system with 128 CPUs, these patches dropped latency (as measured by
> a 12 hour rteval run) from 1045us to 317us (when applied to
> 5.12.0-rc3-rt3).

The patch below has been queued for v5.13 and removed the update of
blocked load what seemed to be the major reason for long preempt/irq
off during newly idle balance:
https://lore.kernel.org/lkml/20210224133007.28644-1-vincent.guittot@linaro.org/

I would be curious to see how it impacts your cases

>
> I tried a couple scheduler benchmarks (perf bench sched pipe, and
> sysbench threads) to try to determine whether the overhead is measurable
> on non-RT, but the results varied widely enough (with or without the patches)
> that I couldn't draw any conclusions from them.  So at least for now, I
> limited the balance callback change to when PREEMPT_RT is enabled.
>
> Link to v1 RFC patches:
> https://lore.kernel.org/lkml/20200428050242.17717-1-swood@redhat.com/
>
> Scott Wood (3):
>   sched/fair: Call newidle_balance() from balance_callback on PREEMPT_RT
>   sched/fair: Enable interrupts when dropping lock in newidle_balance()
>   sched/fair: break out of newidle balancing if an RT task appears
>
>  kernel/sched/fair.c  | 66 ++++++++++++++++++++++++++++++++++++++------
>  kernel/sched/sched.h |  6 ++++
>  2 files changed, 64 insertions(+), 8 deletions(-)
>
> --
> 2.27.0
>
