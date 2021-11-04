Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50C445331
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhKDMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:41:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15361 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:41:27 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HlNTx19h5z90XJ;
        Thu,  4 Nov 2021 20:38:29 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 20:38:39 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 20:38:38 +0800
Message-ID: <a8f58b35-5fc5-110a-53b5-a08b1e8aee19@huawei.com>
Date:   Thu, 4 Nov 2021 20:38:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/3] ARM: Support KFENCE feature
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
 <YYPOObm72VH2l/AT@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YYPOObm72VH2l/AT@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/4 20:12, Russell King (Oracle) wrote:
> The ARM tree is closed; we're in the mainline merge window. Please
> resend after -rc1 is released.

Got it, will do.

> 
> On Wed, Nov 03, 2021 at 09:38:42PM +0800, Kefeng Wang wrote:
>> This patchset supports Kfence feature, tested the kfence_test on ARM QEMU
>> with or without ARM_LPAE and all passed.
>>
>> V2:
>> - drop patch4 in v1, which is used a new way to skip kfence test
>>    see commit c40c6e593bf9 ("kfence: test: fail fast if disabled at boot")
>> - fix some issue about NO MMU
>>    - drop useless set_memory_valid() under no mmu
>>    - fix implicit declaration of function ‘is_write_fault’ if no mmu
>> - make KFENCE depends on !XIP_KERNEL, no tested with xip
>>
>> v1:
>> https://lore.kernel.org/linux-arm-kernel/20210825092116.149975-1-wangkefeng.wang@huawei.com/
>>
>> Kefeng Wang (3):
>>    ARM: mm: Provide set_memory_valid()
>>    ARM: mm: Provide is_write_fault()
>>    ARM: Support KFENCE for ARM
>>
>>   arch/arm/Kconfig                  |  1 +
>>   arch/arm/include/asm/kfence.h     | 53 +++++++++++++++++++++++++++++++
>>   arch/arm/include/asm/set_memory.h |  1 +
>>   arch/arm/mm/fault.c               | 16 ++++++++--
>>   arch/arm/mm/pageattr.c            | 42 ++++++++++++++++++------
>>   5 files changed, 100 insertions(+), 13 deletions(-)
>>   create mode 100644 arch/arm/include/asm/kfence.h
>>
>> -- 
>> 2.26.2
>>
>>
> 
