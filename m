Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5894444F92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 08:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhKDHUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 03:20:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:27111 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKDHUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 03:20:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HlFK35Lp4z1DJ7P;
        Thu,  4 Nov 2021 15:15:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 15:17:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 15:17:25 +0800
Message-ID: <ce1e6f73-a7b5-84a7-243f-8cbf9bd3f70b@huawei.com>
Date:   Thu, 4 Nov 2021 15:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/3] ARM: Support KFENCE feature
Content-Language: en-US
To:     Marco Elver <elver@google.com>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
 <CANpmjNO6-=dLN=K6R7DrqZmZ5Q8NfORV9kQvwK9kcjCRQhuFaw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CANpmjNO6-=dLN=K6R7DrqZmZ5Q8NfORV9kQvwK9kcjCRQhuFaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/4 15:00, Marco Elver wrote:
> On Wed, 3 Nov 2021 at 14:26, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
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
> 
> Looks good to me.
> 
> Acked-by: Marco Elver <elver@google.com>

Thanks Marco.
