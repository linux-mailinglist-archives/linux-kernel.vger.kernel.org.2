Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697353DA79F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhG2Paa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhG2Pa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:30:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86DEC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=irWudObMhOTsKKKvCnHnWi0yd6LYoz4FwB6sLuN6V40=; b=CpD6eVXV19lEZ2jrGAe1BczePU
        h1iY+JYRbbAA7Nt8XlG9ieBPkoMYbwVwevS5cYavEqVoeP9smr6Y26ZXt7J+KTNAdgvz9mIRN9uFp
        +5i13ooPryQrnM1mtR5w5pgba5Su9RUBy/Qt0/L3Qp8buPGdlsWesB0ehlqcc8tge4DZm+Y4dXaJs
        pEASpz+JRwRf7TdzqOplDiQyknn9XPuDicnIIpEIzQQbK7OhNh3mCd3aIsUYODTdVor6hnQvjQe8m
        bvqZE+ScyNLOmUDZiNdflvbLi+0+tRfSRMSHQeuel1nVJNSkmykxpUrJ+5b7urMYJQppZkatJG3Tu
        +r4duF+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m97zB-003zYL-Qj; Thu, 29 Jul 2021 15:30:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDC7B300215;
        Thu, 29 Jul 2021 17:30:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8289D25BEBFBA; Thu, 29 Jul 2021 17:30:12 +0200 (CEST)
Date:   Thu, 29 Jul 2021 17:30:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [perf] fuzzer triggers unchecked MSR access error: WRMSR to 0x318
Message-ID: <YQLJhAiYQKtvvhjJ@hirez.programming.kicks-ass.net>
References: <37881148-a43e-5fd4-817c-a875adc7a15f@maine.edu>
 <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
 <45bee582-0f89-5125-82e7-92caf8b741ea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45bee582-0f89-5125-82e7-92caf8b741ea@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 09:21:01AM -0400, Liang, Kan wrote:
> 
> 
> On 7/29/2021 5:14 AM, Peter Zijlstra wrote:
> > On Wed, Jul 28, 2021 at 12:49:43PM -0400, Vince Weaver wrote:
> > > [32694.087403] unchecked MSR access error: WRMSR to 0x318 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106f854 (native_write_msr+0x4/0x20)
> > > [32694.101374] Call Trace:
> > > [32694.103974]  perf_clear_dirty_counters+0x86/0x100
> > 
> > Hmm.. if I read this right that's MSR_ARCH_PERFMON_FIXED_CTR0 + i, given
> > that FIXED_CTR0 is 0x309 that gives i == 15, which is FIXED_BTS.
> > 
> > I'm thinking something like this ought to cure things.
> > 
> > ---
> >   arch/x86/events/core.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 1eb45139fcc6..04edf8017961 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2489,13 +2489,15 @@ void perf_clear_dirty_counters(void)
> >   		return;
> >   	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
> > -		/* Metrics and fake events don't have corresponding HW counters. */
> > -		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
> > -			continue;
> > -		else if (i >= INTEL_PMC_IDX_FIXED)
> > +		if (i >= INTEL_PMC_IDX_FIXED) {
> > +			/* Metrics and fake events don't have corresponding HW counters. */
> > +			if ((i - INTEL_PMC_IDX_FIXED) >= x86_pmu.num_counters_fixed)
> 
> Yes, the fix is better. My previous implementation tries to pick up all the
> special cases. It's very likely to miss some special cases like FIXED_BTS
> and probably any new fake events added later if there are.
> Thanks for the fix.
> 
> The x86_pmu.num_counters_fixed should work well on HSW. But we have hybrid
> machines now. I think we can use
> hybrid(cpuc->pmu, num_counters_fixed) instead, which should be more
> accurate.

Yes, good point. I guess I still need to adjust to the hybrid world.
