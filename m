Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2E359916
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhDIJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:25:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF75C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iVxq0dNeikAhWMPF1J4XtUbl5B83AWHFSRk0lJ3YhZA=; b=rn9KSkrn67rKqFexra4gczsJow
        zUglAWpXRQHiypTPn4I8TvhoMcahAwld+8KCmFa4amdEUkZ0mdUA42OQg+0UUo44jVy37GqXvlRiZ
        JCtrUlSYX6DWmx6k5jla7jXobfAHFYwCdUnJfbhJGPMZ9XYZlzHUN5c1bCYMba0nK2MQOVfugLWOs
        ttHj3cFO0rEkK+2huZrzKbj087lM4eJLqnIAVBH/pq+o11i8URk6K31EHwKnOHqjsO7ko82qRKtLw
        aH1/zpbjkv6zcC3v8wYViMFoPjJM//3TpJ+R5KJ7I7meZsdSM8RCOjfZ3fQE+xytfljr/xJGR0kI7
        XWmD84yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUnNc-0007sh-LL; Fri, 09 Apr 2021 09:24:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2632300033;
        Fri,  9 Apr 2021 11:24:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B9BB2C2328B7; Fri,  9 Apr 2021 11:24:43 +0200 (CEST)
Date:   Fri, 9 Apr 2021 11:24:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH V5 23/25] perf/x86/msr: Add Alder Lake CPU support
Message-ID: <YHAdW5GmTNwshpOi@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-24-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617635467-181510-24-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 08:11:05AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> PPERF and SMI_COUNT MSRs are also supported on Alder Lake.
> 
> The External Design Specification (EDS) is not published yet. It comes
> from an authoritative internal source.
> 
> The patch has been tested on real hardware.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/msr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
> index 680404c..c853b28 100644
> --- a/arch/x86/events/msr.c
> +++ b/arch/x86/events/msr.c
> @@ -100,6 +100,8 @@ static bool test_intel(int idx, void *data)
>  	case INTEL_FAM6_TIGERLAKE_L:
>  	case INTEL_FAM6_TIGERLAKE:
>  	case INTEL_FAM6_ROCKETLAKE:
> +	case INTEL_FAM6_ALDERLAKE:
> +	case INTEL_FAM6_ALDERLAKE_L:
>  		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
>  			return true;
>  		break;

If only it would be sanely enumerated... What about sapphire rapids?
