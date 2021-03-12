Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1733840F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhCLCwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:52:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13147 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhCLCwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:52:10 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DxVf52cytzmVjv;
        Fri, 12 Mar 2021 10:49:49 +0800 (CST)
Received: from [10.174.177.134] (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 10:52:01 +0800
Subject: Re: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for
 arm64
To:     "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "rientjes@google.com" <rientjes@google.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "Umesh Sargur, Gautam" <sargur@amazon.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
 <3eae8b3e-d6e0-83c8-e9c6-5420767788d5@huawei.com>
 <ED06294F-F046-4B21-9E52-F439C2B32B45@amazon.com>
 <aa3a5951-9dab-d1e1-8257-3569c269e3cf@huawei.com>
 <FE02DFEF-9706-4CEE-8949-89BD13C2AE00@amazon.com>
From:   Chen Huang <chenhuang5@huawei.com>
Message-ID: <ecd800e8-8ca8-a09b-d64a-efde36a0556d@huawei.com>
Date:   Fri, 12 Mar 2021 10:52:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <FE02DFEF-9706-4CEE-8949-89BD13C2AE00@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are you saying that the patch works well in x86, but doesn't in arm64? If so, my suggestion is that first you can check the dumpstack to check whether the function free_vmemmap_page has been called.
Then you can dump the page list of vmemmap_pages and the refcount of pages to verify the pages has been freed into the buddy system.

Hope this will help you!

在 2021/3/12 2:00, Bodeddula, Balasubramaniam 写道:
> Hey, thanks for the testing steps.
> 
> I tried applying these patches on 5.11 source tree. These patches were applied on top of the x86 patch, which worked fine. But in this case we don't see the same improvements in our testing. We made sure we set CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y in our .config file.
> 
> Are we missing any more configuration settings to get this patch to work on ARM? Can you please help with general troubleshooting steps to debug what could be going wrong.
> 
> ﻿On 11/03/21, 11:32 AM, "Chen Huang" <chenhuang5@huawei.com> wrote:
> 
>     CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
>     在 2021/3/11 13:00, Bodeddula, Balasubramaniam 写道:
>     > Chen, is your testing steps documented somewhere, can you please point us to the same. I followed some steps for testing the x86 patches, just wanted to make sure I am covering your tests as well. We are actively working on building and testing these patches for ARM.
>     >
>     > On 11/03/21, 9:44 AM, "Chen Huang" <chenhuang5@huawei.com> wrote:
>     >
>     >     CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>     >
>     >
>     >
>     >     在 2021/3/10 15:15, Muchun Song 写道:
>     >     > This patchset is based on the series of "Free some vmemmap pages of HugeTLB
>     >     > page". More details can refer to the below link.
>     >     >
>     >     >   https://lkml.kernel.org/r/20210308102807.59745-1-songmuchun@bytedance.com
>     >     >
>     >     > I often received some feedback (We want to test this feature on arm64) before.
>     >     > Because the previous code has been reviewed for 18 versions and is merged
>     >     > into mm tree, I think that it is time to release this patchset. If you want
>     >     > to test then you can start now :-). And I also hope someone can review this.
>     >     >
>     >     > Thanks.
>     >     >
>     >     > Muchun Song (3):
>     >     >   mm: bootmem_info: mark register_page_bootmem_info_section __init
>     >     >   mm: hugetlb: introduce arch_free_vmemmap_page
>     >     >   arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
>     >     >
>     >     >  arch/arm64/mm/mmu.c   | 5 +++++
>     >     >  arch/x86/mm/init_64.c | 5 +++++
>     >     >  fs/Kconfig            | 4 ++--
>     >     >  mm/bootmem_info.c     | 4 ++--
>     >     >  mm/sparse-vmemmap.c   | 9 +++++++--
>     >     >  5 files changed, 21 insertions(+), 6 deletions(-)
>     >     >
>     >
>     >     Tested-by: Chen Huang <chenhuang5@huawei.com>
>     >
>     >     I have tested the patch and the result is same as the last time.
>     >
> 
>     The test work is that: I set the total memory of 40G, and use 10G for hugepages.
>     First I reserve 10G hugepages from the command line and the result is that:
>     ------------------------------------------------------------------------------------------------
>                         2M page                    |                    1G page                    |
>     ----------------------|------------------------|----------------------|------------------------|
>            enable         |        disable         |      enable          |        disable         |
>     ----------------------|------------------------|----------------------|------------------------|
>     total  |  used | free | total  |  used | free  |total  |  used | free | total  |  used | free  |
>     39,697 | 10279 |29,415| 39580  | 10279 | 29,297‬|39,739 | 10279 |29,455| 39580  | 10279 | 29,296|
>     ------------------------------------------------------------------------------------------------
>     For 2M hugepage, we can save 118M memory which is correspoinding to the expected 120M memory.
>     For 1G hugepage, we can save 159M memory which is correspoinding to the expected 160M memory.
> 
>     Then I alloc 10G hugepages using "echo XX > /sys/kernel/mm/hugepages/hugepages-XXkB/nr_hugepages",
>     and get the result:
>     ------------------------------------------------------------------------------------------------
>                         2M page                    |                    1G page                    |
>     ----------------------|------------------------|----------------------|------------------------|
>            enable         |        disable         |      enable          |        disable         |
>     ----------------------|------------------------|----------------------|------------------------|
>     total  |  used | free | total  |  used | free  |total  |  used | free | total  |  used | free  |
>     39,699 | 10279 |29,415| 39580  | 10279 | 29,297‬‬|39,739 | 10279 |29,455| 39580  | 10279 | 29,296|
>     ------------------------------------------------------------------------------------------------
>     For 2M hugepage, we can save 118M memory which is correspoinding to the expected 120M memory.
>     For 1G hugepage, we can save 159M memory which is correspoinding to the expected 160M memory.
> 
