Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE0346B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhCWVuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhCWVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:50:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959CFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mYwu2RtzgZKNU9NGCGzqzPwajfLHA9RJT8xFKj9ft30=; b=hGs40wJkP4sjmJs6jHLMVtmpaP
        467+h70F6SkcwaImgB6TNqmKJrQu42ZfHLzwKwG47x0mluF/NH0Up/DZclQCgIBg4z/icSmi22Rdi
        3q3e1rqRGTDwAg7U0WWgJZNw8xrBNu3JNrC0XMtQYYeU7qEenc8i6zt16N8JrC1CaXlbrQJNxe0xS
        kZnzOqqedPxFSHLArCWfkCMA4G+0HcfpBy7VDe/n/s6ggzn/OTPjn3KYYh1HXqee0tzjpZiNhtJXL
        8XtmSDkWHqmdgr8eqkO/LJK+/MpogGGYjT7J50b+cUFxliIOpoPk5SjAvpMmApW1+fXmr7oIhzf6J
        EjDkCldA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOou8-00AZjj-3I; Tue, 23 Mar 2021 21:49:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 376279864F6; Tue, 23 Mar 2021 22:49:35 +0100 (CET)
Date:   Tue, 23 Mar 2021 22:49:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 RESEND 4/5] perf/x86/lbr: Skip checking for the
 existence of LBR_TOS for Arch LBR
Message-ID: <20210323214935.GF4746@worktop.programming.kicks-ass.net>
References: <20210322060635.821531-1-like.xu@linux.intel.com>
 <20210322060635.821531-5-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322060635.821531-5-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:06:34PM +0800, Like Xu wrote:
> The Architecture LBR does not have MSR_LBR_TOS (0x000001c9). KVM will
> generate #GP for this MSR access, thereby preventing the initialization
> of the guest LBR.
> 
> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 382dd3994463..7f6d748421f2 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5740,7 +5740,8 @@ __init int intel_pmu_init(void)
>  	 * Check all LBR MSR here.
>  	 * Disable LBR access if any LBR MSRs can not be accessed.
>  	 */
> -	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
> +	if (x86_pmu.lbr_nr && !boot_cpu_has(X86_FEATURE_ARCH_LBR) &&
> +	    !check_msr(x86_pmu.lbr_tos, 0x3UL))
>  		x86_pmu.lbr_nr = 0;

But when ARCH_LBR we don't set lbr_tos, so we check MSR 0x000, not 0x1c9.

Do we want check_msr() to ignore msr==0 ?
Additionally, do we want a check for lbr_info ?

>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>  		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
> -- 
> 2.29.2
> 
