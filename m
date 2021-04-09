Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F73599C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhDIJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:47:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16509 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDIJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:47:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGtX02Pv8zPpY6;
        Fri,  9 Apr 2021 17:44:48 +0800 (CST)
Received: from [10.174.178.48] (10.174.178.48) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:47:30 +0800
Subject: Re: [PATCH -next] [POWERPC] Rename get_property to of_get_property:
 use DEFINE_SPINLOCK() for spinlock
To:     Ye Bin <yebin10@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20210409095148.2294319-1-yebin10@huawei.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <4b0b16f3-bb06-3a90-5148-ea8302bb3a58@huawei.com>
Date:   Fri, 9 Apr 2021 17:47:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210409095148.2294319-1-yebin10@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.48]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename get_property to of_get_property: use DEFINE_SPINLOCK() for spinlock

~~~~~~~~~~~~~

这是啥模块名？


在 2021/4/9 17:51, Ye Bin 写道:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   drivers/macintosh/via-pmu-led.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
> index ae067ab2373d..2502119cff42 100644
> --- a/drivers/macintosh/via-pmu-led.c
> +++ b/drivers/macintosh/via-pmu-led.c
> @@ -27,7 +27,7 @@
>   #include <linux/pmu.h>
>   #include <asm/prom.h>
>   
> -static spinlock_t pmu_blink_lock;
> +static DEFINE_SPINLOCK(pmu_blink_lock);
>   static struct adb_request pmu_blink_req;
>   /* -1: no change, 0: request off, 1: request on */
>   static int requested_change;
> @@ -105,8 +105,6 @@ static int __init via_pmu_led_init(void)
>   		return -ENODEV;
>   	}
>   	of_node_put(dt);
> -
> -	spin_lock_init(&pmu_blink_lock);
>   	/* no outstanding req */
>   	pmu_blink_req.complete = 1;
>   	pmu_blink_req.done = pmu_req_done;
>
