Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60AB43480B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJTJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:41:07 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26173 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:41:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HZ5B84b6Lz8tlv;
        Wed, 20 Oct 2021 17:37:36 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 17:38:50 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 20 Oct 2021 17:38:50 +0800
Subject: Re: [PATCH v4 1/2] block, bfq: counted root group into
 'num_groups_with_pending_reqs'
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211014014556.3597008-1-yukuai3@huawei.com>
 <20211014014556.3597008-2-yukuai3@huawei.com>
 <0DD9CFF0-6110-497D-A352-9F37CADADC6B@linaro.org>
 <1f89cece-a123-6190-bb72-d59035dac266@huawei.com>
 <2E8712BB-5BFB-4647-AE9A-B06E199500D7@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <8912e5ca-67bb-4a9a-a2ce-ba13e0fc86ed@huawei.com>
Date:   Wed, 20 Oct 2021 17:38:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2E8712BB-5BFB-4647-AE9A-B06E199500D7@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/20 17:29, Paolo Valente wrote:
> 
> 
>> Il giorno 20 ott 2021, alle ore 11:20, yukuai (C) <yukuai3@huawei.com> ha scritto:
>>
>> On 2021/10/20 16:51, Paolo Valente wrote:
>>
>>>> @@ -860,9 +870,25 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>>> 			     struct bfq_queue *bfqq)
>>>> {
>>>> 	struct bfq_entity *entity = bfqq->entity.parent;
>>>> +	struct bfq_sched_data *sd;
>>>> +
>>>> +	/*
>>>> +	 * If the bfq queue is in root group, the decrement of
>>>> +	 * num_groups_with_pending_reqs is performed immediately upon the
>>>> +	 * deactivation of entity.
>>>> +	 */
>>>> +	if (!entity) {
>>>> +		entity = &bfqd->root_group->entity;
>>>> +		sd = entity->my_sched_data;
>>>> +
>>>> +		if (!sd->in_service_entity)
>>>> +			bfq_clear_group_with_pending_reqs(bfqd, entity);
>>>> +
>>>> +		return;
>>>> +	}
>>>>
>>>> 	for_each_entity(entity) {
>>>> -		struct bfq_sched_data *sd = entity->my_sched_data;
>>>> +		sd = entity->my_sched_data;
>>>>
>>>> 		if (sd->next_in_service || sd->in_service_entity) {
>>>> 			/*
>>>> @@ -880,7 +906,8 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>>> 		}
>>>>
>>>> 		/*
>>>> -		 * The decrement of num_groups_with_pending_reqs is
>>>> +		 * If the bfq queue is not in root group,
>>>> +		 * the decrement of num_groups_with_pending_reqs is
>>> I'm sorry if I didn't notice this before, but why do you postpone the
>>> decrement only for queues not in root group?  If I'm not missing
>>> anything, the active (i.e., with pending reqs) state of the root group
>>> is to be computed as that of ay other group.
>>
>> Hi, Paolo
>>
>> I thought if queue is in root group, then bfqq->entity.parent is NULL,
>> and such case is handled above, which is separate from previous
>> implementation for queues that are not in root group.
>>
>> Is this the wrong way to handle root group?
>>
> 
> I think that, if we want to count also the root group among the active
> ones, then the logic for tagging the root group as active must be the
> same as the other groups. Or am I missing something?

Hi, Paolo

Currently, if queue is in root group, bfqq->entity.parent is NULL, and
this makes it hard to keep the same logic.

Can we store root_group->my_entity to bfqq->entity.parent if the queue
is in root group?

Thanks,
Kuai

