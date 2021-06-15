Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64B73A7B69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFOKK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:10:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6375 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhFOKK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:10:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G43pC3n99z63ZS;
        Tue, 15 Jun 2021 18:04:51 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 18:08:43 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 18:08:43 +0800
Subject: Re: [PATCH] KVM: arm64: Fix inconsistency from function comment of
 __unmap_stage2_range
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <yuzenghui@huawei.com>, <wanghaibin.wang@huawei.com>
References: <20210615090436.13916-1-wangyanan55@huawei.com>
 <87mtrrihgl.wl-maz@kernel.org>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <d10107ec-6448-e69c-ecad-6d24c3dd42ae@huawei.com>
Date:   Tue, 15 Jun 2021 18:08:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87mtrrihgl.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/15 17:51, Marc Zyngier wrote:
> On Tue, 15 Jun 2021 10:04:36 +0100,
> Yanan Wang <wangyanan55@huawei.com> wrote:
>> Commit 'b5331379bc626'
>> (KVM: arm64: Only reschedule if MMU_NOTIFIER_RANGE_BLOCKABLE is not set)
>> has converted the original function name 'unmap_stage2_range' to
>> '__unmap_stage2_range', but leaving the corresponding function comment
>> unadjusted. So fix it for code readability.
>>
>> Incidentally, we also tewak some comment identation by using tabs instead
>> of spaces to be consistent with the other functions.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> Same as the previous patch. The first hunk is OK, as it fixes an
> actual defect (wrong documentation), and adjusting the alignment is OK
> as your changing the context.
>
> However, the last 3 are just noise. Please drop them.
Ok, will drop them.

Thanks,
Yanan
> Thanks,
>
> 	M.
>
>> ---
>>   arch/arm64/kvm/mmu.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 5742ba765ff9..80040af147a2 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -151,11 +151,11 @@ static void *kvm_host_va(phys_addr_t phys)
>>    * does.
>>    */
>>   /**
>> - * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
>> - * @mmu:   The KVM stage-2 MMU pointer
>> - * @start: The intermediate physical base address of the range to unmap
>> - * @size:  The size of the area to unmap
>> - * @may_block: Whether or not we are permitted to block
>> + * __unmap_stage2_range -- Clear stage2 page table entries to unmap a range
>> + * @mmu:	The KVM stage-2 MMU pointer
>> + * @start:	The intermediate physical base address of the range to unmap
>> + * @size:	The size of the area to unmap
>> + * @may_block:	Whether or not we are permitted to block
>>    *
>>    * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
>>    * be called while holding mmu_lock (unless for freeing the stage2 pgd before
>> @@ -190,7 +190,7 @@ static void stage2_flush_memslot(struct kvm *kvm,
>>   
>>   /**
>>    * stage2_flush_vm - Invalidate cache for pages mapped in stage 2
>> - * @kvm: The struct kvm pointer
>> + * @kvm:	The struct kvm pointer
>>    *
>>    * Go through the stage 2 page tables and invalidate any cache lines
>>    * backing memory already mapped to the VM.
>> @@ -527,7 +527,7 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>>   
>>   /**
>>    * stage2_unmap_vm - Unmap Stage-2 RAM mappings
>> - * @kvm: The struct kvm pointer
>> + * @kvm:	The struct kvm pointer
>>    *
>>    * Go through the memregions and unmap any regular RAM
>>    * backing memory already mapped to the VM.
>> @@ -578,7 +578,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>>    * @guest_ipa:	The IPA at which to insert the mapping
>>    * @pa:		The physical address of the device
>>    * @size:	The size of the mapping
>> - * @writable:   Whether or not to create a writable mapping
>> + * @writable:	Whether or not to create a writable mapping
>>    */
>>   int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>   			  phys_addr_t pa, unsigned long size, bool writable)
>> @@ -616,7 +616,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>   
>>   /**
>>    * stage2_wp_range() - write protect stage2 memory region range
>> - * @mmu:        The KVM stage-2 MMU pointer
>> + * @mmu:	The KVM stage-2 MMU pointer
>>    * @addr:	Start address of range
>>    * @end:	End address of range
>>    */
>> -- 
>> 2.23.0
>>
>>

