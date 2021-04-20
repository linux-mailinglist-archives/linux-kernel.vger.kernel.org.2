Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05589365796
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhDTLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhDTLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:31:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T5eWFQ885O/XFkIMPsXw7qUyuHPsftGp0BzW4DSZCmw=; b=OiX4Fn9kplSJ1kq1YQSiCVzvk8
        hV5ngaf3Jm9mGy2qw1k1wLRZ/A3DrW5tqBKUPW5LPgwSYGmQ+JptTJ66xkGH1MLADmNh5JiAHstoq
        5qZVTi6/GT2AxJmEskg8qMhTJT3zcjok7eVgvxr7/XAkLwnVi17ZIt0mJV0r72I6RSY7iZBc8EFpB
        qERuJ1NglsssXEeTddhXxbLdmgMWb2bHcpGvpKCwVwqlf1wPt9Ak1ljeJCzQrOAg2xYmdqQXbzGAS
        aIawk1G5bF8FhRc315jYtgp3mtcLhFGzV87JGsxFZmTCCWmpF6ub6iVd6uDuS8w+srY6s+zHvCLqN
        qNQP5ddQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYoYV-00F66j-MK; Tue, 20 Apr 2021 11:28:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1191430020C;
        Tue, 20 Apr 2021 13:28:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C44E42C5C7910; Tue, 20 Apr 2021 13:28:33 +0200 (CEST)
Date:   Tue, 20 Apr 2021 13:28:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
Message-ID: <YH664QumxBAIyYpt@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CABPqkBTncWfeFWY=kYXTAr3gRjpyFVL-YJN4K1YOPpHO35PHBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTncWfeFWY=kYXTAr3gRjpyFVL-YJN4K1YOPpHO35PHBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:34:40AM -0700, Stephane Eranian wrote:
> The sampling approach will certainly incur more overhead and be at
> risk of losing the ability to reconstruct the total counter
> per-cgroup, unless  you set the period for SW_CGROUP_SWITCHES to 1.
> But then, you run the risk of losing samples if the buffer is full or
> sampling is throtlled.  In some scenarios, we believe the number of
> context switches between cgroup could be quite high (>> 1000/s).  And
> on top you would have to add the processing of the samples to extract
> the counts per cgroup. That would require a synthesis on cgroup on
> perf record and some post-processing on perf report. We are interested
> in using the data live to make some policy decisions, so a counting
> approach with perf stat will always be best.
> 
> The fundamental problem Namhyung is trying to solve is the following:
> 
> num_fds = num_cpus x num_events x num_cgroups
> 
> On an 256-CPU AMD server running 200 cgroups with 6 events/cgroup (as
> an example):
> 
> num_fds = 256 x 200 x 6 = 307,200 fds (with all the kernel memory
> associated with them).

So the PERCPU proposal would reduce that to 200 * 6 = 1200 fds, which is
a definite win.

> On each CPU, that implies: 200 x 6 = 1200
> events to schedule and 6 to find on each cgroup switch

Right, so here we could optimize; if we find the event-groups are
identical in composition we can probably frob something that swizzles
the counts around without touching the PMU. That would be very similar
to what we already have in perf_event_context_sched_out().

This gets a wee bit tricky when you consider cgroup hierarchy though;
suppose you have:

           R
	  / \
	 A   B
	    / \
	   C   D

And are monitoring both B and D, then you'll end up with 12 counters
active instead of the 6. I'm not sure how to make that go away. 'Don't
do that then' might be good enough.

> This does not scale for us:
>    - run against the fd limit, but also memory consumption in the
>    kernel per struct file, struct inode, struct perf_event ....
>    - number of events per-cpu is still also large
>    - require event scheduling on cgroup switches, even with RB-tree
>    improvements, still heavy
>    - require event scheduling even if measuring the same events across
>    all cgroups
> 
> One factor in that equation above needs to disappear. The one counter
> per file descriptor is respected with Nahmyung's patch because he is
> operating a plain per-cpu mode. What changes is just how and where the
> count is accumulated in perf_events. The resulting programming on the
> hardware is the same as before.

Yes, you're aggregating differently. And that's exactly the problem. The
aggregation is a variable one with fairly poor semantics. Suppose you
create a new cgroup, then you have to tear down and recreate the whole
thing, which is pretty crap.

Ftrace had a similar issue; where people wanted aggregation, and that
resulted in the event histogram, which, quite frankla,y is a scary
monster that I've no intention of duplicating. That's half a programming
language implemented.

> As you point out, the difficulty is how to express the cgroups of
> interest and how to read the counts back.  I agree that the ioctl() is
> not ideal for the latter. For the former, if you do not want ioctl()
> then you would have to overload perf_event_open() with a vector of
> cgroup fd, for instance. As for the read, you could, as you suggest,
> use the read syscall if you want to read all the cgroups at once using
> a new read_format. I don't have a problem with that.  As for cgroup-id
> vs. cgroup-fd, I think you make a fair point about consistency with
> the existing approach. I don't have a problem with that either

So that is a problem of aggregation; which is basically a
programmability problem. You're asking for a variadic-fixed-function
now, but tomorrow someone else will come and want another one.

