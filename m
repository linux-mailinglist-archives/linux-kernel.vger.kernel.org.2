Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243CC3AB3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFQMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhFQMuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:50:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F3461263;
        Thu, 17 Jun 2021 12:48:00 +0000 (UTC)
Date:   Thu, 17 Jun 2021 08:47:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: [RFC][PATCH] bootconfig/tracing/ktest: Add ktest examples of
 testing bootconfig
Message-ID: <20210617084759.78bc21d1@gandalf.local.home>
In-Reply-To: <20210617115921.624c5c0d163de94d29202a83@kernel.org>
References: <20210616174155.007b764a@gandalf.local.home>
        <20210617115921.624c5c0d163de94d29202a83@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 11:59:21 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, 16 Jun 2021 17:41:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > bootconfig is a new feature that appends scripts onto the initrd, and the
> > kernel executes the scripts as an extended kernel command line.
> > 
> > Need to add tests to test that the happened. To test the bootconfig
> > properly, the initrd needs to be updated and the kernel rebooted. ktest is
> > the perfect solution to perform these tests.
> > 
> > Add a example bootconfig.conf in the tools/testing/ktest/examples/include
> > and example bootconfig scripts in tools/testing/ktest/examples/bootconfig
> > and also include verifier scripts that ktest will install on the target
> > and run to make sure that the bootconfig options in the scripts took place
> > after the target rebooted with the new initrd update.  
> 
> Thank you very much for integrate it to ktest!
> I gave some experimental bconfs without cleanup.
> 

No problem. If I was to take bootconfig patches from you, I had to have a
way to test for regressions ;-)


> > --- /dev/null
> > +++ b/tools/testing/ktest/examples/bootconfigs/ftrace.bconf
> > @@ -0,0 +1,82 @@
> > +#!/bin/sh  
> 
> This shebang is for the syntax hilighting. Please remove it.

OK. I didn't even notice that.

> 
> > +
> > +ftrace {
> > +	options = "sym-addr", "context-info"
> > +	buffer_size = 1MB
> > +}
> > +
> > +ftrace.event {
> > +	# Sample1: Make a histogram for initcall functions
> > +	synthetic.initcall_latency {
> > +                fields = "unsigned long func", "u64 lat"
> > +		hist {
> > +			keys = func.sym, lat
> > +			vals = lat
> > +			sort = lat
> > +		}  
> 
> These event.<GROUP>.<EVENT>.hist block is an experimental syntax (plan A),
> and not implemented yet.

I'll remove this then.

> 
> > +	}
> > +	initcall.initcall_start.hist {
> > +		keys = func
> > +		var.ts0 = common_timestamp.usecs
> > +	}
> > +	initcall.initcall_finish.hist {
> > +		keys = func
> > +		var.lat = common_timestamp.usecs - $ts0
> > +		onmatch {
> > +			event = initcall.initcall_start
> > +			action = "initcall_latency(func, $lat)"
> > +		}
> > +	}  
> 
> So please drop this Sample1.

OK.

> 
> > +
> > +	# Sample2: kmalloc() tracing in read(2) syscall
> > +	syscalls.sys_enter_read.enable_event {
> > +		event = kmem.kmalloc
> > +		count = 1
> > +	}
> > +	syscalls.sys_exit_read.disable_event {
> > +		event = kmem.kmalloc
> > +	}
> > +
> > +	# Sample3: Stacktrace at the event
> > +	kmem.kmalloc.stacktrace {
> > +		count = 5
> > +		filter = 'bytes_req >= 65536'
> > +	}
> > +
> > +	# Sample4: Take a snapshot
> > +	block.block_unplug.snapshot {
> > +		count = 1
> > +		filter = nr_rq > 1
> > +	}
> > +
> > +	# Sample5: Trace-on/off
> > +	block.block_plug.traceon {
> > +		filter = nr_rq > 1
> > +	}
> > +	block.block_unplug.traceoff {
> > +		filter = nr_rq > 1
> > +	}
> > +
> > +        # Sample6: onmax
> > +	sched.sched_waking {
> > +		enable
> > +		hist {
> > +			keys = pid
> > +			ts1 = common_timestamp.usecs
> > +			filter = 'comm == "cyclictest"'
> > +		}
> > +	}
> > +	sched.sched_switch {
> > +		enable
> > +		hist {
> > +			keys = next_pid
> > +			var.wakeup_lat = common_timestamp.usecs - $ts1
> > +			onmax {
> > +				var = wakeup_lat
> > +				action = "save(next_prio,next_comm,prev_pid,prev_prio,prev_comm)"
> > +			}
> > +			filter = 'next_comm == "cyclictest"'
> > +		}  
> 
> This also an experimental syntax. Please drop Sample 6.

OK.

> 
> > +	}
> > +}
> > +
> > diff --git a/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf b/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
> > new file mode 100644
> > index 000000000000..f9fb65caaad2
> > --- /dev/null
> > +++ b/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
> > @@ -0,0 +1,15 @@
> > +ftrace {
> > +      tracing_on = 0  # off by default
> > +      tracer = function_graph
> > +      event.kprobes {
> > +                start_event {
> > +                        probes = "pci_proc_init"
> > +                        actions = "traceon"
> > +                }
> > +                end_event {
> > +                        probes = "pci_proc_init%return"
> > +                        actions = "traceoff"
> > +                }
> > +        }
> > +  }
> > +
> > diff --git a/tools/testing/ktest/examples/bootconfigs/tracing.bconf b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
> > new file mode 100644
> > index 000000000000..4094390ade41
> > --- /dev/null
> > +++ b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
> > @@ -0,0 +1,51 @@
> > +ftrace {
> > +	tracer = function;
> > +	options = event-fork, sym-addr, stacktrace;
> > +	buffer_size = 1M;
> > +	alloc_snapshot;
> > +	trace_clock = global;
> > +	events = "task:task_newtask", "initcall:*";
> > +	event.sched.sched_process_exec {
> > +		filter = "pid < 128";
> > +	}
> > +	event.kprobes.myevent {
> > +		probes = "vfs_read $arg1 $arg2", "vfs_write $arg1 $arg2"
> > +	}
> > +	event.kprobes.myevent2 {
> > +		probes = "initrd_load";
> > +	}
> > +	event.kprobes.enable
> > +	instance.bar {
> > +		event.synthetic.initcall_latency {
> > +			fields = "unsigned long func", "u64 lat";
> > +			actions.hist {
> > +				keys = func.sym, lat;
> > +				vals = lat;
> > +				sort = lat;
> > +			}  
> 
> This is another experimental syntax (plan B). 
> This makes histogram into actions.

I'll remove it for now.

> 
> > +		}
> > +		event.initcall {
> > +			initcall_start.actions.hist {
> > +				keys = func;
> > +				ts0 = "common_timestamp.usecs";  
> 
> But remove "var." from local variable definition.
> 
> > +			}
> > +			initcall_finish.actions.hist {
> > +				keys = "func";
> > +				lat = "common_timestamp.usecs-$ts0";
> > +				onmatch = "initcall.initcall_start",
> > +					  "initcall_latency(func,$lat)";
> > +			}
> > +		}
> > +	}  
> 
> Thus, please drop this "instance.bar" block.

Will do.

Thanks for the review.

-- Steve

> 
> > +	instance.foo {
> > +		tracer = function-graph;
> > +		tracing_on = false;
> > +		event.workqueue.workqueue_start.actions = "tracing_on";
> > +		event.workqueue.workqueue_end.actions = "tracing_off";
> > +	};
> > +}
> > +kernel {
> > +	tp_printk;
> > +	dump_on_oops = 2
> > +	traceoff_on_warning
> > +}  
> 
> Thank you,
> 
> 

