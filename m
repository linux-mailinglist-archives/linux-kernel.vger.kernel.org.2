Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2969394B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 11:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhE2JHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 05:07:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2461 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2JHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 05:07:24 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsbDY0Grlz66yk;
        Sat, 29 May 2021 17:02:53 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:05:39 +0800
Received: from [10.174.179.129] (10.174.179.129) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 29 May 2021 17:05:39 +0800
Subject: Re: [PATCH] agp: remove set but not used variable 'current_size'
To:     <airlied@linux.ie>
CC:     <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210514062210.3534108-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e44124e2-fc8b-e726-8bb2-d39095155d0d@huawei.com>
Date:   Sat, 29 May 2021 17:05:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210514062210.3534108-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.129]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2021/05/14 14:22, Yu Kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/char/agp/via-agp.c:131:28: warning: variable ‘current_size’
> set but not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/char/agp/via-agp.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
> index 87a92a044570..dc594f4eca38 100644
> --- a/drivers/char/agp/via-agp.c
> +++ b/drivers/char/agp/via-agp.c
> @@ -128,9 +128,6 @@ static int via_fetch_size_agp3(void)
>   static int via_configure_agp3(void)
>   {
>   	u32 temp;
> -	struct aper_size_info_16 *current_size;
> -
> -	current_size = A_SIZE_16(agp_bridge->current_size);
>   
>   	/* address to map to */
>   	agp_bridge->gart_bus_addr = pci_bus_address(agp_bridge->dev,
> 
