Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A830728D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhA1JW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:22:59 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2567 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhA1JTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:19:47 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DRFGf5zyKzW2PM;
        Thu, 28 Jan 2021 17:16:58 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 17:18:58 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 28
 Jan 2021 17:18:57 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Daniel Wagner <dwagner@suse.de>
CC:     <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
Date:   Thu, 28 Jan 2021 17:18:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/28 15:58, Daniel Wagner wrote:
> On Thu, Jan 28, 2021 at 09:31:30AM +0800, Chao Leng wrote:
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>>>    	}
>>>    	for (ns = nvme_next_ns(head, old);
>>> -	     ns != old;
>>> +	     ns && ns != old;
>> nvme_round_robin_path just be called when !"old".
>> nvme_next_ns should not return NULL when !"old".
>> It seems unnecessary to add checking "ns".
> 
> The problem is when we enter nvme_round_robin_path() and there is no
> path available. In this case the initialization ns = nvme_next_ns(head,
> old) could return a NULL pointer."old" should not be NULL, so there is at least one path that is "old".
It is impossible to return NULL for nvme_next_ns(head, old).
> .
> 
