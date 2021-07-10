Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6DE3C3275
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 05:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhGJDwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 23:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhGJDwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 23:52:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FACC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 20:49:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gn32so20038981ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8pf9Bx0ZOkg3Cp7W7P1joRDYD3RIZoj57HCD+tYcik=;
        b=k0ROs5w7ClXnWH+BoEwMgZLQ3BzX+Jv5B2tVdL5UfySmb0CbBrr4PwUnu6UtIBdlQh
         Bj9kHcHNYw44vRhkP5eyShL7heRFMPf7EsVCGKUDJRrGWoAzMhnFiewqXBOL6X6bkNbi
         GMntUIeQ+c7tAKojs4BhUuJGj08bR/6QVof0u3oifM/Koi5geWwj/RyjY1ZVaqTg7nDS
         FVofTIN5hUFSJWNjieDWIgGpVTNZ69e/Uj2HF5KWtJeqAHRemntgpfixhff3w4hRTEow
         ebX5qUEmai7t2i0fdeJpk2Ux+2KkpJ4VUyMJt/msiQyrXBuZDBAQjwAlW6weWsy087fz
         4wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8pf9Bx0ZOkg3Cp7W7P1joRDYD3RIZoj57HCD+tYcik=;
        b=Xm3YmybsYEFC5S300xMnlCrFTTfCIxQ6Mu7NSS8IKR/1L60zZAMeKER+u6loZrrwj+
         eR9zAiPy7DNn32gX9BKjqtwAXBw7+41NsTgxfWdnVy6GfGV3QGH/g30W1eJ+qMmR2obK
         h5mFfEWK1OqeShY5qN6gEFf/d+VU1hAjDJoZdNppmi4IaL9PFrJkQCWxen11JwmJyGTr
         rvoIhD6eN2w3syhKjrs71N4550Kx70hRs5dm7q2+MvlRUUfS+/Bq2ov6Bauv+iMnEXPv
         mlVG+ocLnLgGaiBWYEZC4/PAW6r6OdB2igclvlZmOgC+QPvswr4ykLDPUDkoFVelMZd+
         x3vg==
X-Gm-Message-State: AOAM532yVACY1PS+khc+YyD285WAw7ySzFBGjvq1kRpP3tG4M39ZUPNC
        jIZPt/D8cwfMNFBAYEmZryDiAfTGxFgyEvK0eF+QOw==
X-Google-Smtp-Source: ABdhPJy8J2hOZhBsYg+ekLFa3BGVdoRvUkUh/yfFvM8TLIgeRrV2w6UL2eKT5CwsjdyvXVmznD9fB4NeenaijKUGBQc=
X-Received: by 2002:a17:906:b296:: with SMTP id q22mr34466598ejz.313.1625888997804;
 Fri, 09 Jul 2021 20:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210707105659.194171-1-ani@anisinha.ca> <YOWNWq0IHHP3Fdhz@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2107071714060.196080@anisinha-lenovo> <alpine.DEB.2.22.394.2107071731530.196080@anisinha-lenovo>
In-Reply-To: <alpine.DEB.2.22.394.2107071731530.196080@anisinha-lenovo>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Sat, 10 Jul 2021 09:19:47 +0530
Message-ID: <CAARzgwzeiAOyYG5647praaN8c2d=nKQTzdBhbniM_e1NuS1Hng@mail.gmail.com>
Subject: Re: [PATCH v2] sched/clock: print a log when the sched clock is
 marked unstable
To:     Ani Sinha <ani@anisinha.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 5:48 PM Ani Sinha <ani@anisinha.ca> wrote:
>
>
>
> On Wed, 7 Jul 2021, Ani Sinha wrote:
>
> >
> >
> > On Wed, 7 Jul 2021, Peter Zijlstra wrote:
> >
> > > On Wed, Jul 07, 2021 at 04:26:59PM +0530, Ani Sinha wrote:
> > > > When the sched clock transitions from stable to unstable and
> > > > vice versa, a kernel log is printed. When the sched clock
> > > > is marked explicitly as unstable, make __clear_sched_clock_stable()
> > > > emit a warning log. It is useful for example in understanding
> > > > why a certain feature like NOHZ that depends on availability of a
> > > > stable sched clock, is not available.
> > > >
> > > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > > ---
> > > >  kernel/sched/clock.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > Changelog:
> > > > V1: original patch
> > > > v2: print pr_warn from __clear_sched_clock_stable instead. Commit log
> > > >     updated with proper prefix and wording.
> > > >
> > > > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > > > index c2b2859ddd82..99484fec0335 100644
> > > > --- a/kernel/sched/clock.c
> > > > +++ b/kernel/sched/clock.c
> > > > @@ -183,6 +183,7 @@ static void __clear_sched_clock_stable(void)
> > > >           return;
> > > >
> > > >   tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
> > > > + pr_warn("sched_clock: Marking unstable.\n");
> > > >   schedule_work(&sched_clock_work);
> > > >  }
> > >
> > > I'm confused... that work has a ton of printk()s in, what is this
> > > pr_warn() adding?
> > >
> >
> > Right, but for whatever reason, on latest version of Ubuntu (21.04)
> > running on hyperV, I do not see those logs:
> >
> > azureuser@CentOS:~$ uname -a
> > Linux CentOS 5.11.0-1009-azure #9-Ubuntu SMP Thu Jun 17 02:20:07 UTC 2021
> > x86_64 x86_64 x86_64 GNU/Linux
> > azureuser@CentOS:~$ dmesg | grep unstable
> > dmesg: read kernel buffer failed: Operation not permitted
> > azureuser@CentOS:~$ sudo su
> > root@CentOS:/home/azureuser# dmesg | grep unstable
> > [    0.000000] tsc: Marking TSC unstable due to running on Hyper-V
> > root@CentOS:/home/azureuser# dmesg | grep sched
> > [    0.384656] rcu: RCU calculated value of scheduler-enlistment delay is
> > 25 jiffies.
> > [    1.122977] io scheduler mq-deadline registered
> > root@CentOS:/home/azureuser# exit
> >
> > Hence, I was trying the patch.
>
> OK never mimd. Seems on hyperV, they use read_hv_sched_clock_tsc() for
> pv_sched_clock and therefore using_native_sched_clock() returns false.
> Thus, clear_sched_clock_stable() is not called.
>
> I will need to do some instrumentation to confirm this. Maybe we do not
> need any patching after all.

Yes, no additional logging is needed here. This patch can be
discarded. There is a potential issue on the platform side code for
hyperV for which we might send a separate patch.
