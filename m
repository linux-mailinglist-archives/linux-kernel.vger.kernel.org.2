Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9633AC81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCOHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:49:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13927 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhCOHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:49:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DzT6F5WH2zlVnM;
        Mon, 15 Mar 2021 15:47:33 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 15:49:02 +0800
Subject: Re: [PATCH 1/4] KVM: arm64: Hide kvm_mmu_wp_memory_region()
To:     Gavin Shan <gshan@redhat.com>, <kvmarm@lists.cs.columbia.edu>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-2-gshan@redhat.com>
CC:     <maz@kernel.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <shan.gavin@gmail.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <c16969db-480e-3229-9d90-a62a0f7d8a2a@huawei.com>
Date:   Mon, 15 Mar 2021 15:49:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210315041844.64915-2-gshan@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

This function is only used by mmu.c in the first commit c64735554c0a, so please feel free
to add:

Reviewed-by: Keqian Zhu <zhukeqian1@huawei.com>


Thanks,
Keqian

On 2021/3/15 12:18, Gavin Shan wrote:
> We needn't expose the function as it's only used by mmu.c.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 1 -
>  arch/arm64/kvm/mmu.c              | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 3d10e6527f7d..688f2df1957b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -632,7 +632,6 @@ void kvm_arm_resume_guest(struct kvm *kvm);
>  	})
>  
>  void force_vm_exit(const cpumask_t *mask);
> -void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>  
>  int handle_exit(struct kvm_vcpu *vcpu, int exception_index);
>  void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 77cb2d28f2a4..84e70f953de6 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -555,7 +555,7 @@ static void stage2_wp_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_
>   * Acquires kvm_mmu_lock. Called with kvm->slots_lock mutex acquired,
>   * serializing operations for VM memory regions.
>   */
> -void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
> +static void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
>  {
>  	struct kvm_memslots *slots = kvm_memslots(kvm);
>  	struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
> 
