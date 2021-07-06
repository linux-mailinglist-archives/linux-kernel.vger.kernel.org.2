Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6AE3BC5F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhGFFLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhGFFLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625548150;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGDuAhHTOm13+rlbOsExkzDR8UOrKEAH7+Oj+upM9IQ=;
        b=H7BGhtOFBUomybDFX7J2q9ef6qp5EuuOw0UT6pgpuIyQY10/FxvE9349egM6CO7YKy2S1J
        aJ6FUER2DfHn0AiirOAsQMOkj0UOWc1e9h9gmQc18wyHmX6FqckITLA2hFnSD2hdLYBoJT
        tr13K0vHb8MM5dezEC773R5ikbGVRJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-oQuSJVvANW-9LswbWmaYFw-1; Tue, 06 Jul 2021 01:09:06 -0400
X-MC-Unique: oQuSJVvANW-9LswbWmaYFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43D7A800C78;
        Tue,  6 Jul 2021 05:09:05 +0000 (UTC)
Received: from [10.64.54.119] (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 246855C1D0;
        Tue,  6 Jul 2021 05:09:02 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm/debug_vm_pgtable: Fix corrupted PG_arch_1 by
 set_pmd_at()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20210702103225.51448-1-gshan@redhat.com>
 <33cfab46-3b9b-0088-17b5-bc821c74aefb@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <8e7d7ea3-8412-4c6c-0489-5c9f795a6f35@redhat.com>
Date:   Tue, 6 Jul 2021 15:09:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <33cfab46-3b9b-0088-17b5-bc821c74aefb@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/5/21 1:59 PM, Anshuman Khandual wrote:
> On 7/2/21 4:02 PM, Gavin Shan wrote:
>> There are two addresses selected: random virtual address and physical
>> address corresponding to kernel symbol @start_kernel. During the PMD
>> tests in pmd_advanced_tests(), the physical address is aligned down
>> to the starting address of the huge page, whose size is 512MB on ARM64
>> when we have 64KB base page size. After that, set_pmd_at() is called
>> to populate the PMD entry. PG_arch_1, PG_dcache_clean on ARM64, is
>> set to the page flags. Unforunately, the page, corresponding to the
>> starting address of the huge page could be owned by buddy. It means
>> PG_arch_1 can be unconditionally set to page owned by buddy.
>>
>> Afterwards, the page with PG_arch_1 set is fetched from buddy's free
>> area list, but fails the checking. It leads to the following warning
>> on ARM64:
>>
>>     BUG: Bad page state in process memhog  pfn:08000
>>     page:0000000015c0a628 refcount:0 mapcount:0 \
>>          mapping:0000000000000000 index:0x1 pfn:0x8000
>>     flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>>     raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>>     raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>>     page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
> 
> Does this problem happen right after the boot ? OR you ran some tests
> and workloads to trigger this ? IIRC never seen this before on arm64.
> Does this happen on other archs too ?
> 

The page flag (PG_arch_1) is corrupted during boot on ARM64 where
64KB base page size is selected, but the failing page check happens
when the page is pulled from buddy's free area list by "memhog".
I don't think other platform has same issue.

>>
>> This fixes the issue by calling flush_dcache_page() after each call
>> to set_{pud, pmd, pte}_at() because PG_arch_1 isn't needed in any case.
> 
> This (arm64 specific solution) might cause some side effects on other
> platforms ? The solution here needs to be generic enough. I will take
> a look into this patch but probably later this week or next week.
> 

Apart from the overhead of flushing the dcache introduced by flush_dcache_page().
I don't think there is any side-effect. By the way, I'm working on a series
to fix this issue and another issue. I will post the series for review pretty
soon and it's going to fix the following issues:

(1) Current code is organized in relaxed fashion. All information are maintained
     in variables in debug_vm_pgtable(). The variables are passed to test functions.
     It make the code hard to be maintained in long term. So I will introduce a
     dedicated data struct (struct vm_pgtable_debug), as place holder for various
     information.

(2) With the data struct, I'm able to allocate page, to be used by set_{pud, pmd, pte}_at()
     because the target page is accessed on ARM64. The PG_arch_1 flag is set to
     the page and the corresponding iCache is flush if execution permission is given.
     There are two issues if the page used by set_{pud, pmd, pte}_at() wasn't allocated
     from buddy: (a) the PG_arch_1 flag corruption as this patch tries to fix; (b) kernel
     crash because of invalid page fault on accessing the target page. The page isn't
     mapped if CONFIG_DEBUG_PAGEALLOC is enabled.

     start_kernel
     mm_init
     mem_init
     memblock_free_all
     free_low_memory_core_early
     __free_memory_core
     __free_pages_memory
     memblock_free_pages
     __free_pages_core
     __free_pages_ok
     free_pages_prepare
     debug_pagealloc_unmap_pages           # The page is unmapped here

Thanks,
Gavin

