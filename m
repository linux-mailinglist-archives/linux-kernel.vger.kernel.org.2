Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA9D33AEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCOJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhCOJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615801336;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9jrtmDC/sgF925/5dmbQo+IJ37BsuIDvNzAC14K3Bc=;
        b=ayrDke72BlruKAeliRukQBP7yXHSjCQJOo4IE1Nn6GjK0X8qGXJ87Km+8+zYpSfY6XyAIi
        7qJy6BLk9UTfKKS+9X7v/zF4iptKuNFFch/ehQrb5v4ewG7jNuH0JdaUTkogxgynoD2617
        /I93Fr1vptOEVwyZ9LH7r9IunprdWpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-MKfbU30gPv6a6bW-bwiwbw-1; Mon, 15 Mar 2021 05:42:12 -0400
X-MC-Unique: MKfbU30gPv6a6bW-bwiwbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1C7B64AD5;
        Mon, 15 Mar 2021 09:42:10 +0000 (UTC)
Received: from [10.64.54.175] (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DCC92B162;
        Mon, 15 Mar 2021 09:42:08 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
To:     Keqian Zhu <zhukeqian1@huawei.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-3-gshan@redhat.com>
 <65dfdca3-af94-7d5a-86fe-24825301655b@huawei.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2eef2b42-13bd-2414-f748-551039677bf5@redhat.com>
Date:   Mon, 15 Mar 2021 20:42:06 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <65dfdca3-af94-7d5a-86fe-24825301655b@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 3/15/21 7:04 PM, Keqian Zhu wrote:
> On 2021/3/15 12:18, Gavin Shan wrote:
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
> Nit: Keep a same style may be better(Assign vma when declare it).
> Other looks good to me.
> 

Yeah, I agree. I will adjust the code in v2 and included your r-b.
Thanks for your time to review.

Thanks,
Gavin

  
>> +		if (!vma)
>>   			break;
>>   
>>   		/*
>> @@ -1330,10 +1331,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>   	 *     +--------------------------------------------+
>>   	 */
>>   	do {
>> -		struct vm_area_struct *vma = find_vma(current->mm, hva);
>> +		struct vm_area_struct *vma;
>>   		hva_t vm_start, vm_end;
>>   
>> -		if (!vma || vma->vm_start >= reg_end)
>> +		vma = find_vma_intersection(current->mm, hva, reg_end);
>> +		if (!vma)
>>   			break;
>>   
>>   		/*
>>
> 

