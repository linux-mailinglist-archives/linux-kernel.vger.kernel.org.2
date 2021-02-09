Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC431517E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhBIOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBIOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:23:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5D8C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:23:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f23so11461944lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8Hnf5djYRycB4Vm4YkbJqAg3/uOZDrL0UbNFVCbtSI=;
        b=GzwjQt+Sa/VnvWyfZzZqgQ2QhvklmNaMXicZgd8l4HQICcVmj60UcKcOS3k7GiCoBD
         mKIyy72OAbWgXHw27QNZzP2AFw7iMC5QCg6OI5A7/SWRCQNNcKniZIXV34llkdBPgqUW
         RrvqXu4W8Ph+VsrHGQDlr5hSnErKvBKhAkfH1R26PVJeSalGfovfabA2VAiqsqzxjojD
         1+XWnPzj5lDWnJZYK/HZ5G1f+rj/AjOjJU4Nyhjl1GxCrm7WICqmzgrhb4/bRkYZoxi5
         mnGLEuCzCNBMkoSaNhkeI2tPYtC0gdEUnZFv0EpG1AlBw8+Rycaxw0qrBcFW3h4Wnf+L
         LtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8Hnf5djYRycB4Vm4YkbJqAg3/uOZDrL0UbNFVCbtSI=;
        b=X9a+Tet4OisBFZNxPahLRK5ec399CAYlvIvynIKr0KPl4jaYkqFWKJYS/DpNpFKMKJ
         eCDv5UkGlapZ7CjWx8hW+x0pblXmlxF6p/dZ00P+l1RA72QxF9pSw2wxY4aSB/iGNkU8
         DS0rRmI5LSl3Hw3mjYXJWXD/of8U9trvG53l3lcBgEELZ2ymMdaxnJr/QVmB42CEeinK
         0GM+mKlcLFZMBa7SF4yeqFVeCDVIFKROGfXWLKP5DEHIXMOAPPivYsHwAZQ3CK1BcFQM
         7gnZieRO5oBcYH5japBK+mwXRI33qWCzZ1exnE9JyewZYe/liAyg95KGhqr5eEEIn4LX
         egkg==
X-Gm-Message-State: AOAM533UXK+UQhxurQKg32rJQ21Q2BnXIrBv4wZtYaW6IWZlU1cSpF+4
        Ujkjp/jzu0/tnHpZHPIDcvBH4Wbmn3HNDGk09p+9ZQ==
X-Google-Smtp-Source: ABdhPJykCzJsjGIg5llDs9S6fVeBUv+dI5hB9FycYvN69R01HN690+mUlTrgMegiYorySYFiJbee1n+YN3sVpzvv2us=
X-Received: by 2002:a05:6512:3457:: with SMTP id j23mr10192049lfr.305.1612880587700;
 Tue, 09 Feb 2021 06:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-6-vincent.guittot@linaro.org> <86be4035-9350-6cd2-9859-9444307f9033@arm.com>
In-Reply-To: <86be4035-9350-6cd2-9859-9444307f9033@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 15:22:55 +0100
Message-ID: <CAKfTPtANm-b+iKU09Rvu1Tu5MBpNAkmzn0FOstURWs4royTMpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: trigger the update of blocked load on
 newly idle cpu
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 14:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 05/02/2021 12:48, Vincent Guittot wrote:
> > Instead of waking up a random and already idle CPU, we can take advantage
> > of this_cpu being about to enter idle to run the ILB and update the
> > blocked load.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  include/linux/sched/nohz.h |  2 ++
> >  kernel/sched/fair.c        | 11 ++++++++---
> >  kernel/sched/idle.c        |  6 ++++++
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
> > index 6d67e9a5af6b..74cdc4e87310 100644
> > --- a/include/linux/sched/nohz.h
> > +++ b/include/linux/sched/nohz.h
> > @@ -9,8 +9,10 @@
> >  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
> >  extern void nohz_balance_enter_idle(int cpu);
> >  extern int get_nohz_timer_target(void);
> > +extern void nohz_run_idle_balance(int cpu);
> >  #else
> >  static inline void nohz_balance_enter_idle(int cpu) { }
> > +static inline void nohz_run_idle_balance(int cpu) { }
> >  #endif
>
> (1) Since nohz_run_idle_balance() would be an interface one sched class
> (fair) exports to another (idle) I wonder if kernel/sched/sched.h would
> be the more appropriate include file to export/define it?

Yes probably. I have been influenced by the "nohz" filename but
kernel/sched/sched.h is better

>
> nohz_balance_exit_idle() is exported via kernel/sched/sched.h (used only
> within the scheduler) whereas nohz_balance_enter_idle() is exported via
> include/linux/sched/nohz.h (used in kernel/time/tick-sched.c).
>
> Isn't include/linux/sched/nohz.h the interface between kernel/sched/ and
> kernel/time?
>
> There is one exception already though: calc_load_nohz_remote() defined
> in kernel/sched/loadavg.c and (only) used in kernel/sched/core.c.
>
>
> (2) Is there a need for an extra function nohz_run_idle_balance()?
> do_idle() could call nohz_idle_balance() directly in case in would be
> exported instead.

I didn't want to expose the 2 parameters of nohz_idle_balance in
do_idle() and especially the enum cpu_idle_type but it seems that it
is already available so I can probably call
nohz_idle_balance(cpu_rq(cpu), CPU_IDLE); directly


>
> [...]
