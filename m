Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1E361F39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhDPMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:00:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F36C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wGfaRGk/vM3XaxINIwIwZxODviPQhYb7h8rUTm2j1IU=; b=YMCLTAOU3ok6ytzEByDqto/h9H
        ynjZIHbSbB37QjXUCr3AO28T7EvVYqCafU8+KiN/jSvKNegsbENB6rcjFiuIymFnPEI2PWvPS1r+3
        PZdNxgBon6abxwi5bBsmFEDTVZ+oFQ5ukBA1tHXb2ojK0XZIHJWk+Usex2q5dd2QaZpkRa+JylPWI
        9VFUSg6dYSc1dWyYCYaOgvzqIz2x01ffel03TDAdH27loZDN443p+yJvReMb440BpLiTkxnhA5vxC
        ZsyeaCxYGCiARkz2DLmW/He9k9TjZQN40bQJum1wfZSm/0MIMlui0SvAoa6MXxlU6hToiTwP1PcgR
        K9zHomqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXN8G-0020VS-5m; Fri, 16 Apr 2021 11:59:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEEDF300212;
        Fri, 16 Apr 2021 13:59:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 787572BF88167; Fri, 16 Apr 2021 13:59:30 +0200 (CEST)
Date:   Fri, 16 Apr 2021 13:59:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
Message-ID: <YHl8IpC/tJSrlg7l@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
 <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
 <YHlmq2q4nNSqJBw6@hirez.programming.kicks-ass.net>
 <CAM9d7cgjkZuHL=-38DTu8ieMNhLN86Ccg_UUZLb-ZF95Jv6=cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgjkZuHL=-38DTu8ieMNhLN86Ccg_UUZLb-ZF95Jv6=cw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 08:22:38PM +0900, Namhyung Kim wrote:
> On Fri, Apr 16, 2021 at 7:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Apr 16, 2021 at 11:29:30AM +0200, Peter Zijlstra wrote:
> >
> > > > So I think we've had proposals for being able to close fds in the past;
> > > > while preserving groups etc. We've always pushed back on that because of
> > > > the resource limit issue. By having each counter be a filedesc we get a
> > > > natural limit on the amount of resources you can consume. And in that
> > > > respect, having to use 400k fds is things working as designed.
> > > >
> > > > Anyway, there might be a way around this..
> >
> > So how about we flip the whole thing sideways, instead of doing one
> > event for multiple cgroups, do an event for multiple-cpus.
> >
> > Basically, allow:
> >
> >         perf_event_open(.pid=fd, cpu=-1, .flag=PID_CGROUP);
> >
> > Which would have the kernel create nr_cpus events [the corrolary is that
> > we'd probably also allow: (.pid=-1, cpu=-1) ].
> 
> Do you mean it'd have separate perf_events per cpu internally?
> From a cpu's perspective, there's nothing changed, right?
> Then it will have the same performance problem as of now.

Yes, but we'll not end up in ioctl() hell. The interface is sooo much
better. The performance thing just means we need to think harder.

I thought cgroup scheduling got a lot better with the work Ian did a
while back? What's the actual bottleneck now?

> > Output could be done by adding FORMAT_PERCPU, which takes the current
> > read() format and writes a copy for each CPU event. (p)read(v)() could
> > be used to explode or partial read that.
> 
> Yeah, I think it's good for read.  But what about mmap?
> I don't think we can use file offset since it's taken for auxtrace.
> Maybe we can simply disallow that..

Are you actually using mmap() to read? I had a proposal for FORMAT_GROUP
like thing for mmap(), but I never implemented that (didn't get the
enthousiatic response I thought it would). But yeah, there's nowhere
near enough space in there for PERCPU.

Not sure how to do that, these counters must not be sampling counters
because we can't be sharing a buffer from multiple CPUs, so data/aux
just isn't a concern. But it's weird to have them magically behave
differently.
