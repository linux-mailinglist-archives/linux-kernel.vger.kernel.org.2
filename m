Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2113E439B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhHIKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:08:48 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46787 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233514AbhHIKIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:08:47 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GjsGx561wz9sTC;
        Mon,  9 Aug 2021 12:08:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ozi7H-OO-Jzo; Mon,  9 Aug 2021 12:08:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GjsGx3lZGz9sT5;
        Mon,  9 Aug 2021 12:08:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A2138B840;
        Mon,  9 Aug 2021 12:08:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0BxLooPSeYzi; Mon,  9 Aug 2021 12:08:25 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 13AF38B83C;
        Mon,  9 Aug 2021 12:08:25 +0200 (CEST)
Subject: Re: [PATCH v6 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        vgupta@synopsys.com, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210809092631.1888748-1-gshan@redhat.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <34b03b31-f13e-1f8d-a8db-49b2e501ef57@csgroup.eu>
Date:   Mon, 9 Aug 2021 12:08:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809092631.1888748-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/08/2021 à 11:26, Gavin Shan a écrit :
> There are couple of issues with current implementations and this series
> tries to resolve the issues:
> 
>    (a) All needed information are scattered in variables, passed to various
>        test functions. The code is organized in pretty much relaxed fashion.
> 
>    (b) The page isn't allocated from buddy during page table entry modifying
>        tests. The page can be invalid, conflicting to the implementations
>        of set_xxx_at() on ARM64. The target page is accessed so that the
>        iCache can be flushed when execution permission is given on ARM64.
>        Besides, the target page can be unmapped and accessing to it causes
>        kernel crash.
> 
> "struct pgtable_debug_args" is introduced to address issue (a). For issue
> (b), the used page is allocated from buddy in page table entry modifying
> tests. The corresponding tets will be skipped if we fail to allocate the
> (huge) page. For other test cases, the original page around to kernel
> symbol (@start_kernel) is still used.
> 
> The patches are organized as below. PATCH[2-10] could be combined to one
> patch, but it will make the review harder:
> 
>    PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
>             needed information. With it, the old and new implementation
>             can coexist.
>    PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
>    PATCH[11] removes the unused code for old implementation.
>    PATCH[12] fixes the issue of corrupted page flag for ARM64


I tested this series on powerpc 8xx, no failure reported.

Christophe

> 
> Changelog
> =========
> v6:
>     * Populate saved page table entry pointers after
>       they're allocated in init_args()                        (Anshuman)
>     * Fix imbalanced preemption count issue by replacing
>       pte_alloc_mmap() with pte_alloc() in init_args()        (syzbot)
> v5:
>     * Pick r-bs from Anshuman and rebase to 5.14.rc4          (Gavin)
>     * Use args->start_p4dp to free p4d entries                (Anshuman)
>     * Introduce helper to allocate huge page in init_arg()    (Anshuman)
>     * Bail early if the allocated page doesn't exist in
>       swap_migration_tests() and correct the comments         (Anshuman)
>     * Add fixes tag to PATCH[v4 12/12]                        (Christophe)
>     * Address misc comments                                   (Anshuman)
> v4:
>     * Determine the page allocation method according to
>       MAX_ORDER                                               (Anshuman)
>     * Move existing comments to init_args()                   (Anshuman)
>     * Code refactoring as suggested by Anshuman               (Anshuman)
>     * Improved commit log and add comments for flush_dcache_page()
>       in PATCH[v4 12/12]                                      (Anshuman)
>     * Address misc comments                                   (Anshuman)
> v3:
>     * Fix the warning caused by allocating more pages than
>       (1 << (MAX_ORDER - 1)) in init_args()                   (syzbot)
>     * Fix build warning by dropping unused variables in separate
>       patches                                                 (0-day)
>     * Missed "WARN_ON(!pud_none(pud))" in pud_huge_tests() in
>       PATCH[v2 09/12]                                         (0-day)
>     * Fix the subjects for PATCH[05/12] and PATCH[09/12]      (Gavin)
> v2:
>     * Rename struct vm_pgtable_debug to struct pgtable_debug_args.
>       The parameter name to various test functions are renamed
>       to "@args"                                              (Anshuman)
>     * Code changes as suggested by Anshuman                   (Anshuman)
> 
> Gavin Shan (12):
>    mm/debug_vm_pgtable: Introduce struct pgtable_debug_args
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in basic tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in leaf and
>      savewrite tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in protnone and
>      devmap tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in soft_dirty and
>      swap tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in migration and
>      thp tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in PTE modifying
>      tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in PMD modifying
>      tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in PUD modifying
>      tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in PGD and P4D
>      modifying tests
>    mm/debug_vm_pgtable: Remove unused code
>    mm/debug_vm_pgtable: Fix corrupted page flag
> 
>   mm/debug_vm_pgtable.c | 918 +++++++++++++++++++++++++-----------------
>   1 file changed, 559 insertions(+), 359 deletions(-)
> 
