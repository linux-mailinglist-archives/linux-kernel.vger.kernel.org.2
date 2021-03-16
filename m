Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9DF33CC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhCPE13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:27:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:23114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235003AbhCPE12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:27:28 -0400
IronPort-SDR: HAWtICA1Z6Gtgf/7HDGIeKG/ynmXe+tC4iwuY88Z1DjVGaWqMEtHVHdzzbSuzkByDXUAGfsKJU
 2Nzgtccvp2Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253213911"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253213911"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 21:27:28 -0700
IronPort-SDR: TZpwBNAcjt5jDtqXynI0VJW8Y2DZRi0HSNsoJjPQupUAL0cR6g6ivGFQdRd2M6t/wsYUVYBKnj
 KuvNz0rCugMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="439057412"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2021 21:27:24 -0700
Subject: Re: [PATCH v2] sched/fair: reduce long-tail newly idle balance cost
To:     Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        mgorman@techsingularity.net, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <1614154549-116078-1-git-send-email-aubrey.li@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <74f65436-09f2-a4f0-345f-8887b11a51bf@linux.intel.com>
Date:   Tue, 16 Mar 2021 12:27:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614154549-116078-1-git-send-email-aubrey.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/24 16:15, Aubrey Li wrote:
> A long-tail load balance cost is observed on the newly idle path,
> this is caused by a race window between the first nr_running check
> of the busiest runqueue and its nr_running recheck in detach_tasks.
> 
> Before the busiest runqueue is locked, the tasks on the busiest
> runqueue could be pulled by other CPUs and nr_running of the busiest
> runqueu becomes 1 or even 0 if the running task becomes idle, this
> causes detach_tasks breaks with LBF_ALL_PINNED flag set, and triggers
> load_balance redo at the same sched_domain level.
> 
> In order to find the new busiest sched_group and CPU, load balance will
> recompute and update the various load statistics, which eventually leads
> to the long-tail load balance cost.
> 
> This patch clears LBF_ALL_PINNED flag for this race condition, and hence
> reduces the long-tail cost of newly idle balance.

Ping...

> 
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  kernel/sched/fair.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce2..5c67804 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7675,6 +7675,15 @@ static int detach_tasks(struct lb_env *env)
>  
>  	lockdep_assert_held(&env->src_rq->lock);
>  
> +	/*
> +	 * Source run queue has been emptied by another CPU, clear
> +	 * LBF_ALL_PINNED flag as we will not test any task.
> +	 */
> +	if (env->src_rq->nr_running <= 1) {
> +		env->flags &= ~LBF_ALL_PINNED;
> +		return 0;
> +	}
> +
>  	if (env->imbalance <= 0)
>  		return 0;
>  
> 

