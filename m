Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF56350D36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhDADjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:39:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15129 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhDADil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:38:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9pkp2MK8z19K4Y;
        Thu,  1 Apr 2021 11:36:34 +0800 (CST)
Received: from [10.67.100.236] (10.67.100.236) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 11:38:30 +0800
Subject: Re: [PATCH -next] i2c: gpio: use DEFINE_SPINLOCK() for spinlock
To:     Russell King <linux@armlinux.org.uk>
CC:     <heying24@huawei.com>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, <johnny.chenyi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20210327095228.105123-1-chenlifu@huawei.com>
From:   chenlifu <chenlifu@huawei.com>
Message-ID: <fec9295e-c5d6-13ee-23f5-13b593d2fd2e@huawei.com>
Date:   Thu, 1 Apr 2021 11:38:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210327095228.105123-1-chenlifu@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.100.236]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly pinging ...

Best Regards,
Chen Lifu

ÔÚ 2021/3/27 17:52, Chen Lifu Ð´µÀ:
> From: Lifu Chen <chenlifu@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Lifu Chen <chenlifu@huawei.com>
> ---
>   arch/arm/mach-sa1100/simpad.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index c7fb9a73e4c5..c183432880d3 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -45,7 +45,7 @@
>    */
>   
>   static long cs3_shadow;
> -static spinlock_t cs3_lock;
> +static DEFINE_SPINLOCK(cs3_lock);
>   static struct gpio_chip cs3_gpio;
>   
>   long simpad_get_cs3_ro(void)
> @@ -379,8 +379,6 @@ static int __init simpad_init(void)
>   {
>   	int ret;
>   
> -	spin_lock_init(&cs3_lock);
> -
>   	cs3_gpio.label = "simpad_cs3";
>   	cs3_gpio.base = SIMPAD_CS3_GPIO_BASE;
>   	cs3_gpio.ngpio = 24;
> 
> .
> 
