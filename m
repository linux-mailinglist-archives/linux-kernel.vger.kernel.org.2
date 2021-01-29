Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62A308445
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhA2Dg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:36:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2997 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhA2Dgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:36:52 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DRjdf47cvzR8Ny;
        Fri, 29 Jan 2021 11:35:02 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 11:36:09 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 11:36:08 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Jens Axboe" <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <dbc39e56-b2bd-a82e-499a-5032c9716855@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <a3c64c60-13f3-1b99-47bc-05ebfefed343@huawei.com>
Date:   Fri, 29 Jan 2021 11:36:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <dbc39e56-b2bd-a82e-499a-5032c9716855@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/29 11:30, Sagi Grimberg wrote:
> 
>>>>> You can't see exactly where it dies but I followed the assembly to
>>>>> nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
>>>>> old) which returns NULL but nvme_next_ns() is returning NULL eventually
>>>>> (list_next_or_null_rcu()).
>>>> So there is other bug cause nvme_next_ns abormal.
>>>> I review the code about head->list and head->current_path, I find 2 bugs
>>>> may cause the bug:
>>>> First, I already send the patch. see:
>>>> https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/
>>>> Second, in nvme_ns_remove, list_del_rcu is before
>>>> nvme_mpath_clear_current_path. This may cause "old" is deleted from the
>>>> "head", but still use "old". I'm not sure there's any other
>>>> consideration here, I will check it and try to fix it.
>>>
>>> The reason why we first remove from head->list and only then clear
>>> current_path is because the other way around there is no way
>>> to guarantee that that the ns won't be assigned as current_path
>>> again (because it is in head->list).
>> ok, I see.
>>>
>>> nvme_ns_remove fences continue of deletion of the ns by synchronizing
>>> the srcu such that for sure the current_path clearance is visible.
>> The list will be like this:
>> head->next = ns1;
>> ns1->next = head;
>> old->next = ns1;
>> This may cause infinite loop in nvme_round_robin_path.
>> for (ns = nvme_next_ns(head, old);
>>      ns != old;
>>      ns = nvme_next_ns(head, ns))
>> The ns will always be ns1, and then infinite loop.
> 
> Who is being removed? I'm not following
The "old" is being removed path.
Daniel Wagner report crash like this:
head->next = head;
old->next = head;
So nvme_next_ns(head, old) will return NULL, and then crash.
Although check ns can avoid crash, but can not avoid infinite loop.

Similar reason, The list will be like this:
head->next = ns1;
ns1->next = head;
old->next = ns1;
ns1 is other path.

> .
