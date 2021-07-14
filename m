Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4D3C93B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhGNWY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236645AbhGNWYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V4R8I/q91LOV3HLpNvx88Udmhuap5qU40k5RD7ZAgHU=;
        b=XNp2Thv47W4J9kjd+9uuRq7826kD9JuO7Xk2kAihJ3axluJU5vpYfGKESHzA4/SFo8BPqa
        I+oOPpDexnCMNVlWtQJ7RICHHM74RH7y7VnF/cRIFyVKMleAQcwzz1db2nHFbTJwz9LSsS
        OhD4cEPZsptFwgXDMHNwOkcnjiaGkAw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-A9xR6lrHNT--oMCYB53vsA-1; Wed, 14 Jul 2021 18:21:22 -0400
X-MC-Unique: A9xR6lrHNT--oMCYB53vsA-1
Received: by mail-qk1-f199.google.com with SMTP id w16-20020a05620a4450b02903b88832b7cfso2321650qkp.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4R8I/q91LOV3HLpNvx88Udmhuap5qU40k5RD7ZAgHU=;
        b=LEYaoLSdkQeIau+GuGxcxeBytkQf6gq5V6OT61Xq90X1I6zYKM4Q9VMbl20vTXn8QB
         +x3ZmAT5cKJ7wcrbHvFEV7WxPuhv5NGjGcpmAbGWGJbHxzwGeJaoekuJO3ZO99ZC9kNx
         gXzeRgdu8//MCboABpyecm7BSub0JYeJKv/NV143Vzin9JG49MlpCt6k1q79QloyCCss
         ibq0LDwu25xZYnbkAHgGtPqs/TKLqf96NIveROkbd84QY6DVQ5xxczSTqMkXHKmAZqLJ
         1Z6SfoDF5Zo44ZLb9B40NjYHlOpLUcoXx5VGPaNvpcqpKQycevOKnna+3xnHAzEHuTNJ
         wemw==
X-Gm-Message-State: AOAM530OUZ/oREEgz6j6k4WwyEYputhk5QMxBgln26XgSX809kmUuJnT
        8QFICkoTiFE+4RUPzgH7kAPq3B0+UA9WdzbxX0bFlzb6McDUXJk+rDSynhdzmQuFv2BQsoaTkww
        cdbWvPXPoW75opPPs+R8GVSqht9S/N8c6UaoZbNdIGbyuVTQM6mz6vzmuEJ+FLgPBXnpObLjOYA
        ==
X-Received: by 2002:ac8:4e89:: with SMTP id 9mr322477qtp.356.1626301281149;
        Wed, 14 Jul 2021 15:21:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQoMZ0U8D/9+CTlVJ/rWsoHPblkvBTUeopDbqOvpymZ9KQKLGEvyXv/jj4z28On3rUNcdv/A==
X-Received: by 2002:ac8:4e89:: with SMTP id 9mr322429qtp.356.1626301280750;
        Wed, 14 Jul 2021 15:21:20 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 00/26] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Wed, 14 Jul 2021 18:20:51 -0400
Message-Id: <20210714222117.47648-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as=
 a=0D
full feature.  It's based on v5.14-rc1.=0D
=0D
The whole series can also be found online [1].  Nothing big really changed =
from=0D
previous version.=0D
=0D
One thing worth mentioning is in commit 22061a1ffabd we added a new single_=
page=0D
parameter to zap_details from Hugh, then a few zap related patches need som=
e=0D
rebase around it.  There's also the new unmap_mapping_page() introduced, in=
=0D
this series it will start to run with zap flag ZAP_FLAG_DROP_FILE_UFFD_WP, =
as=0D
this function is used as the last phase to unmap shmem mappings when page b=
eing=0D
e.g. truncated.  It actually even simplified a bit as I can drop the patch =
"mm:=0D
Pass zap_flags into unmap_mapping_pages()" now.=0D
=0D
Another thing to mention is I further modified (trivially) the test program=
=0D
umap-apps [4] to allow backend storage to be run on a shmem file (it used t=
o be=0D
a e.g. XFS file, however as I noticed disk latency is a major bottleneck of=
=0D
umapsort program especially when it's a HDD, shmem backend is much faster).=
=0D
This should stress the kernel a bit more than before.=0D
=0D
Full changelog listed below.=0D
=0D
v4:=0D
- Rebased to v5.14-rc1=0D
- Collect r-b for Alistair=0D
- Patch "mm/userfaultfd: Introduce special pte for unmapped file-backed mem=
"=0D
  - make pte_swp_uffd_wp_special() return false for !HAVE_ARCH_USERFAULTFD_=
WP=0D
    [Alistair]=0D
- Patch "mm: Introduce zap_details.zap_flags"=0D
  - Rename zap_check_mapping_skip to zap_skip_check_mapping [Alistair]=0D
- Patch "mm: Pass zap_flags into unmap_mapping_pages()"=0D
  - Dropped the patch because after commit 22061a1ffabd it's not needed any=
more.=0D
- Patch "mm/userfaultfd: Enable write protection for shmem & hugetlbfs"=0D
  - Drop UFFD_FEATURE_WP_HUGETLBFS_SHMEM too if !CONFIG_HAVE_ARCH_USERFAULT=
FD_WP=0D
- Patch "shmem/userfaultfd: Persist uffd-wp bit across zapping for file-bac=
ked":=0D
  - Convert zap_pte_range() of device private to WARN_ON_ONCE() because it =
must=0D
    not be a file-backed pte [Alistair]=0D
  - Coordinate with new commit 22061a1ffabd ("mm/thp: unmap_mapping_page() =
to=0D
    fix THP truncate_cleanup_page()"), add ZAP_FLAG_CHECK_MAPPING for new=0D
    function unmap_mapping_page().=0D
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
[2] https://github.com/xzpeter/umap-apps/tree/peter=0D
[3] https://github.com/xzpeter/umap/tree/peter-shmem-hugetlbfs=0D
[4] https://github.com/xzpeter/umap-apps/commit/b0c2c7b1cd9dcb6835e7c59d02e=
ce1f6b7f1ea01=0D
=0D
Peter Xu (26):=0D
  mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte=0D
  shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  mm: Clear vmf->pte after pte_unmap_same() returns=0D
  mm/userfaultfd: Introduce special pte for unmapped file-backed mem=0D
  mm/swap: Introduce the idea of special swap ptes=0D
  shmem/userfaultfd: Handle uffd-wp special pte in page fault handler=0D
  mm: Drop first_index/last_index in zap_details=0D
  mm: Introduce zap_details.zap_flags=0D
  mm: Introduce ZAP_FLAG_SKIP_SWAP=0D
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
 fs/hugetlbfs/inode.c                     |  15 +-=0D
 fs/proc/task_mmu.c                       |  21 +-=0D
 fs/userfaultfd.c                         |  41 ++--=0D
 include/asm-generic/hugetlb.h            |  15 ++=0D
 include/asm-generic/pgtable_uffd.h       |   3 +=0D
 include/linux/hugetlb.h                  |  30 ++-=0D
 include/linux/mm.h                       |  44 +++-=0D
 include/linux/mm_inline.h                |  42 ++++=0D
 include/linux/shmem_fs.h                 |   4 +-=0D
 include/linux/swapops.h                  |  39 +++-=0D
 include/linux/userfaultfd_k.h            |  49 +++++=0D
 include/uapi/linux/userfaultfd.h         |  10 +-=0D
 mm/gup.c                                 |   2 +-=0D
 mm/hmm.c                                 |   2 +-=0D
 mm/hugetlb.c                             | 160 ++++++++++++---=0D
 mm/khugepaged.c                          |  11 +-=0D
 mm/madvise.c                             |   4 +-=0D
 mm/memcontrol.c                          |   2 +-=0D
 mm/memory.c                              | 244 +++++++++++++++++------=0D
 mm/migrate.c                             |   4 +-=0D
 mm/mincore.c                             |   2 +-=0D
 mm/mprotect.c                            |  63 +++++-=0D
 mm/mremap.c                              |   2 +-=0D
 mm/page_vma_mapped.c                     |   6 +-=0D
 mm/rmap.c                                |   8 +=0D
 mm/shmem.c                               |   5 +-=0D
 mm/swapfile.c                            |   2 +-=0D
 mm/userfaultfd.c                         |  73 +++++--=0D
 tools/testing/selftests/vm/userfaultfd.c |   9 +-=0D
 31 files changed, 756 insertions(+), 186 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

