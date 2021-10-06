Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE94236E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 06:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhJFEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 00:12:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23351 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhJFEMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 00:12:15 -0400
Received: from dggeml754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HPLTy1TsrzRZJ4;
        Wed,  6 Oct 2021 12:05:58 +0800 (CST)
Received: from [10.174.177.21] (10.174.177.21) by
 dggeml754-chm.china.huawei.com (10.1.199.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 6 Oct 2021 12:10:20 +0800
Subject: Re: [RFC 1/8] sched: Add nice value change notifier
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <Intel-gfx@lists.freedesktop.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20211004143650.699120-1-tvrtko.ursulin@linux.intel.com>
 <20211004143650.699120-2-tvrtko.ursulin@linux.intel.com>
From:   "Wanghui (John)" <john.wanghui@huawei.com>
Message-ID: <562d45e1-4a27-3252-f615-3ab1ef531f2b@huawei.com>
Date:   Wed, 6 Oct 2021 12:10:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211004143650.699120-2-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.21]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeml754-chm.china.huawei.com (10.1.199.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Tvrtko

On 2021/10/4 22:36, Tvrtko Ursulin wrote:
>   void set_user_nice(struct task_struct *p, long nice)
>   {
>   	bool queued, running;
> -	int old_prio;
> +	int old_prio, ret;
>   	struct rq_flags rf;
>   	struct rq *rq;
>   
> @@ -6915,6 +6947,9 @@ void set_user_nice(struct task_struct *p, long nice)
>   
>   out_unlock:
>   	task_rq_unlock(rq, p, &rf);
> +
> +	ret = atomic_notifier_call_chain(&user_nice_notifier_list, nice, p);
> +	WARN_ON_ONCE(ret != NOTIFY_DONE);
>   }
How about adding a new "io_nice" to task_struct，and move the call chain to
sched_setattr/getattr, there are two benefits:

1. Decoupled with fair scheduelr. In our use case, high priority tasks often
    use rt scheduler.
2. The range of value don't need to be bound to -20~19 or 0~139




