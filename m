Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41C53AF241
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhFURsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhFURsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:48:54 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A945A60041;
        Mon, 21 Jun 2021 17:46:38 +0000 (UTC)
Date:   Mon, 21 Jun 2021 13:46:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 05/12] trace/hwlat: Support hotplug operations
Message-ID: <20210621134636.5b332226@oasis.local.home>
In-Reply-To: <c87c24bd-253c-a645-1f29-83c558d8d4c5@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
        <8899f8a8bec38bc600f7a2c61bc6ca664aa7beeb.1623746916.git.bristot@redhat.com>
        <20210618124503.388fe4d4@oasis.local.home>
        <20210618150020.689439d4@oasis.local.home>
        <c4b86b0e-b45d-3039-f49c-0dc53e1adcbd@redhat.com>
        <20210621112528.12aee665@oasis.local.home>
        <c87c24bd-253c-a645-1f29-83c558d8d4c5@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 18:14:36 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> >> Yep! I tried to take the trace_type_lock here, and got the lockdep info about
> >> this problem.
> >>  
> >>> The only thing I could think of is to wake up a worker thread to do the
> >>> work. That is, this just wakes the worker thread, then the worker grabs
> >>> the trace_types_lock, iterates through the cpu mask of expect running
> >>> threads, and then starts or kills them depending on the hwlat_busy
> >>> value.    
> >> So, it will not wait for the kworker to run?  
> > What wont wait?  
> 
> For example, at the shutdown, should the hotplug callback wait for the workqueue
> to run & kill the thread, or not?

Doing that won't help the deadlock situation.

	CPU 1			CPU 2
	-----			-----
    Start shutdown
    down online_cpus()

			   mutex_lock(trace_types_lock);
			   get_online_cpus()
			   [BLOCK]

    wake_up_thread;
    [schedule worker]

    mutex_lock(trace_types_lock);

 [ DEADLOCK ]


Make all access to save_cpumask and hwlat_per_cpu_data inside the
get_online_cpus() protection. (like in move_to_next_cpu(),
start_single_thread() expand the get_online_cpus()).

Then in the cpu going down case, we can simply kill the thread and
update the save_cpumask, as it will be protected by the
get_online_cpus() code.

That is, don't even check if hwlat_busy is set or not. Just simply do:


CPU_DOWN:

	stop_cpu_kthead(cpu);

That will stop the kthread if it is running.  But we should update
that function to also set per_cpu(hwlat_per_cpu_data).kthread = NULL;
Like stop_single_kthread() does.

But for CPU_UP, we should do the work via a worker thread.

CPU_UP:
	schedule_work_on(&update_kthreads, cpu);

Which in the work function for that update_kthreads work queue:

	mutex_lock(&trace_types_lock);
	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
		goto out_unlock;

	get_online_cpus();
	if (!this_cpu(hwlat_per_cpu_data).kthread)
		start_per_cpu_kthread(smp_processor_id());
	put_online_cpus();

 out_unlock:
	mutex_unlock(&trace_types_lock);

Or something like that.

-- Steve
