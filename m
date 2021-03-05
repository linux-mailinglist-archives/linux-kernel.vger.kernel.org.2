Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFF432E3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhCEIhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCEIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:36:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 00:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4o8nFaUqdE3XidEkNAZS9FXz8f1fPatJYS1B5VPdZWg=; b=vx3tzdqHWopV7m2mf3R2uMIZLz
        jyvOHTaQlnsPaIBaxI17YADAwkSgwZcbR/oSX1fOOuLiNqnXyixRHA7+CgHqMh0nu3hckW5Y6Px9G
        +Rsd9okcPpiCUH/QOhlCjvmypAjSIch7EWzPkx5eJ5kMCBficpUVXtE2DRHE9OOTLqkKNaik/8zxR
        Vi/XuQZh0cNoyiYOMV23g96+huqGeImyGPUOHYoOFFtkBWjWuF+k0DO+ntqbzdnsexDNUhPq+TQUt
        pBAHbApsVLEqJo7Y9BcD+p7VYeRlvSpoLmr/zklVcB8ZxY5y1Oke80NcPvpfZlli5P6bKKN89B88V
        quIuRi0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lI5wn-00ArwV-Ca; Fri, 05 Mar 2021 08:36:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 991113011E6;
        Fri,  5 Mar 2021 09:36:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E0202BA960C6; Fri,  5 Mar 2021 09:36:30 +0100 (CET)
Date:   Fri, 5 Mar 2021 09:36:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "struct perf_sample_data" alignment
Message-ID: <YEHtjioucovbxbRt@hirez.programming.kicks-ass.net>
References: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:45:44PM -0800, Linus Torvalds wrote:
> That ____cacheline_aligned goes back many years, this is not new, it
> seems to come from back in 2014: commit 2565711fb7d7 ("perf: Improve
> the perf_sample_data struct layout").

long time ago...

> But it really seems entirely and utterly bogus. That cacheline
> alignment makes things *worse*, when the variables are on the local
> stack. The local stack is already going to be dirty and in the cache,
> and aligning those things isn't going to - and I quote from the code
> in that commend in that commit - "minimize the cachelines touched".
> 
> Quite the reverse. It's just going to make the stack frame use *more*
> memory, and make any cacheline usage _worse_.

IIRC there is more history here, but I can't seem to find references
just now.

What I remember is that since perf_sample_data is fairly large,
unconditionally initializing the whole thing is *slow* (and
-fauto-var-init=zero will hurt here).

So at some point I removed that full initialization and made sure we
only unconditionally touched the first few variables, which gave a
measurable speedup.

Then things got messy again and the commit 2565711fb7d7 referenced above
was cleanup, to get back to that initial state.

Now, you're right that __cacheline_aligned on on-stack (and this is
indeed mostly on-stack) is fairly tedious (there were a few patches
recently to reduce the amount of on-stack instances).

I'll put it on the todo list, along with that hotplug stuff (which I
tried to fix but ended up with an even bigger mess). I suppose we can
try and not have the alignment for the on-stack instances while
preserving it for the few off-stack ones.

Also; we're running on the NMI stack, and that's not typically hot.
