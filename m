Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00D937B309
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELAde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 20:33:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:16564 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhELAdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 20:33:32 -0400
IronPort-SDR: syaI6emOLhBOzTHjZIV6uVAkOkU1aFBj0PnaCCBp8JhfalzIVzd0kUEJrQ5zqucYFtHeJxFI8a
 MbzBRWuNcTpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179850376"
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="179850376"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 17:32:25 -0700
IronPort-SDR: +0utWd8fZ+y74rhosBdX/2HB1akE7iVziWV9zI4KBaZ+cWJ9YIZhpLbK4RkRLoqMupYIC1hSSe
 M5oMZsYvYgzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="455323210"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2021 17:32:22 -0700
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <87tun91oaa.mognet@arm.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <c4007fd3-e87b-5b19-6add-91ec4af8e83a@linux.intel.com>
Date:   Wed, 12 May 2021 08:32:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87tun91oaa.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 5/11/21 7:51 PM, Valentin Schneider wrote:
> On 06/05/21 22:15, Srikar Dronamraju wrote:
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 8db40c8a6ad0..00e4669bb241 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -647,6 +647,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
>>  #ifdef CONFIG_SCHED_SMT
>>  DEFINE_PER_CPU(int, smt_id);
>>  #endif
>> +DEFINE_PER_CPU(int, is_idle);
> 
> This + patch 8 immediately reminds me of Aubrey's patch:
> 
>   http://lore.kernel.org/r/1615872606-56087-1-git-send-email-aubrey.li@intel.com
> 
> last I looked it seemed OK, even the test bot seems happy. Aubrey, did you
> have any more work to do on that one (other than rebasing)?
> 

Thanks to mention this patch, in terms of the patch itself, I don't have any more
work, other than rebasing it to Rik's bring-back-select_idle_smt() patch.

But I have some other ideas based on this patch need to verify, for example, if we
have an idle_cpu mask when we scan the idle CPU, we should be able to remove SIS_PROP
feature at all. This removes scan cost computation and should reduce the task wakeup
latency. But I need a while to understand some benchmark regressions.

Thanks,
-Aubrey
