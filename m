Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E878C40A42F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhINDMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:12:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15409 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbhINDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:12:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7pDJ74X3zR5xN;
        Tue, 14 Sep 2021 11:07:12 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:11:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:11:06 +0800
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com> <YT/2z4PSeW5oJWMq@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
Date:   Tue, 14 Sep 2021 11:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YT/2z4PSeW5oJWMq@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/09/14 9:11, Ming Lei wrote:
> On Thu, Sep 09, 2021 at 10:12:55PM +0800, Yu Kuai wrote:
>> blk_mq_tag_to_rq() can only ensure to return valid request in
>> following situation:
>>
>> 1) client send request message to server first
>> submit_bio
>> ...
>>   blk_mq_get_tag
>>   ...
>>   blk_mq_get_driver_tag
>>   ...
>>   nbd_queue_rq
>>    nbd_handle_cmd
>>     nbd_send_cmd
>>
>> 2) client receive respond message from server
>> recv_work
>>   nbd_read_stat
>>    blk_mq_tag_to_rq
>>
>> If step 1) is missing, blk_mq_tag_to_rq() will return a stale
>> request, which might be freed. Thus convert to use
>> blk_mq_find_and_get_req() to make sure the returned request is not
>> freed.
> 
> But NBD_CMD_INFLIGHT has been added for checking if the reply is
> expected, do we still need blk_mq_find_and_get_req() for covering
> this issue? BTW, request and its payload is pre-allocated, so there
> isn't real use-after-free.

Hi, Ming

Checking NBD_CMD_INFLIGHT relied on the request founded by tag is valid,
not the other way round.

nbd_read_stat
  req = blk_mq_tag_to_rq()
  cmd = blk_mq_rq_to_pdu(req)
  mutex_lock(cmd->lock)
  checking NBD_CMD_INFLIGHT

The checking doesn't have any effect on blk_mq_tag_to_rq().

Thanks,
Kuai
