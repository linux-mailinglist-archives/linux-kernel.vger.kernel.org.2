Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6AA3AA697
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhFPWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhFPWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:34:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D59C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nc7+CuwJgCg6XVTWO6UDKQxgiym6JRSNRMkKN6mwM9A=; b=Z8MXqTzfBEdq3CCKvNMfmGS+YT
        5mq6trg9l5uJYzsPnDm3nQBSPdjGCnC+ff1N7Vva14ixgP15DwbBSa4C2tGUwCGRFfpkUYzGglhxc
        NZ5x+DdP2silEeNi2wQxLWRD0IfVNHVwyGR2xUewSKHKMPLnHKKMVByFRlyeThAcW6caQjRash5FF
        IMDI5/HUjUlnShi/z+6jw3BGUSUN/zPoi3uSyaDQ2+lC6Qg0kuLvEo4IlRT54jW5IVGYxy5Q7X9MP
        pohX+L9yPFUBokCbKNjXyhESreuAl22oiyLyGRBr3KMHzLVfz53v4Gbv2Dy3CNzOtptamgheLCJlC
        fN96i27g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lte4t-008SEk-FI; Wed, 16 Jun 2021 22:32:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D25799834C5; Thu, 17 Jun 2021 00:32:12 +0200 (CEST)
Date:   Thu, 17 Jun 2021 00:32:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCHSET v2 0/3] perf stat: Enable BPF counters with
 --for-each-cgroup
Message-ID: <20210616223212.GE4272@worktop.programming.kicks-ass.net>
References: <20210615011724.672612-1-namhyung@kernel.org>
 <YMoVOp4+TIUViBb7@hirez.programming.kicks-ass.net>
 <CAM9d7cj2UhQsd2vx8_C8C_CEW2QQbzs741jCn7f7g-e0i9OiOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj2UhQsd2vx8_C8C_CEW2QQbzs741jCn7f7g-e0i9OiOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:33:42AM -0700, Namhyung Kim wrote:

> > That seems unfortunate; there's no bpf helper to iterate cgroup
> > hierarchy?
> 
> I couldn't find one..

Song, is that something that would make sense to have?

> > >  * there's no reliable way to trigger running the BPF program
> >
> > You can't attach to the PERF_COUNT_SW_CGROUP_SWITCHES event?
> 
> I did it.  But the BPF test run seems not to work with perf_event.
> So it needs to trigger a cgroup switch manually..

AFAICT it should be possible to set a bpf prog on a software event.
perf_event_set_bpf_prog() will take the first branch
(!perf_event_is_tracing()) and call perf_event_set_bpf_handler().

That should then result in running the bpf program every time the event
would generate a sample.

So if you configure the event to sample on every single event, it should
then run your program every time.

This is all from looking at the code, because I really can't operate any
of that for real. I suspect Song can help out.

The alternative is to attach a BPF program to the sched_switch
tracepoint and do the cgroup filter in BPF.
