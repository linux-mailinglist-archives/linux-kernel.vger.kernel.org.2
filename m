Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2244FF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhKOH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229654AbhKOH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OFYWOfIgh+R0pCCOGFbQusLursYsTaR7YBgSvw4x5lw=;
        b=TkmfGl0CLQd2ACJr8/+VN9I7QXvvTs6j8QPPgNtuTU00YLwqCZtjpFBe48BdIjHmiUCpXB
        TN1FI01OdetfZwV//Yu6JKj1i+R+79AJYVGah5ynRzUVAPkyTUxjm90zhRVfqr1wrxSlFB
        42AGUU7WUKbdZoaDkxjJqXjR+SoZMyA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-MPl6QiHxPsSjDhUn6qK8Dw-1; Mon, 15 Nov 2021 02:55:38 -0500
X-MC-Unique: MPl6QiHxPsSjDhUn6qK8Dw-1
Received: by mail-pl1-f198.google.com with SMTP id v23-20020a170902bf9700b001421d86afc4so72057pls.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFYWOfIgh+R0pCCOGFbQusLursYsTaR7YBgSvw4x5lw=;
        b=axsAbS3TGyECeCyWjLrR0ZdRd+JPj2nZSqQC3dI2w0HOHV5T077LwbSrKeyB1uIE1J
         Adn37kaHphnP/13OQUJ3B89PdiB+Bq+qsiHWaD6mIoG+wW6pRI6sfvgKAxnLxeZOHBm5
         7B9JMkEx4aoeG+pyapSdTLr/1EfuhtSTNB09nYJCqN9dEF4C447fsrmL9xZujxvaT5oC
         BfzOB7euTW+T1Acf1S34Jc1LNgR6CjTWd8puB2h3lPvJf7i9IyyNxXFS7Xhhl0uRsE/j
         4JsfNRw9r5FBubX9AzMETAlBYo4Ac3dNJ50/UqNtM8/+WRgGGz7s/WmemOA58gknsWpW
         IhSA==
X-Gm-Message-State: AOAM533zzvWQQdL+kzqfsljwVf29LCKCJX0iBdA3G3R1fJ9EtLp9HKUE
        impGm47i5taZZZai7j/rO/4aIZypV5ywRKWciAgVKB6PgQhlBE1RSWD9zfXF4UA8DPOcgdVyolk
        moihEfDN99JGIijtAfmeiuGWw
X-Received: by 2002:a17:902:b716:b0:141:d36c:78fc with SMTP id d22-20020a170902b71600b00141d36c78fcmr32876783pls.59.1636962937636;
        Sun, 14 Nov 2021 23:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAd51rC565DmR4S0Px83qtaC3tncJfoqUkji9bNAdVboAcS0spgZmn9DtgCef8nGAYJErnow==
X-Received: by 2002:a17:902:b716:b0:141:d36c:78fc with SMTP id d22-20020a170902b71600b00141d36c78fcmr32876737pls.59.1636962937216;
        Sun, 14 Nov 2021 23:55:37 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.55.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:55:36 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v6 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Mon, 15 Nov 2021 15:54:59 +0800
Message-Id: <20211115075522.73795-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v6 of the series to add shmem+hugetlbfs support for userfaultfd write
protection.  It is based on v5.16-rc1 (fa55b7dcdc43), with below two patches
applied first:

  Subject: [PATCH RFC 0/2] mm: Rework zap ptes on swap entries
  https://lore.kernel.org/lkml/20211110082952.19266-1-peterx@redhat.com/

The whole tree can be found here for testing:

  https://github.com/xzpeter/linux/tree/uffd-wp-shmem-hugetlbfs

Previous versions:

  RFC: https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/
  v1:  https://lore.kernel.org/lkml/20210323004912.35132-1-peterx@redhat.com/
  v2:  https://lore.kernel.org/lkml/20210427161317.50682-1-peterx@redhat.com/
  v3:  https://lore.kernel.org/lkml/20210527201927.29586-1-peterx@redhat.com/
  v4:  https://lore.kernel.org/lkml/20210714222117.47648-1-peterx@redhat.com/
  v5:  https://lore.kernel.org/lkml/20210715201422.211004-1-peterx@redhat.com/

Overview
==================

This is the first version of this work to rebase the uffd-wp logic work upon
PTE markers.  The major logic will be the same as v5, but since there're quite
a few minor changes here and there, I decided to not provide a change log at
all as it'll stop to be helpful.  However I should have addressed all the
comments that were raised by reviewers, please shoot if I missed something.  I
still kept many of the Mike's Review-By tag when there's merely no change to
the patch content (I touched up quite a few commit messages), but it'll be nice
if Mike could still went over the patches even if there're R-bs standing.

PTE marker is a new type of swap entry that is ony applicable to file-backed
memories like shmem and hugetlbfs.  It's used to persist some pte-level
information even if the original present ptes in pgtable are zapped.  These
information could be one of:

  (1) Userfaultfd wr-protect information
  (2) PTE soft-dirty information
  (3) Or others

This series only uses the marker to store uffd-wp information across temporary
zappings of shmem/hugetlbfs pgtables, for example, when a shmem thp is split.
So even if ptes are temporarily zapped, the wr-protect information can still be
kept within the pgtables.  Then when the page fault triggers again, we'll know
this pte is wr-protected so we can treat the pte the same as a normal uffd
wr-protected pte.

The extra information is encoded into the swap entry, or swp_offset to be
explicit, with the swp_type being PTE_MARKER.  So far uffd-wp only uses one bit
out of the swap entry, the rest bits of swp_offset are still reserved for other
purposes.

There're two configs to enable/disable PTE markers:

  CONFIG_PTE_MARKER
  CONFIG_PTE_MARKER_UFFD_WP

We can set !PTE_MARKER to completely disable all the PTE markers, along with
uffd-wp support.  I made two config so we can also enable PTE marker but
disable uffd-wp file-backed for other purposes.  At the end of current series,
I'll enable CONFIG_PTE_MARKER by default, but that patch is standalone and if
anyone worries about having it by default, we can also consider turn it off by
dropping that oneliner patch.  So far I don't see a huge risk of doing so, so I
kept that patch.

In most cases, PTE markers should be treated as none ptes.  It is because that
unlike most of the other swap entry types, there's no PFN or block offset
information encoded into PTE markers but some extra well-defined bits showing
the status of the pte.  These bits should only be used as extra data when
servicing an upcoming page fault, and that should be it.

I did spend a lot of time observing all the pte_none() users this time. It is
indeed a challenge because there're a lot, and I hope I didn't miss a single of
them when we should take care of pte markers.  Luckily, I don't think it'll
need to be considered in many cases, for example: boot code, arch code
(especially non-x86), kernel-only page handlings (e.g. CPA), or device driver
codes when we're tackling with pure PFN mappings.

I introduced pte_none_mostly() in this series when we need to handle pte
markers the same as none pte, the "mostly" is the other way to write "either
none pte or a pte marker".

I didn't replace pte_none() to cover pte markers for below reasons:

  - Very rare case of pte_none() callers will handle pte markers.  E.g., all
    the kernel pages do not require knowledge of pte markers.  So we don't
    pollute the major use cases.

  - Unconditionally change pte_none() semantics could confuse people, because
    pte_none() existed for so long a time.

  - Unconditionally change pte_none() semantics could make pte_none() slower
    even if in many cases pte markers do not exist.

  - There're cases where we'd like to handle pte markers differntly from
    pte_none(), so a full replace is also impossible.  E.g. khugepaged should
    still treat pte markers as normal swap ptes rather than none ptes, because
    pte markers will always need a fault-in to merge the marker with a valid
    pte.  Or the smap code will need to parse PTE markers not none ptes.

Patch Layout
============

Introducing PTE marker and uffd-wp bit in PTE marker:

  mm: Introduce PTE_MARKER swap entry
  mm: Teach core mm about pte markers
  mm: Check against orig_pte for finish_fault()
  mm/uffd: PTE_MARKER_UFFD_WP

Adding support for shmem uffd-wp:

  mm/shmem: Take care of UFFDIO_COPY_MODE_WP
  mm/shmem: Handle uffd-wp special pte in page fault handler
  mm/shmem: Persist uffd-wp bit across zapping for file-backed
  mm/shmem: Allow uffd wr-protect none pte for file-backed mem
  mm/shmem: Allows file-back mem to be uffd wr-protected on thps
  mm/shmem: Handle uffd-wp during fork()

Adding support for hugetlbfs uffd-wp:

  mm/hugetlb: Introduce huge pte version of uffd-wp helpers
  mm/hugetlb: Hook page faults for uffd write protection
  mm/hugetlb: Take care of UFFDIO_COPY_MODE_WP
  mm/hugetlb: Handle UFFDIO_WRITEPROTECT
  mm/hugetlb: Handle pte markers in page faults
  mm/hugetlb: Allow uffd wr-protect none ptes
  mm/hugetlb: Only drop uffd-wp special pte if required
  mm/hugetlb: Handle uffd-wp during fork()

Misc handling on the rest mm for uffd-wp file-backed:

  mm/khugepaged: Don't recycle vma pgtable if uffd-wp registered
  mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs

Enabling of uffd-wp on file-backed memory:

  mm/uffd: Enable write protection for shmem & hugetlbfs
  mm: Enable PTE markers by default
  selftests/uffd: Enable uffd-wp for shmem/hugetlbfs

Tests
==============

- x86_64
  - Compile tested on:
    - PTE_MARKER && PTE_MARKER_UFFD_WP,
    - PTE_MARKER && !PTE_MARKER_UFFD_WP,
    - !PTE_MARKER
    - !USERFAULTFD
  - Kernel userfaultfd selftests for shmem/hugetlb/hugetlb_shared
  - Umapsort [1,2] test for shmem/hugetlb, with swap on/off
- aarch64
  - Compile and smoke tested with !PTE_MARKER

[1] https://github.com/xzpeter/umap-apps/tree/peter
[2] https://github.com/xzpeter/umap/tree/peter-shmem-hugetlbfs

Peter Xu (23):
  mm: Introduce PTE_MARKER swap entry
  mm: Teach core mm about pte markers
  mm: Check against orig_pte for finish_fault()
  mm/uffd: PTE_MARKER_UFFD_WP
  mm/shmem: Take care of UFFDIO_COPY_MODE_WP
  mm/shmem: Handle uffd-wp special pte in page fault handler
  mm/shmem: Persist uffd-wp bit across zapping for file-backed
  mm/shmem: Allow uffd wr-protect none pte for file-backed mem
  mm/shmem: Allows file-back mem to be uffd wr-protected on thps
  mm/shmem: Handle uffd-wp during fork()
  mm/hugetlb: Introduce huge pte version of uffd-wp helpers
  mm/hugetlb: Hook page faults for uffd write protection
  mm/hugetlb: Take care of UFFDIO_COPY_MODE_WP
  mm/hugetlb: Handle UFFDIO_WRITEPROTECT
  mm/hugetlb: Handle pte markers in page faults
  mm/hugetlb: Allow uffd wr-protect none ptes
  mm/hugetlb: Only drop uffd-wp special pte if required
  mm/hugetlb: Handle uffd-wp during fork()
  mm/khugepaged: Don't recycle vma pgtable if uffd-wp registered
  mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
  mm/uffd: Enable write protection for shmem & hugetlbfs
  mm: Enable PTE markers by default
  selftests/uffd: Enable uffd-wp for shmem/hugetlbfs

 arch/s390/include/asm/hugetlb.h          |  15 ++
 fs/hugetlbfs/inode.c                     |  15 +-
 fs/proc/task_mmu.c                       |  11 ++
 fs/userfaultfd.c                         |  31 +---
 include/asm-generic/hugetlb.h            |  24 +++
 include/linux/hugetlb.h                  |  27 ++--
 include/linux/mm.h                       |  20 +++
 include/linux/mm_inline.h                |  45 ++++++
 include/linux/shmem_fs.h                 |   4 +-
 include/linux/swap.h                     |  15 +-
 include/linux/swapops.h                  |  79 ++++++++++
 include/linux/userfaultfd_k.h            |  67 +++++++++
 include/uapi/linux/userfaultfd.h         |  10 +-
 mm/Kconfig                               |  16 ++
 mm/filemap.c                             |   5 +
 mm/hmm.c                                 |   2 +-
 mm/hugetlb.c                             | 181 +++++++++++++++++-----
 mm/khugepaged.c                          |  14 +-
 mm/memcontrol.c                          |   8 +-
 mm/memory.c                              | 184 ++++++++++++++++++++---
 mm/mincore.c                             |   3 +-
 mm/mprotect.c                            |  76 +++++++++-
 mm/rmap.c                                |   8 +
 mm/shmem.c                               |   4 +-
 mm/userfaultfd.c                         |  61 +++++---
 tools/testing/selftests/vm/userfaultfd.c |   4 +-
 26 files changed, 798 insertions(+), 131 deletions(-)

-- 
2.32.0

