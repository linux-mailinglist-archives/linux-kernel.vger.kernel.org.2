Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F903CCD83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhGSFoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhGSFo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626673289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k8vrwGfi4buaNEKiEDx9yVcWKxB1hoROC6N2FWsbEvQ=;
        b=CsI7TQ8Zrq/e4jO69rKVEX1ahOWGXdSz/XUkoBxGLu+LXyTAFM8/3DiTtThyalX0l0BBbL
        PQDZCRkY+C+e651OlMmRPv7BkTx3yp2hDKLquEuXXMZU1h2Fmm7TXQbLiQON34VxCzJ2/y
        IeXEQFLo0r8FCkqitpwFV56UORZ1s9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-t-2HJhyMM0SvCUaAJKJ_3w-1; Mon, 19 Jul 2021 01:41:27 -0400
X-MC-Unique: t-2HJhyMM0SvCUaAJKJ_3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1648362F8;
        Mon, 19 Jul 2021 05:41:26 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5E4869CB4;
        Mon, 19 Jul 2021 05:41:23 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 00/12] mm/debug_vm_pgtable: Enhancements
Date:   Mon, 19 Jul 2021 13:41:26 +0800
Message-Id: <20210719054138.198373-1-gshan@redhat.com>
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
  PATCH[11] removes the old implementation.
  PATCH[12] fixes the issue of corrupted page flag for ARM64

Changelog
=========
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
  mm/vm_debug_pgtable: Use struct pgtable_debug_args in soft_dirty and
    swap tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in migration and
    thp tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in PTE modifying
    tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in PMD
  mm/vm_debug_pgtable: Use struct pgtable_debug_args in PUD modifying
    tests
  mm/debug_vm_pgtable: Use struct pgtable_debug_args in PGD and P4D
    modifying tests
  mm/debug_vm_pgtable: Remove unused code
  mm/debug_vm_pgtable: Fix corrupted page flag

 mm/debug_vm_pgtable.c | 849 ++++++++++++++++++++++++------------------
 1 file changed, 479 insertions(+), 370 deletions(-)

-- 
2.23.0

