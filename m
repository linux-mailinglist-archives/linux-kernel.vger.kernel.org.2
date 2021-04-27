Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7C36C920
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhD0QTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237516AbhD0QOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TTUZmZlysPQmfImZFfZ2Wgp7vh1kYkUqotHTouR6XKE=;
        b=M5EPzUxoDmNACLux2gCdKMXV835+OT76FfmL5tBj2dKHPLPqnH4CAkEUY7C9jasTXBKOmO
        ERro5GZTmZ487HGs/rHYfq1Kta9H7x5oNI+0JEwPCtNCeGxRYa9E5Sr880RT+g3jCB9Fdq
        xpMwZEEVHTPWXkvvcIr7ZEKDMGj/G7Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-ZZeAZA_6OHGqzF39Ps4o1w-1; Tue, 27 Apr 2021 12:13:21 -0400
X-MC-Unique: ZZeAZA_6OHGqzF39Ps4o1w-1
Received: by mail-qv1-f71.google.com with SMTP id p2-20020ad452e20000b0290177fba4b9d5so26199129qvu.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTUZmZlysPQmfImZFfZ2Wgp7vh1kYkUqotHTouR6XKE=;
        b=cMNbY7yCX+rxuMd0sYTUIWRyQHZUdpV77Zs5phldYc6eZYj0ViWRhiwuytESF7pnll
         AuF1zfssOgGf+LU7BBqUrSm6EMxJ7LCaqJ8jNVNyLCmdzNXXhifTYFWDG3J8gXSUGIYz
         jF9zImIFourJ3iNa9bJQfhlHKvEcL0pm35ZnXySzrdIpbTqwinBqhheVoTe0++KDnj0B
         7kj12NpxU8QyM1gUBUH0nl9fLPqX3aOzzcOi99gDboeCCaqOhby48En52HUWrG9iRhUy
         rBlocbwfbYzLi4kpkse4PVjkq3MjzdoicLEv2RIyy901Ym2Ohw2ertbt3//C5VcDse7T
         pgWw==
X-Gm-Message-State: AOAM532jM2ydlHHabQh5nqm1f1nL4TlXrmo6RbgzO2f7zrErarQ+F0y9
        NaAZdprLzx0XfG/iGxMaS3xtYX4kH+uRvwRFORa/lCaRc1na+hCpniRCp5c20L4ncnj1nxFQ646
        9uB3G8uysXGoAaB8z6RpFwwQQ
X-Received: by 2002:a37:a1c9:: with SMTP id k192mr23683185qke.169.1619540000197;
        Tue, 27 Apr 2021 09:13:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSEuXfr5EdC22VCGUNbURreOwpVuLnyHWGn2DHfr0rUs32K/lK1rKowH6nHjPWtW6P9DpUrg==
X-Received: by 2002:a37:a1c9:: with SMTP id k192mr23683136qke.169.1619539999670;
        Tue, 27 Apr 2021 09:13:19 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 00/24] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Tue, 27 Apr 2021 12:12:53 -0400
Message-Id: <20210427161317.50682-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as=
 a=0D
kernel full feature, as it only supports anonymous before this series.=0D
=0D
This patchset is based mostly on tag v5.12-rc8-mmots-2021-04-21-23-08, howe=
ver=0D
I dropped some patches there otherwise I'll get some weird build errors.  I=
=0D
think I should have kept most of the -mm-next materials, so hopefully when=
=0D
Andrew gets a new -mm tree, this series can be applied cleanly upon it.  I'=
ll=0D
respin otherwise.=0D
=0D
The whole series can also be found online [1].=0D
=0D
The major change from v1->v2 is that I dropped the FAULT_FLAG_UFFD_WP flag =
in=0D
previous v1, as I think it's not needed and checking of the flag:=0D
=0D
  vmf->flags & FAULT_FLAG_UFFD_WP=0D
=0D
Can be replaced safely by:=0D
=0D
  pte_swp_uffd_wp_special(vmf->orig_pte)=0D
=0D
So we don't need to introduce yet another flag, and the code actually even=
=0D
shrinked a few more lines, which is good.=0D
=0D
Also per discussion with Mike, I dropped the READ emulation when a thread=0D
faulted on a uffd-wp special swap pte, as I'll keep the WRITE fault as is i=
n=0D
this series.=0D
=0D
Nothing big really changed otherwise.  Full changelog listed below.=0D
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
  mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h=0D
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
Peter Xu (24):=0D
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
 fs/userfaultfd.c                         |  39 ++--=0D
 include/asm-generic/hugetlb.h            |  10 +=0D
 include/asm-generic/pgtable_uffd.h       |   3 +=0D
 include/linux/hugetlb.h                  |  30 ++-=0D
 include/linux/mm.h                       |  48 ++++-=0D
 include/linux/mm_inline.h                |  43 +++++=0D
 include/linux/shmem_fs.h                 |   5 +-=0D
 include/linux/swapops.h                  |  39 +++-=0D
 include/linux/userfaultfd_k.h            |  47 +++++=0D
 include/uapi/linux/userfaultfd.h         |   7 +-=0D
 mm/gup.c                                 |   2 +-=0D
 mm/hmm.c                                 |   2 +-=0D
 mm/hugetlb.c                             | 160 +++++++++++++---=0D
 mm/khugepaged.c                          |  14 +-=0D
 mm/madvise.c                             |   4 +-=0D
 mm/memcontrol.c                          |   2 +-=0D
 mm/memory.c                              | 226 +++++++++++++++++------=0D
 mm/migrate.c                             |   4 +-=0D
 mm/mincore.c                             |   2 +-=0D
 mm/mprotect.c                            |  63 ++++++-=0D
 mm/mremap.c                              |   2 +-=0D
 mm/page_vma_mapped.c                     |   6 +-=0D
 mm/rmap.c                                |   8 +=0D
 mm/shmem.c                               |  40 +++-=0D
 mm/swapfile.c                            |   2 +-=0D
 mm/truncate.c                            |  17 +-=0D
 mm/userfaultfd.c                         |  37 ++--=0D
 tools/testing/selftests/vm/userfaultfd.c |   9 +-=0D
 33 files changed, 753 insertions(+), 187 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

