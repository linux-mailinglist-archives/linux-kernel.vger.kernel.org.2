Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489D44A470
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbhKICKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:10:32 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14731 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbhKICKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:10:31 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HpBCJ0nLxzZcwr;
        Tue,  9 Nov 2021 10:05:32 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 9 Nov 2021 10:07:44 +0800
Subject: Re: [PATCH] powerpc/embedded6xx/hlwd-pic: Add missing of_node_put in
 hlwd_pic_probe
From:   He Ying <heying24@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <maz@kernel.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20211103014833.163615-1-heying24@huawei.com>
Message-ID: <21d5814e-cd51-ab24-f673-b2da5e784ce8@huawei.com>
Date:   Tue, 9 Nov 2021 10:07:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211103014833.163615-1-heying24@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping...

ÔÚ 2021/11/3 9:48, He Ying Ð´µÀ:
> Early exits from for_each_compatible_node() should decrease the
> node reference count.
>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>   arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> index 15396333a90b..a4b020e4b6af 100644
> --- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> +++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> @@ -214,6 +214,7 @@ void hlwd_pic_probe(void)
>   			irq_set_chained_handler(cascade_virq,
>   						hlwd_pic_irq_cascade);
>   			hlwd_irq_host = host;
> +			of_node_put(np);
>   			break;
>   		}
>   	}
