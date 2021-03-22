Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117C83437ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhCVEgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:36:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:28633 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVEgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:36:41 -0400
IronPort-SDR: XDMu2FLpo3w4TUFGbL2HhQDIBWEudoHTrqPBFQRf34fdCjNQa3kALijnooGbqAFmf2Z5MnyDp3
 XahyKBYnsaAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="275291796"
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="275291796"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 21:36:41 -0700
IronPort-SDR: ycSH79+VanVDVjNf0IFcUK4CKMHlCpmeYHOuEN3kEPPiSS0FXJGtNWnW+ezWnx1rT9lyJz6Sti
 B2czXCPqUnZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="440999082"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2021 21:36:35 -0700
Subject: Re: [PATCH] sched/fair: remove redundant test_idle_cores for non-smt
To:     Barry Song <song.bao.hua@hisilicon.com>,
        vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwei5@huawei.com,
        prime.zeng@hisilicon.com, guodong.xu@linaro.org,
        yangyicong@huawei.com, liguozhu@hisilicon.com,
        linuxarm@openeuler.org
References: <20210320221432.924-1-song.bao.hua@hisilicon.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <5da632c1-382f-5c23-531e-98899cbe1abb@linux.intel.com>
Date:   Mon, 22 Mar 2021 12:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210320221432.924-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On 2021/3/21 6:14, Barry Song wrote:
> update_idle_core() is only done for the case of sched_smt_present.
> but test_idle_cores() is done for all machines even those without
> smt.

The patch looks good to me.
May I know for what case we need to keep CONFIG_SCHED_SMT for non-smt
machines?

Thanks,
-Aubrey


> this could contribute to up 8%+ hackbench performance loss on a
> machine like kunpeng 920 which has no smt. this patch removes the
> redundant test_idle_cores() for non-smt machines.
> 
> we run the below hackbench with different -g parameter from 2 to
> 14, for each different g, we run the command 10 times and get the
> average time:
> $ numactl -N 0 hackbench -p -T -l 20000 -g $1
> 
> hackbench will report the time which is needed to complete a certain
> number of messages transmissions between a certain number of tasks,
> for example:
> $ numactl -N 0 hackbench -p -T -l 20000 -g 10
> Running in threaded mode with 10 groups using 40 file descriptors each
> (== 400 tasks)
> Each sender will pass 20000 messages of 100 bytes
> 
> The below is the result of hackbench w/ and w/o this patch:
> g=    2      4     6       8      10     12      14
> w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
> w/ : 1.8428 3.7436 5.4501 6.9522 8.2882  9.9535 11.3367
>                           +4.1%  +8.3%  +7.3%   +6.3%
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  kernel/sched/fair.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2e2ab1e..de42a32 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6038,9 +6038,11 @@ static inline bool test_idle_cores(int cpu, bool def)
>  {
>  	struct sched_domain_shared *sds;
>  
> -	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> -	if (sds)
> -		return READ_ONCE(sds->has_idle_cores);
> +	if (static_branch_likely(&sched_smt_present)) {
> +		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +		if (sds)
> +			return READ_ONCE(sds->has_idle_cores);
> +	}
>  
>  	return def;
>  }
> 

