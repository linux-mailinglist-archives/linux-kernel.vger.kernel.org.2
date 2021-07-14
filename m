Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8A3C7DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 07:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhGNF2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 01:28:17 -0400
Received: from foss.arm.com ([217.140.110.172]:57758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237802AbhGNF2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:28:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF72B6D;
        Tue, 13 Jul 2021 22:25:24 -0700 (PDT)
Received: from [10.163.65.222] (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89AF83F694;
        Tue, 13 Jul 2021 22:25:22 -0700 (PDT)
Subject: Re: [PATCH 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
 <42a26202-10f7-e744-3fc5-c9e5a7445193@arm.com>
 <a8539200-35ac-2478-c763-e13c95556b25@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <30a938df-f5c8-910c-8ddc-52a2d2a0a11e@arm.com>
Date:   Wed, 14 Jul 2021 10:56:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a8539200-35ac-2478-c763-e13c95556b25@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/21 6:50 AM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 7/12/21 2:14 PM, Anshuman Khandual wrote:
>> Though I have not jumped into the details for all individual
>> patches here but still have some high level questions below.
>>
>> On 7/6/21 11:47 AM, Gavin Shan wrote:
>>> There are couple of issues with current implementations and this series
>>> tries to resolve the issues:
>>>
>>>    (a) All needed information are scattered in variables, passed to various
>>>        test functions. The code is organized in pretty much relaxed fashion.
>> All these variables are first prepared in debug_vm_pgtable(), before
>> getting passed into respective individual test functions. Also these
>> test functions receive only the required number of variables not all.
>> Adding a structure that captures all test parameters at once before
>> passing them down will be unnecessary. I am still wondering what will
>> be the real benefit of this large code churn ?
>>
> 
> Thanks for your review. There are couple of reasons to have "struct vm_pgtable_debug".
> 
> (1) With the struct, the old and new implementation can coexist. In this way,
>     the patches in this series can be stacked up easily.

Makes sense.

> (2) I think passing single struct to individual test functions improves the
>     code readability. Besides, it also makes the empty stubs simplified.

Empty stub simplified - reduced argument set in the empty stubs ?

> (3) The code can be extended easily if we need in future.

Agreed.

> 
>>>
>>>    (b) The page isn't allocated from buddy during page table entry modifying
>>>        tests. The page can be invalid, conflicting to the implementations
>>>        of set_{pud, pmd, pte}_at() on ARM64. The target page is accessed
>>>        so that the iCache can be flushed when execution permission is given
>>>        on ARM64. Besides, the target page can be unmapped and access to
>>>        it causes kernel crash.
>>
>> Using 'start_kernel' based method for struct page usage, enabled this
>> test to run on platforms which might not have enough memory required
>> for various individual test functions. This method is not a problem for
>> tests that just need an aligned pfn (which creates a page table entry)
>> not a real struct page.
>>
>> But not allocating and owning the struct page might be problematic for
>> tests that expect a real struct page and transform its state via set_
>> {pud, pmd, pte}_at() functions as reported here.
>>
> 
> Yeah, I totally agree. The series follows what you explained: Except the
> test cases where set_{pud, pmd, pte}_at() is used, the allocated page
> is used. For other test cases, 'start_kernel' based PFN is used as before.
> 
>>>
>>> "struct vm_pgtable_debug" is introduced to address issue (a). For issue
>>> (b), the used page is allocated from buddy in page table entry modifying
>>> tests. The corresponding tets will be skipped if we fail to allocate the
>>> (huge) page. For other test cases, the original page around to kernel
>>> symbol (@start_kernel) is still used.
>>
>> For all basic pfn requiring tests, existing 'start_kernel' based method
>> should continue but allocate a struct page for other tests which change
>> the passed struct page. Skipping the tests when allocation fails is the
>> right thing to do.
>>
> 
> Yes, it's exactly what this series does. Hope you can jump into the details
> when you get a chance :)

I have already started looking into the series. But still wondering if
the huge page memory allocation change and the arm64 specific page fix
should be completed first, before getting into the new structure based
arguments (in a separate series). Although the end result would still
remain the same, the transition there would be better I guess. Do you
see any challenges in achieving that ?

- Anshuman
