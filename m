Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B642B1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhJMBLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 21:11:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14339 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbhJMBLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 21:11:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HTZ7S3KlJz905l;
        Wed, 13 Oct 2021 09:04:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 09:09:20 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 09:09:19 +0800
Message-ID: <a0106be4-2822-347f-dec6-7d43ce059e41@huawei.com>
Date:   Wed, 13 Oct 2021 09:09:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v4 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash with
 KASAN_VMALLOC
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <ryabinin.a.a@gmail.com>,
        <andreyknvl@gmail.com>, <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <kasan-dev@googlegroups.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <20210910053354.26721-4-wangkefeng.wang@huawei.com>
 <YWXRKFrGSkgLXNvt@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YWXRKFrGSkgLXNvt@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/13 2:17, Catalin Marinas wrote:
> On Fri, Sep 10, 2021 at 01:33:54PM +0800, Kefeng Wang wrote:
>> With KASAN_VMALLOC and NEED_PER_CPU_PAGE_FIRST_CHUNK, it crashs,
>>
>> Unable to handle kernel paging request at virtual address ffff7000028f2000
>> ...
>> swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000042440000
>> [ffff7000028f2000] pgd=000000063e7c0003, p4d=000000063e7c0003, pud=000000063e7c0003, pmd=000000063e7b0003, pte=0000000000000000
>> Internal error: Oops: 96000007 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc4-00003-gc6e6e28f3f30-dirty #62
>> Hardware name: linux,dummy-virt (DT)
>> pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
>> pc : kasan_check_range+0x90/0x1a0
>> lr : memcpy+0x88/0xf4
>> sp : ffff80001378fe20
>> ...
>> Call trace:
>>   kasan_check_range+0x90/0x1a0
>>   pcpu_page_first_chunk+0x3f0/0x568
>>   setup_per_cpu_areas+0xb8/0x184
>>   start_kernel+0x8c/0x328
>>
>> The vm area used in vm_area_register_early() has no kasan shadow memory,
>> Let's add a new kasan_populate_early_vm_area_shadow() function to populate
>> the vm area shadow memory to fix the issue.
>>
>> Acked-by: Marco Elver <elver@google.com> (for KASAN parts)
>> Acked-by: Andrey Konovalov <andreyknvl@gmail.com> (for KASAN parts)
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> It looks like I only acked patch 2 previously, so here it is:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Many thanks, Catalin :)

> .
> 
