Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9B3EBCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHMToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhHMToY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:44:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5501260F21;
        Fri, 13 Aug 2021 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628883836;
        bh=2hyViBfwHWSQ5FVPojFdRsY2lrOVaSM1RPUsZNslGHQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eH6ijDVTmCJEio8xYt1IYxbLhwyyqK/c56JFiqRI7pUlkpH4Q2o1xaMTKdcwHHWS8
         ZDdAABt/RgQb46p7RsfgG2hGUbrm23LjhIRXUFs23ogtZK06CndzUgx02/WfVF0bfo
         v+uXFhYI118O4LZ/m8gqpZ69vUCnac66PjsiItOc5IPexHpVS0EbxGl3B3PRxz0nru
         3p8QSNQd6CWUnTrMFbYJDrSBVU73FBGgritnex+lBgxapsg2DoH14TFFqIc9jLo2m+
         LaFy+3q4uRBZehB4A+ZU0WBbfhliAOscw6MLxoxGVtTt4C/jc+04lJfH5G7iEznWCv
         j3lEpgheHWKig==
Subject: Re: [PATCH v6 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com,
        arcml <linux-snps-arc@lists.infradead.org>
References: <20210809092631.1888748-1-gshan@redhat.com>
 <b066aea5-6b3e-193a-01d0-32b52d5ac513@arm.com>
 <d96fa0d8-98d8-c924-99f7-bb9673fc2a13@redhat.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <25018384-acc5-dcf7-5125-378499ab4555@kernel.org>
Date:   Fri, 13 Aug 2021 12:43:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d96fa0d8-98d8-c924-99f7-bb9673fc2a13@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 2:25 AM, Gavin Shan wrote:
> Hi Anshuman and Vineet,
>
> On 8/12/21 9:11 PM, Anshuman Khandual wrote:
>> On 8/9/21 2:56 PM, Gavin Shan wrote:
>>> There are couple of issues with current implementations and this series
>>> tries to resolve the issues:
>>>
>>>    (a) All needed information are scattered in variables, passed to 
>>> various
>>>        test functions. The code is organized in pretty much relaxed 
>>> fashion.
>>>
>>>    (b) The page isn't allocated from buddy during page table entry 
>>> modifying
>>>        tests. The page can be invalid, conflicting to the 
>>> implementations
>>>        of set_xxx_at() on ARM64. The target page is accessed so that 
>>> the
>>>        iCache can be flushed when execution permission is given on 
>>> ARM64.
>>>        Besides, the target page can be unmapped and accessing to it 
>>> causes
>>>        kernel crash.
>>>
>>> "struct pgtable_debug_args" is introduced to address issue (a). For 
>>> issue
>>> (b), the used page is allocated from buddy in page table entry 
>>> modifying
>>> tests. The corresponding tets will be skipped if we fail to allocate 
>>> the
>>> (huge) page. For other test cases, the original page around to kernel
>>> symbol (@start_kernel) is still used.
>>>
>>> The patches are organized as below. PATCH[2-10] could be combined to 
>>> one
>>> patch, but it will make the review harder:
>>>
>>>    PATCH[1] introduces "struct pgtable_debug_args" as place holder 
>>> of all
>>>             needed information. With it, the old and new implementation
>>>             can coexist.
>>>    PATCH[2-10] uses "struct pgtable_debug_args" in various test 
>>> functions.
>>>    PATCH[11] removes the unused code for old implementation.
>>>    PATCH[12] fixes the issue of corrupted page flag for ARM64
>>>
>>> Changelog
>>> =========
>>> v6:
>>>     * Populate saved page table entry pointers after
>>>       they're allocated in init_args() (Anshuman)
>>>     * Fix imbalanced preemption count issue by replacing
>>>       pte_alloc_mmap() with pte_alloc() in init_args() (syzbot)
>>
>> + vgupta@kernel.org

Please also keep linux-snps-arc CC'ed for ARC changes.

>>
>> Hello Gavin/Vineet,
>>
>> This series still need to be tested on ARC ?
>>
>
> Yes, I'm unable to test ARC as it's not supported by QEMU yet.
> It would great if Vineet can give it a try on ARC :)

We do have a working QEMU (in the process of being upstreamed) you could try
https://github.com/foss-for-synopsys-dwc-arc-processors/qemu #master

Is this code in some shared git repo we can pull - instead of apply 8 files.

Thx,
-Vineet
