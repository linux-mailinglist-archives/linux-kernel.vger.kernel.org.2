Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71E0361D52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbhDPJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhDPJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:30:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=++QZxlBgT7LgxqpU0jPFwi5srIjm2Y8BfTh1/+DAOsk=; b=YPJl4thEpecBd5MOtykGsWcQQk
        hO4jPOIto8uUulqHkGcGjiy0CKsAtnq5Uf97ZjwbrmDY/CEDc1ek1vzqYY75KO3f/rphCcETncg80
        7hhkp+BVgy6uvrzMPFdB9z+DTdVhcNkRtFA6fgBY7NTllvdRj/Bw8sZkX+7Bx3jgGtYjgRkqRNNQA
        1uumPjgLaqVQ/tm2J0cUQeB3KRre8VxYZQO7dTmDAUu6cio7nqyPwB451yEXOTtzHV3tPqbjoVilo
        e3+3XbcfyWYQuV0e8nrGDqwzktl3Yp2HhBxo4pMBLFEO+Op2WlIh5AWpbyHaPgV7/x6vBG2lmkBc+
        U3VUqbRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXKn5-001YLc-HD; Fri, 16 Apr 2021 09:29:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1D9830015A;
        Fri, 16 Apr 2021 11:29:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACAD2203711CC; Fri, 16 Apr 2021 11:29:30 +0200 (CEST)
Date:   Fri, 16 Apr 2021 11:29:30 +0200
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
Message-ID: <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Duh.. this is a half-finished email I meant to save for later. Anyway,
I'll reply more.

On Fri, Apr 16, 2021 at 11:26:39AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 16, 2021 at 08:48:12AM +0900, Namhyung Kim wrote:
> > On Thu, Apr 15, 2021 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Tue, Apr 13, 2021 at 08:53:36AM -0700, Namhyung Kim wrote:
> 
> > > > cgroup event counting (i.e. perf stat).
> > > >
> > > >  * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
> > > >      64-bit array to attach given cgroups.  The first element is a
> > > >      number of cgroups in the buffer, and the rest is a list of cgroup
> > > >      ids to add a cgroup info to the given event.
> > >
> > > WTH is a cgroup-id? The syscall takes a fd to the path, why have two
> > > different ways?
> > 
> > As you know, we already use cgroup-id for sampling.  Yeah we
> > can do it with the fd but one of the point in this patch is to reduce
> > the number of file descriptors. :)
> 
> Well, I found those patches again after I wrote that. But I'm still not
> sure what a cgroup-id is from userspace.
> 
> How does userspace get one given a cgroup? (I actually mounted cgroupfs
> in order to see if there's some new 'id' file to read, there is not)
> Does having the cgroup-id ensure the cgroup exists? Can the cgroup-id
> get re-used?
> 
> I really don't konw what the thing is. I don't use cgroups, like ever,
> except when I'm forced to due to some regression or bugreport.
> 
> > Also, having cgroup-id is good to match with the result (from read)
> > as it contains the cgroup information.
> 
> What?
> 
> > > >  * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
> > > >      array to get the event counter values.  The first element is size
> > > >      of the array in byte, and the second element is a cgroup id to
> > > >      read.  The rest is to save the counter value and timings.
> > >
> > > :-(
> > >
> > > So basically you're doing a whole seconds cgroup interface, one that
> > > violates the one counter per file premise and lives off of ioctl()s.
> > 
> > Right, but I'm not sure that we really want a separate event for each
> > cgroup if underlying hardware events are all the same.
> 
> Sure, I see where you're coming from; I just don't much like where it
> got you :-)
> 
> > > *IF* we're going to do something like this, I feel we should explore the
> > > whole vector-per-fd concept before proceeding. Can we make it less yuck
> > > (less special ioctl() and more regular file ops. Can we apply the
> > > concept to more things?
> > 
> > Ideally it'd do without keeping file descriptors open.  Maybe we can make
> > the vector accept various types like vector-per-cgroup_id or so.
> 
> So I think we've had proposals for being able to close fds in the past;
> while preserving groups etc. We've always pushed back on that because of
> the resource limit issue. By having each counter be a filedesc we get a
> natural limit on the amount of resources you can consume. And in that
> respect, having to use 400k fds is things working as designed.
> 
> Anyway, there might be a way around this..
> 
> > > The second patch extends the ioctl() to be more read() like, instead of
> > > doing the sane things and extending read() by adding PERF_FORMAT_VECTOR
> > > or whatever. In fact, this whole second ioctl() doesn't make sense to
> > > have if we do indeed want to do vector-per-fd.
> > 
> > One of the upside of the ioctl() is that we can pass cgroup-id to read.
> > Probably we can keep the index in the vector and set the file offset
> > with it.  Or else just read the whole vector, and then it has a cgroup-id
> > in the output like PERF_FORMAT_CGROUP?
> > 
> > >
> > > Also, I suppose you can already fake this, by having a
> > > SW_CGROUP_SWITCHES (sorry, I though I picked those up, done now) event
> > 
> > Thanks!
> > 
> > > with PERF_SAMPLE_READ|PERF_SAMPLE_CGROUP and PERF_FORMAT_GROUP in a
> > > group with a bunch of events. Then the buffer will fill with the values
> > > you use here.
> > 
> > Right, I'll do an experiment with it.
> > 
> > >
> > > Yes, I suppose it has higher overhead, but you get the data you want
> > > without having to do terrible things like this.
> > 
> > That's true.  And we don't need many things in the perf record like
> > synthesizing task/mmap info.  Also there's a risk we can miss some
> > samples for some reason.
> > 
> > Another concern is that it'd add huge slow down in the perf event
> > open as it creates a mixed sw/hw group.  The synchronized_rcu in
> > the move_cgroup path caused significant problems in my
> > environment as it adds up in proportion to the number of cpus.
> 
> Since when is perf_event_open() a performance concern? That thing is
> slow in all possible ways.
