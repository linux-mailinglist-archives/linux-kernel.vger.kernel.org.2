Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F078361D46
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhDPJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhDPJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:27:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BC6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HPc6wzpM0fRvoMm2lRghdfZ9iKMJxYwnHLDM6jmTY5Y=; b=GDTZlHwLb/nSS3o8n4T46sXmHr
        B0QkYBvpxyMVglHu0XAuU8Uoea3LJTV7EM1KE2rOVYoGojgP0gX87RLO0/1W3zteJVJexcOit7wBh
        MeLYwj9Ir1YpYdHpbfaqQxsbs94cFBo3y27FuYj6QAN9s32ZB+WJ9Emf33DDq0ArlrhQT6ZVT68Iw
        zPfjqoF82EJrq4sZYj4CPIdIb10zjQXz0mWAjGr77le9MHKoy+K4Q/fi9O+uYNtRw0c4D0jeJf+Wv
        Qo7moPKS4P2ApUpu3SueKgs3XQ3ng8CLcTBJCpsp2Gm72qiYI2s52RFffBA9Od5uMdyDVWpSFKY98
        EHR9Ko8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXKkL-009lQi-Qd; Fri, 16 Apr 2021 09:26:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DECE30015A;
        Fri, 16 Apr 2021 11:26:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A98D5203711CC; Fri, 16 Apr 2021 11:26:39 +0200 (CEST)
Date:   Fri, 16 Apr 2021 11:26:39 +0200
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
Message-ID: <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 08:48:12AM +0900, Namhyung Kim wrote:
> On Thu, Apr 15, 2021 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Apr 13, 2021 at 08:53:36AM -0700, Namhyung Kim wrote:

> > > cgroup event counting (i.e. perf stat).
> > >
> > >  * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
> > >      64-bit array to attach given cgroups.  The first element is a
> > >      number of cgroups in the buffer, and the rest is a list of cgroup
> > >      ids to add a cgroup info to the given event.
> >
> > WTH is a cgroup-id? The syscall takes a fd to the path, why have two
> > different ways?
> 
> As you know, we already use cgroup-id for sampling.  Yeah we
> can do it with the fd but one of the point in this patch is to reduce
> the number of file descriptors. :)

Well, I found those patches again after I wrote that. But I'm still not
sure what a cgroup-id is from userspace.

How does userspace get one given a cgroup? (I actually mounted cgroupfs
in order to see if there's some new 'id' file to read, there is not)
Does having the cgroup-id ensure the cgroup exists? Can the cgroup-id
get re-used?

I really don't konw what the thing is. I don't use cgroups, like ever,
except when I'm forced to due to some regression or bugreport.

> Also, having cgroup-id is good to match with the result (from read)
> as it contains the cgroup information.

What?

> > >  * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
> > >      array to get the event counter values.  The first element is size
> > >      of the array in byte, and the second element is a cgroup id to
> > >      read.  The rest is to save the counter value and timings.
> >
> > :-(
> >
> > So basically you're doing a whole seconds cgroup interface, one that
> > violates the one counter per file premise and lives off of ioctl()s.
> 
> Right, but I'm not sure that we really want a separate event for each
> cgroup if underlying hardware events are all the same.

Sure, I see where you're coming from; I just don't much like where it
got you :-)

> > *IF* we're going to do something like this, I feel we should explore the
> > whole vector-per-fd concept before proceeding. Can we make it less yuck
> > (less special ioctl() and more regular file ops. Can we apply the
> > concept to more things?
> 
> Ideally it'd do without keeping file descriptors open.  Maybe we can make
> the vector accept various types like vector-per-cgroup_id or so.

So I think we've had proposals for being able to close fds in the past;
while preserving groups etc. We've always pushed back on that because of
the resource limit issue. By having each counter be a filedesc we get a
natural limit on the amount of resources you can consume. And in that
respect, having to use 400k fds is things working as designed.

Anyway, there might be a way around this..

> > The second patch extends the ioctl() to be more read() like, instead of
> > doing the sane things and extending read() by adding PERF_FORMAT_VECTOR
> > or whatever. In fact, this whole second ioctl() doesn't make sense to
> > have if we do indeed want to do vector-per-fd.
> 
> One of the upside of the ioctl() is that we can pass cgroup-id to read.
> Probably we can keep the index in the vector and set the file offset
> with it.  Or else just read the whole vector, and then it has a cgroup-id
> in the output like PERF_FORMAT_CGROUP?
> 
> >
> > Also, I suppose you can already fake this, by having a
> > SW_CGROUP_SWITCHES (sorry, I though I picked those up, done now) event
> 
> Thanks!
> 
> > with PERF_SAMPLE_READ|PERF_SAMPLE_CGROUP and PERF_FORMAT_GROUP in a
> > group with a bunch of events. Then the buffer will fill with the values
> > you use here.
> 
> Right, I'll do an experiment with it.
> 
> >
> > Yes, I suppose it has higher overhead, but you get the data you want
> > without having to do terrible things like this.
> 
> That's true.  And we don't need many things in the perf record like
> synthesizing task/mmap info.  Also there's a risk we can miss some
> samples for some reason.
> 
> Another concern is that it'd add huge slow down in the perf event
> open as it creates a mixed sw/hw group.  The synchronized_rcu in
> the move_cgroup path caused significant problems in my
> environment as it adds up in proportion to the number of cpus.

Since when is perf_event_open() a performance concern? That thing is
slow in all possible ways.
