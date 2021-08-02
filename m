Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844003DD041
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhHBGFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhHBGEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627884283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iLC4bwfdSbwF0yo5Y8i+abm/lowpqvGEJGzZXdiM5N0=;
        b=bXOesDEU12+l0uQkVKu01uUwm2IE1VHArjaAPqLbm5V6CNAp4lroUGfs7A02NSD32CAmp2
        CCGAgrv0/nxH78DnBEZGkPnj2L6iLyrhVosd7af2MqKvMc6Kr6EwoKnZYC9luM8b7eyq9T
        GXoFPQt44AmfKWBm0HmtVosU8HXVPE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-U5vS8WJCNpuEXxe4K_SxXQ-1; Mon, 02 Aug 2021 02:04:42 -0400
X-MC-Unique: U5vS8WJCNpuEXxe4K_SxXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A10DD185302A;
        Mon,  2 Aug 2021 06:04:40 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3BCF1ABD8;
        Mon,  2 Aug 2021 06:04:35 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 00/12] mm/debug_vm_pgtable: Enhancements
Date:   Mon,  2 Aug 2021 14:04:07 +0800
Message-Id: <20210802060419.1360913-1-gshan@redhat.com>
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

 mm/debug_vm_pgtable.c | 916 +++++++++++++++++++++++++-----------------
 1 file changed, 558 insertions(+), 358 deletions(-)

-- 
2.23.0

