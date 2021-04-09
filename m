Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB835A236
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhDIPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDIPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:45:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB4C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ccacilQpw8gp06qfs/99roXEeahKogw23vAA74hgdvo=; b=Lt5gnjW56W4zdS9TCXUP0VLqKq
        UQ6r757R95oVk5leaf9pAafNW2F0ShHEJWJHWKwz/kFFraISRl5oK9RP3v9hTzWIYKWi+Qzu6Qbfx
        VfFCpLRvNqgBZDP4dVjWngl4Gpqv1mZzJCj6AXkQhPBFN+EvDyF9TkDDs9isOGs/ytR0BsLEcPNk5
        hdOZrq/PH1u8ldAwzZAqGbkTRLjcs6+fFT7zrjfQDdQH6DW1Fu4gfobLfpBuvcLa55icd4hu9wNQ5
        8kcVRV34GpvJ5+6VVinlbhkuwzEZQyCdMYpmGe/nB3EKUlN7Zw0OhqW1jpJomUtDQo2jhocM3/apj
        nPVZzGgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUtK6-0012JJ-Bs; Fri, 09 Apr 2021 15:45:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9240830001B;
        Fri,  9 Apr 2021 17:45:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 802B52BE951AC; Fri,  9 Apr 2021 17:45:28 +0200 (CEST)
Date:   Fri, 9 Apr 2021 17:45:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH V5 16/25] perf/x86: Register hybrid PMUs
Message-ID: <YHB2mNgw7k/NUIl9@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-17-git-send-email-kan.liang@linux.intel.com>
 <YG/7BgFaRC/Eos76@hirez.programming.kicks-ass.net>
 <41c7b4ec-b742-2f7c-9991-7b23c9971dc6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c7b4ec-b742-2f7c-9991-7b23c9971dc6@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 09:50:20AM -0400, Liang, Kan wrote:
> 
> 
> On 4/9/2021 2:58 AM, Peter Zijlstra wrote:
> > On Mon, Apr 05, 2021 at 08:10:58AM -0700, kan.liang@linux.intel.com wrote:
> > > @@ -2089,9 +2119,46 @@ static int __init init_hw_perf_events(void)
> > >   	if (err)
> > >   		goto out1;
> > > -	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> > > -	if (err)
> > > -		goto out2;
> > > +	if (!is_hybrid()) {
> > > +		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> > > +		if (err)
> > > +			goto out2;
> > > +	} else {
> > > +		u8 cpu_type = get_this_hybrid_cpu_type();
> > > +		struct x86_hybrid_pmu *hybrid_pmu;
> > > +		bool registered = false;
> > > +		int i;
> > > +
> > > +		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
> > > +			cpu_type = x86_pmu.get_hybrid_cpu_type();
> > > +
> > > +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
> > > +			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
> > > +
> > > +			hybrid_pmu->pmu = pmu;
> > > +			hybrid_pmu->pmu.type = -1;
> > > +			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
> > > +			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
> > > +
> > > +			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
> > > +						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
> > > +			if (err)
> > > +				continue;
> > > +
> > > +			if (cpu_type == hybrid_pmu->cpu_type)
> > > +				x86_pmu_update_cpu_context(&hybrid_pmu->pmu, raw_smp_processor_id());
> > > +
> > > +			registered = true;
> > > +		}
> > > +
> > > +		if (!registered) {
> > > +			pr_warn("Failed to register hybrid PMUs\n");
> > > +			kfree(x86_pmu.hybrid_pmu);
> > > +			x86_pmu.hybrid_pmu = NULL;
> > > +			x86_pmu.num_hybrid_pmus = 0;
> > > +			goto out2;
> > > +		}
> > 
> > I don't think this is quite right. registered will be true even if one
> > fails, while I think you meant to only have it true when all (both)
> > types registered correctly.
> 
> No, I mean that perf error out only when all types fail to be registered.

All or nothing seems a better approach to me. There really isn't a good
reason for any one of them to fail.
