Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65831E0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhBQUr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231905AbhBQUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613594785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWpsk6WR+Bwp1z9BHMOtQqpluxvzU8iTR9I0eDmdXe0=;
        b=WouIktUCUrnvpmQkGw8dP7ClSt+ap4mT7aBgX+PiBEKL3d6vwxKSjfj3Wps5ddfMcthG6K
        SL+n48Hg/45zn8EKeFAuOO9BLvROdS5MKeY8xZWt1eUAZR4RiclnDwMWufCB45puppaGNX
        XDQ1ue4r9HgJI7dBpXZ7BIf8km94fYc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-jOvvRiqqNhmg45tkFOOjMw-1; Wed, 17 Feb 2021 15:46:23 -0500
X-MC-Unique: jOvvRiqqNhmg45tkFOOjMw-1
Received: by mail-qv1-f70.google.com with SMTP id n8so7789505qvo.18
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWpsk6WR+Bwp1z9BHMOtQqpluxvzU8iTR9I0eDmdXe0=;
        b=IqHhCeyrB4wODw90eH6jYXq3/Ehvm7HCB7S5AOhLKTvMWKdgxYzYDLmGviDHzjwG7B
         hRaG8lkzcgrenmxvHEwSweTMy6vWyNDl9tjOmQFP2L/8gRFyA9UyH90rbX2vVefKs9Aq
         VFDtarWJzUARwnKRicauDw0jdsVB5gQfNh8WgGyEHbqDHrD3R9maCASFX92N+mxfd93p
         Cg5w5gKOOaJ3Klj7kguGoefITiphaKQe8agtXFQC7q3vj4taUFQJjzbrxvxbunGb0c3s
         eKvEYtDYkw2Ks9sAR1Cf4aUcAlXJSC4rLpa5x/X+xawuJdj/f7EH+9R3DVisUhukWHAj
         n6bw==
X-Gm-Message-State: AOAM533nB4qU8fZsQEffjfSV0G/vXQPqAtgn92pt+O4qFVwulmzQySPm
        76Ct3qFeBtb9QK4sl/8/FgEcOS0FGgqE0Q9Wd0Poh/vHSpBU9u8Z4+a7bb9FDUAFj+9c4ccQ+Hk
        cQ0h/j/G84OqEaro0hy20SL5Y
X-Received: by 2002:a0c:8485:: with SMTP id m5mr878916qva.14.1613594783297;
        Wed, 17 Feb 2021 12:46:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzpJY/dYRuFJ0bbzo69kje8Ne04jgTMY6pdLwcYDopHHxPEES4boAYuLkYLXf2AHwHwph7Kg==
X-Received: by 2002:a0c:8485:: with SMTP id m5mr878886qva.14.1613594783102;
        Wed, 17 Feb 2021 12:46:23 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p25sm2354901qkh.79.2021.02.17.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:46:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/4] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
Date:   Wed, 17 Feb 2021 15:46:18 -0500
Message-Id: <20210217204619.54761-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217204619.54761-1-peterx@redhat.com>
References: <20210217204418.54259-1-peterx@redhat.com>
 <20210217204619.54761-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for it to be called outside of mm/hugetlb.c.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 8 ++++++++
 mm/hugetlb.c            | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bc86f2f516e7..3b4104021dd3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -952,4 +952,12 @@ static inline __init void hugetlb_cma_check(void)
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 
+#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+/*
+ * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
+ * implement this.
+ */
+#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8e8e2f3dfe06..f53a0b852ed8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4965,14 +4965,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-/*
- * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
- * implement this.
- */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#endif
-
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
-- 
2.26.2

