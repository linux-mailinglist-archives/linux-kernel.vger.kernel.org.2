Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBDC40C1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhIOIpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:45:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9874 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhIOIpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:45:22 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8YYN0B6Yz8yZR;
        Wed, 15 Sep 2021 16:39:36 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:44:02 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:44:01 +0800
Subject: Re: [PATCH v6 6/6] nbd: fix uaf in nbd_handle_reply()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210915081537.1684327-1-yukuai3@huawei.com>
 <20210915081537.1684327-7-yukuai3@huawei.com>
 <YUGswNyMnFHxigsW@infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e933a436-52a7-2faa-63f9-3fa3f6eae610@huawei.com>
Date:   Wed, 15 Sep 2021 16:44:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YUGswNyMnFHxigsW@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/09/15 16:20, Christoph Hellwig wrote:
> On Wed, Sep 15, 2021 at 04:15:37PM +0800, Yu Kuai wrote:
>> +++ b/block/blk-core.c
>> @@ -489,6 +489,7 @@ void blk_queue_exit(struct request_queue *q)
>>   {
>>   	percpu_ref_put(&q->q_usage_counter);
>>   }
>> +EXPORT_SYMBOL(blk_queue_exit);
> 
> These needs to be an EXPORT_SYMBOL_GPL.  But more importantly it
> needs to be a separate properly documented patch, and this function
> needs to grow a kerneldoc comment as well.
> 
>> +		/*
>> +		 * Get q_usage_counter can prevent accessing freed request
>> +		 * through blk_mq_tag_to_rq() in nbd_handle_reply(). If
>> +		 * q_usage_counter is zero, then no request is inflight, which
>> +		 * means something is wrong since we expect to find a request to
>> +		 * complete here.
>> +		 */
>> +		if (!percpu_ref_tryget(&q->q_usage_counter)) {
>> +			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
>> +				__func__);
>> +			break;
>> +		}
> 
> And this needs a properly documented wrapper as well.
> 
>> +
>>   		cmd = nbd_handle_reply(nbd, args->index, &reply);
>> -		if (IS_ERR(cmd))
>> +		if (IS_ERR(cmd)) {
>> +			blk_queue_exit(q);
>>   			break;
>> +		}
>>   
>>   		rq = blk_mq_rq_from_pdu(cmd);
>>   		if (likely(!blk_should_fake_timeout(rq->q)))
>>   			blk_mq_complete_request(rq);
>> +		blk_queue_exit(q);
> 
> That being said I can't say I like how this exposed block layer
> internals.  We don't really need a reference to the queue here
> anywhere, you just use it as a dumb debug check.  If we really want to
> reuse (abuse?) q_usage_counter a helper to just grab a reference and
> immediately drop it might be a better fit.
> .

Hi,

The uaf is because blk_mq_sched_free_requests() can concurrent with
nbd_read_stat(), and hold the ref during nbd_read_stat() can break the
concurrency, thus the ref can't be dropped immediately.

I'll use percpu_ref_put() directly as Ming suggestted.

Thanks,
Kuai
