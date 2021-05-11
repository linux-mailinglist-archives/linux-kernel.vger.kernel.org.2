Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC37737A17E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhEKIQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhEKIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620720942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W+lkFKosn3ZCBfYs9e8QQUkhp3xYn5E5Z8L39/ayP3I=;
        b=Cn51nQO2bh2vSSBMLsey8KEzTGkbnhh7gpLu+S04uwdZl101u3jcvnZBjhM4pYn3Y+QM/x
        IEyoiOdNko/7Raw5HeOZvOCclOY64N5XT6ubc+hDp3SkWJ6bkDYXmkyD174Vt1w3YhX8j3
        X8eRkuro7zYNuuDYPlvw2aNQuhGqUtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-dnng3bvvN9y7_Rys3tTyBA-1; Tue, 11 May 2021 04:15:40 -0400
X-MC-Unique: dnng3bvvN9y7_Rys3tTyBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29BD31008078;
        Tue, 11 May 2021 08:15:40 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-91.ams2.redhat.com [10.36.115.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBD085D6D1;
        Tue, 11 May 2021 08:15:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH resend v2 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page tables
Date:   Tue, 11 May 2021 10:15:29 +0200
Message-Id: <20210511081534.3507-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of v2 because linux-mm seems to have swallowed patch #2.

Excessive details on MADV_POPULATE_(READ|WRITE) can be found in patch #2.

v1 -> v2:
- "mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page
   tables"
-- Renamed patch/series to match what's happening -- prefault page tables
-- Clarified MADV_POPULATE_READ semantics on file holes and that we might
   want fallocate().
-- Updated/clarified description
-- Dropped -EINVAL and -EBUSY checks
-- Added a comment regarding FOLL_TOUCH and why we don't care that
   pages will get set dirty when triggering write-faults for now.
-- Reran and extended performance measurements by more fallocate()
   combinations

RFCv2 -> v1
- "mm: fix variable name in declaration of populate_vma_page_range()"
-- Added
- "mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault ..."
-- Fix detection of memory holes when we have to re-lookup the VMA
-- Return -EHWPOISON to user space when we hit HW poisoned pages
-- Make variable names in definition and declaration consistent
- "MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT"
-- Added
- "selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore"
-- Added
- "selftests/vm: add test for MADV_POPULATE_(READ|WRITE)"
-- Added

RFC -> RFCv2:
- Fix re-locking (-> set "locked = 1;")
- Don't mimic MAP_POPULATE semantics:
--> Explicit READ/WRITE request instead of selecting it automatically,
    which makes it more generic and better suited for some use cases (e.g., we
    usually want to prefault shmem writable)
--> Require proper access permissions
- Introduce and use faultin_vma_page_range()
--> Properly handle HWPOISON pages (FOLL_HWPOISON)
--> Require proper access permissions (!FOLL_FORCE)
- Let faultin_vma_page_range() check for compatible mappings/permissions
- Extend patch description and add some performance numbers

David Hildenbrand (5):
  mm: make variable names for populate_vma_page_range() consistent
  mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page
    tables
  MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT
  selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore
  selftests/vm: add test for MADV_POPULATE_(READ|WRITE)

 MAINTAINERS                                |   1 +
 arch/alpha/include/uapi/asm/mman.h         |   3 +
 arch/mips/include/uapi/asm/mman.h          |   3 +
 arch/parisc/include/uapi/asm/mman.h        |   3 +
 arch/xtensa/include/uapi/asm/mman.h        |   3 +
 include/uapi/asm-generic/mman-common.h     |   3 +
 mm/gup.c                                   |  58 ++++
 mm/internal.h                              |   5 +-
 mm/madvise.c                               |  66 ++++
 tools/testing/selftests/vm/.gitignore      |   3 +
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/madv_populate.c | 342 +++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh  |  16 +
 13 files changed, 506 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/madv_populate.c


base-commit: bf05bf16c76bb44ab5156223e1e58e26dfe30a88
-- 
2.30.2

