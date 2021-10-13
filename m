Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52F142C5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhJMQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhJMQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634141214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FEEhJrRNaD7GTms5d9szZToUgUBP1dWBXeU+qS5AY2c=;
        b=X+p+IRO88+eakT76g+3bMNAIIliXfobSFBVjOvxAgBeG1qGpSlranA3XTz6M8piI7t2YgT
        j5Amr5+NpqfOOz/jBibS3F/t5fRdws4O0Te7P7bLfPLBSTcv0qD5QkSjNrcRDJFPVuLHAf
        c5y8hZH12RYid1KOHIw3b10gFgdG1m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-6fUmlcO2MS2jwp1v4c_x9g-1; Wed, 13 Oct 2021 12:06:50 -0400
X-MC-Unique: 6fUmlcO2MS2jwp1v4c_x9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30E65802928;
        Wed, 13 Oct 2021 16:06:49 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87A66694B5;
        Wed, 13 Oct 2021 16:06:48 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 103A841A801C; Wed, 13 Oct 2021 13:06:30 -0300 (-03)
Date:   Wed, 13 Oct 2021 13:06:30 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch v4 1/8] add basic task isolation prctl interface
Message-ID: <20211013160630.GA106511@fuller.cnet>
References: <20211007192346.731667417@fedora.localdomain>
 <20211007193525.755160804@fedora.localdomain>
 <YWWIHkoAdTkzU0TP@hirez.programming.kicks-ass.net>
 <20211013105637.GA88322@fuller.cnet>
 <YWb0ycw/sNV8isBH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWb0ycw/sNV8isBH@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:01:29PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 07:56:37AM -0300, Marcelo Tosatti wrote:
> > Hi Peter,
> > 
> > On Tue, Oct 12, 2021 at 03:05:34PM +0200, Peter Zijlstra wrote:
> > > On Thu, Oct 07, 2021 at 04:23:47PM -0300, Marcelo Tosatti wrote:
> > > > Add basic prctl task isolation interface, which allows
> > > > informing the kernel that application is executing 
> > > > latency sensitive code (where interruptions are undesired).
> > > > 
> > > > Interface is described by task_isolation.rst (added by
> > > > next patch).
> > > 
> > > That does not absolve you from actually writing a changelog here.
> > > Life is too short to try and read rst shit.
> > 
> > The rst is concise and contains all necessary information.
> 
> rst is a piece of crap and makes it harder to read plain text files.
> 
> > Changelog is on the patch header (I would appreciate reviews of
> > the interface itself, not sure why the changelog is important).
> 
> Adding an interface without Changelog is a no-no. Changelogs go on the
> patches themselves, not someplace random.

OK, can move the changelog to the patches.

> > The rst compiled in PDF form is attached. Its only 6 pages long, it
> > described the interface (please if you think of any improvement 
> > to that document, and not only the interface).
> 
> Wth would I want to read a pdf? Plain text is what I want, without
> added crap on. That's my complaint with rst, it makes reading the actual
> document harder by having all that nonsense sprinkled in.

I understand. At the end of this message is a rst2txt convertion
for your convenience.

> I spend 99% of my time looking at fixed width text in a text editor.
> Having to open a browser or some random other crap gui program is a
> fail.

OK. Please review the API document at the end of this message.

> > > including the kill-me-on-any-interruption thing, vs the inherently racy
> > > nature of some of the don't disturb me stuff.
> > 
> > The kill-me-on-any-interruption thing is not included in this patchset
> > (maybe it can be implemented using this interface, if desired, but we
> > do not see the need for such feature at the moment).
> 
> It's something that has been requested lots, and has been part of
> previous series. 

So what i understand from Alex's comments is that the kill-on-interruption
feature is useful when developing/improving a program to be interruption free:

"The kernel must be built with the new TASK_ISOLATION Kconfig flag
to enable this mode, and the kernel booted with an appropriate   
"isolcpus=nohz,domain,CPULIST" boot argument to enable
nohz_full and isolcpus. The "task_isolation" state is then indicated
by setting a new task struct field, task_isolation_flag, to the
value passed by prctl(), and also setting a TIF_TASK_ISOLATION
bit in the thread_info flags. When the kernel is returning to
userspace from the prctl() call and sees TIF_TASK_ISOLATION set,
it calls the new task_isolation_start() routine to arrange for
the task to avoid being interrupted in the future.

With interrupts disabled, task_isolation_start() ensures that kernel
subsystems that might cause a future interrupt are quiesced. If it
doesn't succeed, it adjusts the syscall return value to indicate that
fact, and userspace can retry as desired. In addition to stopping
the scheduler tick, the code takes any actions that might avoid
a future interrupt to the core, such as a worker thread being
scheduled that could be quiesced now (e.g. the vmstat worker)
or a future IPI to the core to clean up some state that could be
cleaned up now (e.g. the mm lru per-cpu cache).

The last stage of enabling task isolation happens in
task_isolation_exit_to_user_mode() that runs last before returning
to userspace and changes ll_isol_flags (see later) to prevent other
CPUs from interfering with isolated task.

Once the task has returned to userspace after issuing the prctl(),
if it enters the kernel again via system call, page fault, or any
other exception or irq, the kernel will send it a signal to indicate
isolation loss. In addition to sending a signal, the code supports a
kernel command-line "task_isolation_debug" flag which causes a stack
backtrace to be generated whenever a task loses isolation.

To allow the state to be entered and exited, the syscall checking
test ignores the prctl(PR_TASK_ISOLATION) syscall so that we can
clear the bit again later, and ignores exit/exit_group to allow
exiting the task without a pointless signal being delivered.

The prctl() API allows for specifying a signal number to use instead
of the default SIGKILL, to allow for catching the notification
signal; for example, in a production environment, it might be
helpful to log information to the application logging mechanism
before exiting. Or, the signal handler might choose to reset the
program counter back to the code segment intended to be run isolated
via prctl() to continue execution."

First of all, the isolation breaking event might be unrelated
to the current state of the task isolated program (but due 
to an unrelated event, such as a TLB flush, caused by
other programs, due to other activities).

So this patchset does not support sending a signal on 
isolation breaking. There is a bcc tool, which allows
one to see the functions which interrupt the application:

Overview
This is a repo that keeps RT related tracing tools implemented using eBPF. Currently it only contains rt-trace-bcc.py.

rt-trace-bcc.py
rt-trace-bcc.py is a python-bcc based tool for tracking RT related issues. When it's executed in the background, it'll dump suspecious kernel func-calls that may affect real-time determinism of target cores. It can also record all the relative information and report when it quits (by either Ctrl-C from the command line, or a kill $PID with SIGTERM).

It should be able to run this script on any modern kernel, however it's majorly targeted at RHEL8.

Install dependencies
sudo dnf install python3 python-bcc
We can also install it using pip3:

pip3 install bcc
How to use
A help message captured from v0.1.7:

$ ./rt-trace-bcc.py -v
Version: 0.1.6

$ ./rt-trace-bcc.py -h
usage: rt-trace-bcc.py [-h] [--cpu-list CPU_LIST] [--backtrace] [--debug] [--version] [--summary] [--quiet]

Bcc-based trace tool for Real-Time workload.

optional arguments:
  -h, --help            show this help message and exit
  --cpu-list CPU_LIST, -c CPU_LIST
                        Cores to trace interruptions (e.g., 1,2-5,8)
  --backtrace, -b       Whether dump backtrace when possible (default: off)
  --debug, -d           Whether run with debug mode (default: off)
  --version, -v         Dump version information (current: 0.1.7)
  --summary, -s         Dump summary when stop/SIGINT (default: off)
  --quiet, -q           Quiet mode; only dump summary (implies "-s" too)
Here --cpu-list parameter is required as the target cores of the tracing. Normally it should be the isolated cores, or a subset of isolated cores on the system.

Example usage
Run below command in the background to start dumping suspecious calls to stdout happened on cores 36-39:

$ sudo ./rt-trace-bcc.py -c 36-39
[There can be some warnings dumped; we can ignore them]
Enabled hook point: process_one_work
Enabled hook point: __queue_work
Enabled hook point: __queue_delayed_work
Enabled hook point: generic_exec_single
Enabled hook point: smp_call_function_many_cond
Enabled hook point: irq_work_queue
Enabled hook point: irq_work_queue_on
TIME(s)            COMM                 CPU  PID      MSG
0.009599293        rcuc/8               8    75       irq_work_queue_on (target=36, func=nohz_full_kick_func)
0.009603039        rcuc/8               8    75       irq_work_queue_on (target=37, func=nohz_full_kick_func)
0.009604047        rcuc/8               8    75       irq_work_queue_on (target=38, func=nohz_full_kick_func)
0.009604848        rcuc/8               8    75       irq_work_queue_on (target=39, func=nohz_full_kick_func)
0.103600589        rcuc/8               8    75       irq_work_queue_on (target=36, func=nohz_full_kick_func)
0.103604182        rcuc/8               8    75       irq_work_queue_on (target=37, func=nohz_full_kick_func)
0.103605222        rcuc/8               8    75       irq_work_queue_on (target=38, func=nohz_full_kick_func)
Use Ctrl-C to stop tracing.

Run below command in the background to start recording suspecious calls to stdout happened on cores 36-39, enable backtrace, with quiet mode (so no record is dumped immediately; the result will only be dumped in JSON when the script quits):

$ sudo ./rt-trace-bcc.py -c 36-39 -b -q
[There can be some warnings dumped; we can ignore them]
Enabled hook point: process_one_work
Enabled hook point: __queue_work
Enabled hook point: __queue_delayed_work
Enabled hook point: generic_exec_single
Enabled hook point: smp_call_function_many_cond
Enabled hook point: irq_work_queue
Enabled hook point: irq_work_queue_on
Press Ctrl-C to show results..
^CDump summary of messages:
{
    "irq_work_queue_on (target=36, func=nohz_full_kick_func)": {
        "count": 66,
        "backtrace": [
            "irq_work_queue_on+0x1",
            "tick_nohz_dep_set_all+0x55",
            "rcu_do_batch+0x435",
            "rcu_core+0x175",
            "rcu_cpu_kthread+0xa5",
            "smpboot_thread_fn+0x1d6",
            "kthread+0x15d",
            "ret_from_fork+0x35"
        ]
    },
    "irq_work_queue (cpu=36, func=nohz_full_kick_func)": {
        "count": 1,
        "backtrace": [
            "irq_work_queue+0x1"
        ]
    },
    "__queue_work (target=36, func=vmstat_update)": {
        "count": 2,
        "backtrace": [
            "__queue_work+0x1",
            "call_timer_fn+0x32",
            "run_timer_softirq+0x482",
            "__do_softirq+0xa5",
            "run_ksoftirqd+0x38",
            "smpboot_thread_fn+0x1d6",
            "kthread+0x15d",
            "ret_from_fork+0x35"
        ]
    },
    "__queue_delayed_work (target=37, func=vmstat_update, delay=9801)": {
        "count": 1,
        "backtrace": [
            "__queue_delayed_work+0x1",
            "queue_delayed_work_on+0x36",
            "process_one_work+0x18f",
            "worker_thread+0x30",
            "kthread+0x15d",
            "ret_from_fork+0x35"
        ]
    },
    ...
}

> Since it's a known and desired feature, any proposed
> interface ought to be able to deal with it. 

Can easily come up with an extension to this interface
that would allow for this feature to be implemented (ignoring
any signal races).

> Otherwise we need to invent
> yet another interface once that feature does get around to be
> implemented.

This interface is extensible. So you can add a new "isolation feature"
to configure it.

What are the requirements of the signal exactly (and why it is popular) ?
Because the interruption event can be due to:

* An IPI.
* A system call.

In the "full task isolation mode" patchset (the one from Alex), a system call
will automatically generate a SIGKILL once a system call is performed
(after the prctl to enable task isolated mode, but
before the prctl to disable task isolated mode).
This can be implemented, if desired, by SECCOMP syscall blocking
(which already exists).

For other interruptions, which happen through IPIs, one can print
the stack trace of the program (or interrupt) that generated
the IPI to find out the cause (which is what rt-trace-bpf.py is doing).

An alternative would be to add tracepoints so that one can
find out which function in the kernel caused the CPU and
task to become "a target for interruptions".

> > > Also, see:
> > > 
> > >   https://lkml.kernel.org/r/20210929152429.186930629@infradead.org
> > 
> > As you can see from the below pseudocode, we were thinking of queueing
> > the (invalidate icache or TLB flush) in case app is in userspace,
> > to perform on return to kernel space, but the approach in your patch might be
> > superior (will take sometime to parse that thread...).
> 
> Let me assume you're talking about kernel TLB invalidates, otherwise it
> would be terribly broken.
> 
> > > Suppose:
> > > 
> > > 	CPU0					CPU1
> > > 
> > > 	sys_prctl()
> > > 	<kernel entry>
> > > 	  // marks task 'important'
> > > 						text_poke_sync()
> > > 						  // checks CPU0, not userspace, queues IPI
> > > 	<kernel exit>
> > > 
> > > 	$important userspace			  arch_send_call_function_ipi_mask()
> > > 	<IPI>
> > > 	  // finds task is 'important' and
> > > 	  // can't take interrupts
> > > 	  sigkill()
> > > 
> > > *Whoopsie*
> > > 
> > > 
> > > Fundamentally CPU1 can't elide the IPI until CPU0 is in userspace,
> > > therefore CPU0 can't wait for quescence in kernelspace, but if it goes
> > > to userspace, it'll get killed on interruption. Catch-22.
> > 
> > We have been using a BPF tool for logging and monitoring of
> > interruptions:
> > https://github.com/xzpeter/rt-trace-bpf
> 
> I've no idea what you need bpf for, we have tracepoints in the entry
> paths that should suffice.

See the output of rt-trace-bpf.py above (it prints useful information,
for example it shows which CPU generated the interruption to an 
isolated CPU, and prints the backtrace on that "interruptor CPU").

> > But there is no such thing as 
> > 
> >          // finds task is 'important' and
> >          // can't take interrupts
> >          sigkill()
> > 
> > On this patchset.
> 
> But the interface should allow for it.

Well, you can add a feature, query whether the kernel supports it.

However the exact reason for the attention to the races of SIGKILL do 
not seem useful to me (you either know your app generated a 
system call, or you get an IPI, in which case you have enough 
information to find the source of the IPI?).

> > We have been discussing something like this to avoid TLBs / invalidate
> > i-cache IPIs, but 
> > 
> >  #define CPU_REQ_FLUSH_TLB       0x1     /*      __flush_tlb_all()       */ 
> >  #define CPU_REQ_INV_ICACHE      0x2     /*      sync_core()             */ 
> 
> sync_core() is *NOT* an I$ flush.
> 
> >  
> >  #define IN_USER_MODE            (0x1 << 16) 
> >  
> >  /* when CPU is in kernel mode, should IPI rather than queuing the 
> >     request on per-cpu state variable */ 
> >  #define IN_KERNEL_MODE                (0) 
> >  
> >  Then on entry/exit would have to add a conditional branch: 
> >  
> >  Exit to userspace: 
> >  ----------------- 
> >  
> >        cpu = smp_processor_id(); 
> >  
> >        if (isolation_enabled(cpu)) { 
> >                atomic_or(IN_USER_MODE, &percpudata->user_kernel_state); 
> >        } 
> >  
> >  Kernel entry: 
> >  ------------- 
> >  
> >        cpu = smp_processor_id(); 
> >  
> >        if (isolation_enabled(cpu)) { 
> >                reqs = atomic_xchg(&percpudata->user_kernel_state, IN_KERNEL_MODE); 
> >                if (reqs & CPU_REQ_FLUSH_TLB) 
> >                        flush_tlb_all(); 
> >                if (reqs & CPU_REQ_INV_ICACHE) 
> >                        invalidate_icache(); 
> >        } 
> >  
> >  Request side: 
> >  ------------- 
> >  
> >        int targetcpu; 
> >  
> >        do { 
> >                struct percpudata *pcpudata = per_cpu(&percpudata, targetcpu); 
> >  
> >                old_state = pcpudata->user_kernel_state; 
> >  
> >                /* in kernel mode ? */ 
> >                if (!(old_state & IN_USER_MODE)) { 
> >                        smp_call_function_single(request_fn, targetcpu, 1); 
> >                        break; 
> >                } 
> >                new_state = remote_state | CPU_REQ_FLUSH_TLB; // (or CPU_REQ_INV_ICACHE)
> >        } while (atomic_cmpxchg(&pcpudata->user_kernel_state, old_state, new_state) != old_state); 
> > 
> 
> That's absolutely terrible :/ you're adding extra unconditinal atomics
> to the entry/exit path instead of using the ones that are already there.
> That's no good.

Ok, will look into what is already there (in the entry/exit paths).

> Also, you're very much not dealing with that race either.

Not sure why the race you mention is relevant. So upon isolation
breaking, the signal (informing of a isolation breaking) has to be sent
at a specific point in execution? Why?

> Also, I think you're broken vs instrumentation, all of this needs to
> happen super early on entry, possibly while still on the entry stack,
> otherwise the missed TLBi might be handled too late and we just used a
> stale TLB entry.

Probably, yes.

-----------

Task isolation prctl interface
******************************

Certain types of applications benefit from running uninterrupted by
background OS activities. Realtime systems and high-bandwidth
networking applications with user-space drivers can fall into the
category.

To create an OS noise free environment for the application, this
interface allows userspace to inform the kernel the start and end of
the latency sensitive application section (with configurable system
behaviour for that section).

Note: the prctl interface is independent of nohz_full=.

The prctl options are:

   * PR_ISOL_FEAT_GET: Retrieve supported features.

   * PR_ISOL_CFG_GET: Retrieve task isolation configuration.

   * PR_ISOL_CFG_SET: Set task isolation configuration.

   * PR_ISOL_ACTIVATE_GET: Retrieve task isolation activation state.

   * PR_ISOL_ACTIVATE_SET: Set task isolation activation state.

Summary of terms:

* feature:

     A distinct attribute or aspect of task isolation. Examples of
     features could be logging, new operating modes (eg: syscalls
     disallowed), userspace notifications, etc. The only feature
     currently available is quiescing.

* configuration:

     A specific choice from a given set of possible choices that
     dictate how the particular feature in question should behave.

* activation state:

     The activation state (whether activate/inactive) of the task
     isolation features (features must be configured before being
     activated).

Inheritance of the isolation parameters and state, across fork(2) and
clone(2), can be changed via PR_ISOL_CFG_GET/PR_ISOL_CFG_SET.

At a high-level, task isolation is divided in two steps:

1. Configuration.

2. Activation.

Section "Userspace support" describes how to use task isolation.

In terms of the interface, the sequence of steps to activate task
isolation are:

1. Retrieve supported task isolation features (PR_ISOL_FEAT_GET).

2. Configure task isolation features
   (PR_ISOL_CFG_GET/PR_ISOL_CFG_SET).

3. Activate or deactivate task isolation features
   (PR_ISOL_ACTIVATE_GET/PR_ISOL_ACTIVATE_SET).

This interface is based on ideas and code from the task isolation
patchset from Alex Belits: https://lwn.net/Articles/816298/


Feature description
===================

   * "ISOL_F_QUIESCE"

   This feature allows quiescing select kernel activities on return
   from system calls.


Interface description
=====================

**PR_ISOL_FEAT**:

   Returns the supported features and feature capabilities, as a
   bitmask:

      prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);

   The 'feat' argument specifies whether to return supported features
   (if zero), or feature capabilities (if not zero). Possible values
   for 'feat' are:

   * "0":

        Return the bitmask of supported features, in the location
        pointed  to  by  "(int *)arg3". The buffer should allow space
        for 8 bytes.

   * "ISOL_F_QUIESCE":

        Return a structure containing which kernel activities are
        supported for quiescing, in the location pointed to by "(int
        *)arg3":

           struct task_isol_quiesce_extensions {
                   __u64 flags;
                   __u64 supported_quiesce_bits;
                   __u64 pad[6];
           };

        Where:

        *flags*: Additional flags (should be zero).

        *supported_quiesce_bits*: Bitmask indicating
           which features are supported for quiescing.

        *pad*: Additional space for future enhancements.

   Features and its capabilities are defined at
   include/uapi/linux/task_isolation.h.

**PR_ISOL_CFG_GET**:

   Retrieve task isolation configuration. The general format is:

      prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);

   The 'what' argument specifies what to configure. Possible values
   are:

   * "I_CFG_FEAT":

        Return configuration of task isolation features. The 'arg3'
        argument specifies whether to return configured features (if
        zero), or individual feature configuration (if not zero), as
        follows.

        * "0":

             Return the bitmask of configured features, in the
             location pointed  to  by  "(int *)arg4". The buffer
             should allow space for 8 bytes.

        * "ISOL_F_QUIESCE":

             Return the control structure for quiescing of background
             kernel activities, in the location pointed to by "(int
             *)arg4":

                struct task_isol_quiesce_control {
                       __u64 flags;
                       __u64 quiesce_mask;
                       __u64 pad[6];
                };

             Where:

             *flags*: Additional flags (should be zero).

             *quiesce_mask*: A bitmask containing which activities are
             configured for quiescing.

             *pad*: Additional space for future enhancements.

   * "I_CFG_INHERIT":

        Retrieve inheritance configuration across fork/clone.

        Return the structure which configures inheritance across
        fork/clone, in the location pointed to by "(int *)arg4":

           struct task_isol_inherit_control {
                   __u8    inherit_mask;
                   __u8    pad[7];
           };

        See PR_ISOL_CFG_SET description for meaning of bits.

**PR_ISOL_CFG_SET**:

   Set task isolation configuration. The general format is:

      prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);

   The 'what' argument specifies what to configure. Possible values
   are:

   * "I_CFG_FEAT":

        Set configuration of task isolation features. 'arg3' specifies
        the feature. Possible values are:

        * "ISOL_F_QUIESCE":

             Set the control structure for quiescing of background
             kernel activities, from the location pointed to by "(int
             *)arg4":

                struct task_isol_quiesce_control {
                       __u64 flags;
                       __u64 quiesce_mask;
                       __u64 pad[6];
                };

             Where:

             *flags*: Additional flags (should be zero).

             *quiesce_mask*: A bitmask containing which kernel
             activities to quiesce.

             *pad*: Additional space for future enhancements.

             For quiesce_mask, possible bit sets are:

             * "ISOL_F_QUIESCE_VMSTATS"

             VM statistics are maintained in per-CPU counters to
             improve performance. When a CPU modifies a VM statistic,
             this modification is kept in the per-CPU counter. Certain
             activities require a global count, which involves
             requesting each CPU to flush its local counters to the
             global VM counters.

             This flush is implemented via a workqueue item, which
             might schedule a workqueue on isolated CPUs.

             To avoid this interruption, task isolation can be
             configured to, upon return from system calls, synchronize
             the per-CPU counters to global counters, thus avoiding
             the interruption.

             To ensure the application returns to userspace with no
             modified per-CPU counters, its necessary to use
             mlockall() in addition to this isolcpus flag.

   * "I_CFG_INHERIT":

        Set inheritance configuration when a new task is created via
        fork and clone.

        The "(int *)arg4" argument is a pointer to:

           struct task_isol_inherit_control {
                   __u8    inherit_mask;
                   __u8    pad[7];
           };

        inherit_mask is a bitmask that specifies which part of task
        isolation should be inherited:

        * Bit ISOL_INHERIT_CONF: Inherit task isolation
          configuration. This is the stated written via
          prctl(PR_ISOL_CFG_SET, ...).

        * Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
          (requires ISOL_INHERIT_CONF to be set). The new task should
          behave, after fork/clone, in the same manner as the parent
          task after it executed:

             prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);

**PR_ISOL_ACTIVATE_GET**:

   Retrieve task isolation activation state.

   The general format is:

      prctl(PR_ISOL_ACTIVATE_GET, pmask, arg3, arg4, arg5);

   'pmask' specifies the location of a feature mask, where the current
   active mask will be copied. See PR_ISOL_ACTIVATE_SET for
   description of individual bits.

**PR_ISOL_ACTIVATE_SET**:

   Set task isolation activation state (activates/deactivates task
   isolation).

   The general format is:

      prctl(PR_ISOL_ACTIVATE_SET, pmask, arg3, arg4, arg5);

   The 'pmask' argument specifies the location of an 8 byte mask
   containing which features should be activated. Features whose bits
   are cleared will be deactivated. The possible bits for this mask
   are:

      * "ISOL_F_QUIESCE":

      Activate quiescing of background kernel activities. Quiescing
      happens on return to userspace from this system call, and on
      return from subsequent system calls (unless quiesce_oneshot_mask
      is configured, see below).

   If the arg3 argument is non-zero, it specifies a pointer to:

      struct task_isol_activate_control {
              __u64 flags;
              __u64 quiesce_oneshot_mask;
              __u64 pad[6];
      };

   Where:

      *flags*: Additional flags (should be zero).

      *quiesce_oneshot_mask*: Quiescing for the kernel activities
         with bits set on this mask will happen on the return from
         this system call, but not on return from subsequent ones.

   Quiescing can be adjusted (while active) by
   prctl(PR_ISOL_ACTIVATE_SET, &new_mask, ...).


Userspace support
*****************

Task isolation is divided in two main steps: configuration and
activation.

Each step can be performed by an external tool or the latency
sensitive application itself. util-linux contains the "chisol" tool
for this purpose.

This results in three combinations:

1. Both configuration and activation performed by the latency
sensitive application. Allows fine grained control of what task
isolation features are enabled and when (see samples section below).

2. Only activation can be performed by the latency sensitive app (and
configuration performed by chisol). This allows the admin/user to
control task isolation parameters, and applications have to be
modified only once.

3. Configuration and activation performed by an external tool. This
allows unmodified applications to take advantage of task isolation.
Activation is performed by the "-a" option of chisol.


Examples
********

The "samples/task_isolation/" directory contains 3 examples:

* task_isol_userloop.c:

     Example of program with a loop on userspace scenario.

* task_isol_computation.c:

     Example of program that enters task isolated mode, performs an
     amount of computation, exits task isolated mode, and writes the
     computation to disk.

* task_isol_oneshot.c:

     Example of program that enables one-shot mode for quiescing,
     enters a processing loop, then upon an external event performs a
     number of syscalls to handle that event.

This is a snippet of code to activate task isolation if it has been
previously configured (by chisol for example):

   #include <sys/prctl.h>
   #include <linux/types.h>

   #ifdef PR_ISOL_CFG_GET
   unsigned long long fmask;

   ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
   if (ret != -1 && fmask != 0) {
           ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
           if (ret == -1) {
                   perror("prctl PR_ISOL_ACTIVATE_SET");
                   return ret;
           }
   }
   #endif



