Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB733D0EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhGUL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233692AbhGUL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626869380;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDOnx/IOzDkCciZXN2A5TvZxLVe6wZLr2wRXdMxiMoo=;
        b=SkFoTNwZo/swGJqvYbcvaJlBjGtP04mLguXObPiGlPf6yD3LpXJEfHY/HUmH171mu2rQCW
        gv1+93BnGcjmS9D1CXc+Led7iZGpmkJ16IAJ4BGmxHnCVivXKBEZhRbqO+KQ4cehiALGt3
        wSQtypDkFdNtOH+p0/XfuxGdQ8dGkUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-PSlR-IElMYuUpxg8zCCo6w-1; Wed, 21 Jul 2021 08:09:39 -0400
X-MC-Unique: PSlR-IElMYuUpxg8zCCo6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFD9B3E746;
        Wed, 21 Jul 2021 12:09:37 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 546A210013D7;
        Wed, 21 Jul 2021 12:09:34 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719054138.198373-1-gshan@redhat.com>
 <20210719054138.198373-2-gshan@redhat.com>
 <8d754894-5c21-1287-82b6-7ac3b064af3d@redhat.com>
 <ff9766a5-3f4e-f821-daf1-b2779a8c81fc@arm.com>
 <1d8c1b0f-3102-5a4a-f3fb-a0fc50d281cc@redhat.com>
 <aba5506f-5777-6e57-10f3-c414eb012b01@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <ad93c023-5b95-fe90-fc41-26c983255fa5@redhat.com>
Date:   Wed, 21 Jul 2021 22:09:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <aba5506f-5777-6e57-10f3-c414eb012b01@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/21/21 2:50 PM, Anshuman Khandual wrote:
> On 7/21/21 4:59 AM, Gavin Shan wrote:
>> On 7/20/21 4:42 PM, Anshuman Khandual wrote:
>>> On 7/19/21 6:31 PM, Gavin Shan wrote:
>>>>> +    if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>>>> +        has_transparent_hugepage()) {
>>>>> +        page = alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
>>>>> +        if (page) {
>>>>> +            args->pmd_pfn = page_to_pfn(page);
>>>>> +            args->pte_pfn = args->pmd_pfn;
>>>>> +            return 0;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>
>>>> As syzbot reported against v1 series, we could allocate pages larger than (1 << (MAX_ORDER - 1)) here.
>>>> So __GFP_NOWARN is needed here. I will fix it in v3 series.
>>>
>>> I could find the following build error reported from lkp on V2.
>>>
>>> mm/debug_vm_pgtable.c:445:8: warning: variable 'pud' set but not used [-Wunused-but-set-variable]
>>>
>>
>> Yes, The following line is missed in PATCH[v2 09/12] and fixed in
>> PATCH[v3 09/12]: WARN_ON(!pud_none(pud)). With this line added,
>> the variable @pud is used in v3.
>>
>>> Could you please point to the syzbot reported problem on V1 as you
>>> have mentioned above. Are there configs where HPAGE_[PMD|PUD]_ORDER
>>> is greater than (MAX_ORDER - 1) ? If yes, how adding __GFP_NOWARN
>>> solves the problem ?
>>>
>>
>> https://syzkaller.appspot.com/bug?extid=8730ec44a441a434a2c8
>> https://syzkaller.appspot.com/x/.config?x=29a82c885e192046
>>
>> The kernel config has the following options:
>>
>> CONFIG_X86_64=y
>> CONFIG_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
>> #define PUD_SHIFT        30
>> #define PMD_SHIFT        21
>>
>> CONFIG_FORCE_MAX_ZONEORDER=n
>> #define MAX_ORDER    11
>>
>> (HPAGE_PUD_SHIFT - PAGE_SHIFT) >= (1 << MAX_ORDER)
>> (HPAGE_PMD_ORDER)              <  (1 << MAX_ORDER)
>>
>> The warning is triggered in the following path, __GFP_NOWARN helps to
>> avoid the WARNING_ON_ONCE(), but NULL is returned as expected.
>>
>>     alloc_pages
>>       __alloc_pages
>>
>>         if (unlikely(order >= MAX_ORDER)) {
>>                  WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
>>                  return NULL;
>>          }
> 
> But then that does not allocate the PUD element for the test which
> subsequently will be skipped. Isn't it ? So if the order is greater
> than MAX_ORDER, allocation needs to happen via alloc_contig_pages()
> or something similar.
> 

Yes, the corresponding (modifying) tests will be skipped if we fail
to allocate the PUD huge page. And we need to use alloc_contig_pages()
when CONFIG_CONTIG_ALLOC is enabled. Otherwise, alloc_pages() is still
used as best-effort before we fail completely.

It's explained to you when we're discussion on PATCH[v3 01/12].

Thanks,
Gavin

