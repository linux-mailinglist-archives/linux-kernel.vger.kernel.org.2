Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBF40C1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhIOIed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:34:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9046 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhIOIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8YNp1lWzzW1dR;
        Wed, 15 Sep 2021 16:32:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:33:10 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:33:10 +0800
Subject: Re: [PATCH v4 0/3] arm64: support page mapping percpu first chunk
 allocator
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>
CC:     <kasan-dev@googlegroups.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <c06faf6c-3d21-04f2-6855-95c86e96cf5a@huawei.com>
Date:   Wed, 15 Sep 2021 16:33:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Andrew， as Catalin saids，the series touches drivers/ and mm/ 
but missing

acks from both of you，could you take a look of this patchset(patch1 
change mm/vmalloc.c

and patch2 changes drivers/base/arch_numa.c).

And Catalin, is there any other comments? I hope this could be merged 
into next version,

Many thanks all of you.

On 2021/9/10 13:33, Kefeng Wang wrote:
> Percpu embedded first chunk allocator is the firstly option, but it
> could fails on ARM64, eg,
>    "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
>    "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
>    "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"
>
> then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
> even the system could not boot successfully.
>
> Let's implement page mapping percpu first chunk allocator as a fallback
> to the embedding allocator to increase the robustness of the system.
>
> Also fix a crash when both NEED_PER_CPU_PAGE_FIRST_CHUNK and KASAN_VMALLOC enabled.
>
> Tested on ARM64 qemu with cmdline "percpu_alloc=page" based on v5.14.
>
> V4:
> - add ACK/RB
> - address comments about patch1 from Catalin
> - add Greg and Andrew into list suggested by Catalin
>
> v3:
> - search for a range that fits instead of always picking the end from
>    vmalloc area suggested by Catalin.
> - use NUMA_NO_NODE to avoid "virt_to_phys used for non-linear address:"
>    issue in arm64 kasan_populate_early_vm_area_shadow().
> - add Acked-by: Marco Elver <elver@google.com> to patch v3
>
> V2:
> - fix build error when CONFIG_KASAN disabled, found by lkp@intel.com
> - drop wrong __weak comment from kasan_populate_early_vm_area_shadow(),
>    found by Marco Elver <elver@google.com>
>
> Kefeng Wang (3):
>    vmalloc: Choose a better start address in vm_area_register_early()
>    arm64: Support page mapping percpu first chunk allocator
>    kasan: arm64: Fix pcpu_page_first_chunk crash with KASAN_VMALLOC
>
>   arch/arm64/Kconfig         |  4 ++
>   arch/arm64/mm/kasan_init.c | 16 ++++++++
>   drivers/base/arch_numa.c   | 82 +++++++++++++++++++++++++++++++++-----
>   include/linux/kasan.h      |  6 +++
>   mm/kasan/init.c            |  5 +++
>   mm/vmalloc.c               | 19 ++++++---
>   6 files changed, 116 insertions(+), 16 deletions(-)
>
