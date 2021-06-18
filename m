Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E43AC10E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFRCy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:54:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11060 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhFRCy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:54:56 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5k0s1c6lzZdGs;
        Fri, 18 Jun 2021 10:49:49 +0800 (CST)
Received: from [10.174.176.146] (10.174.176.146) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 10:52:45 +0800
Subject: Re: [PATCH v2 2/2] mm/zbud: don't export any zbud API
To:     Nathan Chancellor <nathan@kernel.org>
CC:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210608114515.206992-1-linmiaohe@huawei.com>
 <20210608114515.206992-3-linmiaohe@huawei.com>
 <YMvsYm8b+yTIrqBC@archlinux-ax161>
 <813ac556-4a48-1e29-ad87-1ddb74546ef1@huawei.com>
 <621684b8-7aac-97e5-198e-e62061c79301@kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ce708f00-750c-8d31-8c16-c54da7384349@huawei.com>
Date:   Fri, 18 Jun 2021 10:52:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <621684b8-7aac-97e5-198e-e62061c79301@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.146]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 10:42, Nathan Chancellor wrote:
> On 6/17/2021 7:28 PM, Miaohe Lin wrote:
>> Hi:
>> On 2021/6/18 8:44, Nathan Chancellor wrote:
>>> On Tue, Jun 08, 2021 at 07:45:15PM +0800, Miaohe Lin wrote:
>>>> The zbud doesn't need to export any API and it is meant to be used via
>>>> zpool API since the commit 12d79d64bfd3 ("mm/zpool: update zswap to use
>>>> zpool"). So we can remove the unneeded zbud.h and move down zpool API
>>>> to avoid any forward declaration.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>
>> Thank you for help figure these warnings out. It seems zbud module won't do
>> anything when CONFIG_ZPOOL is disabled. I think we should make zbud depends
>> on ZPOOL and eliminate the CONFIG_ZPOOL macro in zbud.c like what z3fold does.
>> Does this make sense for you?
>> Thanks again. :)
> 
> That seems logical to me. It probably makes sense to send that as a fix patch for this one so Andrew can squash it in.

Sure. This is also what I meant to do. Will do it later.
Many thanks!

> 
> Cheers,
> Nathan
> 
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 8f748010f7ea..5dc28e9205e0 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -674,6 +674,7 @@ config ZPOOL
>>
>>   config ZBUD
>>          tristate "Low (Up to 2x) density storage for compressed pages"
>> +       depends on ZPOOL
>>          help
>>            A special purpose allocator for storing compressed pages.
>>            It is designed to store up to two compressed pages per physical
>> diff --git a/mm/zbud.c b/mm/zbud.c
>> index 3f61304405cb..6348932430b8 100644
>> --- a/mm/zbud.c
>> +++ b/mm/zbud.c
>> @@ -111,10 +111,8 @@ struct zbud_pool {
>>          struct list_head lru;
>>          u64 pages_nr;
>>          const struct zbud_ops *ops;
>> -#ifdef CONFIG_ZPOOL
>>          struct zpool *zpool;
>>          const struct zpool_ops *zpool_ops;
>> -#endif
>>   };
>>
>>   /*
>> @@ -526,8 +524,6 @@ static u64 zbud_get_pool_size(struct zbud_pool *pool)
>>    * zpool
>>    ****************/
>>
>> -#ifdef CONFIG_ZPOOL
>> -
>>   static int zbud_zpool_evict(struct zbud_pool *pool, unsigned long handle)
>>   {
>>          if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
>> @@ -618,7 +614,6 @@ static struct zpool_driver zbud_zpool_driver = {
>>   };
>>
>>   MODULE_ALIAS("zpool-zbud");
>> -#endif /* CONFIG_ZPOOL */
>>
>>   static int __init init_zbud(void)
>>   {
>> @@ -626,19 +621,14 @@ static int __init init_zbud(void)
>>          BUILD_BUG_ON(sizeof(struct zbud_header) > ZHDR_SIZE_ALIGNED);
>>          pr_info("loaded\n");
>>
>> -#ifdef CONFIG_ZPOOL
>>          zpool_register_driver(&zbud_zpool_driver);
>> -#endif
>>
>>          return 0;
>>   }
>>
>>   static void __exit exit_zbud(void)
>>   {
>> -#ifdef CONFIG_ZPOOL
>>          zpool_unregister_driver(&zbud_zpool_driver);
>> -#endif
>> -
>>          pr_info("unloaded\n");
>>   }
>>
>>> This patch causes several new warnings when CONFIG_ZPOOL is disabled:
>>>
>>> mm/zbud.c:222:26: warning: unused function 'zbud_create_pool' [-Wunused-function]
>>> mm/zbud.c:246:13: warning: unused function 'zbud_destroy_pool' [-Wunused-function]
>>> mm/zbud.c:270:12: warning: unused function 'zbud_alloc' [-Wunused-function]
>>> mm/zbud.c:345:13: warning: unused function 'zbud_free' [-Wunused-function]
>>> mm/zbud.c:417:12: warning: unused function 'zbud_reclaim_page' [-Wunused-function]
>>> mm/zbud.c:499:14: warning: unused function 'zbud_map' [-Wunused-function]
>>> mm/zbud.c:509:13: warning: unused function 'zbud_unmap' [-Wunused-function]
>>> mm/zbud.c:520:12: warning: unused function 'zbud_get_pool_size' [-Wunused-function]
>>>
>>> It seems to me like all of these functions should be sunk into their
>>> callers and eliminated entirely as part of this refactoring. I took a
>>> whack at it but got lost with the kernel docs so someone who is familiar
>>> with this should probably do it.
>>>
>>> Cheers,
>>> Nathan
>>> .
>>>
>>
> 
> .

