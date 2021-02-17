Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2C31DD67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhBQQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhBQQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613579471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWpsk6WR+Bwp1z9BHMOtQqpluxvzU8iTR9I0eDmdXe0=;
        b=GRrUswuWEWt6a5z5qIuniZnXMrsWPTuoCxx/GP0vrMPj9Or1NjGU1MIGPAa6sCoB/lap/k
        7QLRgMDqVY5X0q2liSIg24TPSWNar2aj5WskzO4fY/8Kdbw6NMD+H5Z2HtBOTDbaruip7N
        uBWvN3JLIJa7S+XBCWmEXdrZDV8Iml8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-KpamiKZiMKaA64okhXBjKA-1; Wed, 17 Feb 2021 11:31:09 -0500
X-MC-Unique: KpamiKZiMKaA64okhXBjKA-1
Received: by mail-qv1-f72.google.com with SMTP id a13so10170443qvv.14
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWpsk6WR+Bwp1z9BHMOtQqpluxvzU8iTR9I0eDmdXe0=;
        b=ZxZ2G7VTK3qHfZLlXH9cgOiLOH62qMfm08tbQg1XfAnS8wjsbasuzFjIBHPzyiu40+
         j3776PgdQX6Wl+pfLGtkWUVTjT+ep4P/F+CUQLmXNBM+65mqspOoz66KyK5ovNdlSkaL
         1JLl9ZoYhyVjIRaHhxhPTRmK+f6oNXZRDT3rzLruSPwuo07iN6mcJJrKQZj1KOL80GtU
         WC37JBzzogH2lyr+Erl6md+S4J9MZoH/vd/PhyvW9SerY3QhjnQh7sk6sMVSSoAeeg9b
         n1H6Y8IzRmorTuJDUIeA3wId+8MEYGAArajR0d9yTNou9pYSI7qvIwGKEtJomyog/QPd
         jE0g==
X-Gm-Message-State: AOAM5312cQwRvtQEtcr8YRBDBmmwZHdDysbegaGvgBrPUJVCCR4hKzyG
        rZmHQv1RPUGJdPwdOFjD0ABOdu1MXOGp6lJ0YJEK77S3ROPRtRYaynx8S6yEFE1yL2+HF2tjSFH
        YHeHhqaL8boaItbr6AEVaFCVUhkame51TgeSsnqaz9POq0iAD7dZVKZqVrF/OgnVoPGdiCXj+Dg
        ==
X-Received: by 2002:ac8:7557:: with SMTP id b23mr114982qtr.10.1613579468622;
        Wed, 17 Feb 2021 08:31:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvVZMfmcfU5UP4AHANsYDhZdSFMybJOgfWQPKuMRHOiyCJ5cBdD8K1bDxpYI+5LrnEztIn+A==
X-Received: by 2002:ac8:7557:: with SMTP id b23mr114950qtr.10.1613579468380;
        Wed, 17 Feb 2021 08:31:08 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z37sm399902qth.87.2021.02.17.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:31:07 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 3/4] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
Date:   Wed, 17 Feb 2021 11:31:01 -0500
Message-Id: <20210217163102.13436-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217163102.13436-1-peterx@redhat.com>
References: <20210217163102.13436-1-peterx@redhat.com>
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

