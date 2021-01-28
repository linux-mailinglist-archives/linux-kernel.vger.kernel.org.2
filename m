Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78173072C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhA1Jb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:31:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:53970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhA1JY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:24:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6CE71AE12;
        Thu, 28 Jan 2021 09:23:43 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8704038d-0b71-5c9c-2d2b-a9ff2166dbe4@suse.de>
Date:   Thu, 28 Jan 2021 10:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 10:18 AM, Chao Leng wrote:
> 
> 
> On 2021/1/28 15:58, Daniel Wagner wrote:
>> On Thu, Jan 28, 2021 at 09:31:30AM +0800, Chao Leng wrote:
>>>> --- a/drivers/nvme/host/multipath.c
>>>> +++ b/drivers/nvme/host/multipath.c
>>>> @@ -221,7 +221,7 @@ static struct nvme_ns 
>>>> *nvme_round_robin_path(struct nvme_ns_head *head,
>>>>        }
>>>>        for (ns = nvme_next_ns(head, old);
>>>> -         ns != old;
>>>> +         ns && ns != old;
>>> nvme_round_robin_path just be called when !"old".
>>> nvme_next_ns should not return NULL when !"old".
>>> It seems unnecessary to add checking "ns".
>>
>> The problem is when we enter nvme_round_robin_path() and there is no
>> path available. In this case the initialization ns = nvme_next_ns(head,
>> old) could return a NULL pointer."old" should not be NULL, so there is 
>> at least one path that is "old".
> It is impossible to return NULL for nvme_next_ns(head, old).

No. list_next_or_null_rcu()/list_first_or_null_rcu() will return NULL 
when then end of the list is reached.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
