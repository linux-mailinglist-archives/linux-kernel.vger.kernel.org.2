Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CC33729C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhCKMbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhCKMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:31:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681E5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t6hAglufpM9QmvKebIGtn+Yjg4xR0fUMa1JXcygR53g=; b=vEvsCnvfv2iJfDITyPepipHmRo
        O8EhAT02CeEAfYwhd16j4KE7jyLmu9m1mNIVytxYdRzn3tFbPJLgcxkxuZni0SIA4Hhz76KHOYbFo
        fn8Opg8AR14omYvdCUVVyek9cJdRAsJb+uPgRyi8CE055ifUHv0kp2shuTeQoGtKcly6O7eMpOee1
        u4u9EnWa6+GIJeZU1GXFmIwK6h8LpJohbqEh0YUpQ6pJYYM/KNLZ5wVPMqZbagt+Xtz3KdL67qPH8
        uA2pVsAeHBrchZfVc8ZRPLYsEXDrMAeQiT4lBdBtGjBjb7eS3ZIYHQeWAWo2kbdDXjUMYf1IWx2tx
        SB33r+Jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKSH-007J0G-BW; Thu, 11 Mar 2021 12:30:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D850F3013E5;
        Thu, 11 Mar 2021 13:30:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9B6929D00063; Thu, 11 Mar 2021 13:30:16 +0100 (CET)
Date:   Thu, 11 Mar 2021 13:30:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <YEoNWGEYSv7Xmw6B@hirez.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
 <YEoKSyx9E+CSFIk/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEoKSyx9E+CSFIk/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:17:15PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 08:37:52AM -0800, kan.liang@linux.intel.com wrote:
> > @@ -2092,9 +2105,37 @@ static int __init init_hw_perf_events(void)
> >  	if (err)
> >  		goto out1;
> >  
> > -	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> > -	if (err)
> > -		goto out2;
> > +	if (!is_hybrid()) {
> > +		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> > +		if (err)
> > +			goto out2;
> > +	} else {
> > +		u8 cpu_type = get_hybrid_cpu_type(smp_processor_id());
> > +		struct x86_hybrid_pmu *hybrid_pmu;
> > +		int i;
> > +
> > +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
> > +			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
> 
> I can't find where you actually allocated x86_pmu.hybrid_pmu.

Ah, patch 20 has that.

> > +			hybrid_pmu->pmu = pmu;
> > +			hybrid_pmu->pmu.type = -1;
> > +			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
> > +			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
> > +
> > +			/* Only register the PMU for the boot CPU */
> > +			if (hybrid_pmu->cpu_type != cpu_type)
> > +				continue;
> > +
> > +			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
> > +						x86_get_hybrid_pmu_type(cpu_type));
> > +			if (err) {
> > +				pr_warn("Failed to register a PMU, err %d\n", err);
> > +				kfree(x86_pmu.hybrid_pmu);
> > +				x86_pmu.hybrid_pmu = NULL;
> > +				goto out2;
> > +			}
> > +		}
> > +	}
> >  
> >  	return 0;
