Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8D31E315
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhBQXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232792AbhBQXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613604956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wPuFJC5ZmioOYdkJPPlSi2y7gf606iWtPZy7eDdgzpg=;
        b=duKHLlRhtTXdePk1J2tEyIHbUFRKx481BA8tXQ9MyHObwJBByTgfGCk1ofImxN1riGlO+4
        jhZrNASuE5Yuf5NKpun7XN/NhIzvYQCpbMmUNayhEeWjCYdk8Re2/RultSdFbAch+ufiPv
        fnOQdn72/zTPLgX+T6ucKdFaTW7qcKM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-5Bd5GQbIM22-Vj8ljwUxrA-1; Wed, 17 Feb 2021 18:35:51 -0500
X-MC-Unique: 5Bd5GQbIM22-Vj8ljwUxrA-1
Received: by mail-qv1-f70.google.com with SMTP id bc13so74810qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPuFJC5ZmioOYdkJPPlSi2y7gf606iWtPZy7eDdgzpg=;
        b=GKNt5aF7PdYzr1yG8HHftbx/ndZ8kgfvTKgwKCvIBXeBuYN8Gf0L+od3WYPi4KUHbL
         xlH7NSUtBRv617okkG7khADL0SHaNOSPyUStB8WM40oC7u/QlymxtDVBu6I9U9Qv0f40
         Oca0csoPGgq5TuYqueRt6SPKzNuNo1kqCcPVUWzL7BBRxlZhHfIV+Pj5LQSFsLo2V4CX
         C6e5CnbwMlzg9semDlEVA7BKaYOmnl6quVd1nrpCfHhFC0YcNVHds9kPY+Po+m6eLwzm
         sVvr5g3/pXwyKbYyjdEEySINmcI5BM9bMC5ftNsiR+F0HbkzzqeXvRP2A8tJb+vBn2qF
         kFTA==
X-Gm-Message-State: AOAM530tNJ5WolUhzcKNN+KU0EZT3JOUTRJR775wheeNCN8PgUNjJKDn
        IHCzR90HCy8yETwJR/S/1TmGNous/DRnMD7o2M2nDqvEYpf2xJWt1DC4QfPBCcAH+Dd/9qWdqUp
        QJiZTmDTSEbdp9+ZHhAOLYnqI
X-Received: by 2002:a37:9f17:: with SMTP id i23mr1669459qke.315.1613604950439;
        Wed, 17 Feb 2021 15:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm1CBcAJwKP+CnH8d9e9wr0xY2dhgacL4GB1zw3TmbxOVNILszGTSN2t2l1wdVYEMtEgkELQ==
X-Received: by 2002:a37:9f17:: with SMTP id i23mr1669428qke.315.1613604950139;
        Wed, 17 Feb 2021 15:35:50 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o5sm2739622qkh.59.2021.02.17.15.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:35:49 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Date:   Wed, 17 Feb 2021 18:35:42 -0500
Message-Id: <20210217233547.93892-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:=0D
- patch 4: change "int cow" into "bool cow"=0D
- collect r-bs for Jason=0D
=0D
v4:=0D
- add r-b for Mike on the last patch, add some more commit message explains=
=0D
  that why we don't need wr-protect trick=0D
- fix one warning of unused var in copy_present_page() [Gal]=0D
=0D
v3:=0D
- rebase to linux-next/akpm, switch to the new HPAGE helpers [MikeK]=0D
- correct error check for alloc_huge_page(); test it this time to make sure=
=0D
  fork() fails gracefully when overcommit [MikeK]=0D
- move page copy out of pgtable lock: this changed quite a bit of the logic=
 in=0D
  the last patch, prealloc is dropped since I found it easier to understand=
=0D
  without looping at all [MikeK]=0D
=0D
v2:=0D
- pass in 1 to alloc_huge_page() last param [Mike]=0D
- reduce comment, unify the comment in one place [Linus]=0D
- add r-bs for Mike and Miaohe=0D
=0D
---- original cover letter ----=0D
=0D
As reported by Gal [1], we still miss the code clip to handle early cow for=
=0D
hugetlb case, which is true.  Again, it still feels odd to fork() after usi=
ng a=0D
few huge pages, especially if they're privately mapped to me..  However I d=
o=0D
agree with Gal and Jason in that we should still have that since that'll=0D
complete the early cow on fork effort at least, and it'll still fix issues=
=0D
where buffers are not well under control and not easy to apply MADV_DONTFOR=
K.=0D
=0D
The first two patches (1-2) are some cleanups I noticed when reading into t=
he=0D
hugetlb reserve map code.  I think it's good to have but they're not necess=
ary=0D
for fixing the fork issue.=0D
=0D
The last two patches (3-4) is the real fix.=0D
=0D
I tested this with a fork() after some vfio-pci assignment, so I'm pretty s=
ure=0D
the page copy path could trigger well (page will be accounted right after t=
he=0D
fork()), but I didn't do data check since the card I assigned is some rando=
m=0D
nic.  Gal, please feel free to try this if you have better way to verify th=
e=0D
series.=0D
=0D
  https://github.com/xzpeter/linux/tree/fork-cow-pin-huge=0D
=0D
Please review, thanks!=0D
=0D
[1] https://lore.kernel.org/lkml/27564187-4a08-f187-5a84-3df50009f6ca@amazo=
n.com/=0D
=0D
Peter Xu (5):=0D
  hugetlb: Dedup the code to add a new file_region=0D
  hugetlg: Break earlier in add_reservation_in_range() when we can=0D
  mm: Introduce page_needs_cow_for_dma() for deciding whether cow=0D
  mm: Use is_cow_mapping() across tree where proper=0D
  hugetlb: Do early cow when page pinned on src mm=0D
=0D
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |   4 +-=0D
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c   |   2 +-=0D
 fs/proc/task_mmu.c                         |   2 -=0D
 include/linux/mm.h                         |  21 ++++=0D
 mm/huge_memory.c                           |   8 +-=0D
 mm/hugetlb.c                               | 123 +++++++++++++++------=0D
 mm/internal.h                              |   5 -=0D
 mm/memory.c                                |   8 +-=0D
 8 files changed, 117 insertions(+), 56 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

