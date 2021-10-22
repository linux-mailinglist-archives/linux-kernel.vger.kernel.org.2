Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A97437087
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhJVDkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:40:49 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26179 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhJVDkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:40:47 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Hb95M62FWz8tpl;
        Fri, 22 Oct 2021 11:37:11 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 22 Oct 2021 11:38:27 +0800
Subject: Re: [PATCH lkdtm] lkdtm: Fix reference preceded by free
To:     <davidcomponentone@gmail.com>, <keescook@chromium.org>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211022012832.10644-1-yang.guang5@zte.com.cn>
From:   He Ying <heying24@huawei.com>
Message-ID: <6eaee800-a88d-6810-ef0e-724e7e846e80@huawei.com>
Date:   Fri, 22 Oct 2021 11:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211022012832.10644-1-yang.guang5@zte.com.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/22 9:28, davidcomponentone@gmail.com Ð´µÀ:
> From: Yang Guang <yang.guang5@zte.com.cn>
>
> The coccinelle check report:
> ./drivers/misc/lkdtm/heap.c:115:7-11:
> ERROR: reference preceded by free on line 112
> Moving the "kfree(base)" after using place to fix it.

Look at the name of the function "lkdtm_READ_AFTER_FREE". It's meant to

use after free to test something.

>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>   drivers/misc/lkdtm/heap.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> index 8a92f5a800fa..4c6341e7bdca 100644
> --- a/drivers/misc/lkdtm/heap.c
> +++ b/drivers/misc/lkdtm/heap.c
> @@ -109,8 +109,6 @@ void lkdtm_READ_AFTER_FREE(void)
>   	base[offset] = *val;
>   	pr_info("Value in memory before free: %x\n", base[offset]);
>   
> -	kfree(base);
> -
>   	pr_info("Attempting bad read from freed memory\n");
>   	saw = base[offset];
>   	if (saw != *val) {
> @@ -121,6 +119,7 @@ void lkdtm_READ_AFTER_FREE(void)
>   		pr_expected_config_param(CONFIG_INIT_ON_FREE_DEFAULT_ON, "init_on_free");
>   	}
>   
> +	kfree(base);
>   	kfree(val);
>   }
>   
