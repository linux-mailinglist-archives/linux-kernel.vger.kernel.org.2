Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD71F3CADA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbhGOURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240805AbhGOURZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bqwTshlhtuZxcBr6uL1w6ltcJoVFtNt75o8Eacpkod0=;
        b=gYQdKtW1hspskKzXRt6iYudu0ftzjHEVqkY1FZnaTBPRfDxNh6Ak1zCUDG1jaiM5yP0JKA
        f0rajp0fHsOE4gjAtvEBoEbx4K+3qvNCXlaJlk31Wh+8x6kvnY1eKDdrSaK+7BmdOBGRTp
        Wnw3asD9I2DNJoid7n+1/Z2o9PbM2iA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-8kyoiSnsOeOPsgTMIPWhQA-1; Thu, 15 Jul 2021 16:14:27 -0400
X-MC-Unique: 8kyoiSnsOeOPsgTMIPWhQA-1
Received: by mail-qk1-f200.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so4706203qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqwTshlhtuZxcBr6uL1w6ltcJoVFtNt75o8Eacpkod0=;
        b=lsYwpSWC6famiGVqp2wUGQktOuRBgdNAL9T6rpymMNV0wxqo4JCC5bqYnqclArYzUw
         dH9bd5sBcisa1XeeTKBcj/jPX7enj8S//pncM5ib9w0c5DZEzvyrRDE7herU3M7SERLz
         8cq+FK3NzzXVax+go7jWTanWw65n29RlsA2p/yvJigoLAgZM3VO/wWpuOgwPNMvVkAZC
         if1wSU+NbxNlO5a3HqRl/fUwv3eFGR2xuefYloLp3Ue9DJvsL6bU5PZdv2uhCTUV2hLb
         D/IUT4hpCyj99SEiGlQDTWvOuxdqOyqgdq3gkw1xXnHxju+1slyd4NozjZZdl8rthr74
         YH5w==
X-Gm-Message-State: AOAM530BRbghxeritiY2QCkFvPZIBF3nZWisUpJgvZAJ2i5T+WTxcop3
        n4ICjx4cKSWnh0OQxYjfW38BLSYvQYeg6lowNpJtCSvm991YVD52ACMquYpClgPs5IPrtvLVLTV
        5MrH9Xrtq+mjBQzdND0fWxZkc
X-Received: by 2002:ac8:7305:: with SMTP id x5mr2623475qto.270.1626380066672;
        Thu, 15 Jul 2021 13:14:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy48hr26opiOkIV9BzjiZCq6gJCYlROMwUXdofVCgCfC/PTRGiNuNiHdMig2Y5Biv4tQyy3IQ==
X-Received: by 2002:ac8:7305:: with SMTP id x5mr2623444qto.270.1626380066315;
        Thu, 15 Jul 2021 13:14:26 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>, peterx@redhat.com
Subject: [PATCH v5 00/26] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Thu, 15 Jul 2021 16:13:56 -0400
Message-Id: <20210715201422.211004-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v5 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as=
 a=0D
full feature.  It's based on v5.14-rc1.=0D
=0D
I reposted the whole series majorly to trigger the syzbot tests again; sorr=
y if=0D
it brings a bit of noise.  Please let me know if there's easier way to trig=
ger=0D
the syzbot test instead of reposting the whole series.=0D
=0D
Meanwhile, recently discussion around soft-dirty shows that soft-dirty may =
have=0D
similar requirement as uffd-wp on persisting the dirty information:=0D
=0D
https://lore.kernel.org/lkml/20210714152426.216217-1-tiberiu.georgescu@nuta=
nix.com/=0D
=0D
Then the mechanism provided in this patchset may be suitable for soft-dirty=
 too.=0D
=0D
The whole series can also be found online [1].=0D
=0D
v5 changelog:=0D
- Fix two issues spotted by syzbot=0D
- Compile test with (1) !USERFAULTFD, (2) USERFAULTFD && !USERFAULTFD_WP=0D
=0D
Previous versions:=0D
=0D
RFC: https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/=
=0D
v1:  https://lore.kernel.org/lkml/20210323004912.35132-1-peterx@redhat.com/=
=0D
v2:  https://lore.kernel.org/lkml/20210427161317.50682-1-peterx@redhat.com/=
=0D
v3:  https://lore.kernel.org/lkml/20210527201927.29586-1-peterx@redhat.com/=
=0D
v4:  https://lore.kernel.org/lkml/20210714222117.47648-1-peterx@redhat.com/=
=0D
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
 include/linux/userfaultfd_k.h            |  54 +++++=0D
 include/uapi/linux/userfaultfd.h         |  10 +-=0D
 mm/gup.c                                 |   2 +-=0D
 mm/hmm.c                                 |   2 +-=0D
 mm/hugetlb.c                             | 164 ++++++++++++---=0D
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
 31 files changed, 763 insertions(+), 188 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

