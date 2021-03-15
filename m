Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BE33AC54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCOHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:34:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14338 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhCOHdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:33:44 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DzSm56Pybz8yRT;
        Mon, 15 Mar 2021 15:31:49 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 15:33:39 +0800
Subject: Re: [PATCH 3/4] KVM: arm64: Fix address check for memory slot
To:     Gavin Shan <gshan@redhat.com>, <kvmarm@lists.cs.columbia.edu>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-4-gshan@redhat.com>
CC:     <maz@kernel.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <shan.gavin@gmail.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <be57b9fb-89c4-9c32-f273-9f4bbe973b00@huawei.com>
Date:   Mon, 15 Mar 2021 15:33:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210315041844.64915-4-gshan@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

FYI, this has been fixed by Marc in commit 262b003d059c.

Thanks,
Keqian

On 2021/3/15 12:18, Gavin Shan wrote:
> The last (IPA) page can't be specified when a new memory slot is
> added. The error -EFAULT is returned when the memory slot is added
> with the following parameters for the VM, which has 40-bits IPA
> limit. The host has 4KB base page size. It's not correct because
> the last (IPA) page is still usable.
> 
>    struct kvm_userspace_memory_region {
>       __u32 slot;               /* 1            */
>       __u32 flags;              /* 0            */
>       __u64 guest_phys_addr;    /* 0xfffffff000 */
>       __u64 memory_size;        /* 0x1000       */
>       __u64 userspace_addr;
>    };
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 286b603ed0d3..a5a8ade9fde4 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1313,7 +1313,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  	 * Prevent userspace from creating a memory region outside of the IPA
>  	 * space addressable by the KVM guest IPA space.
>  	 */
> -	if (memslot->base_gfn + memslot->npages >=
> +	if (memslot->base_gfn + memslot->npages >
>  	    (kvm_phys_size(kvm) >> PAGE_SHIFT))
>  		return -EFAULT;
>  
> 
