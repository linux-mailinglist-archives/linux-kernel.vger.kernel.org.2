Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF13032ED91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCEO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 09:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhCEO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 09:59:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56966C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/OkZYQVM7XyISLc6jdwXi4U1aEK7k/C0FjZm3dELGM=; b=U6ndaEufEOfSAhtZyRCaH1C3gK
        RtyLSTEArq5ZWQzUV238E1tmsJpPYg8lE3MJGTFzw8W0AElF3GboT6sX6NylBO1Ds5LIJab/vSASs
        1PQTD85Q+I0FxFEblx0H67cWlf4YD/0AcjedzZs6IlpWsfmUalyxVCEfq/dQ2TsU9t7376+6YavUd
        HUgL2FzCNUMLnMPr53o2fx6rc/xvaf7ARxtt/rwIsj17DZb5qLqO5PgfgCiKSCFJDHSjtMrblH5qH
        A1v6nqQ9xKXtc2tn9zNKbUZhrRZ0L7H5A6uQVBo0trWSXpYXGdK16n/Z+fdgVX+vv/IpVri/oe/BV
        kkoYbBCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lIBtr-00Brah-Le; Fri, 05 Mar 2021 14:58:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD93D30011C;
        Fri,  5 Mar 2021 15:57:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1373203D8A3F; Fri,  5 Mar 2021 15:57:54 +0100 (CET)
Date:   Fri, 5 Mar 2021 15:57:54 +0100
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
Message-ID: <YEJG8v/sCxsG5Lsg@hirez.programming.kicks-ass.net>
References: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
 <YEHtjioucovbxbRt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEHtjioucovbxbRt@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 09:36:30AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 04, 2021 at 07:45:44PM -0800, Linus Torvalds wrote:
> > That ____cacheline_aligned goes back many years, this is not new, it
> > seems to come from back in 2014: commit 2565711fb7d7 ("perf: Improve
> > the perf_sample_data struct layout").
> 
> long time ago...
> 
> > But it really seems entirely and utterly bogus. That cacheline
> > alignment makes things *worse*, when the variables are on the local
> > stack. The local stack is already going to be dirty and in the cache,
> > and aligning those things isn't going to - and I quote from the code
> > in that commend in that commit - "minimize the cachelines touched".
> > 
> > Quite the reverse. It's just going to make the stack frame use *more*
> > memory, and make any cacheline usage _worse_.
> 
> IIRC there is more history here, but I can't seem to find references
> just now.
> 
> What I remember is that since perf_sample_data is fairly large,
> unconditionally initializing the whole thing is *slow* (and
> -fauto-var-init=zero will hurt here).
> 
> So at some point I removed that full initialization and made sure we
> only unconditionally touched the first few variables, which gave a
> measurable speedup.
> 
> Then things got messy again and the commit 2565711fb7d7 referenced above
> was cleanup, to get back to that initial state.
> 
> Now, you're right that __cacheline_aligned on on-stack (and this is
> indeed mostly on-stack) is fairly tedious (there were a few patches
> recently to reduce the amount of on-stack instances).
> 
> I'll put it on the todo list, along with that hotplug stuff (which I
> tried to fix but ended up with an even bigger mess). I suppose we can
> try and not have the alignment for the on-stack instances while
> preserving it for the few off-stack ones.
> 
> Also; we're running on the NMI stack, and that's not typically hot.

This seems to be it... (completely untested)

---
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f7f89ea5e51..918a296d2ca2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1032,7 +1032,9 @@ struct perf_sample_data {
 	u64				cgroup;
 	u64				data_page_size;
 	u64				code_page_size;
-} ____cacheline_aligned;
+};
+
+typedef struct perf_sample_data perf_sample_data_t ____cacheline_aligned;
 
 /* default value for data source */
 #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0c45d923f0f..f32c623abef6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -923,7 +923,7 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
  * bpf_perf_event_output
  */
 struct bpf_trace_sample_data {
-	struct perf_sample_data sds[3];
+	perf_sample_data_t sds[3];
 };
 
 static DEFINE_PER_CPU(struct bpf_trace_sample_data, bpf_trace_sds);
