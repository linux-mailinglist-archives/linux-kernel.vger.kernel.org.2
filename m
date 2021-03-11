Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB49336B00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 05:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCKENS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 23:13:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12708 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCKEM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 23:12:58 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DwwTr5RYRzmVmM;
        Thu, 11 Mar 2021 12:10:40 +0800 (CST)
Received: from [10.174.177.134] (10.174.177.134) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 11 Mar 2021 12:12:49 +0800
Subject: Re: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for
 arm64
To:     Muchun Song <songmuchun@bytedance.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>, <david@redhat.com>,
        <bodeddub@amazon.com>, <osalvador@suse.de>,
        <mike.kravetz@oracle.com>, <rientjes@google.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>, Chen Huang <chenhuang5@huawei.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
From:   Chen Huang <chenhuang5@huawei.com>
Message-ID: <3eae8b3e-d6e0-83c8-e9c6-5420767788d5@huawei.com>
Date:   Thu, 11 Mar 2021 12:12:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210310071535.35245-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/3/10 15:15, Muchun Song 写道:
> This patchset is based on the series of "Free some vmemmap pages of HugeTLB
> page". More details can refer to the below link.
> 
>   https://lkml.kernel.org/r/20210308102807.59745-1-songmuchun@bytedance.com
> 
> I often received some feedback (We want to test this feature on arm64) before.
> Because the previous code has been reviewed for 18 versions and is merged
> into mm tree, I think that it is time to release this patchset. If you want
> to test then you can start now :-). And I also hope someone can review this.
> 
> Thanks.
> 
> Muchun Song (3):
>   mm: bootmem_info: mark register_page_bootmem_info_section __init
>   mm: hugetlb: introduce arch_free_vmemmap_page
>   arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
> 
>  arch/arm64/mm/mmu.c   | 5 +++++
>  arch/x86/mm/init_64.c | 5 +++++
>  fs/Kconfig            | 4 ++--
>  mm/bootmem_info.c     | 4 ++--
>  mm/sparse-vmemmap.c   | 9 +++++++--
>  5 files changed, 21 insertions(+), 6 deletions(-)
> 

Tested-by: Chen Huang <chenhuang5@huawei.com>

I have tested the patch and the result is same as the last time.
