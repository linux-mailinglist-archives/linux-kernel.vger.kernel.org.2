Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2051C36C94C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbhD0QYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237590AbhD0QOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ene9hsYCt95YhP01hJ6SbYksc0YKGhtCroAdQwF4+A0=;
        b=SsO5w+YD/3UfTErcd3ikOmwdCf/CT1++6ywJLuqoEW1qdr29+ramIxnweTDI+a2V5Y07k0
        HCi9GZe7LiI6QT5h9yl6kNnp42XaeL6XMvG4EqE1DEDFEYtsJyu3/j7lR34Oztt1zdo6iQ
        zS+yl/ZWYJvLGoMC7KV+6LKUXFPjkmU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-8_IP50NhNNGdsGs1K8jDPg-1; Tue, 27 Apr 2021 12:13:47 -0400
X-MC-Unique: 8_IP50NhNNGdsGs1K8jDPg-1
Received: by mail-qt1-f198.google.com with SMTP id z5-20020a05622a0285b02901b943be06b5so15527743qtw.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ene9hsYCt95YhP01hJ6SbYksc0YKGhtCroAdQwF4+A0=;
        b=RAi/tYH+2r49qOKmnaIzuifjaEpk2QK8sugdpvtkzJ1Yay2S7R1ZjuMsoFonhjh+R9
         XcA0YlX6jMFD9wwQjdIeaividC9kId53sX9q2zkcU6LXF59Jm7z8BneRSdLVaJOdV+BE
         yc9zdmkUhXas/UPGMMjNEMZzrNjsk0opAd7vr/H6QQYn1LNruwvRuabLcd/EVCRVP57h
         4BTKRUhel/bc8mafP6eiXtsBgk+RGPVZTUikrPCC1pHz+gdVxTIIJjB2kF+VZIDKyirq
         ONJhLXhTdAekXNBE8Seufv55EJFkIEKRd+T+swc+tPgqWqVymLfZfV1Cc6Bz6Pu7iHcE
         4ZZw==
X-Gm-Message-State: AOAM533TeyTTuaNVrXPWDRx29K+cKEozYeRSI3U8irCBipmWYu41nUHc
        /1/8XPHvz4zGiqs9DxhpWwGgx4rlu6XiWn3nBuz9h1Cwqlk/WPAWBwyuHUlNUfoiFx9jR1K1bNA
        Sxj0RnD5+1iEVDtiUTekDnejU
X-Received: by 2002:a0c:a98d:: with SMTP id a13mr24391176qvb.39.1619540026656;
        Tue, 27 Apr 2021 09:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeBDEAolLFEvpC2nGq6dbXDcre41GVmLMNg+IbtaHl9JGzGvURbs1BlzbLWeFm2t7fJ9kOdQ==
X-Received: by 2002:a0c:a98d:: with SMTP id a13mr24391159qvb.39.1619540026457;
        Tue, 27 Apr 2021 09:13:46 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:46 -0700 (PDT)
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
Subject: [PATCH v2 15/24] mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
Date:   Tue, 27 Apr 2021 12:13:08 -0400
Message-Id: <20210427161317.50682-16-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop it in the header since it's only used in hugetlb.c.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b92f25ccef588..eb134a75cad41 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -126,9 +126,6 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
 			  struct page *ref_page);
-void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-				unsigned long start, unsigned long end,
-				struct page *ref_page);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo(void);
@@ -362,13 +359,6 @@ static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 	BUG();
 }
 
-static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
-			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
-{
-	BUG();
-}
-
 static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned int flags)
-- 
2.26.2

