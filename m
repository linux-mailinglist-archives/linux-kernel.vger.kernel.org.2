Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC3337249
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhCKMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhCKMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:19:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E29C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9fW2qOyfoaaSWaCbCb4i39/BpyWx1Esy2ISXN8IdcGM=; b=j10HWpwtWxymRpEF2yl67R3IbP
        cFCBR25hCPIuxF1LIw5V8c8uRhGf225MfO+uw9lb3kDaWlFWYlmw8e4q3r68HglHCzLXMZqF+B/Rs
        1hdmKJqGQzzozETL4e9EPbokI3+J7BF6vChy6kAT96yM3JNE3P7Hzq0WaHyvRVCu3nTVWJgEYe67G
        G3qOgywj/w9j3RXquPMiumupw4Fj2M/bQDgYMNBsMghCVXyYd1Vs8d8mKfumaYRpDa1OdsPLS8hTG
        qactMgBieyrWTfofhRhgJhCeFXRS36FjdjfkPtpFaE/3/8186zAbVeeab4uWh3hI7J4TcWu/C0Q8i
        GeJHkpnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKHb-0094KB-A2; Thu, 11 Mar 2021 12:19:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51DDB301959;
        Thu, 11 Mar 2021 13:19:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D76229CB84C6; Thu, 11 Mar 2021 13:19:14 +0100 (CET)
Date:   Thu, 11 Mar 2021 13:19:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <YEoKwoNqagQzoj0i@hirez.programming.kicks-ass.net>
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
> @@ -4420,6 +4513,27 @@ void intel_cpuc_finish(struct cpu_hw_events *cpuc)
>  static void intel_pmu_cpu_dead(int cpu)
>  {
>  	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
> +
> +	if (is_hybrid()) {
> +		struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> +		struct x86_hybrid_pmu *hybrid_pmu = NULL;
> +		int i;
> +
> +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
> +			if (cpumask_test_and_clear_cpu(cpu, &x86_pmu.hybrid_pmu[i].supported_cpus)) {
> +				hybrid_pmu = &x86_pmu.hybrid_pmu[i];
> +				break;
> +			}
> +		}
> +		if (WARN_ON_ONCE(!hybrid_pmu))
> +			return;
> +
> +		cpuc->pmu = NULL;
> +		if (cpumask_empty(&hybrid_pmu->supported_cpus)) {
> +			perf_pmu_unregister(&hybrid_pmu->pmu);
> +			hybrid_pmu->pmu.type = -1;
> +		}
> +	}
>  }

CPU_DEAD is the part of hotplug after we've disabled IRQs for the last
time and before we kill ourselves, and you're trying to use mutexes
again!
