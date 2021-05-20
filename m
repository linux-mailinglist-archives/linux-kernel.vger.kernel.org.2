Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FB389D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhETGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:22:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4693 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETGWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:22:52 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm01H2PXbz16Q01;
        Thu, 20 May 2021 14:18:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 14:21:29 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 14:21:29 +0800
Subject: Re: [PATCH v2 0/3] memblock, arm: fixes for freeing of the memory map
To:     Mike Rapoport <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210519141436.11961-1-rppt@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <fd5846e4-4c75-6de9-6bc1-7e993f4685b4@huawei.com>
Date:   Thu, 20 May 2021 14:21:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210519141436.11961-1-rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/19 22:14, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> The coordination between freeing of unused memory map, pfn_valid() and core
> mm assumptions about validity of the memory map in various ranges was not
> designed for complex layouts of the physical memory with a lot of holes all
> over the place.
> 
> Kefen Wang reported crashes in move_freepages() on a system with the
> following memory layout:
> 
>    node   0: [mem 0x0000000080a00000-0x00000000855fffff]
>    node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
>    node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
>    node   0: [mem 0x000000008e300000-0x000000008ecfffff]
>    node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
>    node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
>    node   0: [mem 0x00000000de700000-0x00000000de9fffff]
>    node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
>    node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
>    node   0: [mem 0x00000000fda00000-0x00000000ffffefff]
> 
> The crashes can be mitigated by enabling CONFIG_HOLES_IN_ZONE and
> essentially turning pfn_valid_within() to pfn_valid() instead of having it
> hardwired to 1.
> 
> Alternatively, we can update ARM's implementation of pfn_valid() to take
> into accounting rounding of the freed memory map to pageblock boundaries
> and make sure it returns true for PFNs that have memory map entries even if
> there is no physical memory.
> 
> I can take the entire series via memblock tree.
> 
> @Kefen, I didn't add your Tested-by yet because the patch is slightly
> different from the version you've tested.

Backport this version(also with link[2]) and oom test could pass too.

> 
> v2:
> * Use single memblock_overlaps_region() instead of several
> memblock_is_map_memory() lookups. This makes this series depend on update
> of MEMBLOCK_NOMAP handling in the memory map [2]
> 
> v1: Link: https://lore.kernel.org/lkml/20210518090613.21519-1-rppt@kernel.org
> 
> [1] https://lore.kernel.org/lkml/2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com
> [2] https://lore.kernel.org/lkml/20210511100550.28178-1-rppt@kernel.org
> 
> Mike Rapoport (3):
>    memblock: free_unused_memmap: use pageblock units instead of MAX_ORDER
>    memblock: align freed memory map on pageblock boundaries with SPARSEMEM
>    arm: extend pfn_valid to take into accound freed memory map alignment
> 
>   arch/arm/mm/init.c | 13 ++++++++++++-
>   mm/memblock.c      | 23 ++++++++++++-----------
>   2 files changed, 24 insertions(+), 12 deletions(-)
> 
> 
> base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
> 
