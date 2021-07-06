Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC43BC65A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGFGUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhGFGUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+ru+U+Oc29lc1AvLWBgfwb6rzCmttJjIzNLEviVazlo=;
        b=jQdCzGc26QR62tmPI6cR1aS3rJbWzA9PzXffhJrFGOnRpfmnyu71SUDgugTjFvuoGjwpR5
        3LSP09f0WpVeXEQh2agGLNfrTtcnzy6oG/kBuCmGwcaz0ya5wozhwN7mb7pA/oTcBqOGhj
        ljvIpI3HhikPZ+wLSuXjLZKnJLUH4HA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-M9hHX5HRMdijwX-T4bPiOQ-1; Tue, 06 Jul 2021 02:18:01 -0400
X-MC-Unique: M9hHX5HRMdijwX-T4bPiOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71C94801B1C;
        Tue,  6 Jul 2021 06:18:00 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A17102C00F;
        Tue,  6 Jul 2021 06:17:57 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 00/12] mm/debug_vm_pgtable: Enhancements
Date:   Tue,  6 Jul 2021 14:17:36 +0800
Message-Id: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are couple of issues with current implementations and this series
tries to resolve the issues:

  (a) All needed information are scattered in variables, passed to various
      test functions. The code is organized in pretty much relaxed fashion.

  (b) The page isn't allocated from buddy during page table entry modifying
      tests. The page can be invalid, conflicting to the implementations
      of set_{pud, pmd, pte}_at() on ARM64. The target page is accessed
      so that the iCache can be flushed when execution permission is given
      on ARM64. Besides, the target page can be unmapped and access to
      it causes kernel crash.

"struct vm_pgtable_debug" is introduced to address issue (a). For issue
(b), the used page is allocated from buddy in page table entry modifying
tests. The corresponding tets will be skipped if we fail to allocate the
(huge) page. For other test cases, the original page around to kernel
symbol (@start_kernel) is still used.

The patches are organized as below. PATCH[2-10] could be combined to one
patch, but it will make the review harder:

  PATCH[1] introduces "struct vm_pgtable_debug" as place holder of all
           needed information. With it, the old and new implementation
           can coexist.
  PATCH[2-10] uses "struct vm_pgtable_debug" in various test functions.
  PATCH[11] removes the old implementation.
  PATCH[12] fixes the issue of corrupted page flag for ARM64


Gavin Shan (12):
  mm/debug_vm_pgtable: Introduce struct vm_pgtable_debug
  mm/debug_vm_pgtable: Use struct vm_pgtable_debug in basic tests
  mm/debug_vm_pgtable: Use struct vm_pgtable_debug in leaf and savewrite
    tests
  mm/debug_vm_pgtable: Use struct vm_pgtable_debug in protnone and
    devmap tests
  mm/vm_debug_pgtable: Use struct vm_pgtable_debug in soft_dirty and
    swap tests
  mm/debug_vm_pgtable: Use struct vm_pgtable_debug in migration and thp
    tests
  mm/debug_vm_pgtable: Use struct vm_pgtable_debug in PTE modifying
    tests
  mm/debug_vm_pgtable: Use struct vm_pgtable_debug in PMD modifying
    tests
  mm/vm_debug_pgtable: Use struct vm_pgtable_debug in PUD modifying
    tests
  mm/debug_vm_pgtable: Use struct vm_pgtable_debug in PGD and P4D
    modifying tests
  mm/debug_vm_pgtable: Remove unused code
  mm/debug_vm_pgtable: Fix corrupted page flag

 mm/debug_vm_pgtable.c | 875 ++++++++++++++++++++++++------------------
 1 file changed, 500 insertions(+), 375 deletions(-)

-- 
2.23.0

