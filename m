Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CEE3CD57C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhGSM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236935AbhGSM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626700042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=htLWUl9ptDYSCDmTTDEtd9WdgLa8oSPYzBBixivS3+w=;
        b=UW9gD4QoFfaFK1+y7oVeHrA25a/zGUCq0FyabvhAfIiIuESlv5548hijX9NAYdj0lrL83j
        fseBvMJR+QSabgzNvFqOZEY+tZH7tRO/cGYoMtSJ5iUdxpi5Rtc96TnwctMYQuieOj38il
        Ge3y2MNOYH8PVe10COrEFt3oDMF+psU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-gD8EUaYAPV-gS68Nz1JOXQ-1; Mon, 19 Jul 2021 09:07:21 -0400
X-MC-Unique: gD8EUaYAPV-gS68Nz1JOXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 749BF362FF;
        Mon, 19 Jul 2021 13:07:19 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 468DA5D6A1;
        Mon, 19 Jul 2021 13:07:14 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 00/12] mm/debug_vm_pgtable: Enhancements
Date:   Mon, 19 Jul 2021 21:06:01 +0800
Message-Id: <20210719130613.334901-1-gshan@redhat.com>
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
      of set_xxx_at() on ARM64. The target page is accessed so that the iCache
      can be flushed when execution permission is given on ARM64. Besides,
      the target page can be unmapped and access to it causes kernel crash.

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
v3:
   * Fix the warning caused by allocating more pages than
     (1 << (MAX_ORDER - 1)) in init_args()                       (syzbot)
   * Fix build warning by dropping unused variables in separate
     patches                                                     (0-day)
   * Missed "WARN_ON(!pud_none(pud))" in pud_huge_tests() in
     PATCH[v2 09/12]                                             (0-day)
   * Fix the subjects for PATCH[05/12] and PATCH[09/12]          (Gavin)
v2:
   * Rename struct vm_pgtable_debug to struct pgtable_debug_args.
     The parameter name to various test functions are renamed
     to "@args"                                                  (Anshuman)
   * Code changes as suggested by Anshuman                       (Anshuman)

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

 mm/debug_vm_pgtable.c | 849 ++++++++++++++++++++++++------------------
 1 file changed, 480 insertions(+), 369 deletions(-)

-- 
2.23.0

