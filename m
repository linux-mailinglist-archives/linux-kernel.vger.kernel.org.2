Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72C3AC0E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFRCol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhFRCol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:44:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EF0960FF1;
        Fri, 18 Jun 2021 02:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623984152;
        bh=hafJ5IUDjp1Ik3inNtiETMdZsJZ7nTkQNqoNrUpELBM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TNXxY56Yrp5vbVIXvyG3STK2+clis1qM3yMCz43aOElg0WvKh4wAk0OCiTuB1Nvuz
         Qz3LfMkUxMKqClbXQZ0jkhFTCb1B0Z7VbkgIHeWpg96ma/AaTHnrHX4+WbXWeCCdoC
         s9PYWPvMCGse1zAfRcgqFBawkyShBvEAz8Kjao0cMr9209hFDB3d3Svsgr8hrHULQ4
         ChvbLrTlo3UuNtWRWsLYvoYwNtQH+5i9/pAwiBknpfL1bMPVa4Tn2UWoaa5R/iut3u
         tQJjo6wrc2kr42PP+QlCr3zVISm+BIBybGvGCu2zr5H2u30U+Gt7v7jvcdESE5qDTM
         ItvZk4WYoFQ9Q==
Subject: Re: [PATCH v2 2/2] mm/zbud: don't export any zbud API
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, sjenning@redhat.com, ddstreet@ieee.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210608114515.206992-1-linmiaohe@huawei.com>
 <20210608114515.206992-3-linmiaohe@huawei.com>
 <YMvsYm8b+yTIrqBC@archlinux-ax161>
 <813ac556-4a48-1e29-ad87-1ddb74546ef1@huawei.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <621684b8-7aac-97e5-198e-e62061c79301@kernel.org>
Date:   Thu, 17 Jun 2021 19:42:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <813ac556-4a48-1e29-ad87-1ddb74546ef1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/2021 7:28 PM, Miaohe Lin wrote:
> Hi:
> On 2021/6/18 8:44, Nathan Chancellor wrote:
>> On Tue, Jun 08, 2021 at 07:45:15PM +0800, Miaohe Lin wrote:
>>> The zbud doesn't need to export any API and it is meant to be used via
>>> zpool API since the commit 12d79d64bfd3 ("mm/zpool: update zswap to use
>>> zpool"). So we can remove the unneeded zbud.h and move down zpool API
>>> to avoid any forward declaration.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>
> 
> Thank you for help figure these warnings out. It seems zbud module won't do
> anything when CONFIG_ZPOOL is disabled. I think we should make zbud depends
> on ZPOOL and eliminate the CONFIG_ZPOOL macro in zbud.c like what z3fold does.
> Does this make sense for you?
> Thanks again. :)

That seems logical to me. It probably makes sense to send that as a fix 
patch for this one so Andrew can squash it in.

Cheers,
Nathan

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 8f748010f7ea..5dc28e9205e0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -674,6 +674,7 @@ config ZPOOL
> 
>   config ZBUD
>          tristate "Low (Up to 2x) density storage for compressed pages"
> +       depends on ZPOOL
>          help
>            A special purpose allocator for storing compressed pages.
>            It is designed to store up to two compressed pages per physical
> diff --git a/mm/zbud.c b/mm/zbud.c
> index 3f61304405cb..6348932430b8 100644
> --- a/mm/zbud.c
> +++ b/mm/zbud.c
> @@ -111,10 +111,8 @@ struct zbud_pool {
>          struct list_head lru;
>          u64 pages_nr;
>          const struct zbud_ops *ops;
> -#ifdef CONFIG_ZPOOL
>          struct zpool *zpool;
>          const struct zpool_ops *zpool_ops;
> -#endif
>   };
> 
>   /*
> @@ -526,8 +524,6 @@ static u64 zbud_get_pool_size(struct zbud_pool *pool)
>    * zpool
>    ****************/
> 
> -#ifdef CONFIG_ZPOOL
> -
>   static int zbud_zpool_evict(struct zbud_pool *pool, unsigned long handle)
>   {
>          if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
> @@ -618,7 +614,6 @@ static struct zpool_driver zbud_zpool_driver = {
>   };
> 
>   MODULE_ALIAS("zpool-zbud");
> -#endif /* CONFIG_ZPOOL */
> 
>   static int __init init_zbud(void)
>   {
> @@ -626,19 +621,14 @@ static int __init init_zbud(void)
>          BUILD_BUG_ON(sizeof(struct zbud_header) > ZHDR_SIZE_ALIGNED);
>          pr_info("loaded\n");
> 
> -#ifdef CONFIG_ZPOOL
>          zpool_register_driver(&zbud_zpool_driver);
> -#endif
> 
>          return 0;
>   }
> 
>   static void __exit exit_zbud(void)
>   {
> -#ifdef CONFIG_ZPOOL
>          zpool_unregister_driver(&zbud_zpool_driver);
> -#endif
> -
>          pr_info("unloaded\n");
>   }
> 
>> This patch causes several new warnings when CONFIG_ZPOOL is disabled:
>>
>> mm/zbud.c:222:26: warning: unused function 'zbud_create_pool' [-Wunused-function]
>> mm/zbud.c:246:13: warning: unused function 'zbud_destroy_pool' [-Wunused-function]
>> mm/zbud.c:270:12: warning: unused function 'zbud_alloc' [-Wunused-function]
>> mm/zbud.c:345:13: warning: unused function 'zbud_free' [-Wunused-function]
>> mm/zbud.c:417:12: warning: unused function 'zbud_reclaim_page' [-Wunused-function]
>> mm/zbud.c:499:14: warning: unused function 'zbud_map' [-Wunused-function]
>> mm/zbud.c:509:13: warning: unused function 'zbud_unmap' [-Wunused-function]
>> mm/zbud.c:520:12: warning: unused function 'zbud_get_pool_size' [-Wunused-function]
>>
>> It seems to me like all of these functions should be sunk into their
>> callers and eliminated entirely as part of this refactoring. I took a
>> whack at it but got lost with the kernel docs so someone who is familiar
>> with this should probably do it.
>>
>> Cheers,
>> Nathan
>> .
>>
> 

