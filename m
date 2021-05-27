Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E73936F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhE0UVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhE0UVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T6ZvkDZs1JkPtyt2pxdaGgFzkC14Kk0ZcOFtmuLLQh4=;
        b=XFqy9HG604mYWD+4vWCGjV10TBiaZ6LniV0g5zyzfV+P5hvP42PN0nnokPDCzlNrCqxih0
        KIgl4TtKPZ+4jKP++bySqE68d/iGTK9YBUsixZ5x6IjotydoPbK0h76EfxjQD9dKGjqj5Y
        u/1UCuTQCuE97gKZkV1viWqmApetmd8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-dm94zboSMyKHvRisKZLtdA-1; Thu, 27 May 2021 16:19:33 -0400
X-MC-Unique: dm94zboSMyKHvRisKZLtdA-1
Received: by mail-qv1-f71.google.com with SMTP id e2-20020ad442a20000b02901f3586a14easo925565qvr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6ZvkDZs1JkPtyt2pxdaGgFzkC14Kk0ZcOFtmuLLQh4=;
        b=N0AuxsN1b7Wh3kp6WD+8aBCsFZx2rmF/SaOEl+OoMcnTP/wbOwSi4jX2qYrPuf+OVz
         8yHtEDx0Y0yTJ9ICfB7N2HV04gbofNArsrmZ1Y3wiZnHJkCXISjF6Dts1cTbZZxkWqMs
         JQ++W54S3lD1ZFVj5EdFax+lqtGxoVFNFBmG7ADrXznnDnoca1GztG04BqfmJ0YBlHQG
         i/2Mn1haRHU0Ikn+VI3cIC9KdCZNF7xP/7cHJ2G8luzfeF8GnVbMcr9Jr/WeJmJnhOZ5
         BoULlYkNuUyTK8LmjEEynOqEXWzXHAeySYbn2YICdQejU/ZeiEvtXG3UJDQbzTTWaooP
         qddQ==
X-Gm-Message-State: AOAM532RmbN5cFQ0nZPCGCnvs42mnDuQM9+UmUQl0EVDIxFrkZwulULP
        h1TOuZBfumtsWNOtqa5ruhJ8cpiCsZEVaHJY0+MtSqshvWRPhz7zBHJyK5K9KLkIDgr7e7gvh/o
        7B9KHZS2DiKz/8YCDsXpberah6CBvzcimW2Al3GT7jL+tX94mENzA5UulYKQWunaaWxb50ml0TA
        ==
X-Received: by 2002:a05:620a:2282:: with SMTP id o2mr262422qkh.479.1622146772633;
        Thu, 27 May 2021 13:19:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5vkJmluZmZqoCYAIfl4ITJ1DrJDiNpaOWk8DAcYiQBB3XQAhcfS6UD1Ktlcgggk2jbwP+gw==
X-Received: by 2002:a05:620a:2282:: with SMTP id o2mr262371qkh.479.1622146772081;
        Thu, 27 May 2021 13:19:32 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u14sm2089536qkp.80.2021.05.27.13.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:19:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 00/27] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Thu, 27 May 2021 16:19:00 -0400
Message-Id: <20210527201927.29586-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as=
 a=0D
kernel full feature, as it only supports anonymous before this series.  It'=
s=0D
based on latest v5.13-rc3-mmots-2021-05-25-20-12.=0D
=0D
The rebase was probably the hardest one, as I encountered quite a few break=
age=0D
here and there within a few mmots tags.  But now after figuring out everyth=
ing=0D
(which does took time) it's settling.=0D
=0D
The whole series can also be found online [1].=0D
=0D
Nothing big really changed otherwise.  Full changelog listed below.=0D
=0D
v3:=0D
- Rebase to v5.13-rc3-mmots-2021-05-25-20-12=0D
- Fix commit message and comment for patch "shmem/userfaultfd: Handle uffd-=
wp=0D
  special pte in page fault handler", dropping all reference to FAULT_FLAG_=
UFFD_WP.=0D
- Reworked patch "shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP" afte=
r=0D
  Axel's refactoring on uffdio-copy/continue.=0D
- Added patch "mm/hugetlb: Introduce huge pte version of uffd-wp helpers", =
so=0D
  that huge pte helpers are introduced in one patch.  Also add huge_pte_uff=
d_wp=0D
  helper, which was missing previously.=0D
- Added patch: "mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs", to =
let=0D
  pagemap uffd-wp bit work for shmem/hugetlbfs=0D
- Added patch: "mm/shmem: Unconditionally set pte dirty in=0D
  mfill_atomic_install_pte", to clean up dirty bit together in uffdio-copy=
=0D
=0D
v2:=0D
- Add R-bs=0D
- Added patch "mm/hugetlb: Drop __unmap_hugepage_range definition from=0D
  hugetlb.h" as noticed/suggested by Mike Kravets=0D
- Fix commit message of patch "hugetlb/userfaultfd: Only drop uffd-wp speci=
al=0D
  pte if required" [MikeK]=0D
- Removing comments for fields in zap_details since they're either incorrec=
t or=0D
  not helping [Matthew]=0D
- Rephrase commit message in patch "hugetlb/userfaultfd: Take care of=0D
  UFFDIO_COPY_MODE_WP" to explain better on why set dirty bit for UFFDIO_CO=
PY=0D
  in hugetlbfs [MikeK]=0D
- Don't emulate READ for uffd-wp-special on both shmem & hugetlbfs.=0D
- Drop FAULT_FLAG_UFFD_WP flag, by checking vmf->orig_pte directly against=
=0D
  pte_swp_uffd_wp_special()=0D
- Fix race condition of page fault handling on uffd-wp-special [Mike]=0D
=0D
About Swap Special PTE=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
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
  mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte=0D
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
Part (2): Hugetlb supportdisable huge pmd sharing for uffd-wp patches have =
been=0D
merged.  The rest is the changes required to teach hugetlbfs understand the=
=0D
special swap pte too that introduced with the uffd-wp change:=0D
=0D
  mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h=0D
  mm/hugetlb: Introduce huge pte version of uffd-wp helpers=0D
  hugetlb/userfaultfd: Hook page faults for uffd write protection=0D
  hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT=0D
  mm/hugetlb: Introduce huge version of special swap pte helpers=0D
  hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler=0D
  hugetlb/userfaultfd: Allow wr-protect none ptes=0D
  hugetlb/userfaultfd: Only drop uffd-wp special pte if required=0D
=0D
Part (3): Enable both features in code and test (plus pagemap support)=0D
=0D
  mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs=0D
  userfaultfd: Enable write protection for shmem & hugetlbfs=0D
  userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs=0D
=0D
Tests=0D
=3D=3D=3D=3D=3D=0D
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
Peter Xu (27):=0D
  mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte=0D
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
  mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h=0D
  mm/hugetlb: Introduce huge pte version of uffd-wp helpers=0D
  hugetlb/userfaultfd: Hook page faults for uffd write protection=0D
  hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT=0D
  mm/hugetlb: Introduce huge version of special swap pte helpers=0D
  hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler=0D
  hugetlb/userfaultfd: Allow wr-protect none ptes=0D
  hugetlb/userfaultfd: Only drop uffd-wp special pte if required=0D
  mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs=0D
  mm/userfaultfd: Enable write protection for shmem & hugetlbfs=0D
  userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs=0D
=0D
 arch/arm64/kernel/mte.c                  |   2 +-=0D
 arch/x86/include/asm/pgtable.h           |  28 +++=0D
 fs/dax.c                                 |  10 +-=0D
 fs/hugetlbfs/inode.c                     |  15 +-=0D
 fs/proc/task_mmu.c                       |  21 +-=0D
 fs/userfaultfd.c                         |  38 ++--=0D
 include/asm-generic/hugetlb.h            |  15 ++=0D
 include/asm-generic/pgtable_uffd.h       |   3 +=0D
 include/linux/hugetlb.h                  |  30 ++-=0D
 include/linux/mm.h                       |  48 ++++-=0D
 include/linux/mm_inline.h                |  43 +++++=0D
 include/linux/shmem_fs.h                 |   4 +-=0D
 include/linux/swapops.h                  |  39 +++-=0D
 include/linux/userfaultfd_k.h            |  45 +++++=0D
 include/uapi/linux/userfaultfd.h         |  10 +-=0D
 mm/gup.c                                 |   2 +-=0D
 mm/hmm.c                                 |   2 +-=0D
 mm/hugetlb.c                             | 160 +++++++++++++---=0D
 mm/khugepaged.c                          |  14 +-=0D
 mm/madvise.c                             |   4 +-=0D
 mm/memcontrol.c                          |   2 +-=0D
 mm/memory.c                              | 234 +++++++++++++++++------=0D
 mm/migrate.c                             |   4 +-=0D
 mm/mincore.c                             |   2 +-=0D
 mm/mprotect.c                            |  63 +++++-=0D
 mm/mremap.c                              |   2 +-=0D
 mm/page_vma_mapped.c                     |   6 +-=0D
 mm/rmap.c                                |   8 +=0D
 mm/shmem.c                               |   5 +-=0D
 mm/swapfile.c                            |   2 +-=0D
 mm/truncate.c                            |  17 +-=0D
 mm/userfaultfd.c                         |  73 ++++---=0D
 tools/testing/selftests/vm/userfaultfd.c |   9 +-=0D
 33 files changed, 765 insertions(+), 195 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

