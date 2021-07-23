Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9123D31EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhGWB6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:58:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231663AbhGWB6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:58:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFD60113E;
        Thu, 22 Jul 2021 19:38:47 -0700 (PDT)
Received: from [10.163.66.36] (unknown [10.163.66.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F23083F694;
        Thu, 22 Jul 2021 19:38:44 -0700 (PDT)
Subject: Re: [PATCH v3 07/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PTE modifying tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-8-gshan@redhat.com>
 <bfa07f56-f58c-f2c3-64e1-1cdb09dbf366@arm.com>
 <99c73652-7294-17ff-0c4f-986b588ab022@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <492c96ea-5f60-2720-7da8-1fc18a1f95d3@arm.com>
Date:   Fri, 23 Jul 2021 08:09:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <99c73652-7294-17ff-0c4f-986b588ab022@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/21 12:07 PM, Gavin Shan wrote:
> 
>>>         pgdp = pgd_offset(mm, vaddr);
>>>       p4dp = p4d_alloc(mm, pgdp, vaddr);
>>> @@ -1272,11 +1275,11 @@ static int __init debug_vm_pgtable(void)
>>>        * Page table modifying tests. They need to hold
>>>        * proper page table lock.
>>>        */
>>> -
>>> -    ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
>>> -    pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
>>> -    pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>>> -    pte_unmap_unlock(ptep, ptl);
>>> +    ptl = pte_lockptr(args.mm, args.pmdp);
>>> +    spin_lock(ptl);
>>> +    pte_clear_tests(&args);
>>> +    pte_advanced_tests(&args);
>>> +    spin_unlock(ptl);
>>
>> Why pte_offset_map_lock()/pte_unmap_unlock() has been dropped and
>> spin_lock()/spin_unlock() sequence has been added ? Please dont
>> change the tests in these patches.
>>
> 
> The semantics of pte_offset_map_lock() is to grab and take the lock
> and return the PTE entry, which is mapped if needed. We already had
> the PTE entry tracked by args->ptep in init_args(). So some of the
> operations covered by pte_offset_map_lock() isn't needed any more

To keep the patch on purpose, please avoid this change here. But if
required, you could send a follow up patch later.
