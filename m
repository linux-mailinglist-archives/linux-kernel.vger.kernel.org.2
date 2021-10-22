Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE5F436F94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJVByA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:54:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14840 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJVBx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:53:59 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hb6dv5MBvz90MK;
        Fri, 22 Oct 2021 09:46:43 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 09:51:41 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 09:51:40 +0800
Subject: Re: [RFC PATCH v2] arm64: barrier: add macro dgh() to control memory
 accesses merging
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <mark.rutland@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <moyufeng@huawei.com>
References: <20211015090511.92421-1-wangxiongfeng2@huawei.com>
 <YWnBngJeIvV2S5IB@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <3303413f-a8de-bd41-4095-80ffa98cf75b@huawei.com>
Date:   Fri, 22 Oct 2021 09:51:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YWnBngJeIvV2S5IB@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 2021/10/16 1:59, Catalin Marinas wrote:
> On Fri, Oct 15, 2021 at 05:05:11PM +0800, Xiongfeng Wang wrote:
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 451e11e5fd23..d71a7457d619 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -18,6 +18,14 @@
>>  #define wfe()		asm volatile("wfe" : : : "memory")
>>  #define wfi()		asm volatile("wfi" : : : "memory")
>>  
>> +/*
>> + * Data Gathering Hint:
>> + * This instruction prohibits merging memory accesses with Normal-NC or
>> + * Device-GRE attributes before the hint instruction with any memory accesses
>> + * appearing after the hint instruction.
>> + */
>> +#define dgh()		asm volatile("hint #6" : : : "memory")
> 
> On its own, this patch doesn't do anything. It's more interesting to see
> how it will be used and maybe come up with a common name that other
> architectures would share (or just implement as no-opp). I'm not sure
> there was any conclusion last time we discussed this.

In the last mail, I was suggested to investigate the code in other architecture
to find if there exists similar interface. I searched 'merg' in the code and
didn't find similar interface.

The only thing similar I found is in Intel Software Developer's Manual. It says
"Write Combining (WC) ... Writes may be delayed and combined in the write
combining buffer (WC buffer) to reduce memory accesses. If the WC buffer is
partially filled, the writes may be delayed until the next occurrence of a
serializing event; such as an SFENCE or MFENCE instruction, CPUID or other
serializing instruction, a read or write to uncached memory, an interrupt
occurrence, or an execution of a LOCK instruction (including one with an
XACQUIRE or XRELEASE prefix)."
Maybe this is more like the write combine buffer flushing, not prevent merging.
Sorry I still didn't understand the difference clearly.

How about a common name called 'merge_prohibit_hint()'? Could you give me some
suggestions ?

Thanks,
Xiongfeng

> 
