Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16B930F132
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbhBDKud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:50:33 -0500
Received: from foss.arm.com ([217.140.110.172]:55768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235436AbhBDKua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:50:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F226111D4;
        Thu,  4 Feb 2021 02:49:43 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC3E43F719;
        Thu,  4 Feb 2021 02:49:41 -0800 (PST)
Subject: Re: [PATCH 5/8] sched/fair: Make check_misfit_status() only compare
 dynamic capacities
To:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-6-valentin.schneider@arm.com>
 <20210203151546.rwkbdjxc2vgiodvx@e107158-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f1ea5b53-5953-15dc-6b67-9b6d520c61fc@arm.com>
Date:   Thu, 4 Feb 2021 11:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203151546.rwkbdjxc2vgiodvx@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 16:15, Qais Yousef wrote:
> On 01/28/21 18:31, Valentin Schneider wrote:

[...]

>> @@ -10238,7 +10236,7 @@ static void nohz_balancer_kick(struct rq *rq)
>>  		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
>>  		 * to run the misfit task on.
>>  		 */
>> -		if (check_misfit_status(rq, sd)) {
>> +		if (check_misfit_status(rq)) {

Since check_misfit_status() doesn't need sd anymore it looks like that
rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu)) could be replaced by
static_branch_unlikely(&sched_asym_cpucapacity)) in nohz_balancer_kick().

But as you mentioned in an earlier conversation we do need to check sd
because of asymmetric CPU capacity systems w/ exclusive cpusets which
could create symmetric islands (unique capacity_orig among CPUs).

Maybe worth putting a comment here (similar to the one in sis()) so
people don't try to optimize?
