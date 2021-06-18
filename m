Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0183F3AC3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhFRGWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232881AbhFRGT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:19:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45234611CD;
        Fri, 18 Jun 2021 06:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623997038;
        bh=DKBV8eGHuSQy8H4OhHF30d+NZv2jVGL2zYU+5pJv3v0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SwwKPRZT4TieYmtNlWNHtUkg76+PbztcxnNEpyKtc0dy4ncPaQR7nl1kEPwnsaNCi
         WIw2wLtm5bZa2VOJPp9x3szhbK+rhdB8o2U6xTRQRqNvx4NLmrcccq5VH6w9EnJEoJ
         I/mr+GRII1LB5zr5cmRFD4VnCDu0CLRDyrZtMwHTQ00dhsucPF8OsE86A2qdaNflwp
         32Cy7ED7kOXsNHqIp46BNeEjzcoFrYe20pcl0L8Fe4ZknBC3yjTTbxjOxmW2nVZ2He
         tEGypAP2PZkjigi4RQAcdHe0cPjYcZkQmpzL/iw4QQuI9Hn4Iq9ZVbB0D8uqHfKGKR
         9ggHhloS9akhQ==
Date:   Fri, 18 Jun 2021 15:17:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-Id: <20210618151714.3ae6528eba99eea39771b859@kernel.org>
In-Reply-To: <1623934820.8pqjdszq8o.naveen@linux.ibm.com>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
        <1623934820.8pqjdszq8o.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 21:49:36 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Tue, 15 Jun 2021 23:11:27 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> Masami Hiramatsu wrote:
> >> > On Mon, 14 Jun 2021 23:33:29 +0530
> >> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >> > 
> >> >> We currently limit maxactive for a kretprobe to 4096 when registering
> >> >> the same through tracefs. The comment indicates that this is done so as
> >> >> to keep list traversal reasonable. However, we don't ever iterate over
> >> >> all kretprobe_instance structures. The core kprobes infrastructure also
> >> >> imposes no such limitation.
> >> >> 
> >> >> Remove the limit from the tracefs interface. This limit is easy to hit
> >> >> on large cpu machines when tracing functions that can sleep.
> >> >> 
> >> >> Reported-by: Anton Blanchard <anton@ozlabs.org>
> >> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >> > 
> >> > OK, but I don't like to just remove the limit (since it can cause
> >> > memory shortage easily.)
> >> > Can't we make it configurable? I don't mean Kconfig, but 
> >> > tracefs/options/kretprobe_maxactive, or kprobes's debugfs knob.
> >> > 
> >> > Hmm, maybe debugfs/kprobes/kretprobe_maxactive will be better since
> >> > it can limit both trace_kprobe and kprobes itself.
> >> 
> >> I don't think it is good to put a new tunable in debugfs -- we don't 
> >> have any kprobes tunable there, so this adds a dependency on debugfs 
> >> which shouldn't be necessary.
> >> 
> >> /proc/sys/debug/ may be a better fit since we have the 
> >> kprobes-optimization flag to disable optprobes there, though I'm not 
> >> sure if a new sysfs file is agreeable.
> > 
> > Indeed.
> > 
> >> But, I'm not too sure this really is a problem. Maxactive is a user 
> >> _opt-in_ feature which needs to be explicitly added to an event 
> >> definition. In that sense, isn't this already a tunable?
> > 
> > Let me explain the background of the limiation.
> 
> Thanks for the background on this.
> 
> > 
> > Maxactive is currently no limit for the kprobe kernel module API,
> > because the kernel module developer must take care of the max memory
> > usage (and they can).
> > 
> > But the tracefs user may NOT have enough information about what
> > happens if they pass something like 10M for maxactive (it will consume
> > around 500MB kernel memory for one kretprobe).
> 
> Ok, thinking more about this...
> 
> Right now, the only way for a user to notice that kretprobe maxactive is 
> an issue is by looking at kprobe_profile.  This is not even possible if 
> using a bcc tool, which uses perf_event_open().  It took the reporting 
> team some effort to even identify that the reason why they were getting 
> weird results when tracing was due to the default value used for 
> kretprobe maxactive; and then that 4096 was the hard limit through 
> tracefs.
> 
> So, IMO, anyone using any existing bcc tool, or a pre-canned perf script 
> will not even be able to identify this as a problem to begin with... at 
> least, not without some effort.

Yeah, the nmissed counter must be exposed in that case via tracefs or
debugfs. Maybe ebpf can also warn it (by checking nmissed count). 


> To address this, as a first step, we should probably consider parsing 
> kprobe_profile and printing a warning with 'perf' if we detect a 
> non-zero miss count for a probe -- both a regular probe, as well as a 
> retprobe.

Yeah, it is doable. Note that perf-probe only set up the event and
perf-trace or other commands will use it.


> If we do this, the nice thing with kprobe_profile is that the probe miss 
> count is available, and can serve as a good way to decide what a more 
> reasonable maxactive value should be. This should help prevent users 
> from trying with arbitrary maxactive values.

Such feedback loop is an interesting idea.
Note that nmissed count is an accumulate value, not the max number of
the instance which will be needed.

> For perf_event_open(), perhaps we can introduce an ioctl to query the 
> probe miss count.

Or, maybe we can expand the maxactive in runtime. e.g. add a shortage
counter on the kretprobe, and run a monitor kernel thread (or kworker).
If the shortage counter is incremented, the monitor allocates instances
(2x counter) and give it to the kretprobe. And it resets the shortage
counter. This adaptive maxactive may cause mis-hit in the beginning,
but finally find the optimal maxactive value automatically.


> > To avoid such trouble, I had set the 4096 limitation for the maxactive
> > parameter. Of course 4096 may not enough for some use-cases. I'm welcome
> > to expand it (e.g. 32k, isn't it enough?), but removing the limitation
> > may cause OOM trouble easily.
> 
> Do you have suggestions for how we can determine a better limit? As you 
> point out in the other email, there could very well be 64k or more 
> processes on a large machine. Since the primary concern is memory usage, 
> we probably need to decide this based on total memory. But, memory usage 
> will vary depending on system load...

This is very good question. IMHO, it might better to calculate the total
maxactive from the system memory size. For example, 1% of system memory
can be used for the kretprobes, 16GB system will allow using 160MB for
kretprobes, which means about "30M" is the max number of maxactive, or
multiple kretprobes can share it. Doesn't it sound enough? Of course
this will need to show the current usage of the kretprobe instance objects
via tracefs or debugfs. But this total cap seems reasonable for me to
avoid OOM trouble.

> Perhaps we can start by making maxactive limit be a tunable with a 
> default value of 4096, with the understanding that users will be careful 
> when bumping up this value. Hopefully, scripts won't simply start 
> writing into this file ;)

Yeah, that's what I suggested at first, because the best maxactive will
depend on the max number of the *processes* and the probed function.

If the probed function will NOT be preempted or slept, maxactive will be
the number of *processor cores*. Or, if it can be preempted or slept, it
will be the max number of *processes*. If the probed function can
recursively called (Note: this is rare case), the maxactive has to
be multiplied.

It is hard to estimate the max number of processes, since it depends
on the system. Small embedded systems don't run thousands of processes,
but big servers will run more than ten thousands of processes.
Thus make it tunable will be a good idea.

Thank you,

> 
> If we can feed back the probe miss count, tools should be able to guide 
> users on what would be a reasonable maxactive value to use.
> 
> 
> Thanks,
> Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
