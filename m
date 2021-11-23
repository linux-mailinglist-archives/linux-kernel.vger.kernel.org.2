Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985434598E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhKWAEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhKWAEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:04:13 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A38C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 16:01:06 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id n6-20020a17090a670600b001a9647fd1aaso436776pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 16:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c5/tpWSff4dFHh5q6xjJHceDD7GLZ6RDhs8W9YIAjtE=;
        b=qhWa4Zhk7NchUhmumrVqvSAJuvqQCaRNgR3VhkJ1cgKkIgT3PnHJcxg50Bf/bvcBWt
         B03yUWlvIhJT0+svy9+S95w02WodOrWOwkw5zEquFIWPBU1l2w1CU7Z6SunbYgyeaykD
         s996BxASMp47tXiGEFsA9XFGGfjUhPiOjd5sWt5YfXx/RvgMTswVOyEFMuhEg2iC5Adx
         6+ysqnul60O+2OJzTLAjf4CFIj4TQV0rDQNETBIJgTDohirT10IhjQPH532Pn59O1ID0
         N50qA7HX83qIC2v7mwBK9B04GibyR4v/fffAzRRrTrmFPY3jEDG+KTy2R0ntAim9z/uJ
         1fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c5/tpWSff4dFHh5q6xjJHceDD7GLZ6RDhs8W9YIAjtE=;
        b=cDA7J/7AC2dfdUzmw3xlGiUGq8RyxXDdvUsoI7L295YPKeqnLih7axlmQpHN6AnMqb
         brH0f5wa37G4mebl0RihQnGhB51hj5RaJu7KjhCvrP/NPaMf6CiP/Y7uR9A1mpGDcA76
         eUi4ZPq64wVKhXaeWKKoeEyKbnYClWsQbNYiOZJs8oxMxhr0iCwgCiDu10x22o7KZ1bW
         6+uL9ykPpe4wu8c3Vqis5uEhsMtwPhgSeG8r3/80/LH/egGJYbmgyDHfZ/2jcAIfm7Y8
         qDLkTiUW9o462CUrfe7WhGNTiRRqOGQGjX4goygrV7GfUsMH+sSxcFV0xXDUJ1riQvoq
         pcpg==
X-Gm-Message-State: AOAM533VJyzRomyqeRzEbJMgnqT4JNPY1hQ9pqglbfb1Hz/ciY6FnYtT
        esLx8w7JbfXLk0/I8VGd6vpV0BbnAz1jEHZ79w==
X-Google-Smtp-Source: ABdhPJxCARKpo3QKn92oJKAmEFehwZ16v8foZGYajsmSBMeZsEGa8Zj7R770PBjkFSHsamA67kz2cPaXIlGU69lLmw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:2c06:26c4:bf33:6d15])
 (user=almasrymina job=sendgmr) by 2002:a05:6a00:1705:b0:4a0:3492:16c with
 SMTP id h5-20020a056a00170500b004a03492016cmr928900pfc.3.1637625666001; Mon,
 22 Nov 2021 16:01:06 -0800 (PST)
Date:   Mon, 22 Nov 2021 16:01:02 -0800
Message-Id: <20211123000102.4052105-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
From:   Mina Almasry <almasrymina@google.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mina Almasry <almasrymina@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
address is currently mapped by a transparent huge page or not.  Example
use case is a process requesting THPs from the kernel (via a huge tmpfs
mount for example), for a performance critical region of memory.  The
userspace may want to query whether the kernel is actually backing this
memory by hugepages or not.

PM_THP_MAPPED bit is set if the virt address is mapped at the PMD
level and the underlying page is a transparent huge page.

A few options were considered:
1. Add /proc/pid/pageflags that exports the same info as
   /proc/kpageflags.  This is not appropriate because many kpageflags are
   inappropriate to expose to userspace processes.
2. Simply get this info from the existing /proc/pid/smaps interface.
   There are a couple of issues with that:
   1. /proc/pid/smaps output is human readable and unfriendly to
      programatically parse.
   2. /proc/pid/smaps is slow because it must read the whole memory range
      rather than a small range we care about.  The cost of reading
      /proc/pid/smaps into userspace buffers is about ~800us per call,
      and this doesn't include parsing the output to get the information
      you need. The cost of querying 1 virt address in /proc/pid/pagemaps
      however is around 5-7us.

Tested manually by adding logging into transhuge-stress, and by
allocating THP and querying the PM_THP_MAPPED flag at those
virtual addresses.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes rientjes@google.com
Cc: Paul E. McKenney <paulmckrcu@fb.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc: Florian Schmidt <florian.schmidt@nutanix.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org


---

Changes in v7:
- Added clarification that smaps is only slow because it looks at the
  whole address space.

Changes in v6:
- Renamed to PM_THP_MAPPED
- Removed changes to transhuge-stress

Changes in v5:
- Added justification for this interface in the commit message!

Changes in v4:
- Removed unnecessary moving of flags variable declaration

Changes in v3:
- Renamed PM_THP to PM_HUGE_THP_MAPPING
- Fixed checks to set PM_HUGE_THP_MAPPING
- Added PM_HUGE_THP_MAPPING docs
---
 Documentation/admin-guide/mm/pagemap.rst | 3 ++-
 fs/proc/task_mmu.c                       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index fdc19fbc10839..8a0f0064ff336 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -23,7 +23,8 @@ There are four components to pagemap:
     * Bit  56    page exclusively mapped (since 4.2)
     * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
       :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
-    * Bits 57-60 zero
+    * Bit  58    page is a huge (PMD size) THP mapping
+    * Bits 59-60 zero
     * Bit  61    page is file-page or shared-anon (since 3.5)
     * Bit  62    page swapped
     * Bit  63    page present
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5c..d784a97aa209a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1302,6 +1302,7 @@ struct pagemapread {
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
+#define PM_THP_MAPPED		BIT_ULL(58)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1456,6 +1457,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		if (page && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
+		if (page && is_transparent_hugepage(page))
+			flags |= PM_THP_MAPPED;
 
 		for (; addr != end; addr += PAGE_SIZE) {
 			pagemap_entry_t pme = make_pme(frame, flags);
-- 
2.34.0.rc2.393.gf8c9666880-goog

