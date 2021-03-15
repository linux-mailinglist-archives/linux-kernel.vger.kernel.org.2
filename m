Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7133AF38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCOJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhCOJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615801601;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WY2MxEFcVlULLMgxUmbdvrWVsJ3NRRAN+UTOLbgUHmA=;
        b=VVMei67X90H1KatRu85WEXgn7jiPvMjmOBFr/qfIjjzyySSe4tysEnQJ97oS+LxQTZg2QR
        tpQxnKxH0dItgOF93xXQIU/x9dRQ9pujfARgBfm7CA6W58PWuNAV0swsTuspmD1NQybRup
        70EdCdGTMsx2tU1pxPZxHdABSgvlkPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-xbVeZD4HMweo1KXZ7TSTFA-1; Mon, 15 Mar 2021 05:46:37 -0400
X-MC-Unique: xbVeZD4HMweo1KXZ7TSTFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCCA51084D68;
        Mon, 15 Mar 2021 09:46:35 +0000 (UTC)
Received: from [10.64.54.175] (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA7A3620DE;
        Mon, 15 Mar 2021 09:46:33 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 3/4] KVM: arm64: Fix address check for memory slot
To:     Keqian Zhu <zhukeqian1@huawei.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-4-gshan@redhat.com>
 <be57b9fb-89c4-9c32-f273-9f4bbe973b00@huawei.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <b7aaa914-04f7-4560-4a53-393adaccd27d@redhat.com>
Date:   Mon, 15 Mar 2021 20:46:30 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <be57b9fb-89c4-9c32-f273-9f4bbe973b00@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 3/15/21 6:33 PM, Keqian Zhu wrote:
> FYI, this has been fixed by Marc in commit 262b003d059c.
> 

Yeah, I didn't check 5.12.rc3 code where the issue has been
fixed. So please ignore this one and sorry for the noise.

Thanks,
Gavin
  
> On 2021/3/15 12:18, Gavin Shan wrote:
>> The last (IPA) page can't be specified when a new memory slot is
>> added. The error -EFAULT is returned when the memory slot is added
>> with the following parameters for the VM, which has 40-bits IPA
>> limit. The host has 4KB base page size. It's not correct because
>> the last (IPA) page is still usable.
>>
>>     struct kvm_userspace_memory_region {
>>        __u32 slot;               /* 1            */
>>        __u32 flags;              /* 0            */
>>        __u64 guest_phys_addr;    /* 0xfffffff000 */
>>        __u64 memory_size;        /* 0x1000       */
>>        __u64 userspace_addr;
>>     };
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 286b603ed0d3..a5a8ade9fde4 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1313,7 +1313,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>   	 * Prevent userspace from creating a memory region outside of the IPA
>>   	 * space addressable by the KVM guest IPA space.
>>   	 */
>> -	if (memslot->base_gfn + memslot->npages >=
>> +	if (memslot->base_gfn + memslot->npages >
>>   	    (kvm_phys_size(kvm) >> PAGE_SHIFT))
>>   		return -EFAULT;
>>   
>>
> 

