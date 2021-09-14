Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B72640B76F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhINTEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:04:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:56129 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhINTEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:04:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="283104302"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="283104302"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 12:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="529081215"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2021 12:03:36 -0700
Received: from [10.251.14.198] (kliang2-MOBL.ccr.corp.intel.com [10.251.14.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5D0785805A1;
        Tue, 14 Sep 2021 12:03:35 -0700 (PDT)
Subject: Re: [PATCH 1/3] Fix filter_tid mask for CHA events on Skylake Server
To:     alexander.antonov@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, alexey.v.bayduraev@linux.intel.com
References: <20210914182349.36186-1-alexander.antonov@linux.intel.com>
 <20210914182349.36186-2-alexander.antonov@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d6fc0d04-0707-dad5-b04a-6c12d6f347ec@linux.intel.com>
Date:   Tue, 14 Sep 2021 15:03:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914182349.36186-2-alexander.antonov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2021 2:23 PM, alexander.antonov@linux.intel.com wrote:
> From: Alexander Antonov <alexander.antonov@linux.intel.com>
> 
> According Uncore Reference Manual: any of the CHA events may be filtered
> by Thread/Core-ID by using tid modifier in CHA Filter 0 Register.
> Update skx_cha_hw_config() to follow Uncore Guide.
> 
> Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>   arch/x86/events/intel/uncore_snbep.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 5ddc0f30db6f..9cc65a4194ce 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3607,7 +3607,9 @@ static int skx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
>   {
>   	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
>   	struct extra_reg *er;
> -	int idx = 0;
> +	/* Any of the CHA events may be filtered by Thread/Core-ID.*/
> +	int idx = !!(event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN) ?
> +		     SKX_CHA_MSR_PMON_BOX_FILTER_TID : 0;
>   
>   	for (er = skx_uncore_cha_extra_regs; er->msr; er++) {
>   		if (er->event != (event->hw.config & er->config_mask))
> 
