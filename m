Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37A311189
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhBESKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233195AbhBEPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612544462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SoQrqQPF9+borL+qHQ4hNWJYo4oscRnbkbb9Q51ktbk=;
        b=a+iYws7pC4fIAsBC1VZ3+UtJNp67pYvA/Y7FAe5GdwV0kG2h+WDo5KeUdO/jrG+Z+4hQYJ
        KL1EN2BdAIx/FkgIN/9voYxhhSovx52Qu7HuAGGswfAnNofl35vElgEli7R/xiI5LaOnk1
        dy8sBrINxDfCUvOF0TyFZ0okI90xia4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-fqnEKWgJNXiGc8cLJ3tJ-Q-1; Fri, 05 Feb 2021 11:53:31 -0500
X-MC-Unique: fqnEKWgJNXiGc8cLJ3tJ-Q-1
Received: by mail-qv1-f71.google.com with SMTP id j13so5425141qvy.19
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SoQrqQPF9+borL+qHQ4hNWJYo4oscRnbkbb9Q51ktbk=;
        b=QjmQEWNhYX4XRqZ2uy970a742kDH00sGRuLhBIAiTf69qT5Smsmys1vqK32+R20h3Y
         4p1DSgginWciyFimSpNgepJz+9VoyjJDy5TatL/N0TzRQvNv57kTr/cTEygguJr6uoDE
         UKDEfV1rV+6+gkqmb13Gwb1DFsns9RNkxbV4oNoTAwbKH6jirtMhx94mx4KKyYU4WCYL
         LLHbyjeuQWXTiv4thIpBuUIkbFIQeXlg4NDipVYeaW6SrgslXgDzY+YkyInF3zZgkYag
         RABghOVYLVU8ihfUzBc/4qw5igZwDqVvrRDeeBUzjY8HlWZOrrUWYbwldfA1VmXsUoe8
         0T9Q==
X-Gm-Message-State: AOAM531a62Xl8MZaiTkokbCEW4fSSoZTULcx9Q2wqn2KSZ3b9MGHpMTT
        0z9esxcu1RAYZAOjaF3cpXZJ+2Mh6plzAdeN6ZcHnEPbwlbQlKXLvwDvOmDAdDeupxdmNpu+DPv
        tLCsiL4FenMivfn69gMsKH/Tr
X-Received: by 2002:ac8:5a0d:: with SMTP id n13mr4868968qta.172.1612544010989;
        Fri, 05 Feb 2021 08:53:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhGJdXJrGmwrXmKNbOfGZisxwRZvH9uZmN6zAs71jWNsD2lLWwz1jxezZDDIeb0pNDGx93TQ==
X-Received: by 2002:ac8:5a0d:: with SMTP id n13mr4868948qta.172.1612544010663;
        Fri, 05 Feb 2021 08:53:30 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm9618893qkg.39.2021.02.05.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:53:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Date:   Fri,  5 Feb 2021 11:54:01 -0500
Message-Id: <20210205165406.4655-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 mm/memory.c                                |   7 +-=0D
 8 files changed, 117 insertions(+), 55 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

