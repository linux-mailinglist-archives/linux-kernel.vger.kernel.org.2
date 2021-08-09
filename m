Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A546B3E4293
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhHIJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234198AbhHIJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628501239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3zhESEW2Ji+uo2bsEAl1W/kp0ipaDd92cn/ErvGasJI=;
        b=G8MuNTQ2FPbqhpjO/m8a2VfHHl9wepM8hSXHO/F8kNIUfqK8uyY1t4JlEUALz21EWfnuvH
        0Kv5GNMLRvHelCARXAlpxxm0Q09MvapWKlVe/2SV56SuoRHje77UVH5q8oI6P5iaCVbUD9
        9K/Kscdq2AHYshb7XY4CxmwfI9q3uSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-7gvd0McsOU2aASFitRALaQ-1; Mon, 09 Aug 2021 05:27:16 -0400
X-MC-Unique: 7gvd0McsOU2aASFitRALaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6544618C89C4;
        Mon,  9 Aug 2021 09:27:14 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-155.bne.redhat.com [10.64.54.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B45F95D6AD;
        Mon,  9 Aug 2021 09:27:07 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v6 00/12] mm/debug_vm_pgtable: Enhancements
Date:   Mon,  9 Aug 2021 17:26:19 +0800
Message-Id: <20210809092631.1888748-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are couple of issues with current implementations and this series
tries to resolve the issues:

  (a) All needed information are scattered in variables, passed to various
      test functions. The code is organized in pretty much relaxed fashion.

  (b) The page isn't allocated from buddy during page table entry modifying
      tests. The page can be invalid, conflicting to the implementations
      of set_xxx_at() on ARM64. The target page is accessed so that the
      iCache can be flushed when execution permission is given on ARM64.
      Besides, the target page can be unmapped and accessing to it causes
      kernel crash.

"struct pgtable_debug_args" is introduced to address issue (a). For issue
(b), the used page is allocated from buddy in page table entry modifying
tests. The corresponding tets will be skipped if we fail to allocate the
(huge) page. For other test cases, the original page around to kernel
symbol (@start_kernel) is still used.

The patches are organized as below. PATCH[2-10] could be combined to one
patch, but it will make the review harder:

  PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
           needed information. With it, the old and new implementation
           can coexist.
  PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
  PATCH[11] removes the unused code for old implementation.
  PATCH[12] fixes the issue of corrupted page flag for ARM64

Changelog
=========
v6:
   * Populate saved page table entry pointers after
     they're allocated in init_args()                        (Anshuman)
   * Fix imbalanced preemption count issue by replacing
     pte_alloc_mmap() with pte_alloc() in init_args()        (syzbot)
v5:
   * Pick r-bs from Anshuman and rebase to 5.14.rc4          (Gavin)
   * Use args->start_p4dp to free p4d entries                (Anshuman)
   * Introduce helper to allocate huge page in init_arg()    (Anshuman)
   * Bail early if the allocated page doesn't exist in
     swap_migration_tests() and correct the comments         (Anshuman)
   * Add fixes tag to PATCH[v4 12/12]                        (Christophe)
   * Address misc comments                                   (Anshuman)
v4:
   * Determine the page allocation method according to
     MAX_ORDER                                               (Anshuman)
   * Move existing comments to init_args()                   (Anshuman)
   * Code refactoring as suggested by Anshuman               (Anshuman)
   * Improved commit log and add comments for flush_dcache_page()
     in PATCH[v4 12/12]                                      (Anshuman)
   * Address misc comments                                   (Anshuman)
v3:
   * Fix the warning caused by allocating more pages than
     (1 << (MAX_ORDER - 1)) in init_args()                   (syzbot)
   * Fix build warning by dropping unused variables in separate
     patches                                                 (0-day)
   * Missed "WARN_ON(!pud_none(pud))" in pud_huge_tests() in
     PATCH[v2 09/12]                                         (0-day)
   * Fix the subjects for PATCH[05/12] and PATCH[09/12]      (Gavin)
v2:
   * Rename struct vm_pgtable_debug to struct pgtable_debug_args.
     The parameter name to various test functions are renamed
     to "@args"                                              (Anshuman)
   * Code changes as suggested by Anshuman                   (Anshuman)

Gavin Shan (12):
  mm/debug_vm_pgtable: Introduce struct pgtable_debug_args
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in basic tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in leaf and
    savewrite tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in protnone and
    devmap tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in soft_dirty and
    swap tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in migration and
    thp tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in PTE modifying
    tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in PMD modifying
    tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in PUD modifying
    tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in PGD and P4D
    modifying tests
  mm/debug_vm_pgtable: Remove unused code
  mm/debug_vm_pgtable: Fix corrupted page flag

 mm/debug_vm_pgtable.c | 918 +++++++++++++++++++++++++-----------------
 1 file changed, 559 insertions(+), 359 deletions(-)

-- 
2.23.0

