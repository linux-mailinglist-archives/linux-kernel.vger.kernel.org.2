Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235603D3383
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhGWDmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233558AbhGWDmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627014196;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDqHRpETL/O2hE265L4eJPKQHOvkYVQFRK0q5+wQoR8=;
        b=YCePppPq9NRtcRX9CIvNRslB5z6Oxnz/kadAmXxxfTA3t9eXfMM4uC+03r5+AQDEHxm1hr
        w0La3LFpOU4zOh8kp1eLwrMLUjjRVbR48zIS1Yf47H64J2zjzkC53OfbrcceISaUsu10v9
        0mmJIKO0gdyOIKwVcCYXLzUS/le7i+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-v8wIC43vPGGswb643-0W9A-1; Fri, 23 Jul 2021 00:23:12 -0400
X-MC-Unique: v8wIC43vPGGswb643-0W9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC243488C;
        Fri, 23 Jul 2021 04:23:11 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63E485D9C6;
        Fri, 23 Jul 2021 04:23:08 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 07/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PTE modifying tests
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-8-gshan@redhat.com>
 <bfa07f56-f58c-f2c3-64e1-1cdb09dbf366@arm.com>
 <99c73652-7294-17ff-0c4f-986b588ab022@redhat.com>
 <492c96ea-5f60-2720-7da8-1fc18a1f95d3@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2666f07b-7a84-89a4-a738-ffb21f76ca8a@redhat.com>
Date:   Fri, 23 Jul 2021 14:23:24 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <492c96ea-5f60-2720-7da8-1fc18a1f95d3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/23/21 12:39 PM, Anshuman Khandual wrote:
> On 7/22/21 12:07 PM, Gavin Shan wrote:
>>
>>>>          pgdp = pgd_offset(mm, vaddr);
>>>>        p4dp = p4d_alloc(mm, pgdp, vaddr);
>>>> @@ -1272,11 +1275,11 @@ static int __init debug_vm_pgtable(void)
>>>>         * Page table modifying tests. They need to hold
>>>>         * proper page table lock.
>>>>         */
>>>> -
>>>> -    ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
>>>> -    pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
>>>> -    pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>>>> -    pte_unmap_unlock(ptep, ptl);
>>>> +    ptl = pte_lockptr(args.mm, args.pmdp);
>>>> +    spin_lock(ptl);
>>>> +    pte_clear_tests(&args);
>>>> +    pte_advanced_tests(&args);
>>>> +    spin_unlock(ptl);
>>>
>>> Why pte_offset_map_lock()/pte_unmap_unlock() has been dropped and
>>> spin_lock()/spin_unlock() sequence has been added ? Please dont
>>> change the tests in these patches.
>>>
>>
>> The semantics of pte_offset_map_lock() is to grab and take the lock
>> and return the PTE entry, which is mapped if needed. We already had
>> the PTE entry tracked by args->ptep in init_args(). So some of the
>> operations covered by pte_offset_map_lock() isn't needed any more
> 
> To keep the patch on purpose, please avoid this change here. But if
> required, you could send a follow up patch later.
> 

In order to use pte_offset_map_lock() and pte_unmap_unlock(), we need
a temporary variable @ptep to store the return value from pte_offset_map_lock().
The temporary variable @ptep is passed to pte_unmap_unlock(). It means
we just need the temporary variable to keep the original implementation
in this regard. I will keep pte_offset_map_lock() and pte_unmap_unlock()
in v4.

If we really want to remove the temporary variable (@ptep), we can do it
after this series gets merged.

Thanks,
Gavin

