Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75E040A432
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhINDNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:13:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9864 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhINDNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:13:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7pDg4ZNPz8ySQ;
        Tue, 14 Sep 2021 11:07:31 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:11:57 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:11:56 +0800
Subject: Re: [PATCH v5 2/6] nbd: make sure request completion won't concurrent
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-3-yukuai3@huawei.com> <YT/zkdoXG+awaVbm@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <74f3f2d9-fd85-f1d8-1f40-5319e247c5e1@huawei.com>
Date:   Tue, 14 Sep 2021 11:11:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YT/zkdoXG+awaVbm@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/09/14 8:57, Ming Lei wrote:
> On Thu, Sep 09, 2021 at 10:12:52PM +0800, Yu Kuai wrote:
>> commit cddce0116058 ("nbd: Aovid double completion of a request")
>> try to fix that nbd_clear_que() and recv_work() can complete a
>> request concurrently. However, the problem still exists:
>>
>> t1                    t2                     t3
>>
>> nbd_disconnect_and_put
>>   flush_workqueue
>>                        recv_work
>>                         blk_mq_complete_request
>>                          blk_mq_complete_request_remote -> this is true
>>                           WRITE_ONCE(rq->state, MQ_RQ_COMPLETE)
>>                            blk_mq_raise_softirq
>>                                               blk_done_softirq
>>                                                blk_complete_reqs
>>                                                 nbd_complete_rq
>>                                                  blk_mq_end_request
>>                                                   blk_mq_free_request
>>                                                    WRITE_ONCE(rq->state, MQ_RQ_IDLE)
>>    nbd_clear_que
>>     blk_mq_tagset_busy_iter
>>      nbd_clear_req
>>                                                     __blk_mq_free_request
>>                                                      blk_mq_put_tag
>>       blk_mq_complete_request -> complete again
>>
>> There are three places where request can be completed in nbd:
>> recv_work(), nbd_clear_que() and nbd_xmit_timeout(). Since they
>> all hold cmd->lock before completing the request, it's easy to
>> avoid the problem by setting and checking a cmd flag.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/nbd.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 04861b585b62..550c8dc438ac 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -406,7 +406,11 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>>   	if (!mutex_trylock(&cmd->lock))
>>   		return BLK_EH_RESET_TIMER;
>>   
>> -	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>> +	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>> +		mutex_unlock(&cmd->lock);
>> +		return BLK_EH_DONE;
>> +	}
>> +
>>   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>>   		cmd->status = BLK_STS_TIMEOUT;
>>   		mutex_unlock(&cmd->lock);
>> @@ -842,7 +846,10 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
>>   
>>   	mutex_lock(&cmd->lock);
>>   	cmd->status = BLK_STS_IOERR;
>> -	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>> +	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>> +		mutex_unlock(&cmd->lock);
>> +		return true;
>> +	}
>>   	mutex_unlock(&cmd->lock);
> 
> If this request has completed from other code paths, ->status shouldn't be
> updated here, maybe it is done successfully.

Hi, Ming

Will change this in next iteration.

Thanks,
Kuai
