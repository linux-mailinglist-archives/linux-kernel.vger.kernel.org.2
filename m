Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB31131E459
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBRCdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:33:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:65138 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBRCdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:33:18 -0500
IronPort-SDR: H0B45p6ncjsSYUDpdCJvb7uXF8U/bLmlqgH/wAjFlPiwUL4s8Pllv+cMox3bLgYIiiGJQCRfqL
 4g+09VNneghg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="202619801"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="202619801"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 18:31:32 -0800
IronPort-SDR: h/YMGYfFVccVrrZVrdT2THkW82ifAkJmps4ADW7CB8BL9p5F+jPFf0dtVAnZ+UxJiuiOi4nMWx
 CayZkZKAf0Pg==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="439627474"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.93]) ([10.238.4.93])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 18:31:29 -0800
Subject: Re: [PATCH] perf/x86/lbr: Simplify the exposure check for the
 LBR_INFO registers
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210203070337.329511-1-like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <5299a9a1-447e-be47-4b19-c5ada666b64e@linux.intel.com>
Date:   Thu, 18 Feb 2021 10:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210203070337.329511-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Would you help pick up this patch so that we can enable guest Arch LBR?

---
thx,likexu

On 2021/2/3 15:03, Like Xu wrote:
> If the platform supports LBR_INFO register, the x86_pmu.lbr_info will
> be assigned in intel_pmu_?_lbr_init_?() and it's safe to expose LBR_INFO
> in the x86_perf_get_lbr() directly, instead of relying on lbr_format check.
> 
> Also Architectural LBR has IA32_LBR_x_INFO instead of LBR_FORMAT_INFO_x
> to hold metadata for the operation, including mispredict, TSX, and
> elapsed cycle time information.
> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>   arch/x86/events/intel/lbr.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 21890dacfcfe..355ea70f1879 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1832,12 +1832,10 @@ void __init intel_pmu_arch_lbr_init(void)
>    */
>   int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
>   {
> -	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
> -
>   	lbr->nr = x86_pmu.lbr_nr;
>   	lbr->from = x86_pmu.lbr_from;
>   	lbr->to = x86_pmu.lbr_to;
> -	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
> +	lbr->info = x86_pmu.lbr_info;
>   
>   	return 0;
>   }
> 

