Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4125E3CADB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbhGOUT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244763AbhGOUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltWxXgdsERQEx3E6ySA6em4pDoRaSyrvcOj0w7z20l8=;
        b=CCAUyH0f7SC5kyXh8GMbBb9EOfFqh/MQ6mYAoDsKHH27fUdM72cpfnpo/np6Bpzz853YpC
        ToCtYkaJZ+dPklTdDPiSVSCmdFIIGrODj80rGkv3b70caY9DVQHVV8xzcXKDJR8e+ADdKT
        lNb1kdmwZ34o7lhiFg8POWoyOGSj/aU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-DfYPIdMAN0qeUTsVLMRtkA-1; Thu, 15 Jul 2021 16:16:06 -0400
X-MC-Unique: DfYPIdMAN0qeUTsVLMRtkA-1
Received: by mail-qt1-f199.google.com with SMTP id z6-20020a05622a0606b029025368c044d9so5009646qta.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltWxXgdsERQEx3E6ySA6em4pDoRaSyrvcOj0w7z20l8=;
        b=q8YuySNnL/fV3nPeImcVO+omTzWeyijKbyRtbFP7AxUvgOBEDxx3LBcqLvkzTEYewB
         GzPhcxAkhr6AFvIHxyYoRD6ir7ZhCeT1KlnCCwiP0SrFiALpQSR7VfSRerb+ZVrSqblU
         Wp++ZY90lOdxbXhTS5JEtT/NZuSnBGBtesIlL+P9Tv18B8NxynMtzmyVhTndz0OWPf05
         Bzt8BLLTzDXZn++YUMF3IET25ozpI+mKlNqqYoMLqIZ3EVEPWPDQdCs/9ZULAawQL6Zs
         hhhUhIvpmj0NTfiprMcBnw/u+bFN6kr4DEl+vaGiyxxdLXGE2Jh2V1pLRkmF0s3t9oMO
         UZxw==
X-Gm-Message-State: AOAM533lIQZxr3WYXLOHsWA4yskCpllitclQmLvyLJRD/Q7ycNdLkSbJ
        Us3Po4E97rlpc9Ef2GScSOXpqcvLxYZZCyL0A5zRa1MaX3dT9t6riA3/OcQpBWZBxj4ZfKs3gN+
        lWkRhDWACwliE7sWcHCdACjLVhwijroMyBQ6PkRXg9cC743tdclMEZJePwxtRZIiKVGztzDw9gA
        ==
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr5686356qkn.16.1626380165773;
        Thu, 15 Jul 2021 13:16:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTC10tfMm3pV49bd4wppQjkiX3paXGPpQYHfxNtmjnsg+u4bX3Eh1j3I/WypQ2MQKfcLIqUg==
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr5686323qkn.16.1626380165505;
        Thu, 15 Jul 2021 13:16:05 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id j65sm3147909qkd.17.2021.07.15.13.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 12/26] shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
Date:   Thu, 15 Jul 2021 16:16:02 -0400
Message-Id: <20210715201602.211496-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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

