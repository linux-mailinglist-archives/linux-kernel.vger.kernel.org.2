Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42AA3AB47A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhFQNU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232322AbhFQNUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:20:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5052C613C1;
        Thu, 17 Jun 2021 13:18:10 +0000 (UTC)
Date:   Thu, 17 Jun 2021 09:18:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: [RFC][PATCH] bootconfig/tracing/ktest: Add ktest examples of
 testing bootconfig
Message-ID: <20210617091808.659abb1d@gandalf.local.home>
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

> > +++ b/tools/testing/ktest/examples/bootconfigs/ftrace.bconf

I'm trying to get this file to work. But I may just drop it completely.


> > @@ -0,0 +1,82 @@
> > +#!/bin/sh  
> 
> This shebang is for the syntax hilighting. Please remove it.
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

None of the above samples do anything.

I'll see if tracing.bconf does anything with the changes.

-- Steve

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

