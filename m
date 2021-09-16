Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654D440D10B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhIPBD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:03:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9880 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhIPBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:03:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8zGM50MFz8yZ6;
        Thu, 16 Sep 2021 08:58:03 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 09:02:29 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 09:02:28 +0800
Subject: Re: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
To:     Marco Elver <elver@google.com>, <akpm@linux-foundation.org>
CC:     <glider@google.com>, <dvyukov@google.com>, <jannh@google.com>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kasan-dev@googlegroups.com>,
        <hdanton@sina.com>
References: <20210421105132.3965998-1-elver@google.com>
 <20210421105132.3965998-3-elver@google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <6c0d5f40-5067-3a59-65fa-6977b6f70219@huawei.com>
Date:   Thu, 16 Sep 2021 09:02:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210421105132.3965998-3-elver@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/21 18:51, Marco Elver wrote:
> The allocation wait timeout was initially added because of warnings due
> to CONFIG_DETECT_HUNG_TASK=y [1]. While the 1 sec timeout is sufficient
> to resolve the warnings (given the hung task timeout must be 1 sec or
> larger) it may cause unnecessary wake-ups if the system is idle.
> [1] https://lkml.kernel.org/r/CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com
>
> Fix it by computing the timeout duration in terms of the current
> sysctl_hung_task_timeout_secs value.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>   mm/kfence/core.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 235d726f88bc..9742649f3f88 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -20,6 +20,7 @@
>   #include <linux/moduleparam.h>
>   #include <linux/random.h>
>   #include <linux/rcupdate.h>
> +#include <linux/sched/sysctl.h>
>   #include <linux/seq_file.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> @@ -621,7 +622,16 @@ static void toggle_allocation_gate(struct work_struct *work)
>   	/* Enable static key, and await allocation to happen. */
>   	static_branch_enable(&kfence_allocation_key);
>   
> -	wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate), HZ);
> +	if (sysctl_hung_task_timeout_secs) {
> +		/*
> +		 * During low activity with no allocations we might wait a
> +		 * while; let's avoid the hung task warning.
> +		 */
> +		wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate),
> +				   sysctl_hung_task_timeout_secs * HZ / 2);
> +	} else {
> +		wait_event(allocation_wait, atomic_read(&kfence_allocation_gate));
> +	}
>   
>   	/* Disable static key and reset timer. */
>   	static_branch_disable(&kfence_allocation_key);
