Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596A93AA94B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 04:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFQDBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhFQDBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:01:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26C10613BF;
        Thu, 17 Jun 2021 02:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623898763;
        bh=umiuaCQKvucTYHnUe8mB6MY3ELOxEDV8qgzMyvZXw3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oAS/GCUeifzy2LAY9LiqbVlGixRLUVtxDtW8URQAJ0bOxDXgZhl42DYWsBGkqOamD
         Q2Ta8kSvHtClN+t1Z8ogPnWP7LhEcAgyMFjtUroIe7iiIGTph9jAvdHDwxmrXcA1zI
         tX7xYCdTJacpOl88ccAEz3do+c88/2JVg6/XETrRA+Y5gUaWdbsgIOO8O6ucU9e7hu
         /ZFvXDCuyuSzZa5LtO3tQQu2xSrpErocS2NwKF6Lh93fBKVgS/7V1iBN0RqUcCF9gZ
         VY+Hv+wtOxzjaTG8VU7Gawy+lSgAFpQvHeD9k0SfV7Wr7UjIgOvx8oXAlFSqwl88j2
         S1j6Dy5J2do4w==
Date:   Thu, 17 Jun 2021 11:59:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: [RFC][PATCH] bootconfig/tracing/ktest: Add ktest examples of
 testing bootconfig
Message-Id: <20210617115921.624c5c0d163de94d29202a83@kernel.org>
In-Reply-To: <20210616174155.007b764a@gandalf.local.home>
References: <20210616174155.007b764a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 16 Jun 2021 17:41:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> bootconfig is a new feature that appends scripts onto the initrd, and the
> kernel executes the scripts as an extended kernel command line.
> 
> Need to add tests to test that the happened. To test the bootconfig
> properly, the initrd needs to be updated and the kernel rebooted. ktest is
> the perfect solution to perform these tests.
> 
> Add a example bootconfig.conf in the tools/testing/ktest/examples/include
> and example bootconfig scripts in tools/testing/ktest/examples/bootconfig
> and also include verifier scripts that ktest will install on the target
> and run to make sure that the bootconfig options in the scripts took place
> after the target rebooted with the new initrd update.

Thank you very much for integrate it to ktest!
I gave some experimental bconfs without cleanup.


[..]
> diff --git a/tools/testing/ktest/examples/bootconfigs/config-bootconfig b/tools/testing/ktest/examples/bootconfigs/config-bootconfig
> new file mode 100644
> index 000000000000..0685b6811388
> --- /dev/null
> +++ b/tools/testing/ktest/examples/bootconfigs/config-bootconfig
> @@ -0,0 +1 @@
> +CONFIG_CMDLINE="bootconfig"
> diff --git a/tools/testing/ktest/examples/bootconfigs/ftrace.bconf b/tools/testing/ktest/examples/bootconfigs/ftrace.bconf
> new file mode 100644
> index 000000000000..30ab0d5e636f
> --- /dev/null
> +++ b/tools/testing/ktest/examples/bootconfigs/ftrace.bconf
> @@ -0,0 +1,82 @@
> +#!/bin/sh

This shebang is for the syntax hilighting. Please remove it.

> +
> +ftrace {
> +	options = "sym-addr", "context-info"
> +	buffer_size = 1MB
> +}
> +
> +ftrace.event {
> +	# Sample1: Make a histogram for initcall functions
> +	synthetic.initcall_latency {
> +                fields = "unsigned long func", "u64 lat"
> +		hist {
> +			keys = func.sym, lat
> +			vals = lat
> +			sort = lat
> +		}

These event.<GROUP>.<EVENT>.hist block is an experimental syntax (plan A),
and not implemented yet.

> +	}
> +	initcall.initcall_start.hist {
> +		keys = func
> +		var.ts0 = common_timestamp.usecs
> +	}
> +	initcall.initcall_finish.hist {
> +		keys = func
> +		var.lat = common_timestamp.usecs - $ts0
> +		onmatch {
> +			event = initcall.initcall_start
> +			action = "initcall_latency(func, $lat)"
> +		}
> +	}

So please drop this Sample1.

> +
> +	# Sample2: kmalloc() tracing in read(2) syscall
> +	syscalls.sys_enter_read.enable_event {
> +		event = kmem.kmalloc
> +		count = 1
> +	}
> +	syscalls.sys_exit_read.disable_event {
> +		event = kmem.kmalloc
> +	}
> +
> +	# Sample3: Stacktrace at the event
> +	kmem.kmalloc.stacktrace {
> +		count = 5
> +		filter = 'bytes_req >= 65536'
> +	}
> +
> +	# Sample4: Take a snapshot
> +	block.block_unplug.snapshot {
> +		count = 1
> +		filter = nr_rq > 1
> +	}
> +
> +	# Sample5: Trace-on/off
> +	block.block_plug.traceon {
> +		filter = nr_rq > 1
> +	}
> +	block.block_unplug.traceoff {
> +		filter = nr_rq > 1
> +	}
> +
> +        # Sample6: onmax
> +	sched.sched_waking {
> +		enable
> +		hist {
> +			keys = pid
> +			ts1 = common_timestamp.usecs
> +			filter = 'comm == "cyclictest"'
> +		}
> +	}
> +	sched.sched_switch {
> +		enable
> +		hist {
> +			keys = next_pid
> +			var.wakeup_lat = common_timestamp.usecs - $ts1
> +			onmax {
> +				var = wakeup_lat
> +				action = "save(next_prio,next_comm,prev_pid,prev_prio,prev_comm)"
> +			}
> +			filter = 'next_comm == "cyclictest"'
> +		}

This also an experimental syntax. Please drop Sample 6.

> +	}
> +}
> +
> diff --git a/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf b/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
> new file mode 100644
> index 000000000000..f9fb65caaad2
> --- /dev/null
> +++ b/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
> @@ -0,0 +1,15 @@
> +ftrace {
> +      tracing_on = 0  # off by default
> +      tracer = function_graph
> +      event.kprobes {
> +                start_event {
> +                        probes = "pci_proc_init"
> +                        actions = "traceon"
> +                }
> +                end_event {
> +                        probes = "pci_proc_init%return"
> +                        actions = "traceoff"
> +                }
> +        }
> +  }
> +
> diff --git a/tools/testing/ktest/examples/bootconfigs/tracing.bconf b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
> new file mode 100644
> index 000000000000..4094390ade41
> --- /dev/null
> +++ b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
> @@ -0,0 +1,51 @@
> +ftrace {
> +	tracer = function;
> +	options = event-fork, sym-addr, stacktrace;
> +	buffer_size = 1M;
> +	alloc_snapshot;
> +	trace_clock = global;
> +	events = "task:task_newtask", "initcall:*";
> +	event.sched.sched_process_exec {
> +		filter = "pid < 128";
> +	}
> +	event.kprobes.myevent {
> +		probes = "vfs_read $arg1 $arg2", "vfs_write $arg1 $arg2"
> +	}
> +	event.kprobes.myevent2 {
> +		probes = "initrd_load";
> +	}
> +	event.kprobes.enable
> +	instance.bar {
> +		event.synthetic.initcall_latency {
> +			fields = "unsigned long func", "u64 lat";
> +			actions.hist {
> +				keys = func.sym, lat;
> +				vals = lat;
> +				sort = lat;
> +			}

This is another experimental syntax (plan B). 
This makes histogram into actions.

> +		}
> +		event.initcall {
> +			initcall_start.actions.hist {
> +				keys = func;
> +				ts0 = "common_timestamp.usecs";

But remove "var." from local variable definition.

> +			}
> +			initcall_finish.actions.hist {
> +				keys = "func";
> +				lat = "common_timestamp.usecs-$ts0";
> +				onmatch = "initcall.initcall_start",
> +					  "initcall_latency(func,$lat)";
> +			}
> +		}
> +	}

Thus, please drop this "instance.bar" block.

> +	instance.foo {
> +		tracer = function-graph;
> +		tracing_on = false;
> +		event.workqueue.workqueue_start.actions = "tracing_on";
> +		event.workqueue.workqueue_end.actions = "tracing_off";
> +	};
> +}
> +kernel {
> +	tp_printk;
> +	dump_on_oops = 2
> +	traceoff_on_warning
> +}

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
