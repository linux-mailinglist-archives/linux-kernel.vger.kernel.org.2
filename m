Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08213146CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhBIDFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230310AbhBIDEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612839755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RBKJHJerYt2KSF+eTc+DgeeMY1UBm0hZ6pOYGuVUj1Q=;
        b=Hv5o+9UBbj8oZjmAl3lsYBIIOXXC/qlDDVoJmELbXxxe9zxkIag5Q1auGuVdy9mtYnyKaP
        UqUWFSVONOzwMeInv8bChqLMgTDr4wG5BjNZj9wfFvbsBaJusme5iKmBDanfLvxVpjuM6V
        eW/4CRTgB/ZrDRC6RDD0LwJXbPER3MA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-N_31ZdvrO9SXuRLl6Ja8Tg-1; Mon, 08 Feb 2021 22:02:32 -0500
X-MC-Unique: N_31ZdvrO9SXuRLl6Ja8Tg-1
Received: by mail-qk1-f197.google.com with SMTP id n62so2199049qkn.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 19:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBKJHJerYt2KSF+eTc+DgeeMY1UBm0hZ6pOYGuVUj1Q=;
        b=YEO2gL6gOpsXEjmSW11ui171lHcKYKuFr/vSWMV6oog0aj+knD893kPPngYSRmuqT8
         KmShJRS9ZbpsIr7D9VazVxzTojc5W3YNhcKL7oF1htiJ7TqeTAgVdb9CUTpMRIDwO0nO
         bDTN4kC7ac71pbceiFzPotNFuZ7GrW+8h6nwHzaN+zCAlmItm5LM24sYrEjI9v3BEdsA
         BMsDU/PnGsKiW3xVe7YjNoEibQbyqzNgoq5LFUe7MVOpm6VzrRMIT0W8cFrRm9oOVvcB
         CgCcBWVDzZSOqNMYFclzsnf4Rvu9iYmlGZbpID2dF/vFJtcXJdAACTu+H07mQj8k9Hbx
         1m1w==
X-Gm-Message-State: AOAM53232yjHSp6PvUgiOmeOQQZJwqKbvWi3R9raIs8HeIsz73NObFdh
        jWk/JjGBC9kipj4u5NNzZq9il5KZsPbtJk7nzynT0QnD+N3y+mVQY84uqTzEYOwGRPiZLbzlX+q
        CjAfr5wOjn+ADyO/FxxLKWBHB
X-Received: by 2002:ad4:4ba6:: with SMTP id i6mr3232324qvw.50.1612839752337;
        Mon, 08 Feb 2021 19:02:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybLayjCqSqkV2EMC3QrWtF/NVm3sRdRjSiXft71EPzkOdMUwlhKoqtbSci9ONCrNK5bQEoPA==
X-Received: by 2002:ad4:4ba6:: with SMTP id i6mr3232315qvw.50.1612839752119;
        Mon, 08 Feb 2021 19:02:32 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z20sm17078830qki.93.2021.02.08.19.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 19:02:31 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        peterx@redhat.com, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Date:   Mon,  8 Feb 2021 22:02:24 -0500
Message-Id: <20210209030229.84991-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

