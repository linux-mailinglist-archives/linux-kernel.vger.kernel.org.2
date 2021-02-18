Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80CB31F2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBRXIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:08:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhBRXIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613689598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GV3FE/jRmWIDU2Byyij+J0dLblDpKaJcJNBj8qAB4Uo=;
        b=YY2jwdxcJIcHou3HsXgDrG+ew5TqHbs/Cdghb9zORsS+tLkgktnRy9fHmgi9xAGMOFziDC
        DWyX4YdbtaEpiJ/L3mLf0seNv722qCruCsSttaakLd4AWthQVyDu0DaeNm2fFeRpSLo1J1
        HngDNmfbBV10OvVnBbHa9qUkV9CDvsQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-_Y3fkQNXN5-gJ83RCVkyTw-1; Thu, 18 Feb 2021 18:06:37 -0500
X-MC-Unique: _Y3fkQNXN5-gJ83RCVkyTw-1
Received: by mail-qt1-f199.google.com with SMTP id o20so2128693qtx.22
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GV3FE/jRmWIDU2Byyij+J0dLblDpKaJcJNBj8qAB4Uo=;
        b=UIwTty4zyexMHos4TxrCAVDeV18rp+4t8w8gu6fP0qvCYa2q5Gxgx4GbagEVYC2iPy
         Za8sE0YFnFJCABCR8sCkSGDJt+Asol+7U/ayQrgg1MIugU49YFdYu66f7iPPout8kjCK
         kZOqGmxLpmevJNy2+xeYR5DF2VsSEIkWqbjm93F/Z1zxn9WAi48YkZKV1rGR2Hh4GduN
         xqyB9inr74LIB9DKAv7DuDWbAkYdPAKR1id268W4yFG9yREh+kMqRpsBAoyz4PgIvWto
         AaRy/drBpurgOr0LD7tBOGa9GZoL0uNICpriGA58I6JTxx3tvWw45TGLyT2e+OHAP6+M
         qmSw==
X-Gm-Message-State: AOAM533HVChgUDNEUvABKxmo46JErszOvtbBbxnU+BNKhPumxudmonw5
        siTqe2mrftjQWJmQY5SLQ9GtNbwQlfhQeHqra48I1HHBTEF6E0KFv0hvGziOvO2DIWYh5ia0ohI
        vy5RUlNhugl2oBPlDnbVodEi+B/RWuedh2ez7O87m5fzcpocio2dJCTRQfTrX3PKosWQlrYyBDg
        ==
X-Received: by 2002:a37:a151:: with SMTP id k78mr6574378qke.359.1613689596252;
        Thu, 18 Feb 2021 15:06:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPrqsgYJKzHr/HODkfu/1u3GuJEBtKDqd45PLibWEiQQEcWHtTMfT4v9Ji/0SungUuXvBO8g==
X-Received: by 2002:a37:a151:: with SMTP id k78mr6574349qke.359.1613689595954;
        Thu, 18 Feb 2021 15:06:35 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p81sm4994324qke.18.2021.02.18.15.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 15:06:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com
Subject: [PATCH v4 0/4] hugetlb: Disable huge pmd unshare for uffd-wp
Date:   Thu, 18 Feb 2021 18:06:29 -0500
Message-Id: <20210218230633.15028-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:=0D
- fix build for sparc by removing extra line in patch 1 [Mike]=0D
- pick Mike's r-b for patch 4=0D
=0D
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
 arch/sparc/mm/hugetlbpage.c   |  2 +-=0D
 fs/userfaultfd.c              |  4 ++=0D
 include/linux/hugetlb.h       | 18 ++++++-=0D
 include/linux/userfaultfd_k.h |  9 ++++=0D
 mm/hugetlb.c                  | 94 +++++++++++++++++++++++++++--------=0D
 mm/userfaultfd.c              |  2 +-=0D
 13 files changed, 116 insertions(+), 36 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

