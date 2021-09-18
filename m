Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF2841028D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 03:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhIRBPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 21:15:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9744 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIRBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 21:15:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HBCVk4hsxzWK5b;
        Sat, 18 Sep 2021 09:13:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 18 Sep 2021 09:14:06 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 18 Sep 2021 09:14:06 +0800
Subject: Re: [PATCH v2 0/2] riscv: improve unaligned memory accesses
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Chen Huang <chenhuang5@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Darius Rad <darius@bluespec.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210916130855.4054926-1-chenhuang5@huawei.com>
 <20210917221429.4d3a15ca@xhacker>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <9200c4c2-44b9-480e-6970-5188640fb00a@huawei.com>
Date:   Sat, 18 Sep 2021 09:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210917221429.4d3a15ca@xhacker>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/17 22:14, Jisheng Zhang wrote:
> On Thu, 16 Sep 2021 13:08:53 +0000
> Chen Huang <chenhuang5@huawei.com> wrote:
>
>> The patchset improves RISCV unaligned memory accesses, selects
>> HAVE_EFFICIENT_UNALIGNED_ACCESS if CPU_HAS_NO_UNALIGNED not
>> enabled and supports DCACHE_WORD_ACCESS to improve the efficiency
>> of unaligned memory accesses.
>>
>> If CPU don't support unaligned memory accesses for now, please
>> select CONFIG_CPU_HAS_NO_UNALIGNED. For I don't know which CPU
>> don't support unaligned memory accesses, I don't choose the
>> CONFIG for them.
> This will break unified kernel Image for riscv. Obviously, we will have
> two images for efficient unaligned access platforms and non-efficient
> unaligned access platforms. IMHO, we may need alternative mechanism or
> something else to dynamically enable related code path.

it won't break unified kernel Image for riscv, if one SoC choose

CPU_HAS_NO_UNALIGNED, the single Image won't support unaligned memory

accesses, indeed, it depends on the CONFIG, and now, arm/powerpc/m68k has

similar configuration.

Yes,  it could be an optimization via alternative mechanism or something 
else to

dynamically enable related code path later.

>
> Regards
>
>> Changes since v1:
>>   - As Darius Rad and Jisheng Zhang mentioned, some CPUs don't support
>>     unaligned memory accesses, add an option for CPUs to choose it or not.
>>
>> Chen Huang (2):
>>    riscv: support HAVE_EFFICIENT_UNALIGNED_ACCESS
>>    riscv: Support DCACHE_WORD_ACCESS
>>
>>   arch/riscv/Kconfig                      |  5 ++++
>>   arch/riscv/include/asm/word-at-a-time.h | 37 +++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>
>
> .
>
