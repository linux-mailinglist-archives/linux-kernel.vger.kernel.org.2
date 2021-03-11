Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C5337243
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCKMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhCKMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:17:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g+bNVj9h8VlGyzSquHDsden2IrrsfgAWLAU+Fcw3F3U=; b=K2u2nViwI3je8/Mwf1EaMTB5+D
        6/JE0Nr/tA6judvhclVcJmNtMBCQvBPQ3Sr3W990icBhptHCkj4VqUlONhB39L5+jcYX1sn37f01C
        3YoQjec5tGmglbWcckTwfsm7tIjmzKIahUUlDE2ZSCaCB3a3w+CUjr4Mfh/eoIWLcc7Lm2muNd2JU
        8NWKocNqp2SAMn2fsF8RaahNSV/GGGIJEN20miEU1w4SRAeSeh2lnMBHFwDqywU1u8WyfdXLOK+nN
        j9rb6mq4fsQAwE25rZhSbZsfaZFp0u+9gxMhSl0/n2tIwNWZSQGsdIqaHNhDAzz92VJ6SPsKwWinb
        LCXyjNPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKFg-007ICP-UV; Thu, 11 Mar 2021 12:17:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBF1E3011F0;
        Thu, 11 Mar 2021 13:17:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4C6729CB84C4; Thu, 11 Mar 2021 13:17:15 +0100 (CET)
Date:   Thu, 11 Mar 2021 13:17:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <YEoKSyx9E+CSFIk/@hirez.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:37:52AM -0800, kan.liang@linux.intel.com wrote:
> @@ -2092,9 +2105,37 @@ static int __init init_hw_perf_events(void)
>  	if (err)
>  		goto out1;
>  
> -	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> -	if (err)
> -		goto out2;
> +	if (!is_hybrid()) {
> +		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> +		if (err)
> +			goto out2;
> +	} else {
> +		u8 cpu_type = get_hybrid_cpu_type(smp_processor_id());
> +		struct x86_hybrid_pmu *hybrid_pmu;
> +		int i;
> +
> +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
> +			hybrid_pmu = &x86_pmu.hybrid_pmu[i];

I can't find where you actually allocated x86_pmu.hybrid_pmu.

> +			hybrid_pmu->pmu = pmu;
> +			hybrid_pmu->pmu.type = -1;
> +			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
> +			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
> +
> +			/* Only register the PMU for the boot CPU */
> +			if (hybrid_pmu->cpu_type != cpu_type)
> +				continue;
> +
> +			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
> +						x86_get_hybrid_pmu_type(cpu_type));
> +			if (err) {
> +				pr_warn("Failed to register a PMU, err %d\n", err);
> +				kfree(x86_pmu.hybrid_pmu);
> +				x86_pmu.hybrid_pmu = NULL;
> +				goto out2;
> +			}
> +		}
> +	}
>  
>  	return 0;
