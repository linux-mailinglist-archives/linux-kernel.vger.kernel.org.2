Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD395361255
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhDOSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhDOSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:47:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l30so3517247ybj.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HOv3LI0amuLnu16Azoij1WiD0ahUGLpZta25xI8mbb4=;
        b=K+sh8JarhAxis1EkzesQd7EqJyIE6gNyonS8n+ov71E2StwoJ8B2pEj16zjFHpwi1E
         6ZAXgOWIG7qs+YTeFn5TiDMqbmrPXVBrmzi2XdQAiFUbT8uHoz5txjNNWW8uyU3J8lus
         On8DVQ2eOOh4iDqFWQAbUMCGlvMVGNByIOkjFT7OrsMo31nByw19h2IPOnHfowP614H0
         56XU7arD5SCK6pNUkw+NXtNCVLWfltQxlouDjl4qsSmZLXSNNbfUSW5CVOq7Cr6YVHh9
         XyMXJcn6JsBiQzG3cSNimz3DHSZ0uRHsh+jAsxeSvzJSp8ycAdNi5eVAogPRcnD46KBD
         sdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HOv3LI0amuLnu16Azoij1WiD0ahUGLpZta25xI8mbb4=;
        b=QKUDd2IstBpNCVnECmUMzZJfxuor0JyUoIDDHXHNBdF+xwGpoddtcSOpJXwIGypu8L
         EkKaKubnY3FZiAYMxEyG4MAT8RSfG2fh7W2iS2JQpVS57DWTeMSj0MnGxXo8+5wImbK6
         ya8WvV/Dqxqog94E8C64RyQmverj8Z2yuCdcJrga8y/OECPJaCdDD8H9ijFm4fqMtazv
         DMQoyc5r7vdDlWi7ZpctdjtgZivAZqOrNapxU2DBUECXurlWGE/AdHObwO4toBld1Tjb
         mYq8uETGzl90StZCfFl3n9KoIWyR028vy/BS8wCuskmFpBLCfEAabAGL1jziB5EdK/M4
         o+pA==
X-Gm-Message-State: AOAM530W7mYwh5cPQJ40iAnvRQV2UXsnbM5YsuuT3XRRSuiMLjbJACwe
        b/fl7Pfe2m2eCPXxSfRign8CC8MRazctwha8Wyt8
X-Google-Smtp-Source: ABdhPJzoNSXv2urXx3peba3eorPfVQfJb4ZTqrlOnBXFac83aVKjuHsYFDHRRJKeqOVJqqs2DLnDqHPXoPg6+QsjU4Ji
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:cc05:: with SMTP id
 l5mr6554359ybf.520.1618512455879; Thu, 15 Apr 2021 11:47:35 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:22 -0700
Message-Id: <20210415184732.3410521-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 00/10] userfaultfd: add minor fault handling for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base
====

This series is based on (and therefore should apply cleanly to) the tag
"v5.12-rc7-mmots-2021-04-11-20-49", additionally with Peter's selftest cleanup
series applied first:

https://lore.kernel.org/patchwork/cover/1412450/

Changelog
=========

v2->v3:
- Picked up {Reviewed,Acked}-by's.
- Reorder commits: introduce CONTINUE before MINOR registration. [Hugh, Peter]
- Don't try to {unlock,put}_page an xarray value in shmem_getpage_gfp. [Hugh]
- Move enum mcopy_atomic_mode forward declare out of CONFIG_HUGETLB_PAGE. [Hugh]
- Keep mistakenly removed UFFD_USER_MODE_ONLY in selftest. [Peter]
- Cleanup context management in self test (make clear implicit, remove unneeded
  return values now that we have err()). [Peter]
- Correct dst_pte argument to dst_pmd in shmem_mcopy_atomic_pte macro. [Hugh]
- Mention the new shmem support feature in documentation. [Hugh]

v1->v2:
- Pick up Reviewed-by's.
- Don't swapin page when a minor fault occurs. Notice that it needs to be
  swapped in, and just immediately fire the minor fault. Let a future CONTINUE
  deal with swapping in the page. [Peter]
- Clarify comment about i_size checks in mm/userfaultfd.c. [Peter]
- Only forward declare once (out of #ifdef) in hugetlb.h. [Peter]

Changes since [2]:
- Squash the fixes ([2]) in with the original series ([1]). This makes reviewing
  easier, as we no longer have to sift through deltas undoing what we had done
  before. [Hugh, Peter]
- Modify shmem_mcopy_atomic_pte() to use the new mcopy_atomic_install_ptes()
  helper, reducing code duplication. [Hugh]
- Properly trigger handle_userfault() in the shmem_swapin_page() case. [Hugh]
- Use shmem_getpage() instead of find_lock_page() to lookup the existing page in
  for continue. This properly deals with swapped-out pages. [Hugh]
- Unconditionally pte_mkdirty() for anon memory (as before). [Peter]
- Don't include userfaultfd_k.h in either hugetlb.h or shmem_fs.h. [Hugh]
- Add comment for UFFD_FEATURE_MINOR_SHMEM (to match _HUGETLBFS). [Hugh]
- Fix some small cleanup issues (parens, reworded conditionals, reduced plumbing
  of some parameters, simplify labels/gotos, ...). [Hugh, Peter]

Overview
========

See the series which added minor faults for hugetlbfs [3] for a detailed
overview of minor fault handling in general. This series adds the same support
for shmem-backed areas.

This series is structured as follows:

- Commits 1 and 2 are cleanups.
- Commits 3 and 4 implement the new feature (minor fault handling for shmem).
- Commits 5, 6, 7, 8 update the userfaultfd selftest to exercise the feature.
- Commit 9 is one final cleanup, modifying an existing code path to re-use a new
  helper we've introduced. We rely on the selftest to show that this change
  doesn't break anything.

Use Case
========

In some cases it is useful to have VM memory backed by tmpfs instead of
hugetlbfs. So, this feature will be used to support the same VM live migration
use case described in my original series.

Additionally, Android folks (Lokesh Gidra <lokeshgidra@google.com>) hope to
optimize the Android Runtime garbage collector using this feature:

"The plan is to use userfaultfd for concurrently compacting the heap. With
this feature, the heap can be shared-mapped at another location where the
GC-thread(s) could continue the compaction operation without the need to
invoke userfault ioctl(UFFDIO_COPY) each time. OTOH, if and when Java threads
get faults on the heap, UFFDIO_CONTINUE can be used to resume execution.
Furthermore, this feature enables updating references in the 'non-moving'
portion of the heap efficiently. Without this feature, uneccessary page
copying (ioctl(UFFDIO_COPY)) would be required."

[1] https://lore.kernel.org/patchwork/cover/1388144/
[2] https://lore.kernel.org/patchwork/patch/1408161/
[3] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/T/#t

Axel Rasmussen (10):
  userfaultfd/hugetlbfs: avoid including userfaultfd_k.h in hugetlb.h
  userfaultfd/shmem: combine shmem_{mcopy_atomic,mfill_zeropage}_pte
  userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
  userfaultfd/shmem: support minor fault registration for shmem
  userfaultfd/selftests: use memfd_create for shmem test type
  userfaultfd/selftests: create alias mappings in the shmem test
  userfaultfd/selftests: reinitialize test context in each test
  userfaultfd/selftests: exercise minor fault handling shmem support
  userfaultfd/shmem: modify shmem_mcopy_atomic_pte to use install_ptes
  userfaultfd: update documentation to mention shmem minor faults

 Documentation/admin-guide/mm/userfaultfd.rst |   3 +-
 fs/userfaultfd.c                             |   6 +-
 include/linux/hugetlb.h                      |   4 +-
 include/linux/shmem_fs.h                     |  17 +-
 include/linux/userfaultfd_k.h                |   5 +
 include/uapi/linux/userfaultfd.h             |   7 +-
 mm/hugetlb.c                                 |   1 +
 mm/memory.c                                  |   8 +-
 mm/shmem.c                                   | 114 +++-----
 mm/userfaultfd.c                             | 183 +++++++++----
 tools/testing/selftests/vm/userfaultfd.c     | 274 ++++++++++++-------
 11 files changed, 371 insertions(+), 251 deletions(-)

--
2.31.1.368.gbe11c130af-goog

