Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC35306A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhA1Bds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:33:48 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2969 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhA1BcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:32:25 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DR2wB6nWYz5L7Y;
        Thu, 28 Jan 2021 09:30:18 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 09:31:32 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 28
 Jan 2021 09:31:31 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        "Jens Axboe" <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
Date:   Thu, 28 Jan 2021 09:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210127103033.15318-1-dwagner@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/27 18:30, Daniel Wagner wrote:
> nvme_round_robin_path() should test if the return ns pointer is
> valid. nvme_next_ns() will return a NULL pointer if there is no path
> left.
> 
> Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v2:
>    - moved NULL test into the if conditional statement
>    - added Fixes tag
> 
>   drivers/nvme/host/multipath.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9ac762b28811..282b7a4ea9a9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>   	}
>   
>   	for (ns = nvme_next_ns(head, old);
> -	     ns != old;
> +	     ns && ns != old;
nvme_round_robin_path just be called when !"old".
nvme_next_ns should not return NULL when !"old".
It seems unnecessary to add checking "ns".
Is there a bug that "old" in not in "head" list?
If yes, we should fix it.
>   	     ns = nvme_next_ns(head, ns)) {
>   		if (nvme_path_is_disabled(ns))
>   			continue;
> 
