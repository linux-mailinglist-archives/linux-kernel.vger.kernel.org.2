Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC44933CC52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhCPDxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231340AbhCPDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615866761;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V40kaFfpUEyV4ZKdYetesb/NkWxPeo4GP3hb5Jwdckc=;
        b=Sy9dn26nUwgqWV1C1OVs3JpWSNigiJRmfffFJHnHHdxhFGQ7hz9Z+NkeYEhGqerWMlwiJk
        luLQu+Cc3X6MeB/cCszeR0hh2GTzDijyniSRnw1tS6v8XtLeBm+YXkqeexfIIh4bShfPxf
        OPtmlhDuiWthl5tmEwU++LRwNiFXFBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Pu0pn-o-OkaHyKopJf4Ndg-1; Mon, 15 Mar 2021 23:52:37 -0400
X-MC-Unique: Pu0pn-o-OkaHyKopJf4Ndg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DA8239381;
        Tue, 16 Mar 2021 03:52:36 +0000 (UTC)
Received: from [10.64.54.175] (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46FE461F5C;
        Tue, 16 Mar 2021 03:52:32 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
From:   Gavin Shan <gshan@redhat.com>
To:     Keqian Zhu <zhukeqian1@huawei.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-3-gshan@redhat.com>
 <65dfdca3-af94-7d5a-86fe-24825301655b@huawei.com>
 <2eef2b42-13bd-2414-f748-551039677bf5@redhat.com>
Message-ID: <d46320a2-7381-a46a-42e5-6bfa75321d31@redhat.com>
Date:   Tue, 16 Mar 2021 14:52:28 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2eef2b42-13bd-2414-f748-551039677bf5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 3/15/21 8:42 PM, Gavin Shan wrote:
> On 3/15/21 7:04 PM, Keqian Zhu wrote:
>> On 2021/3/15 12:18, Gavin Shan wrote:
>>> find_vma_intersection() has been existing to search the intersected
>>> vma. This uses the function where it's applicable, to simplify the
>>> code.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/mmu.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>> index 84e70f953de6..286b603ed0d3 100644
>>> --- a/arch/arm64/kvm/mmu.c
>>> +++ b/arch/arm64/kvm/mmu.c
>>> @@ -421,10 +421,11 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>>>        *     +--------------------------------------------+
>>>        */
>>>       do {
>>> -        struct vm_area_struct *vma = find_vma(current->mm, hva);
>>> +        struct vm_area_struct *vma;
>>>           hva_t vm_start, vm_end;
>>> -        if (!vma || vma->vm_start >= reg_end)
>>> +        vma = find_vma_intersection(current->mm, hva, reg_end);
>> Nit: Keep a same style may be better(Assign vma when declare it).
>> Other looks good to me.
>>
> 
> Yeah, I agree. I will adjust the code in v2 and included your r-b.
> Thanks for your time to review.
> 

After rechecking the code, I think it'd better to keep current style
because there is a follow-on validation on @vma. Keeping them together
seems a good idea. I think it wouldn't a big deal to you. So I will
keep current style with your r-b in v2.

	vma = find_vma_intersection(current->mm, hva, reg_end);
         if (!vma)
              break;
Thanks,
Gavin
  
>>> +        if (!vma)
>>>               break;
>>>           /*
>>> @@ -1330,10 +1331,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>>        *     +--------------------------------------------+
>>>        */
>>>       do {
>>> -        struct vm_area_struct *vma = find_vma(current->mm, hva);
>>> +        struct vm_area_struct *vma;
>>>           hva_t vm_start, vm_end;
>>> -        if (!vma || vma->vm_start >= reg_end)
>>> +        vma = find_vma_intersection(current->mm, hva, reg_end);
>>> +        if (!vma)
>>>               break;
>>>           /*
>>>
>>
> 

