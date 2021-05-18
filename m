Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153BF386F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbhERBmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbhERBmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:42:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F2C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 18:41:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so617247pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pjy5w60FpAWG9FHGLlpjBUUubAhnFUl2QsqnA1hjKck=;
        b=KsP5nxaxO/8y7nmI2eQzwR1K0Isf5sQEd3fS7eSI0QVvJpMzM2wldQDEWmqbIqMcvY
         PK8JOfpnmU4Hrd6YDKO/AX2ntaySO81fkc5X+QUe1G7RyJ4hhhRw9f4rAzF7rXTiOqg+
         baogAteaEFWPcKx93GYjRqp6k4XD/C61w/RVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pjy5w60FpAWG9FHGLlpjBUUubAhnFUl2QsqnA1hjKck=;
        b=d8Raa8aAg3hnt+R+3oFVBCPF0zAuJQWvveMVISUqG8n6XqpPm3eVm5tRXqUGhZPTHg
         2cUEXhKasyk+0ISQhVj+Ai0wR6eKbEFDhbtgL4UML5gBstUWZcrXKKmsucXOlKV0snD8
         tz7mHAoWs49ryf9oEA9se9GElF1+09iKRsvi+Gz11M5SeI1RGjyWphF3Yia6/IrRJn+k
         tiocL895i9D7hkFnBMQ7U91DCyvw8yHKxJa6UmoM7ABeVQDVcBJf9TrcIHXCzjdCck28
         r4Am/Jb6SIcETwzahbhhmLf/lr08zIPfi0S8KHPjahrcSD5XnRNkl7fBVQsyhU9TezGk
         T3Xw==
X-Gm-Message-State: AOAM530Z3MqKMpKt3yGP5nhF1tlcomVQIRKrDG1rnNXlGCnzYSV4PAHU
        4WqyImb7BQGzwaIU+OOj9UKTaQ==
X-Google-Smtp-Source: ABdhPJxuzqErHqIEbbp9ZNiZIwWYgguRFzrUn8cZ+DD+0ENQ5SKmPkw2ObcBUDgsyrTx5egGhEdrwg==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr2584724pjr.12.1621302086604;
        Mon, 17 May 2021 18:41:26 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:1f25:dd29:abb6:257a])
        by smtp.gmail.com with ESMTPSA id v8sm10778557pff.220.2021.05.17.18.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:41:26 -0700 (PDT)
Date:   Tue, 18 May 2021 10:41:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKMbQQ0qBAixXC5p@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/17 09:23), Paul E. McKenney wrote:
> On Sun, May 16, 2021 at 07:27:16PM +0900, Sergey Senozhatsky wrote:
> > Soft watchdog timer function checks if a virtual machine
> > was suspended and hence what looks like a lockup in fact
> > is a false positive.
> > 
> > This is what kvm_check_and_clear_guest_paused() does: it
> > tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
> > and if it's set then we need to touch all watchdogs and bail
> > out.
> > 
> > Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
> > check works fine.
> > 
> > There is, however, one more watchdog that runs from IRQ, so
> > watchdog timer fn races with it, and that watchdog is not aware
> > of PVCLOCK_GUEST_STOPPED - RCU stall detector.
> > 
> > apic_timer_interrupt()
> >  smp_apic_timer_interrupt()
> >   hrtimer_interrupt()
> >    __hrtimer_run_queues()
> >     tick_sched_timer()
> >      tick_sched_handle()
> >       update_process_times()
> >        rcu_sched_clock_irq()
> > 
> > This triggers RCU stalls on our devices during VM resume.
> > 
> > If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
> > before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
> > then there is nothing on this VCPU that touches watchdogs and
> > RCU reads stale gp stall timestamp and new jiffies value, which
> > makes it think that RCU has stalled.
> > 
> > Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
> > don't report RCU stalls when we resume the VM.
> 
> Good point!
> 
> But if I understand your patch correctly, if the virtual machine is
> stopped at any point during a grace period, even if only for a short time,
> stall warnings are suppressed for that grace period forever, courtesy of
> the call to rcu_cpu_stall_reset().  So, if something really is stalling,
> and the virtual machine just happens to stop for a few milliseconds, the
> stall warning is completely suppressed.  Which would make it difficult
> to debug the underlying stall condition.
> 
> Is it possible to provide RCU with information on the duration of the
> virtual-machine stoppage so that RCU could adjust the timing of the
> stall warning?  Maybe by having something like rcu_cpu_stall_reset()
> that takes the duration of the stoppage in jiffies?

Good questions!

And I think I've some bad news and some good news.

As far as I can tell, none of the PVCLOCK_GUEST_STOPPED handlers take
the stoppage duration into consideration. For instance, as soon as
watchdog timer IRQ detects a potential softlockup it checks
PVCLOCK_GUEST_STOPPED and touches all watchdogs, including RCU:

watchdog_timer_fn()
 kvm_check_and_clear_guest_paused()
  pvclock_touch_watchdogs()
   rcu_cpu_stall_reset()                 // + the remaining watchdogs

But things get more complex.

pvclock_clocksource_read() also checks PVCLOCK_GUEST_STOPPED and calls
pvclock_touch_watchdogs(). And this path is executed rather often.

For instance,

apic_timer_interrupt()
 smp_apic_timer_interrupt()
  hrtimer_interrupt()
   __hrtimer_run_queues()
    hrtimer_wakeup()
     try_to_wake_up()
      update_rq_clock()
       sched_clock_cpu()
        sched_clock()
	 kvm_sched_clock_read()
	  kvm_clock_read()
	   pvclock_clocksource_read()
	    pvclock_touch_watchdogs()
	     rcu_cpu_stall_reset()       // + the remaining watchdogs

Or

do_IRQ
 irq_exit
  sched_clock_cpu
   sched_clock
    kvm_sched_clock_read
     kvm_clock_read
      pvclock_clocksource_read
       pvclock_touch_watchdogs
        rcu_cpu_stall_reset()            // + the remaining watchdogs

And so on...

You may wonder what are the good news then.

Well. I'd say that my patch (is not beautiful but it) does not add
a lot of additional or new damage. And it still fixes the valid race
condition, as far as I'm concerned.

I think we need to rework how pvclock_touch_watchdogs() does things
internally, basically what you suggested, and this can be a separate
effort.
