Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286304349B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhJTLHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhJTLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:07:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BEAC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KgkRcXS4QOq4wBKQCamGCOypYldhycjYz5j0T64a6b8=; b=kk5GlPd/FwITJFGUg/8o69S7zx
        c3o67K6cLNLDXfucc+Bs0Yy3z5n1LGuSAcshzt/tNahInOA5FzNEs/abygpXKnUfVo79a6iNxvwB0
        AlB0qijEMNkHoE5hy4zbwDqrglWxaxehlFhskWDvkvamTj2f12FeyIntGrmm75XhLbxkhVfFWo72m
        OevhOogFSKc5U3ew9V/+cZniOqC9iIP3H4qt6oCWHr5i/ZiYWt5zUm7Q0q7EqCC0+mENm2ZRvO7pQ
        bzRpv8a/Tg0xbH1o1RvR4EC20DQW5jJFACqrZsqG4MB05IfIrlggHVoxS3Klf4rdoqF3JE+GYMooO
        ns/dMfpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9Nb-00CRA4-GO; Wed, 20 Oct 2021 11:04:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B3BA300221;
        Wed, 20 Oct 2021 13:03:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 758EA201BB3D6; Wed, 20 Oct 2021 13:03:31 +0200 (CEST)
Date:   Wed, 20 Oct 2021 13:03:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     alexander.antonov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, alexey.v.bayduraev@linux.intel.com
Subject: Re: [RESEND PATCH 1/3] Fix filter_tid mask for CHA events on Skylake
 Server
Message-ID: <YW/3g350K04xX63g@hirez.programming.kicks-ass.net>
References: <20211020110028.38781-1-alexander.antonov@linux.intel.com>
 <20211020110028.38781-2-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020110028.38781-2-alexander.antonov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 02:00:26PM +0300, alexander.antonov@linux.intel.com wrote:
> From: Alexander Antonov <alexander.antonov@linux.intel.com>
> 
> According Uncore Reference Manual: any of the CHA events may be filtered
> by Thread/Core-ID by using tid modifier in CHA Filter 0 Register.
> Update skx_cha_hw_config() to follow Uncore Guide.
> 
> Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 5ddc0f30db6f..9cc65a4194ce 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3607,7 +3607,9 @@ static int skx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
>  {
>  	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
>  	struct extra_reg *er;
> -	int idx = 0;
> +	/* Any of the CHA events may be filtered by Thread/Core-ID.*/
> +	int idx = !!(event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN) ?
> +		     SKX_CHA_MSR_PMON_BOX_FILTER_TID : 0;

Wouldn't something like:

	if (event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN)
		idx = SKX_CHA_MSR_PMON_BOX_FILTER_TID;

be *MUCH* more readable?

>  
>  	for (er = skx_uncore_cha_extra_regs; er->msr; er++) {
>  		if (er->event != (event->hw.config & er->config_mask))
> -- 
> 2.21.3
> 
