Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451E7345423
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCWAto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhCWAtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rvoI1qdKEfspGJCPdlDFMoYFs7ZhJOMq3uHtD+HwICI=;
        b=PvUs67D/eIlMNPec54lCeDJA588g0+8WkDUGTI+caVbj5q8aZqcA2HR6Jm9671c99Oq5Xm
        HaJJOVfu+M5a7gyHrZ5+eBbarzaPvUtHxhE1SJkHGyvlHfMrxouIusPFyfvWCptb/hj2c8
        cVTjXlqz2U73oyIrcHJRue+aYKR3vME=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-5d3N0CirOe6qtaPtdwSBFQ-1; Mon, 22 Mar 2021 20:49:17 -0400
X-MC-Unique: 5d3N0CirOe6qtaPtdwSBFQ-1
Received: by mail-qv1-f70.google.com with SMTP id bt20so578163qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvoI1qdKEfspGJCPdlDFMoYFs7ZhJOMq3uHtD+HwICI=;
        b=PUgbGEyLlNqqVMf9XTq6kUdqq0RJ1T/N0hzhraEp/3DjTqHwUd9vMZlz71AuX6VAwj
         N3g+qK/ChD257N0ab6YJ/aB97Z9lqNrc06rd4SZ4RdGd2YJ47l8svRnv6tkP/54b25YN
         vFggi9I3EC0+3ObRhgRcuFuA9aL0m95I298LBHNOudHnx8+DypMdin8H8/pTo4AwRV3Y
         fpZ4SKrOGLcp1KzArB/O5iNlLfFX8GJ3vC9nmwP5HaO9UJltD6ebqWW88DaIrVK22Utq
         8p9/JI22c/rOrBkmgy0af5aA4XrTNR7/PYzqSZNL89Hb4ejiWzZ1ltGk/xSt48d4oGIU
         or8Q==
X-Gm-Message-State: AOAM533eRR51VU2k5Nk94pCdxKOSJEDlJ1FCJDtoQj2lmqdiGSDiwmhc
        YrLoh2XdfHuPd8oAvKfvexG0X5JHFT9Hzn9u7qIn/FeAE/NAPyI32FOIdo3MT1VvBPARiW0ebL1
        cPWVrvI4/Y6olTlg8TMjb1Ky74qFS6pTOTX0HM/AMBk4+hhyen+KIK0IcGO6AtD5buJA274Obqw
        ==
X-Received: by 2002:ac8:6f2e:: with SMTP id i14mr2339162qtv.277.1616460556043;
        Mon, 22 Mar 2021 17:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa8nFhBKigj+cy7jQp1pDPBmbwrf4XYyXLlKuRA437qcGajMfEx+HTBlRrPU7LH8eL0xJKww==
X-Received: by 2002:ac8:6f2e:: with SMTP id i14mr2339127qtv.277.1616460555441;
        Mon, 22 Mar 2021 17:49:15 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Mon, 22 Mar 2021 20:48:49 -0400
Message-Id: <20210323004912.35132-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on tag v5.12-rc3-mmots-2021-03-17-22-26.  To run the=
=0D
selftest, need to apply the two patches to fix minor mode page leak:=0D
=0D
https://lore.kernel.org/lkml/20210322175132.36659-1-peterx@redhat.com/=0D
https://lore.kernel.org/lkml/20210322204836.1650221-1-axelrasmussen@google.=
com/=0D
=0D
Since I didn't get any NACK in the previous RFC series for months, I decide=
d to=0D
remove the RFC tag starting from this version, so this is v1 of uffd-wp sup=
port=0D
on shmem & hugetlb.=0D
=0D
The whole series can also be found online [1].=0D
=0D
The major comment I'd like to get is on the new idea of swap special pte.  =
That=0D
comes from suggestions from both Hugh and Andrea and I appreciated a lot fo=
r=0D
those discussions.=0D
=0D
In short, the so-called "swap special pte" in this patchset is a new type o=
f=0D
pte that doesn't exist in the past, but it got used initially in this serie=
s in=0D
file-backed memories.  It is used to persist information even if the ptes g=
ot=0D
dropped meanwhile when the page cache still existed.  For example, when=0D
splitting a file-backed huge pmd, we could be simply dropping the pmd entry=
=0D
then wait until another fault coming.  It's okay in the past since all=0D
information in the pte can be retained from the page cache when the next pa=
ge=0D
fault triggers.  However in this case, uffd-wp is per-pte information which=
=0D
cannot be kept in page cache, so that information needs to be maintained=0D
somehow still in the pgtable entry, even if the pgtable entry is going to b=
e=0D
dropped.  Here instead of replacing with a none entry, we used the "swap=0D
special pte".  Then when the next page fault triggers, we can observe orig_=
pte=0D
to retain this information.=0D
=0D
I'm copy-pasting some commit message from the patch "mm/swap: Introduce the=
=0D
idea of special swap ptes", where it tried to explain this pte in another a=
ngle:=0D
=0D
    We used to have special swap entries, like migration entries, hw-poison=
=0D
    entries, device private entries, etc.=0D
=0D
    Those "special swap entries" reside in the range that they need to be a=
t least=0D
    swap entries first, and their types are decided by swp_type(entry).=0D
=0D
    This patch introduces another idea called "special swap ptes".=0D
=0D
    It's very easy to get confused against "special swap entries", but a sp=
eical=0D
    swap pte should never contain a swap entry at all.  It means, it's ille=
gal to=0D
    call pte_to_swp_entry() upon a special swap pte.=0D
=0D
    Make the uffd-wp special pte to be the first special swap pte.=0D
=0D
    Before this patch, is_swap_pte()=3D=3Dtrue means one of the below:=0D
=0D
       (a.1) The pte has a normal swap entry (non_swap_entry()=3D=3Dfalse).=
  For=0D
             example, when an anonymous page got swapped out.=0D
=0D
       (a.2) The pte has a special swap entry (non_swap_entry()=3D=3Dtrue).=
  For=0D
             example, a migration entry, a hw-poison entry, etc.=0D
=0D
    After this patch, is_swap_pte()=3D=3Dtrue means one of the below, where=
 case (b) is=0D
    added:=0D
=0D
     (a) The pte contains a swap entry.=0D
=0D
       (a.1) The pte has a normal swap entry (non_swap_entry()=3D=3Dfalse).=
  For=0D
             example, when an anonymous page got swapped out.=0D
=0D
       (a.2) The pte has a special swap entry (non_swap_entry()=3D=3Dtrue).=
  For=0D
             example, a migration entry, a hw-poison entry, etc.=0D
=0D
     (b) The pte does not contain a swap entry at all (so it cannot be pass=
ed=0D
         into pte_to_swp_entry()).  For example, uffd-wp special swap pte.=
=0D
=0D
Hugetlbfs needs similar thing because it's also file-backed.  I directly re=
used=0D
the same special pte there, though the shmem/hugetlb change on supporting t=
his=0D
new pte is different since they don't share code path a lot.=0D
=0D
Patch layout=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
Part (1): Shmem support, this is where the special swap pte is introduced.=
=0D
Some zap rework is needed within the process:=0D
=0D
  shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  mm: Clear vmf->pte after pte_unmap_same() returns=0D
  mm/userfaultfd: Introduce special pte for unmapped file-backed mem=0D
  mm/swap: Introduce the idea of special swap ptes=0D
  shmem/userfaultfd: Handle uffd-wp special pte in page fault handler=0D
  mm: Drop first_index/last_index in zap_details=0D
  mm: Introduce zap_details.zap_flags=0D
  mm: Introduce ZAP_FLAG_SKIP_SWAP=0D
  mm: Pass zap_flags into unmap_mapping_pages()=0D
  shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed=0D
  shmem/userfaultfd: Allow wr-protect none pte for file-backed mem=0D
  shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps=0D
  shmem/userfaultfd: Handle the left-overed special swap ptes=0D
  shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()=0D
=0D
Part (2): Hugetlb support, we need to disable huge pmd sharing for uffd-wp=
=0D
because not compatible just like uffd minor mode.  The rest is the changes=
=0D
required to teach hugetlbfs understand the special swap pte too that introd=
uced=0D
with the uffd-wp change:=0D
=0D
  hugetlb/userfaultfd: Hook page faults for uffd write protection=0D
  hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT=0D
  hugetlb: Pass vma into huge_pte_alloc()=0D
  hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled=0D
  mm/hugetlb: Introduce huge version of special swap pte helpers=0D
  mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h=0D
  hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp=0D
  hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler=0D
  hugetlb/userfaultfd: Allow wr-protect none ptes=0D
  hugetlb/userfaultfd: Only drop uffd-wp special pte if required=0D
=0D
Part (3): Enable both features in code and test=0D
=0D
  userfaultfd: Enable write protection for shmem & hugetlbfs=0D
  userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs=0D
=0D
Tests=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
I've tested it using either userfaultfd kselftest program, but also with=0D
umapsort [2] which should be even stricter.  Tested page swapping in/out du=
ring=0D
umapsort.=0D
=0D
If anyone would like to try umapsort, need to use an extremely hacked versi=
on=0D
of umap library [3], because by default umap only supports anonymous.  So t=
o=0D
test it we need to build [3] then [2].=0D
=0D
Any comment would be greatly welcomed.  Thanks,=0D
=0D
[1] https://github.com/xzpeter/linux/tree/uffd-wp-shmem-hugetlbfs=0D
[2] https://github.com/LLNL/umap-apps=0D
[3] https://github.com/xzpeter/umap/tree/peter-shmem-hugetlbfs=0D
=0D
Peter Xu (23):=0D
  shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  mm: Clear vmf->pte after pte_unmap_same() returns=0D
  mm/userfaultfd: Introduce special pte for unmapped file-backed mem=0D
  mm/swap: Introduce the idea of special swap ptes=0D
  shmem/userfaultfd: Handle uffd-wp special pte in page fault handler=0D
  mm: Drop first_index/last_index in zap_details=0D
  mm: Introduce zap_details.zap_flags=0D
  mm: Introduce ZAP_FLAG_SKIP_SWAP=0D
  mm: Pass zap_flags into unmap_mapping_pages()=0D
  shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed=0D
  shmem/userfaultfd: Allow wr-protect none pte for file-backed mem=0D
  shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on=0D
    thps=0D
  shmem/userfaultfd: Handle the left-overed special swap ptes=0D
  shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()=0D
  hugetlb/userfaultfd: Hook page faults for uffd write protection=0D
  hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT=0D
  mm/hugetlb: Introduce huge version of special swap pte helpers=0D
  hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler=0D
  hugetlb/userfaultfd: Allow wr-protect none ptes=0D
  hugetlb/userfaultfd: Only drop uffd-wp special pte if required=0D
  mm/userfaultfd: Enable write protection for shmem & hugetlbfs=0D
  userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs=0D
=0D
 arch/arm64/kernel/mte.c                  |   2 +-=0D
 arch/x86/include/asm/pgtable.h           |  28 +++=0D
 fs/dax.c                                 |  10 +-=0D
 fs/hugetlbfs/inode.c                     |  15 +-=0D
 fs/proc/task_mmu.c                       |  14 +-=0D
 fs/userfaultfd.c                         |  38 ++--=0D
 include/asm-generic/hugetlb.h            |  10 +=0D
 include/asm-generic/pgtable_uffd.h       |   3 +=0D
 include/linux/hugetlb.h                  |  25 ++-=0D
 include/linux/mm.h                       |  50 ++++-=0D
 include/linux/mm_inline.h                |  43 ++++=0D
 include/linux/shmem_fs.h                 |   5 +-=0D
 include/linux/swapops.h                  |  39 +++-=0D
 include/linux/userfaultfd_k.h            |  46 +++++=0D
 include/uapi/linux/userfaultfd.h         |   7 +-=0D
 mm/gup.c                                 |   2 +-=0D
 mm/hmm.c                                 |   2 +-=0D
 mm/hugetlb.c                             | 167 ++++++++++++---=0D
 mm/khugepaged.c                          |  14 +-=0D
 mm/madvise.c                             |   4 +-=0D
 mm/memcontrol.c                          |   2 +-=0D
 mm/memory.c                              | 249 ++++++++++++++++++-----=0D
 mm/migrate.c                             |   4 +-=0D
 mm/mincore.c                             |   2 +-=0D
 mm/mprotect.c                            |  63 +++++-=0D
 mm/mremap.c                              |   2 +-=0D
 mm/page_vma_mapped.c                     |   6 +-=0D
 mm/rmap.c                                |   8 +=0D
 mm/shmem.c                               |  31 ++-=0D
 mm/swapfile.c                            |   2 +-=0D
 mm/truncate.c                            |  17 +-=0D
 mm/userfaultfd.c                         |  37 ++--=0D
 tools/testing/selftests/vm/userfaultfd.c |   9 +-=0D
 33 files changed, 776 insertions(+), 180 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

