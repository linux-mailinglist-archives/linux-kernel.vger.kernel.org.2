Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46F13BF9E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGHMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:17:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6446 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhGHMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:17:11 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GLFW62Z6Kz798P;
        Thu,  8 Jul 2021 20:10:58 +0800 (CST)
Received: from [10.174.177.209] (10.174.177.209) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 8 Jul 2021 20:14:26 +0800
Subject: Re: [PATCH v2] mm/zsmalloc.c: close race window between
 zs_pool_dec_isolated() and zs_unregister_migration()
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <ngupta@vflare.org>
CC:     <senozhatsky@chromium.org>, <henryburns@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210708115117.12359-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7a16cf45-eaed-e7ba-bf47-2382b2c542f2@huawei.com>
Date:   Thu, 8 Jul 2021 20:14:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210708115117.12359-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.209]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the disturbs! Please ignore this duplicated one...

On 2021/7/8 19:51, Miaohe Lin wrote:
> There has one possible race window between zs_pool_dec_isolated() and
> zs_unregister_migration() because wait_for_isolated_drain() checks the
> isolated count without holding class->lock and there is no order inside
> zs_pool_dec_isolated(). Thus the below race window could be possible:
> 
> zs_pool_dec_isolated		zs_unregister_migration
>   check pool->destroying != 0
> 				  pool->destroying = true;
> 				  smp_mb();
> 				  wait_for_isolated_drain()
> 				    wait for pool->isolated_pages == 0
>   atomic_long_dec(&pool->isolated_pages);
>   atomic_long_read(&pool->isolated_pages) == 0
> 
> Since we observe the pool->destroying (false) before atomic_long_dec()
> for pool->isolated_pages, waking pool->migration_wait up is missed.
> 
> Fix this by ensure checking pool->destroying is happened after the
> atomic_long_dec(&pool->isolated_pages).
> 
> Fixes: 701d678599d0 ("mm/zsmalloc.c: fix race condition in zs_destroy_pool")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v1->v2:
>   Fix potential race window rather than simply combine atomic_long_dec
> and atomic_long_read.
> 
> Hi Andrew,
>   This patch is the version 2 of
> mm-zsmallocc-combine-two-atomic-ops-in-zs_pool_dec_isolated.patch.
> Many thanks.
> ---
>  mm/zsmalloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 5f3df680f0a2..0fc388a0202d 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1830,10 +1830,11 @@ static inline void zs_pool_dec_isolated(struct zs_pool *pool)
>  	VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
>  	atomic_long_dec(&pool->isolated_pages);
>  	/*
> -	 * There's no possibility of racing, since wait_for_isolated_drain()
> -	 * checks the isolated count under &class->lock after enqueuing
> -	 * on migration_wait.
> +	 * Checking pool->destroying must happen after atomic_long_dec()
> +	 * for pool->isolated_pages above. Paired with the smp_mb() in
> +	 * zs_unregister_migration().
>  	 */
> +	smp_mb__after_atomic();
>  	if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
>  		wake_up_all(&pool->migration_wait);
>  }
> 

