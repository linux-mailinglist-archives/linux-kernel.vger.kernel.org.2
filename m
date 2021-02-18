Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9331F1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBRV4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhBRV4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613685279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X72h3X9QeITmbnaHCGHJT4/NFKw/NsWjIcozUdmjBYg=;
        b=OOYVb+BQ4j0hX3ZBJyORL1wtu9fTmvY3sqzjv9b5vj7MXGvvEZq9yNmVv9Ur+md0CbV3l9
        KE1GJoxBcGbUVlCUpyU9YGIZAAkaJkmQOnPD2btezEeWXT3QRASyKk5fqu+IGWDlRBP3m8
        jZpwuHyugG0mYk1ByuYkdbHnr7kHifY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-gK5Us1vcOIiSLLuZqfEaSg-1; Thu, 18 Feb 2021 16:54:37 -0500
X-MC-Unique: gK5Us1vcOIiSLLuZqfEaSg-1
Received: by mail-qt1-f197.google.com with SMTP id o20so2033708qtx.22
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X72h3X9QeITmbnaHCGHJT4/NFKw/NsWjIcozUdmjBYg=;
        b=Bd/rhX2r4UrKNNI6OaOuVQFa8IiwQ9UIRmWHvLuw5aFLJtUHwFSu34dCsI8nJcBCur
         E1IoIj2Hj5YCCrD4lxVbzEhpsVUl319KXwUYNvEkYZ/QczkoKUToa0m1W1fiHED9rMUs
         GH3K60Z6EDWxJ7JYP4wDYyg9STlG1jWfA/MCsn+xsmg6x21fD6gyBu75lXqiFFwNhDjn
         rlY8n8ewMueB8I5kEJX7zlne5iBU70NiwxWjdazmH/5pCQPXhhGsB4cDUTBB8DzyzzZC
         Hs/b98NMzEQVPK63zz3i99mx3x7MnKAAnwPDGp/4kFbFcFT6WHEydcXAq6ij6irQq4Jj
         TxBQ==
X-Gm-Message-State: AOAM531HSa0HJ54Xo18olLmiwMG5Ngm8iS8OgUO8Azs+79K2t4mw3tiF
        3m8poFUTVyeyg9OFi6DdeRtQ/IWmmW/e31znoTyjqElyf3sEg1JME1DAf+/DUEPbP/nqm6GghFb
        83wt5fMlgHYFHlceBCa+he3btBrkx7Rkib1ezjUxKC+0+p0eKlKIYgVpYN7ejAm/H7q887qHMsw
        ==
X-Received: by 2002:ac8:1c8a:: with SMTP id f10mr6247950qtl.4.1613685276975;
        Thu, 18 Feb 2021 13:54:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKpJysF8Z6OiDKi/RnE/9ALHDKOUdtKMTout7CHDUFl0L9SidW1njBRGBHLHCtpGd/DqLCKw==
X-Received: by 2002:ac8:1c8a:: with SMTP id f10mr6247928qtl.4.1613685276697;
        Thu, 18 Feb 2021 13:54:36 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id r80sm4964260qke.97.2021.02.18.13.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 13:54:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 0/4] hugetlb: Disable huge pmd unshare for uffd-wp
Date:   Thu, 18 Feb 2021 16:54:30 -0500
Message-Id: <20210218215434.10203-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:=0D
- patch 4:=0D
  - fix build failure for !CMA and/or !HUGETLBFS [Axel]=0D
  - Fix mmu notifier range to use start/end [Mike]=0D
- add more r-bs=0D
=0D
v2:=0D
- patch 4: move hugetlb_unshare_all_pmds() into mm/hugetlb.c, so it can be =
used=0D
  even outside userfaultfd.c=0D
=0D
This series tries to disable huge pmd unshare of hugetlbfs backed memory fo=
r=0D
uffd-wp.  Although uffd-wp of hugetlbfs is still during rfc stage, the idea=
 of=0D
this series may be needed for multiple tasks (Axel's uffd minor fault serie=
s,=0D
and Mike's soft dirty series), so I picked it out from the larger series.=0D
=0D
References works:=0D
=0D
Uffd shmem+hugetlbfs rfc:=0D
https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/=0D
=0D
Uffd minor mode for hugetlbfs:=0D
https://lore.kernel.org/lkml/20210212215403.3457686-1-axelrasmussen@google.=
com/=0D
=0D
Soft dirty for hugetlbfs:=0D
https://lore.kernel.org/lkml/20210211000322.159437-1-mike.kravetz@oracle.co=
m/=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (4):=0D
  hugetlb: Pass vma into huge_pte_alloc() and huge_pmd_share()=0D
  hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled=0D
  mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h=0D
  hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp=0D
=0D
 arch/arm64/mm/hugetlbpage.c   |  7 ++-=0D
 arch/ia64/mm/hugetlbpage.c    |  3 +-=0D
 arch/mips/mm/hugetlbpage.c    |  4 +-=0D
 arch/parisc/mm/hugetlbpage.c  |  2 +-=0D
 arch/powerpc/mm/hugetlbpage.c |  3 +-=0D
 arch/s390/mm/hugetlbpage.c    |  2 +-=0D
 arch/sh/mm/hugetlbpage.c      |  2 +-=0D
 arch/sparc/mm/hugetlbpage.c   |  1 +=0D
 fs/userfaultfd.c              |  4 ++=0D
 include/linux/hugetlb.h       | 18 ++++++-=0D
 include/linux/userfaultfd_k.h |  9 ++++=0D
 mm/hugetlb.c                  | 94 +++++++++++++++++++++++++++--------=0D
 mm/userfaultfd.c              |  2 +-=0D
 13 files changed, 116 insertions(+), 35 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

