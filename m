Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77531F1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBRV5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229916AbhBRV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613685358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE6cAOaasOy90WntQkvLo9Y3tII8NSr50Af2SEtWMdM=;
        b=cMF0LTbjhRhwF/n6n9/+jkBkTvgY9lgx2ACJv5xq8SZB37hmuqPUNyVtXg2c+X8oS/DuyV
        umirPASn5bNl8yHNSThdjqT0pUIx/MOk8txi8WqKAtJ8UZVlFQ9gxyM11lkjfGTSBRoCe6
        jwk+mZuUgtxcLPCQLkRxFiXrBG2JXl0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-HdQOeU9KMkmHW5ei6WQQUQ-1; Thu, 18 Feb 2021 16:55:56 -0500
X-MC-Unique: HdQOeU9KMkmHW5ei6WQQUQ-1
Received: by mail-qt1-f200.google.com with SMTP id k90so2070188qte.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dE6cAOaasOy90WntQkvLo9Y3tII8NSr50Af2SEtWMdM=;
        b=lKYUHQmjOKWLa2BfvINr3+bJalXbwyZEDPYGjbEXZVAFizULHqKVROkeODxN2STRB8
         d1VBenxFAP2xCrDsE3BE/bhfIpr48V3LfRzmq427XUUz7GqM1mCduXYsLUNPHEaZu/nT
         CaN7PhK5JyI/oY/Jxwxgr0kqmntXqsdW9EEf29U1SKs7jhTy3FS1sMMP1j/FHcycR0vq
         UIGwua6o1NgrtMCtJiq/h9cWUXFHFlxaVoObvDu2XnU0ty/SzHcxOVVqceo50Q66Fu93
         6qSZZzz2wmF5dpsjcGt29kxC+EqS3nCJwTIb0bHLqEvc0BH2iuSfH5XlkYviwYZ3yRE2
         Tasg==
X-Gm-Message-State: AOAM530hAHrJTw2GpDvGfntUH0faPRb2kMrO0B5eefQ8mNQ2XDLbpBj2
        MBth6CEea4JdZ1FI1gvTpOUhN5ZqBdNdgWu/YB9yPBllfgsWjDhPr/X/gIyeF4P559u9FK19C/Q
        rtLA+Nrp4EwbgaNLmRjq6pWF8r3PAisZgfK8Q2zhklEpYjRIL+7/AOK5bEch53OECKr41Ie3ZUA
        ==
X-Received: by 2002:a05:620a:152f:: with SMTP id n15mr6697898qkk.268.1613685355433;
        Thu, 18 Feb 2021 13:55:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUYiPTPAG+FWyIYsYpoaJpCU9FHaZZLdQmhQYw1Jnez6gl+V7mpMBxMVwbBcm/2BMMAyhCjg==
X-Received: by 2002:a05:620a:152f:: with SMTP id n15mr6697871qkk.268.1613685355126;
        Thu, 18 Feb 2021 13:55:55 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id c7sm4311038qtm.60.2021.02.18.13.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 13:55:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 3/4] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
Date:   Thu, 18 Feb 2021 16:55:53 -0500
Message-Id: <20210218215553.10661-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210218215434.10203-1-peterx@redhat.com>
References: <20210218215434.10203-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for it to be called outside of mm/hugetlb.c.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
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

