Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27053FA308
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhH1CBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 22:01:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8793 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhH1CAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 22:00:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GxKWn3412zYql5;
        Sat, 28 Aug 2021 09:59:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 09:59:54 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 09:59:53 +0800
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b653a431-997b-0d94-2823-779f877c314f@huawei.com>
Date:   Sat, 28 Aug 2021 09:59:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/27 2:09, Bart Van Assche wrote:
> On 8/26/21 7:40 AM, Zhen Lei wrote:
>> lock protection needs to be added only in
>> dd_finish_request(), which is unlikely to cause significant performance
>> side effects.
> 
> Not sure the above is correct. Every new atomic instruction has a measurable
> performance overhead. But I guess in this case that overhead is smaller than
> the time needed to sum 128 per-CPU variables.
> 
>> Tested on my 128-core board with two ssd disks.
>> fio bs=4k rw=read iodepth=128 cpus_allowed=0-95 <others>
>> Before:
>> [183K/0/0 iops]
>> [172K/0/0 iops]
>>
>> After:
>> [258K/0/0 iops]
>> [258K/0/0 iops]
> 
> Nice work!
> 
>> Fixes: fb926032b320 ("block/mq-deadline: Prioritize high-priority requests")
> 
> Shouldn't the Fixes: tag be used only for patches that modify functionality?
> I'm not sure it is appropriate to use this tag for performance improvements.
> 
>>  struct deadline_data {
>> @@ -277,9 +278,9 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>>  }
>>  
>>  /* Number of requests queued for a given priority level. */
>> -static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>> +static __always_inline u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>>  {
>> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
>> +	return dd->per_prio[prio].nr_queued;
>>  }
> 
> Please leave out "__always_inline". Modern compilers are smart enough to
> inline this function without using the "inline" keyword.

Yes.

> 
>> @@ -711,6 +712,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>  
>>  	prio = ioprio_class_to_prio[ioprio_class];
>>  	dd_count(dd, inserted, prio);
>> +	per_prio = &dd->per_prio[prio];
>> +	per_prio->nr_queued++;
>>  
>>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>>  		blk_mq_free_requests(&free);
> 
> I think the above is wrong - nr_queued should not be incremented if the
> request is merged into another request. Please move the code that increments
> nr_queued past the above if-statement.

So dd_count(dd, inserted, prio) needs to be moved behind "if-statement" as well?

> 
> Thanks,
> 
> Bart.
> .
> 
