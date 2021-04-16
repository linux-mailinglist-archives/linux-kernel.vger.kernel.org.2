Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B364361DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhDPK3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:28:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F27C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CWrS5XSLYo4ciqDUEjhD1jnthccxk9YJcxF+IcCqVhY=; b=ADPdO0BxVbJOyovTHpfTPOoKum
        gDDMTFcJNFsxXDMtyOJAmVgqMEGklqUx97H8S4cC071lxCG66pLtoWaEitLNB6SrAmdckWFLrSCHA
        kSkWP5ztBXQS+YVREZ3kPWqCxmY9jFUUEtABuSGUNyIOQ79NTeYlVVJA5kq7MS6YFVUh9c2gIxfWL
        eGIalbTXqZTUlbHSGFGuBz1xnT0rPe5hBNZPcUWnqn50zPyf9NppjoEBXNZKTMguqswD+NjhpVXQL
        cqnALhnG+ZsKt1Laxzz0wojtxtvASN44/j4+pmWlvVoPmTYgknNMLsIJnDq8UROox0XnQytdQ/vAu
        K9eqFn+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXLhd-009omq-H4; Fri, 16 Apr 2021 10:28:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B426300212;
        Fri, 16 Apr 2021 12:27:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 043DD200C8D28; Fri, 16 Apr 2021 12:27:55 +0200 (CEST)
Date:   Fri, 16 Apr 2021 12:27:55 +0200
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
Message-ID: <YHlmq2q4nNSqJBw6@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
 <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:29:30AM +0200, Peter Zijlstra wrote:

> > So I think we've had proposals for being able to close fds in the past;
> > while preserving groups etc. We've always pushed back on that because of
> > the resource limit issue. By having each counter be a filedesc we get a
> > natural limit on the amount of resources you can consume. And in that
> > respect, having to use 400k fds is things working as designed.
> > 
> > Anyway, there might be a way around this..

So how about we flip the whole thing sideways, instead of doing one
event for multiple cgroups, do an event for multiple-cpus.

Basically, allow:

	perf_event_open(.pid=fd, cpu=-1, .flag=PID_CGROUP);

Which would have the kernel create nr_cpus events [the corrolary is that
we'd probably also allow: (.pid=-1, cpu=-1) ].

Output could be done by adding FORMAT_PERCPU, which takes the current
read() format and writes a copy for each CPU event. (p)read(v)() could
be used to explode or partial read that.

This gets rid of the nasty variadic nature of the
'get-me-these-n-cgroups'. While still getting rid of the n*m fd issue
you're facing.
