Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9D428471
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 03:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJKBLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 21:11:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28908 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhJKBLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 21:11:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSLDz4x22zbn2h;
        Mon, 11 Oct 2021 09:05:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 09:09:30 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 09:09:30 +0800
Message-ID: <6d78633c-8e74-1d84-5f02-90fc56c1a11b@huawei.com>
Date:   Mon, 11 Oct 2021 09:09:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v4 0/3] arm64: support page mapping percpu first chunk
 allocator
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <gregkh@linuxfoundation.org>,
        <kasan-dev@googlegroups.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <20211010143622.18f491df5591d039cda8f7b7@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20211010143622.18f491df5591d039cda8f7b7@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/11 5:36, Andrew Morton wrote:
> On Fri, 10 Sep 2021 13:33:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> Percpu embedded first chunk allocator is the firstly option, but it
>> could fails on ARM64, eg,
>>    "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
>>    "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
>>    "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"
>>
>> then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
>> even the system could not boot successfully.
>>
>> Let's implement page mapping percpu first chunk allocator as a fallback
>> to the embedding allocator to increase the robustness of the system.
>>
>> Also fix a crash when both NEED_PER_CPU_PAGE_FIRST_CHUNK and KASAN_VMALLOC enabled.
> 
> How serious are these problems in real-world situations?  Do people
> feel that a -stable backport is needed, or is a 5.16-rc1 merge
> sufficient?
> .
Thanks Andrew.

A specific memory layout is required(also with KASAN enabled), we met 
this issue at qemu and real hardware, due to KASAN enabled, so I think
5.16-rc1 is sufficient.



