Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42F33AEFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCOJkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhCOJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615801228;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIA9uAdrAsc0WNE5pHXgO80SUEbsiEpbQtctUapRlUU=;
        b=NFnIoPSHCJqB6nGFxA4BlPzi6uNdToLLZhE87/1KUjCtYvjE4BeM7ybtZgN8G9HraaDrHN
        juxbgCSM7X1gwVmi3qx7Il92jfyCuqGYPKKNDx/ptaO/pK0wiDkOYdN5Z95YIQoTzidZBW
        NzwzMBasIP/PBE7BJ/bZ0loMY7zwV1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-npB8E8JqPrW9mu9ad9xpXA-1; Mon, 15 Mar 2021 05:40:24 -0400
X-MC-Unique: npB8E8JqPrW9mu9ad9xpXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 682228710F1;
        Mon, 15 Mar 2021 09:40:22 +0000 (UTC)
Received: from [10.64.54.175] (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B66F6627DD;
        Mon, 15 Mar 2021 09:40:19 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        will@kernel.org, alexandru.elisei@arm.com, shan.gavin@gmail.com
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-3-gshan@redhat.com> <87eeggg5nt.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <86cd410a-d62c-9023-7371-a9d178bfafc1@redhat.com>
Date:   Mon, 15 Mar 2021 20:40:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87eeggg5nt.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/15/21 7:52 PM, Marc Zyngier wrote:
> On Mon, 15 Mar 2021 04:18:42 +0000,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> find_vma_intersection() has been existing to search the intersected
>> vma. This uses the function where it's applicable, to simplify the
>> code.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 84e70f953de6..286b603ed0d3 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -421,10 +421,11 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>>   	 *     +--------------------------------------------+
>>   	 */
>>   	do {
>> -		struct vm_area_struct *vma = find_vma(current->mm, hva);
>> +		struct vm_area_struct *vma;
>>   		hva_t vm_start, vm_end;
>>   
>> -		if (!vma || vma->vm_start >= reg_end)
>> +		vma = find_vma_intersection(current->mm, hva, reg_end);
> 
> For context, here's the definition of find_vma_intersection():
> 
> <quote>
> static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * mm, unsigned long start_addr, unsigned long end_addr)
> {
> 	struct vm_area_struct * vma = find_vma(mm,start_addr);
> 
> 	if (vma && end_addr <= vma->vm_start)
> 		vma = NULL;
> 	return vma;
> }
> </quote>
> 
> It seems that there is a boundary issue in either the old code or the
> new one in the case where (reg_end == vma->start).
> 
> Which one is which?
> 

The old and new code is interchangeable, meaning "reg_end == vma->start"
is invalid in both cases. So if there is a boundary issue, the old and new
code should have same issue.

According to the code, "reg_end == vma->start" is invalid. So I don't see
there is a boundary issue. Hopefully, I don't miss anything :)

Thanks,
Gavin

