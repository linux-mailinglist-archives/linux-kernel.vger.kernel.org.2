Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84CC3B4F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFZQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFZQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 12:21:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E73C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 09:19:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso8754439pjx.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7FPqJOHK0r/nDcT4Wvf4/Qf/C23DNea/ZKsuhjqXUwA=;
        b=L7fvNelx3wHobG3XEB5D4mQMMFvl8Xu+Im1qBURZdJYlcqlCCz4+tgOJZNPm/6I3vB
         8KVUnOF2u8iAL1IOS6QobqBt+D2+7dqOXHNigUtNX2cAm08KmJ9tkwUNrv7cN4jv/nf5
         Pmla4MyZ7lhrYJJ6g0gmk3dGnk+GonOtyqzrQhNLLaT3qzuUQAUXASJUyaB/UNhfzDO8
         cRXXOMPCJF4GZPjX9vaEgx6HPJp/mSg7VEmz+d69ck5gAe9UpHGZQkiXsdI+cytRDsUL
         Lvu3VCgm3iQwP6XA3OTFBBetzDAWZppCckQPP4v/En8KdWkeqR8HwAUw/jy+S2FHtyBm
         nLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7FPqJOHK0r/nDcT4Wvf4/Qf/C23DNea/ZKsuhjqXUwA=;
        b=V+HHE+9V0sjsEAXyCdlcdUVkL2yHntkHnQoKeoOkUlgL1hmn22prHifGM+JNisDeXD
         AUJ4VZIkQRRLIIZHUqrpBgbQCMhYIWc/U3TgRsfIhJedY4wvpL/Tfv/iUsgSBZeWD6oK
         JQ71y7NFw7kSohiZeXS2als2l2PhJ9O4El9gBZXSEVMCmt/C6BNPLGPHAN6fwMDbPFgT
         sezAxiTHEXULZmj1tzXPI9DYNmsy7+2EKg+nGkQvNt+b3HdQWCkYYLH7oFCY5XJuCCmz
         Psxpr8sVNvR0xKnaecx5QdkvF/tMrKhPGwqcH3bSkUyxlcQ99wEzYnHC+ue0+COukXZB
         Lsdg==
X-Gm-Message-State: AOAM531QlHbNcFiy4NJho1D67/z1VfLQqPY3DW4xImvXCUPJPsRN5Xc8
        A+C3eJZvAKtirAAur5lXJbXdFA==
X-Google-Smtp-Source: ABdhPJz86CL7LsEjJnymKcvMKqw1e7bQiYmtjQlSf89+KLhFE/ClCJGVg3Y2+L5FMybOLkhScQyuNg==
X-Received: by 2002:a17:90b:1509:: with SMTP id le9mr27055714pjb.35.1624724341791;
        Sat, 26 Jun 2021 09:19:01 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.123.144])
        by smtp.googlemail.com with ESMTPSA id i3sm9817786pgc.92.2021.06.26.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:19:01 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Sat, 26 Jun 2021 21:48:40 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v3] Add kernel logs when sched clock unstable and NO_HZ_FULL
 is not possible
In-Reply-To: <87r1gudj87.ffs@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.22.394.2106262136340.2111427@anisinha-lenovo>
References: <20210620101312.1757363-1-ani@anisinha.ca> <87r1gudj87.ffs@nanos.tec.linutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Jun 2021, Thomas Gleixner wrote:

> On Sun, Jun 20 2021 at 15:43, Ani Sinha wrote:
>
> > Commit 4f49b90abb4aca ("sched-clock: Migrate to use new tick
> > dependency mask model") had also removed the kernel warning
> > message informing the user that it was not possible to turn
> > on NO_HZ_FULL. Adding back that log message here. It is
> > unhelpful when the kernel turns off NO_HZ_FULL silently
> > without informing anyone.
> > Also added a kernel log when sched clock is marked as unstable.
>
> Don't do two things at once. See Documentation/process/....

Ok I will split up this patch into two.

>
> Also your subject line want's a proper prefix.

OK will fix.

>
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index c2b2859ddd82..9f9fe658f8a5 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -192,8 +192,11 @@ void clear_sched_clock_stable(void)
> >
> >  	smp_mb(); /* matches sched_clock_init_late() */
> >
> > -	if (static_key_count(&sched_clock_running.key) == 2)
> > +	if (static_key_count(&sched_clock_running.key) == 2) {
> > +		WARN_ONCE(sched_clock_stable(),
> > +			  "sched clock is now marked unstable.");
>
> What's the WARN for here? That backtrace is largely uninteresting.

OK to be consistent with other parts of the code, I will replace this with
pr_warn()

>
> > -	if (can_stop_full_tick(cpu, ts))
> > +	if (can_stop_full_tick(cpu, ts)) {
> >  		tick_nohz_stop_sched_tick(ts, cpu);
> > -	else if (ts->tick_stopped)
> > -		tick_nohz_restart_sched_tick(ts, ktime_get());
> > +	} else {
> > +		/*
> > +		 * Don't allow the user to think they can get
> > +		 * full NO_HZ with this machine.
> > +		 */
> > +		WARN_ONCE(tick_nohz_full_running,
> > +			  "NO_HZ_FULL will not work for the current system.");
>
> can_stop_full_tick() returning false can be transient and then the user
> still has no idea _why_ this is printed.
>
> Also assume the user/admin starts perf and knows he's going to disturb
> NOHZ full, then _why_ would he be interested in that warning.
>

If NOHZ is disabled intentionally, that is not an interesting case. I am
worried about the situation where the user specifies NOHZ option in the
kernel commandline and the kernel silently disabled this because of one or
more limitations in the system. I want to address this. All the reasons
specified in the following commit is still true:

commit e12d0271774fea9fddf1e2a7952a0bffb2ee8e8b
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Fri May 10 17:12:28 2013 -0400

    nohz: Warn if the machine can not perform nohz_full

    If the user configures NO_HZ_FULL and defines nohz_full=XXX on the
    kernel command line, or enables NO_HZ_FULL_ALL, but nohz fails
    due to the machine having a unstable clock, warn about it.

    We do not want users thinking that they are getting the benefit
    of nohz when their machine can not support it.

    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Li Zhong <zhong@linux.vnet.ibm.com>
    Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>

This log was removed from the kernel in commit

commit 4f49b90abb4aca6fe677c95fc352fd0674d489bd
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Wed Jul 22 17:03:52 2015 +0200

    sched-clock: Migrate to use new tick dependency mask model

    Instead of checking sched_clock_stable from the nohz subsystem to
verify
    its tick dependency, migrate it to the new mask in order to include it
    to the all-in-one check.


and it seems to me that the removal of the log defeats the purpose that
commit e12d0271774fea9fddf tried to serve.

Please enlighten me as to how to achieve this and I will cook up
something.

Ani
