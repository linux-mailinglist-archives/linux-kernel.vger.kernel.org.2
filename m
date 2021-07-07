Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB703BE7B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhGGMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhGGMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:21:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53CAC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 05:18:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fs7so1431991pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vkHA6LR/4YdsktFAdkRpizTIR7eEoBlKowBOEhkg9u4=;
        b=ep2XnMAzyVR9fcMxEkiXLWEgNHSE/ZToSfuorddtoJqGdXkzoixiPQWIJXklImRHp3
         xFfR7LzUqcwk9msoKp7rNaoH/XDrJY7w80uHk1ZfJ5cQdTaQOzgsaLpxSl+15STYrL91
         ShS19N1BdjixxiUZ5RTYLTxqPt9ah1CKP0aM3aL0MLA2P1vVCwCPfJx1V8qFiyjEEMhx
         VBSW7uVEBUr4aemwptbW8gbllTtXH4S6cDVi5wtIcTwJpz5S+Kzit94yuNxecoe4pnCo
         TmVHUrYEgxGnrW9f1vGpiJVTWYMv9d2P05NmyuLJbC399ZougvRLxtZHPF4oQTe6y6lw
         8YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vkHA6LR/4YdsktFAdkRpizTIR7eEoBlKowBOEhkg9u4=;
        b=P4/JK478OVdFkRJbgz6AH6BICsx1E5EaIuD6OpWffJqS2hhyjtynmh6NMJmJx86rkB
         0WDCqxt1MqIyn+f+mDy7xXxfYF/oEGVdmlvqTeXDHIStwGY1r/BtQeYjEM7PJSp7Oacf
         oGi83b1VPo9gPhS76VqdKABUfDXfiqpoiuXJASoKoTx+qjhN+tKJh3eBclZH7dHkdhuM
         Vv68Mny7SRFwpfAEvY7B8kcb3OGVJpFwdcjAwW1jF7bbu/FmZJsysemF9g+38MeEMI8K
         YjoJoPvH8SO4i5zz3iK9W2SElr6HOJahqLmlNjEg3ZMJj3yFhl+uAq1CteMB1+9mMtDR
         lXVA==
X-Gm-Message-State: AOAM532U1CgPid9m2vvjpYPow6uY1LWX82EGYBv31m9ESum55vuMJzxS
        QJVXC4q1cxBeE8wcfiBeNhtS4A==
X-Google-Smtp-Source: ABdhPJyiLa/d+syAkKjqIi1StcSEApys3+PqL336REeEnF5hwcmmJeRXooJfuaDz6p4qoh4q2NdErw==
X-Received: by 2002:a17:90a:2e14:: with SMTP id q20mr5746777pjd.188.1625660337239;
        Wed, 07 Jul 2021 05:18:57 -0700 (PDT)
Received: from 192.168.1.6 ([115.96.127.142])
        by smtp.googlemail.com with ESMTPSA id y16sm19929054pfe.70.2021.07.07.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 05:18:56 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Wed, 7 Jul 2021 17:48:36 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Ani Sinha <ani@anisinha.ca>
cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2] sched/clock: print a log when the sched clock is
 marked unstable
In-Reply-To: <alpine.DEB.2.22.394.2107071714060.196080@anisinha-lenovo>
Message-ID: <alpine.DEB.2.22.394.2107071731530.196080@anisinha-lenovo>
References: <20210707105659.194171-1-ani@anisinha.ca> <YOWNWq0IHHP3Fdhz@hirez.programming.kicks-ass.net> <alpine.DEB.2.22.394.2107071714060.196080@anisinha-lenovo>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jul 2021, Ani Sinha wrote:

>
>
> On Wed, 7 Jul 2021, Peter Zijlstra wrote:
>
> > On Wed, Jul 07, 2021 at 04:26:59PM +0530, Ani Sinha wrote:
> > > When the sched clock transitions from stable to unstable and
> > > vice versa, a kernel log is printed. When the sched clock
> > > is marked explicitly as unstable, make __clear_sched_clock_stable()
> > > emit a warning log. It is useful for example in understanding
> > > why a certain feature like NOHZ that depends on availability of a
> > > stable sched clock, is not available.
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > ---
> > >  kernel/sched/clock.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > Changelog:
> > > V1: original patch
> > > v2: print pr_warn from __clear_sched_clock_stable instead. Commit log
> > >     updated with proper prefix and wording.
> > >
> > > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > > index c2b2859ddd82..99484fec0335 100644
> > > --- a/kernel/sched/clock.c
> > > +++ b/kernel/sched/clock.c
> > > @@ -183,6 +183,7 @@ static void __clear_sched_clock_stable(void)
> > >  		return;
> > >
> > >  	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
> > > +	pr_warn("sched_clock: Marking unstable.\n");
> > >  	schedule_work(&sched_clock_work);
> > >  }
> >
> > I'm confused... that work has a ton of printk()s in, what is this
> > pr_warn() adding?
> >
>
> Right, but for whatever reason, on latest version of Ubuntu (21.04)
> running on hyperV, I do not see those logs:
>
> azureuser@CentOS:~$ uname -a
> Linux CentOS 5.11.0-1009-azure #9-Ubuntu SMP Thu Jun 17 02:20:07 UTC 2021
> x86_64 x86_64 x86_64 GNU/Linux
> azureuser@CentOS:~$ dmesg | grep unstable
> dmesg: read kernel buffer failed: Operation not permitted
> azureuser@CentOS:~$ sudo su
> root@CentOS:/home/azureuser# dmesg | grep unstable
> [    0.000000] tsc: Marking TSC unstable due to running on Hyper-V
> root@CentOS:/home/azureuser# dmesg | grep sched
> [    0.384656] rcu: RCU calculated value of scheduler-enlistment delay is
> 25 jiffies.
> [    1.122977] io scheduler mq-deadline registered
> root@CentOS:/home/azureuser# exit
>
> Hence, I was trying the patch.

OK never mimd. Seems on hyperV, they use read_hv_sched_clock_tsc() for
pv_sched_clock and therefore using_native_sched_clock() returns false.
Thus, clear_sched_clock_stable() is not called.

I will need to do some instrumentation to confirm this. Maybe we do not
need any patching after all.
