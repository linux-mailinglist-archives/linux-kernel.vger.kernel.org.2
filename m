Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B03C93BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhGNW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhGNW1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltWxXgdsERQEx3E6ySA6em4pDoRaSyrvcOj0w7z20l8=;
        b=Xr4q4WUDDs58U085Cw9HVjcHln0cFs428rPvLi6gd7EEkS41fflcE1TAu7eMbscbtG8Q98
        bZu1NElR0o2Sf3J7iM9D0X/gme9aLWrpfq0nx/raU/iaiP8aqGPxbViUSkooFeRpO34lEd
        TQgi6udmWP/zjwn8PU4XjsD81OhIfX8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-a5KZbveKMP-989Wr7Co_UA-1; Wed, 14 Jul 2021 18:24:42 -0400
X-MC-Unique: a5KZbveKMP-989Wr7Co_UA-1
Received: by mail-qt1-f198.google.com with SMTP id e9-20020ac859890000b0290250be770d0fso2801455qte.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltWxXgdsERQEx3E6ySA6em4pDoRaSyrvcOj0w7z20l8=;
        b=HhQZE0aMebz+VkqQ8e/Lhzy5CWMNEBc/8Kwxv3nxTpObjV6/GfobyXnZYHLb7IbcwU
         YTRE1GS1NwrGEiZ49QnP6cw9und2Z3m06rqKbfavMJvDeC5gMGA3GCmqdk9207MEK20P
         /bmAYLsSNKFbHqPeW6muDSaFvbiMx5prsj/Mo1sLxuwRuBdpRdbOSdAILLvZV/gDylZ/
         bOTUp78EPHpB58wTgRUOsMrW4VdJ7qp/RC2uu8WUj/TDhg4/ou/uInTCDq6OyP8Ao1dX
         Y7MSuXqX8e2qXQE+jj3W45P5rVy2tAEyVSBmjGCHkJeY5+q37g7fB8NK65TJBH1/6DSU
         QX5Q==
X-Gm-Message-State: AOAM530e2QNHJJBkBThPBNVN3Bxdz1UZAr0dbqMmcAfb+M1Uf9whAgrs
        rDj4VPhU5VQmbgjmDv9KKnWvVXK5rkKiizvHH2hyB6pvD2ENQ54c3cKIsAf5tDV90qSncx1B1wn
        /dmqmSpJskC9Y7YcydfcFJuX7
X-Received: by 2002:ac8:44c2:: with SMTP id b2mr348914qto.216.1626301481568;
        Wed, 14 Jul 2021 15:24:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxltkXhESK8mTiLGdx//VedRH0qopTtyIpRgcuMJZv4e/oNyE6Nw/k7eAZhcln38G+Gz1hD3g==
X-Received: by 2002:ac8:44c2:: with SMTP id b2mr348896qto.216.1626301481364;
        Wed, 14 Jul 2021 15:24:41 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id t125sm1645040qkf.41.2021.07.14.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:24:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 12/26] shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
Date:   Wed, 14 Jul 2021 18:24:37 -0400
Message-Id: <20210714222437.48687-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have "huge" version of PTE_SWP_UFFD_WP_SPECIAL, instead when necessary
we split the thp if the huge page is uffd wr-protected previously.

However split the thp is not enough, because file-backed thp is handled totally
differently comparing to anonymous thps - rather than doing a real split, the
thp pmd will simply got dropped in __split_huge_pmd_locked().

That is definitely not enough if e.g. when there is a thp covers range [0, 2M)
but we want to wr-protect small page resides in [4K, 8K) range, because after
__split_huge_pmd() returns, there will be a none pmd.

Here we leverage the previously introduced change_protection_prepare() macro so
that we'll populate the pmd with a pgtable page.  Then change_pte_range() will
do all the rest for us, e.g., install the uffd-wp swap special pte marker at
any pte that we'd like to wr-protect, under the protection of pgtable lock.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8ec85b276975..3fcb87b59696 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -306,8 +306,16 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		}
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
+			if (next - addr != HPAGE_PMD_SIZE ||
+			    /* Uffd wr-protecting a file-backed memory range */
+			    unlikely(!vma_is_anonymous(vma) &&
+				     (cp_flags & MM_CP_UFFD_WP))) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
+				/*
+				 * For file-backed, the pmd could have been
+				 * gone; still provide a pte pgtable if needed.
+				 */
+				change_protection_prepare(vma, pmd, addr, cp_flags);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
-- 
2.31.1

