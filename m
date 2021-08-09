Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529613E46B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhHINfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:35:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13256 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhHINfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:35:22 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gjxs204Ybz1CTxx;
        Mon,  9 Aug 2021 21:34:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 21:34:58 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 21:34:57 +0800
Subject: Re: [PATCH v3 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash with
 KASAN_VMALLOC
To:     Marco Elver <elver@google.com>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
 <20210809093750.131091-4-wangkefeng.wang@huawei.com>
 <ae15c02e-d825-dbef-1419-5b5220f826c1@huawei.com>
 <CANpmjNOM-fzk2_q9LNLgM1wSReHWj42MxHBeDBLg8Ga5vv8HhQ@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <03828e22-9869-7c57-3ad0-f266a435e427@huawei.com>
Date:   Mon, 9 Aug 2021 21:34:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNOM-fzk2_q9LNLgM1wSReHWj42MxHBeDBLg8Ga5vv8HhQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/9 19:21, Marco Elver wrote:
> On Mon, 9 Aug 2021 at 13:10, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> On 2021/8/9 17:37, Kefeng Wang wrote:
>>> With KASAN_VMALLOC and NEED_PER_CPU_PAGE_FIRST_CHUNK, it crashs,
>>>
>>> Unable to handle kernel paging request at virtual address ffff7000028f2000
>>> ...
>>> swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000042440000
>>> [ffff7000028f2000] pgd=000000063e7c0003, p4d=000000063e7c0003, pud=000000063e7c0003, pmd=000000063e7b0003, pte=0000000000000000
>>> Internal error: Oops: 96000007 [#1] PREEMPT SMP
>>> Modules linked in:
>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc4-00003-gc6e6e28f3f30-dirty #62
>>> Hardware name: linux,dummy-virt (DT)
>>> pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
>>> pc : kasan_check_range+0x90/0x1a0
>>> lr : memcpy+0x88/0xf4
>>> sp : ffff80001378fe20
>>> ...
>>> Call trace:
>>>    kasan_check_range+0x90/0x1a0
>>>    pcpu_page_first_chunk+0x3f0/0x568
>>>    setup_per_cpu_areas+0xb8/0x184
>>>    start_kernel+0x8c/0x328
>>>
>>> The vm area used in vm_area_register_early() has no kasan shadow memory,
>>> Let's add a new kasan_populate_early_vm_area_shadow() function to populate
>>> the vm area shadow memory to fix the issue.
>> Should add Acked-by: Marco Elver <elver@google.com> [for KASAN parts] ,
> My Ack is still valid, thanks for noting.
Thanks,  Marco ;)
