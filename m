Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF73BE762
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhGGLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGLtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:49:00 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEAEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:46:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g22so1942860pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/W6wqXaIDmqrBkdIRlzAJMgAoGBgy04IRL+F1Bx61lE=;
        b=zBj/27dHcc7lvTGWG7MHS/bpuQQu4WGZXv1+uKjRYpaBpre8T2ztMgPfIb3vPof+2i
         tXhIc6zXMCOAUO5sZUYKJlL5Z8XGJtftx8N54xLBdyHGe+4SoLYV5KRs4cxHbgzi1NGV
         FAaqJGEI0ipCRBJbY1G8NvKTD5YRE89qF3JHd4vk3QIU6jrCoIhopbqDzc6VAHplVRmz
         wl0E1ypuKckYKmSxLclQ8Mg3QSrvl1sBTUoHnOL3LX3xlkswb8Q6A6kMipHL68auwHLd
         QVSRvKiKd+BG66XUsWmEuvT9QrgAEdsRLcgqk/ileTiIoHo2fgKE3DGcZ5SYa8147rzf
         rDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/W6wqXaIDmqrBkdIRlzAJMgAoGBgy04IRL+F1Bx61lE=;
        b=Kx18ek+Wh4Xrp/JlvyR1aX2Xu6sPgTEhO7b44FlmsYCozsllJBukuJ2Bciek3h2xAX
         OIvAUu+4yRmTyYpftjPw04w+i8XFzorDa6IdYO4URUfmwUHHB6lriwcBaxULB+JWwzpi
         O4W1L6c67uW4DecUfWyPNHWgb8aJn/QpSGVJyb5PvEoLqpO6le+Hj7aKR26oGuDfMQmY
         VitRrtsUDT5iTV3QQ7rSOB1rErew5FbKZqjL7/nVNgq1xxF/nwRxkjrZfJ04A2bs94AI
         BGRJg5SEa6+7wr1iptlLIYFQrFSlke1P3fJrWxEg/28Rrb8fa2JG4jK7P0wDbSZiD21T
         jV/g==
X-Gm-Message-State: AOAM533lv+dmeNbPT6EqNBwJMBCEb/DZF4ltCIS5qcqNkYNtaDlo0tP1
        +aARZsFSqFEhBgj31SfvAzrQ5w==
X-Google-Smtp-Source: ABdhPJwgGEEt6VotvPf9NUkaZjJ15bm060VFu0d7noueCvci++I4MwyP4m9S9LVfLHW+/PInXprkCQ==
X-Received: by 2002:aa7:8543:0:b029:31c:85d:60fe with SMTP id y3-20020aa785430000b029031c085d60femr19643168pfn.44.1625658378656;
        Wed, 07 Jul 2021 04:46:18 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.127.142])
        by smtp.googlemail.com with ESMTPSA id i24sm17773958pfr.56.2021.07.07.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:46:18 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Wed, 7 Jul 2021 17:15:53 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2] sched/clock: print a log when the sched clock is
 marked unstable
In-Reply-To: <YOWNWq0IHHP3Fdhz@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2107071714060.196080@anisinha-lenovo>
References: <20210707105659.194171-1-ani@anisinha.ca> <YOWNWq0IHHP3Fdhz@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jul 2021, Peter Zijlstra wrote:

> On Wed, Jul 07, 2021 at 04:26:59PM +0530, Ani Sinha wrote:
> > When the sched clock transitions from stable to unstable and
> > vice versa, a kernel log is printed. When the sched clock
> > is marked explicitly as unstable, make __clear_sched_clock_stable()
> > emit a warning log. It is useful for example in understanding
> > why a certain feature like NOHZ that depends on availability of a
> > stable sched clock, is not available.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  kernel/sched/clock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > Changelog:
> > V1: original patch
> > v2: print pr_warn from __clear_sched_clock_stable instead. Commit log
> >     updated with proper prefix and wording.
> >
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index c2b2859ddd82..99484fec0335 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -183,6 +183,7 @@ static void __clear_sched_clock_stable(void)
> >  		return;
> >
> >  	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
> > +	pr_warn("sched_clock: Marking unstable.\n");
> >  	schedule_work(&sched_clock_work);
> >  }
>
> I'm confused... that work has a ton of printk()s in, what is this
> pr_warn() adding?
>

Right, but for whatever reason, on latest version of Ubuntu (21.04)
running on hyperV, I do not see those logs:

azureuser@CentOS:~$ uname -a
Linux CentOS 5.11.0-1009-azure #9-Ubuntu SMP Thu Jun 17 02:20:07 UTC 2021
x86_64 x86_64 x86_64 GNU/Linux
azureuser@CentOS:~$ dmesg | grep unstable
dmesg: read kernel buffer failed: Operation not permitted
azureuser@CentOS:~$ sudo su
root@CentOS:/home/azureuser# dmesg | grep unstable
[    0.000000] tsc: Marking TSC unstable due to running on Hyper-V
root@CentOS:/home/azureuser# dmesg | grep sched
[    0.384656] rcu: RCU calculated value of scheduler-enlistment delay is
25 jiffies.
[    1.122977] io scheduler mq-deadline registered
root@CentOS:/home/azureuser# exit

Hence, I was trying the patch.

A
