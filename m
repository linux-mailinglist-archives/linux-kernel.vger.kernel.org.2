Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752293A464B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFKQSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:18:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:4238 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhFKQSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:18:43 -0400
IronPort-SDR: laPAzS2QKnjEIKOz1TE3l8VCbFI6Gw3iCDyK31Cq9pfCpx86nmS2TrFrKePmgYatJtbAlgNTEe
 q1CuSuX2QBbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291187112"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="291187112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:16:45 -0700
IronPort-SDR: y05z96HmoWxYhGabTqiJaqm9UQteuFaK5Ht0q3f4rApdzEb1QwkpZAMQg/Rj2TymkTpehdmk6Y
 ya3j/x/CivwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="403053439"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2021 09:16:45 -0700
Received: from [10.209.40.10] (kliang2-MOBL.ccr.corp.intel.com [10.209.40.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DF13A5808BA;
        Fri, 11 Jun 2021 09:16:44 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel/lbr: Zero the xstate buffer on allocation
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <87wnr0wo2z.ffs@nanos.tec.linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <807e78dc-eaae-9034-7f15-1639d696d336@linux.intel.com>
Date:   Fri, 11 Jun 2021 12:16:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87wnr0wo2z.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2021 9:03 AM, Thomas Gleixner wrote:
> XRSTORS requires a valid xstate buffer to work correctly. XSAVES does not
> guarantee to write a fully valid buffer according to the SDM:
> 
>    "XSAVES does not write to any parts of the XSAVE header other than the
>     XSTATE_BV and XCOMP_BV fields."
> 
> XRSTORS triggers a #GP:
> 
>    "If bytes 63:16 of the XSAVE header are not all zero."
> 
> It's dubious at best how this can work at all when the buffer is not zeroed
> before use.
>

I didn't run into any issues when I did the test. I guess the reserved 
bits in the buffer may always happen to be 0. That's why it didn't set 
off the alarm to me. Thank you very much for the fix.

Thanks,
Kan

> Allocate the buffers with __GFP_ZERO to prevent XRSTORS failure.
> 
> Fixes: ce711ea3cab9 ("perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR context switch")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org
> ---
>   arch/x86/events/intel/lbr.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -731,7 +731,8 @@ void reserve_lbr_buffers(void)
>   		if (!kmem_cache || cpuc->lbr_xsave)
>   			continue;
>   
> -		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
> +		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache,
> +							GFP_KERNEL | __GFP_ZERO,
>   							cpu_to_node(cpu));
>   	}
>   }
> 
