Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DE131E0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhBQUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234469AbhBQUpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613594664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wKnX6l35uYOYGVmyrGbS8NnU2DNKyn8085j6FnLGtks=;
        b=Ut2uvwAocxeg33/Mf7kERk58dfx5s85hCRM6AeSiqXCuIouVlUA0PuDGZ2Nz0ai4j+DbqU
        eupM/pp9SnXV6Vt/qPqWCzUNxGQEUEvZiNw7IZeBS9cEEMllmJeWmOoNRKt+ueXRW6ev9Y
        8E+ofOG0bkM+4Sc60KTJVHjHR30lrEk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-v7r6bm-GNJiOB2ZTLgZLfQ-1; Wed, 17 Feb 2021 15:44:21 -0500
X-MC-Unique: v7r6bm-GNJiOB2ZTLgZLfQ-1
Received: by mail-qk1-f199.google.com with SMTP id z19so11662949qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKnX6l35uYOYGVmyrGbS8NnU2DNKyn8085j6FnLGtks=;
        b=R8vZSx8wYkglHkem+s6RFWocBld1TF0cOPuD6jBNqHJSfXVHSPOT4t2qcHE+AH4sCP
         5SvOqienAhZRtbUMMpaNIgesznUWL7IFBU4VMn4y0ScNBnfOtekXqet4AOwfRZPfYKt0
         PCPNRuY7Gvr+h7k/L8wJv13ZOdn5k8BgxfjUfuRhyL0+uTApnVp8ad7VJbm4DFfpAwDS
         qSBmLTAhse4vEYcnDy0dfRrd92+k8oKdJYqZUI+iveMNneFomYDQS1BTD5yqnn8YZaO4
         WVm1h6NX1tLzQDQHT/nJVwoLjbAkvTEjNU2URmMVqmyg8BSwq/W1+CycPfkhrpV2WIVm
         z+UQ==
X-Gm-Message-State: AOAM531hXUanOAjwDXLO7CrDyP/s9BLLGiivXEtJ5wi3IhXbF9lW9kvw
        Uxw60zkgdEjwccgyBE+vLVcanA48oPl12lGn+PmZRkpGrxjnvR/VgQ0Cm4mrYB8UOjibURy7JOL
        rzAG+qg3J+nl0ZBjXNu2kTdta
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr1162189qtv.92.1613594660607;
        Wed, 17 Feb 2021 12:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw41/8jcc85nh57uJJp6w4BmUxYj45HaRdC7P+WmAiuC/RN7+9paF6jxDr68f7JF00mqhPc1g==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr1162168qtv.92.1613594660352;
        Wed, 17 Feb 2021 12:44:20 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id f9sm2440561qkm.28.2021.02.17.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:44:19 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 0/4] hugetlb: Disable huge pmd unshare for uffd-wp
Date:   Wed, 17 Feb 2021 15:44:14 -0500
Message-Id: <20210217204418.54259-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/hugetlb.h       | 16 +++++-=0D
 include/linux/userfaultfd_k.h |  9 ++++=0D
 mm/hugetlb.c                  | 94 +++++++++++++++++++++++++++--------=0D
 mm/userfaultfd.c              |  2 +-=0D
 13 files changed, 114 insertions(+), 35 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

