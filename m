Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6DC33AF55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhCOJ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhCOJ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615802189;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s663/ZH1yFhPEvrM19sba3u1Bf1Jh6lElfvXAN6LRbo=;
        b=EP29WVvaO/rKTS+GsONWdpZfjDnnPl7b+YqDoPrULEaWwGQrMtmpTQBOdQpie3FGHZ043E
        I9LGHKaPuHGtu+Ou0GZa1Kf5uursz1JqVKbSTouNxaAYM5TstWx6Idu5rm/yzV+DMQKi2C
        9YnWRZthFgPt2K3XofdQCV99zg6cfvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-hK3KDtw3MVGNr9lOM4Ywsw-1; Mon, 15 Mar 2021 05:56:25 -0400
X-MC-Unique: hK3KDtw3MVGNr9lOM4Ywsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A57E802B45;
        Mon, 15 Mar 2021 09:56:23 +0000 (UTC)
Received: from [10.64.54.175] (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDF1B100239A;
        Mon, 15 Mar 2021 09:56:20 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 4/4] KVM: arm64: Don't retrieve memory slot again in page
 fault handler
To:     Keqian Zhu <zhukeqian1@huawei.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-5-gshan@redhat.com>
 <30073114-339f-33dd-0168-b4d6bfbe88bc@huawei.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7a29ac43-ef11-e990-e08c-c5e97ea7d78d@redhat.com>
Date:   Mon, 15 Mar 2021 20:56:17 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <30073114-339f-33dd-0168-b4d6bfbe88bc@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 3/15/21 7:25 PM, Keqian Zhu wrote:
> On 2021/3/15 12:18, Gavin Shan wrote:
>> We needn't retrieve the memory slot again in user_mem_abort() because
>> the corresponding memory slot has been passed from the caller. This
> I think you are right, though fault_ipa will be adjusted when we try to use block mapping,
> the fault_supports_stage2_huge_mapping() makes sure we're not trying to map anything
> not covered by the memslot, so the adjusted fault_ipa still belongs to the memslot.
> 

Yeah, it's correct. Besides, the @logging_active is determined
based on the passed memory slot. It means user_mem_abort() can't
support memory range which spans multiple memory slot.

>> would save some CPU cycles. For example, the time used to write 1GB
>> memory, which is backed by 2MB hugetlb pages and write-protected, is
>> dropped by 6.8% from 928ms to 864ms.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index a5a8ade9fde4..4a4abcccfafb 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -846,7 +846,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	 */
>>   	smp_rmb();
>>   
>> -	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
>> +	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
>> +				   write_fault, &writable, NULL);
> It's better to update the code comments at same time.
> 

I guess you need some comments here? If so, I would add something
like below in v2:

	/*
	 * gfn_to_pfn_prot() can be used either with unnecessary overhead
	 * introduced to locate the memory slot because the memory slot is
	 * always fixed even @gfn is adjusted for huge pages.
	 */

>>   	if (pfn == KVM_PFN_ERR_HWPOISON) {
>>   		kvm_send_hwpoison_signal(hva, vma_shift);
>>   		return 0;
>> @@ -912,7 +913,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	/* Mark the page dirty only if the fault is handled successfully */
>>   	if (writable && !ret) {
>>   		kvm_set_pfn_dirty(pfn);
>> -		mark_page_dirty(kvm, gfn);
>> +		mark_page_dirty_in_slot(kvm, memslot, gfn);
>>   	}
>>   
>>   out_unlock:
>>

Thanks,
Gavin


