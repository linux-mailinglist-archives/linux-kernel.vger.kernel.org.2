Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C493A3DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhFKIDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:03:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C436C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iV6PuYBcGabhwMrk5vnVTC9sgARARQ/ZX23mi9Any1A=; b=hu6lDzSN1VXJtmAqBxQYQgTqKx
        ISyXh0L8nqlJ54pRxUntgG2l9ctPgyiFQn9uQlGj5e+bKaPjczJIz4WlgeHF6rVFgczL7vS65H35X
        DlSJmUtdiG2VC9HdRPFUrWR1XAg+3MDEU8MsP7wi8VYAZ8U/8vBZu5iC5zUaSpULj0+53CF4sYtqK
        LxBsp/nMS8309HCOu98APJxRzADSWsKbsA9DH9phA+kiGbEXESTxqcSA+W8Jdyy4OIeZP5OSboq1+
        OYw2LVaRMzYvpmae1nmcMw0FaXsrcv57ULYYZFeUxx5vqAbzLkZlzB1I5ddKNCoDACur8gj/eJGTx
        tBKuo6TA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrc6T-002X4L-G3; Fri, 11 Jun 2021 08:01:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF0B3300091;
        Fri, 11 Jun 2021 10:01:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83C5420709422; Fri, 11 Jun 2021 10:01:20 +0200 (CEST)
Date:   Fri, 11 Jun 2021 10:01:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/fpu: Rename "dynamic" XSTATEs to "independent"
Message-ID: <YMMYUGW9f7CUJ+oz@hirez.programming.kicks-ass.net>
References: <cover.1623388344.git.luto@kernel.org>
 <1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:13:36PM -0700, Andy Lutomirski wrote:
> The salient feature of "dynamic" XSTATEs is that they are not part of the
> main task XSTATE buffer.  The fact that they are dynamically allocated is
> irrelevant and will become quite confusing when user math XSTATEs start
> being dynamically allocated.  Rename them to "independent" because they
> are independent of the main XSTATE code.
> 
> This is just a search-and-replace with some whitespace updates to keep
> things aligned.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/events/intel/lbr.c       |  6 +--
>  arch/x86/include/asm/fpu/xstate.h | 14 +++----
>  arch/x86/kernel/fpu/xstate.c      | 62 +++++++++++++++----------------
>  3 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 76dbab6ac9fb..0189807fc3c1 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(void *ctx)
>  {
>  	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
>  
> -	copy_kernel_to_dynamic_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
> +	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
>  }
>  
>  static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
> @@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(void *ctx)
>  {
>  	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
>  
> -	copy_dynamic_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
> +	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
>  }
>  
>  static void __intel_pmu_lbr_save(void *ctx)
> @@ -978,7 +978,7 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
>  		intel_pmu_store_lbr(cpuc, NULL);
>  		return;
>  	}
> -	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
> +	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
>  
>  	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>  }

Yesterday tglx proposed the *save*_to_{user,kernel}() and
*rstor*_from_{user,kernel}() namespace for pretty much every other such
function.

And while I agree that independent_supervisor beats dynamic_supervisor
for a name, they're both stupid long :-(

I don't suppose we can simply use xsaves_to_kernel()
xstrors_from_kernel() and add some magic to their respective mask
handling to ensure that a mask belongs to only 1 (of 3) types.

	int types = 0;

	if (mask & xfeatures_mask_user())
		type++;
	if (mask & xfeatures_mask_supervisor())
		types++;
	if (mask & xfeatures_mask_independent())
		types++;

	if (WARN_ON_ONCE(type != 1))
		return;

?

