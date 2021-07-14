Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1EB3C83C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbhGNLXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:23:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6818 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbhGNLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:23:40 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPvzr1fVlzXsxX;
        Wed, 14 Jul 2021 19:15:04 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 19:20:40 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 19:20:40 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
Subject: Re: [PATCH -next] sched: Dec __cfs_bandwith_used in
 destroy_cfs_bandwidth()
Reply-To: <20210712162655.w3j6uczwbfkzazvt@oracle.com>
To:     <daniel.m.jordan@oracle.com>
CC:     <bsegall@google.com>, <dietmar.eggemann@arm.com>,
        <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <vincent.guittot@linaro.org>, <zhangqiao22@huawei.com>
Message-ID: <3b2eb2c6-20d5-9f13-09f9-77f87f333b8d@huawei.com>
Date:   Wed, 14 Jul 2021 19:20:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 06, 2021 at 04:38:20PM +0800, Zhang Qiao wrote:
>> __cfs_bandwith_uesd is a static_key to control cfs bandwidth
>> feature. When adding a cfs_bandwidth group, we need increase
>> the key, and decrease it when removing. But currently when we
>> remove a cfs_bandwidth group, we don't decrease the key and
>> this switch will always be on even if there is no cfs bandwidth
>> group in the system.
> 
> Yep, that's broken.
> 
>> Therefore, when removing a cfs bandwidth group, we decrease
>> __cfs_bandwith_used by calling cfs_bandwidth_usage_dec().
>> 
>> Fixes: 56f570e512ee ("sched: use jump labels to reduce overhead when bandwidth control is inactive")
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> ---
>>  kernel/sched/fair.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 103e31e53e2b..857e8908b7f7 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5344,6 +5344,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>  	if (!cfs_b->throttled_cfs_rq.next)
>>  		return;
>>  
>> +	if (cfs_b->quota != RUNTIME_INF)
>> +		cfs_bandwidth_usage_dec();
> 
> This calls static_key_slow_dec_cpuslocked, but destroy_cfs_bandwidth
> isn't holding the hotplug lock.
> 
> The other caller of cfs_bandwidth_usage_dec needs to hold it for another
> reason, so what about having both cfs_bandwidth_usage_dec() and
> cfs_bandwidth_usage_dec_cpuslocked()?  In that case, the _inc one could
> be renamed similarly so this isn't a stumbling block later on.
Hi Jordan, thanks for your comments.It is valuable to me.

And i have another thought is that we can hold the
hotplug lock before calling cfs_bandwidth_usage_dec().
This way, fewer modifications are involved.
What do you think about it?

thanks.
> 
>> +
>>  	hrtimer_cancel(&cfs_b->period_timer);
>>  	hrtimer_cancel(&cfs_b->slack_timer);
>>  }
>> -- 
>> 2.18.0.huawei.25
>> 

