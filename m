Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390C44A46F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbhKICKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:10:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14730 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbhKICJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:09:56 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HpBBc4xfnzVfsf;
        Tue,  9 Nov 2021 10:04:56 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 9 Nov 2021 10:07:08 +0800
Subject: Re: [PATCH] fsl_hypervisor: Add missing of_node_put in
 fsl_hypervisor_init
From:   He Ying <heying24@huawei.com>
To:     <galak@kernel.crashing.org>, <timur@freescale.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
References: <20211029032002.97355-1-heying24@huawei.com>
Message-ID: <18de7555-0d77-77ae-f357-dea07c73d771@huawei.com>
Date:   Tue, 9 Nov 2021 10:07:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211029032002.97355-1-heying24@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping...

ÔÚ 2021/10/29 11:20, He Ying Ð´µÀ:
> Early exits from for_each_compatible_node() should decrement the
> node reference counter.
>
> Signed-off-by: He Ying <heying24@huawei.com>
> Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor management driver")
> ---
>   drivers/virt/fsl_hypervisor.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> index 46ee0a0998b6..ef5fcca4b8f0 100644
> --- a/drivers/virt/fsl_hypervisor.c
> +++ b/drivers/virt/fsl_hypervisor.c
> @@ -849,8 +849,10 @@ static int __init fsl_hypervisor_init(void)
>   		}
>   
>   		dbisr = kzalloc(sizeof(*dbisr), GFP_KERNEL);
> -		if (!dbisr)
> +		if (!dbisr) {
> +			of_node_put(np);
>   			goto out_of_memory;
> +		}
>   
>   		dbisr->irq = irq;
>   		dbisr->doorbell = be32_to_cpup(handle);
