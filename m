Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06273372B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhCKMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhCKMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:34:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B799AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uYQOV+uWm8ftXyQ2Xca8N4eM+vMvs0u/E17UZmM5nQQ=; b=gQ07OHE/uJWsc03S41EdzLrH6X
        VDh8K0b89boqBGb47/8qBchC/pjIJFg3UZARRr7Gn9P+PDuerlK8Xra37oTb2jNgTUi+MHaZOe0Ju
        n3l1wXnU0MuLwz8Hbas/3kA/l2aKQdvBBWUip8n8XDDCUcT6CWGrIS98wz5noEX8DG/TsVCYCJHkQ
        P01Bw0CGiyjbPDudIHzZDfK1M5e+Qo8IAyXmQvI4sMt4e/36pReQpYbGF36qnBRKcc2ouJFN491SA
        oby+sSlsurZMa51wbsorywdxFznT1aoz6balmAhOIp1g2yR9T/h6QmcsgPgdIfJYI8oHZuY2rpCat
        GwttRYTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKWM-0096ke-FM; Thu, 11 Mar 2021 12:34:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D98C7304D28;
        Thu, 11 Mar 2021 13:34:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C48AA29D00066; Thu, 11 Mar 2021 13:34:29 +0100 (CET)
Date:   Thu, 11 Mar 2021 13:34:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <YEoOVTVhN3DpQXl2@hirez.programming.kicks-ass.net>
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
> +
> +			hybrid_pmu->pmu = pmu;
> +			hybrid_pmu->pmu.type = -1;
> +			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
> +			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
> +
> +			/* Only register the PMU for the boot CPU */

Why ?!

AFAICT we could register them all here. That instantly fixes that
CPU_STARTING / CPU_DEAD fail elsewhere in this patch.

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
>  
