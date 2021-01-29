Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E0308324
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhA2BTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:19:01 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2802 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhA2BSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:18:54 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DRfYR3r1hz13nB5;
        Fri, 29 Jan 2021 09:16:11 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 09:18:11 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 09:18:10 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
CC:     <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <8704038d-0b71-5c9c-2d2b-a9ff2166dbe4@suse.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <c91cb4df-6736-bc0f-9d33-ecc3e2f4f510@huawei.com>
Date:   Fri, 29 Jan 2021 09:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8704038d-0b71-5c9c-2d2b-a9ff2166dbe4@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/28 17:23, Hannes Reinecke wrote:
> On 1/28/21 10:18 AM, Chao Leng wrote:
>>
>>
>> On 2021/1/28 15:58, Daniel Wagner wrote:
>>> On Thu, Jan 28, 2021 at 09:31:30AM +0800, Chao Leng wrote:
>>>>> --- a/drivers/nvme/host/multipath.c
>>>>> +++ b/drivers/nvme/host/multipath.c
>>>>> @@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>>>>>        }
>>>>>        for (ns = nvme_next_ns(head, old);
>>>>> -         ns != old;
>>>>> +         ns && ns != old;
>>>> nvme_round_robin_path just be called when !"old".
>>>> nvme_next_ns should not return NULL when !"old".
>>>> It seems unnecessary to add checking "ns".
>>>
>>> The problem is when we enter nvme_round_robin_path() and there is no
>>> path available. In this case the initialization ns = nvme_next_ns(head,
>>> old) could return a NULL pointer."old" should not be NULL, so there is at least one path that is "old".
>> It is impossible to return NULL for nvme_next_ns(head, old).
> 
> No. list_next_or_null_rcu()/list_first_or_null_rcu() will return NULL when then end of the list is reached.
Although list_next_or_null_rcu()/list_first_or_null_rcu() may return
NULL, but nvme_next_ns(head, old) assume that the "old" is in the "head",
so nvme_next_ns(head, old) should not return NULL. If the "old" is not
in the "head", nvme_next_ns(head, old) will run abnormal.
So there is other bug which cause nvme_next_ns(head, old).

I review the code about head->list and head->current_path, I find 2 bugs
may cause nvme_next_ns(head, old) abnormal:
First, I already send the patch. see:
https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/
Second, in nvme_ns_remove, list_del_rcu is before
nvme_mpath_clear_current_path. This may cause "old" is deleted from the
"head", but still use "old". I'm not sure there's any other
consideration here, I will check it and try to fix it.
> 
> Cheers,
> 
> Hannes
