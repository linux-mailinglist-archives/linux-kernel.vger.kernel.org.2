Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04C9346B37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhCWVjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhCWVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7088C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nya+ov9UQJL5DIroCTuSAcRlSsVdt2e1wLenJZbbPhA=; b=AJ1Kfe/DCRHVaPq4z0nIiPsldY
        LDB0+A4YE6Yi/95NfZjZeWKLuaq4lx056SshaDbv65lUWEs630/POM0n0dHn0IAJpIt/ftddjFXoq
        IOIv092DQcSpk/8+lpehm/iWA7SVyMTIkxgu8VuRK0K2Y5g5t4+0motLaD3gX8WjCCB8OiO2ivkZu
        B7lZJSbphZQCSaE/Wh2CJwXxC0nGPk0GoBpdtAv0QNqKmcpK0mQOo8Ml11aa3ypgbYFxmh9eufRs5
        RIfZTSIvgm4rjwxI3uD5AiYvaL4/vKdvRefQhvn/kaP5nTRZrn0/4YtqnAL9Y2ABKKgbmKXto5meB
        yhd/P2XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOojn-00FnZS-T1; Tue, 23 Mar 2021 21:38:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F21F99864F6; Tue, 23 Mar 2021 22:38:54 +0100 (CET)
Date:   Tue, 23 Mar 2021 22:38:54 +0100
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
Subject: Re: [PATCH v4 RESEND 2/5] perf/x86/lbr: Simplify the exposure check
 for the LBR_INFO registers
Message-ID: <20210323213854.GD4746@worktop.programming.kicks-ass.net>
References: <20210322060635.821531-1-like.xu@linux.intel.com>
 <20210322060635.821531-3-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322060635.821531-3-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:06:32PM +0800, Like Xu wrote:
> If the platform supports LBR_INFO register, the x86_pmu.lbr_info will
> be assigned in intel_pmu_?_lbr_init_?() and it's safe to expose LBR_INFO

You mean: intel_pmu_lbr_*init*(). '?' is a single character glob and
you've got too many '_'s.

> in the x86_perf_get_lbr() directly, instead of relying on lbr_format check.

But, afaict, not every model calls one of those. CORE_YONAH for example
doesn't.

> Also Architectural LBR has IA32_LBR_x_INFO instead of LBR_FORMAT_INFO_x
> to hold metadata for the operation, including mispredict, TSX, and
> elapsed cycle time information.

Relevance?

Wouldn't it be much simpler to simple say something like:

  "x86_pmu.lbr_info is 0 unless explicitly initialized, so there's no
  point checking lbr_fmt"

> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 21890dacfcfe..355ea70f1879 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1832,12 +1832,10 @@ void __init intel_pmu_arch_lbr_init(void)
>   */
>  int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
>  {
> -	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
> -
>  	lbr->nr = x86_pmu.lbr_nr;
>  	lbr->from = x86_pmu.lbr_from;
>  	lbr->to = x86_pmu.lbr_to;
> -	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
> +	lbr->info = x86_pmu.lbr_info;
>  
>  	return 0;
>  }
> -- 
> 2.29.2
> 
