Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21629360B05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhDONtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhDONtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:49:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71FF613BA;
        Thu, 15 Apr 2021 13:49:25 +0000 (UTC)
Date:   Thu, 15 Apr 2021 09:49:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] tracing/hwlat: Add a cpus file specific for
 hwlat_detector
Message-ID: <20210415094924.473a98df@gandalf.local.home>
In-Reply-To: <e5547e9a-d3d8-2cd1-7cb9-e567c798e78d@redhat.com>
References: <cover.1617889883.git.bristot@redhat.com>
        <94bbcd0e0f06b79aeb775e8dbf3a301f6679bb4c.1617889883.git.bristot@redhat.com>
        <20210414101019.7c5a66f6@gandalf.local.home>
        <e5547e9a-d3d8-2cd1-7cb9-e567c798e78d@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 15:09:50 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> But for the osnoise tracer the cpus file is really useful. For instance, on a 
> system with the CPU 7 isolated:
> 
> ----- %< -----
>  # echo 7 > osnoise/cpus
>  # echo target_cpu == 7 > events/sched/sched_wakeup/filter 
>  # echo stacktrace if target_cpu == 7 > events/sched/sched_wakeup/trigger
>  # echo 1 > events/sched/sched_wakeup/enable
>  # echo osnoise:thread_noise > set_event 
>  # echo osnoise > current_tracer
>  # cat trace 
>     [find...]
>      kworker/0:1-7       [000] d..5  1820.717780: <stack trace>
>  => trace_event_raw_event_sched_wakeup_template
>  => __traceiter_sched_wakeup
>  => ttwu_do_wakeup
>  => try_to_wake_up
>  => __queue_work
>  => queue_delayed_work_on
>  => vmstat_shepherd
>  => process_one_work
>  => worker_thread
>  => kthread
>  => ret_from_fork  
>      kworker/7:1-410     [007] d..3  1820.717790: thread_noise: kworker/7:1:410 start 1820.717786519 duration 3626 ns
>        osnoise/7-1000    [007] ....  1821.582340: 1000000         90  99.99100      15      1      0     12      6      1
> ----- >% -----  
> 
> It was possible to easily find that the '1' thread noise was a kworker,
> dispatched from CPU 0, and that it was dispatched by "vmstat_shepherd".
> 
> Also, the osnoise dir is not added to a new instance... so, it only
> costs "one" file...

Every file counts. ;-)

What you did not articulate well, is that you want the other trace points
to be traced on all CPUs (maybe) when the osnoise threads are on a few (or
vice versa).

OK, for osnoise, I can see how it is useful. But as you said above, for
hwlat tracer, it's not as useful.

-- Steve
