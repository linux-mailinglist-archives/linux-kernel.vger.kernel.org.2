Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADED23DCFDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 06:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhHBEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 00:52:50 -0400
Received: from foss.arm.com ([217.140.110.172]:58620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHBEwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 00:52:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DED9106F;
        Sun,  1 Aug 2021 21:52:40 -0700 (PDT)
Received: from [10.163.66.153] (unknown [10.163.66.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9B563F719;
        Sun,  1 Aug 2021 21:52:36 -0700 (PDT)
Subject: Re: [PATCH v4 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com,
        Vineet Gupta <vgupta@synopsys.com>
References: <20210727061401.592616-1-gshan@redhat.com>
 <8b969a2a-a883-3ce2-fac4-70ac2e3fd157@arm.com>
 <05736d94-3bd1-3193-69b1-3c71aa22d0a7@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5ef150b0-60dc-3cf6-da6e-34fe0734ee2e@arm.com>
Date:   Mon, 2 Aug 2021 10:23:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <05736d94-3bd1-3193-69b1-3c71aa22d0a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/21 5:39 AM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 7/29/21 5:14 PM, Anshuman Khandual wrote:
>> On 7/27/21 11:43 AM, Gavin Shan wrote:
>>> There are couple of issues with current implementations and this series
>>> tries to resolve the issues:
>>>
>>>    (a) All needed information are scattered in variables, passed to various
>>>        test functions. The code is organized in pretty much relaxed fashion.
>>>
>>>    (b) The page isn't allocated from buddy during page table entry modifying
>>>        tests. The page can be invalid, conflicting to the implementations
>>>        of set_xxx_at() on ARM64. The target page is accessed so that the iCache
>>>        can be flushed when execution permission is given on ARM64. Besides,
>>>        the target page can be unmapped and access to it causes kernel crash.
>>>
>>> "struct pgtable_debug_args" is introduced to address issue (a). For issue
>>> (b), the used page is allocated from buddy in page table entry modifying
>>> tests. The corresponding tets will be skipped if we fail to allocate the
>>> (huge) page. For other test cases, the original page around to kernel
>>> symbol (@start_kernel) is still used.
>>>
>>> The patches are organized as below. PATCH[2-10] could be combined to one
>>> patch, but it will make the review harder:
>>>
>>>    PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
>>>             needed information. With it, the old and new implementation
>>>             can coexist.
>>>    PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
>>>    PATCH[11] removes the unused code for old implementation.
>>>    PATCH[12] fixes the issue of corrupted page flag for ARM64
>>>
>>> Changelog
>>> =========
>>> v4:
>>>     * Determine the page allocation method according to
>>>       MAX_ORDER                                                   (Anshuman)
>>>     * Move existing comments to init_args()                       (Anshuman)
>>>     * Code refactoring as suggested by Anshuman                   (Anshuman)
>>>     * Improved commit log and add comments for flush_dcache_page()
>>>       in PATCH[v4 12/12]                                          (Anshuman)
>>>     * Address misc comments                                       (Anshuman
>>
>> This series builds ok on all supported platforms but should also be tested
>> on them as well i.e s390, ppc, arc and riscv. I was able to do some tests
>> on arm64 and x86 platforms.
>>
> 
> I had tests on the platforms except arc as it's not supported by QEMU yet.
> The test is pretty simple to boot the kernel and see if there is any warning
> raised from mm/debug_vm_pgtable. Everything looks good.

Sure, that should be enough.

> 
> The test was done on v5, which will be posted pretty soon. Thanks again for
> your continuous review.

Please also do copy Vineet Gupta <vgupta@synopsys.com> for ARC in the next version.

- Anshuman
