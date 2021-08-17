Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6153EEBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhHQL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:57:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8433 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbhHQL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:57:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GpqCP13p1z86qZ;
        Tue, 17 Aug 2021 19:52:33 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 19:56:35 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 17 Aug 2021 19:56:34 +0800
Subject: Re: [PATCH linux-next] module: remove duplicate include in
 interrupt.c
To:     <cgel.zte@gmail.com>
CC:     <linux@armlinux.org.uk>, <yang.guang5@zte.com.cn>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Lv Ruyi" <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210816112917.126675-1-lv.ruyi@zte.com.cn>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c01bbfdc-c586-93b7-a282-b859f2ebdb89@huawei.com>
Date:   Tue, 17 Aug 2021 19:56:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210816112917.126675-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/16 19:29, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> 'asm/interrupt.h' included in 'interrupt.c' is duplicated.

Sorry but this obviously doesn't match with the change you've made.

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  arch/arm/mach-sa1100/hackkit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> index 3085f1c2e586..3fe34ee7c0ab 100644
> --- a/arch/arm/mach-sa1100/hackkit.c
> +++ b/arch/arm/mach-sa1100/hackkit.c
> @@ -18,7 +18,6 @@
>  #include <linux/serial_core.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/tty.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> 
