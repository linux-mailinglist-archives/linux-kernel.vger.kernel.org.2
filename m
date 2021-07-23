Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACB3D3101
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhGWAEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232832AbhGWACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627000990;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzAgVUDW4F6INuiFdyg/5BoR655vppoe7oB6S9hgdEk=;
        b=fTiA1RxrVU9vTRclYax/z/bT18HTYxbZ9fLzko7KHvTTytsETdPGcsxHfU+utlQ3Y0tzu0
        hl2bhL2fmmIvvZKyZcdDOkSzx8yXWnkgriHjttnCzBA9Kk1+qV6WPpyXijrxXif++RYoUV
        TlsUnMw6rgE8u8eaXenx5d9orCew1RY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-MXfsOGNcOt2WfyCpXaBMhA-1; Thu, 22 Jul 2021 20:43:09 -0400
X-MC-Unique: MXfsOGNcOt2WfyCpXaBMhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A64FA806688;
        Fri, 23 Jul 2021 00:43:07 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1EB017A99;
        Fri, 23 Jul 2021 00:43:04 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-2-gshan@redhat.com>
 <ab0f9daa-0c49-e74c-e073-6e03a3cabb07@arm.com>
 <280a5740-b5dc-4b78-3a38-67e5adbb0afd@redhat.com>
 <04a4618f-9899-1518-cee1-0a48cb4df4c6@arm.com>
 <65078a0c-c35c-8e3f-d4d3-3090b0c3daaf@redhat.com>
 <4a534102-11ff-c849-781e-ed173e46da56@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <118678e4-b67a-2141-8caa-3bbb9e9cdc19@redhat.com>
Date:   Fri, 23 Jul 2021 10:43:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4a534102-11ff-c849-781e-ed173e46da56@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/22/21 5:08 PM, Anshuman Khandual wrote:
> On 7/22/21 11:53 AM, Gavin Shan wrote:
>> On 7/22/21 2:41 PM, Anshuman Khandual wrote:
>>> On 7/21/21 3:50 PM, Gavin Shan wrote:
>>>> On 7/21/21 3:44 PM, Anshuman Khandual wrote:
>>>>> On 7/19/21 6:36 PM, Gavin Shan wrote:
>>>>>> In debug_vm_pgtable(), there are many local variables introduced to
>>>>>> track the needed information and they are passed to the functions for
>>>>>> various test cases. It'd better to introduce a struct as place holder
>>>>>> for these information. With it, what the functions for various test
>>>>>> cases need is the struct, to simplify the code. It also makes code
>>>>>> easier to be maintained.
>>>>>>
>>>>>> Besides, set_xxx_at() could access the data on the corresponding pages
>>>>>> in the page table modifying tests. So the accessed pages in the tests
>>>>>> should have been allocated from buddy. Otherwise, we're accessing pages
>>>>>> that aren't owned by us. This causes issues like page flag corruption.
>>>>>>
>>>>>> This introduces "struct pgtable_debug_args". The struct is initialized
>>>>>> and destroyed, but the information in the struct isn't used yet. They
>>>>>> will be used in subsequent patches.
>>>>>>
>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>> ---
>>>>>>     mm/debug_vm_pgtable.c | 197 +++++++++++++++++++++++++++++++++++++++++-
>>>>>>     1 file changed, 196 insertions(+), 1 deletion(-)
>>>>>>

[...]

>>>
>>> IIRC it is also not guaranteed that PMD_SHIFT <= (MAX_ORDER - 1). Hence
>>> this same scheme should be followed for PMD level allocation as well.
>>>
>>
>> In theory, it's possible to have PMD_SHIFT <= (MAX_ORDER - 1) with misconfigured
>> kernel. I will apply the similar logic to PMD huge page in v4.
>>
>>>>       [... The code to release the PUD huge page needs changes based on @args->is_contiguous_pud_page]
>>>
>>> Right, a flag would be needed to call the appropriate free function.
>>>
>>
>> Yes. We need two falgs for PUD and PMD huge pages separately.
> 
> A single flag should be enough, the order would be dependent on
> whether args->pud_pfn or args->pmd_pfn is valid.
> 

Yes, it's correct that one flag is enough as we're sharing the PUD
or PMD huge page.

Thanks,
Gavin

