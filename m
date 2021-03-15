Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2844A33AD06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCOIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:05:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14339 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCOIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:04:45 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DzTRw1Y4nz8y3T;
        Mon, 15 Mar 2021 16:02:52 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 16:04:40 +0800
Subject: Re: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
To:     Gavin Shan <gshan@redhat.com>, <kvmarm@lists.cs.columbia.edu>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-3-gshan@redhat.com>
CC:     <maz@kernel.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <shan.gavin@gmail.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <65dfdca3-af94-7d5a-86fe-24825301655b@huawei.com>
Date:   Mon, 15 Mar 2021 16:04:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210315041844.64915-3-gshan@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 2021/3/15 12:18, Gavin Shan wrote:
> find_vma_intersection() has been existing to search the intersected
> vma. This uses the function where it's applicable, to simplify the
> code.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/mmu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 84e70f953de6..286b603ed0d3 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -421,10 +421,11 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>  	 *     +--------------------------------------------+
>  	 */
>  	do {
> -		struct vm_area_struct *vma = find_vma(current->mm, hva);
> +		struct vm_area_struct *vma;
>  		hva_t vm_start, vm_end;
>  
> -		if (!vma || vma->vm_start >= reg_end)
> +		vma = find_vma_intersection(current->mm, hva, reg_end);
Nit: Keep a same style may be better(Assign vma when declare it).
Other looks good to me.

Thank,
Keqian


> +		if (!vma)
>  			break;
>  
>  		/*
> @@ -1330,10 +1331,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  	 *     +--------------------------------------------+
>  	 */
>  	do {
> -		struct vm_area_struct *vma = find_vma(current->mm, hva);
> +		struct vm_area_struct *vma;
>  		hva_t vm_start, vm_end;
>  
> -		if (!vma || vma->vm_start >= reg_end)
> +		vma = find_vma_intersection(current->mm, hva, reg_end);
> +		if (!vma)
>  			break;
>  
>  		/*
> 
