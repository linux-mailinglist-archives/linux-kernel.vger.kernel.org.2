Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1931F2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBRXNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhBRXNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613689930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE6cAOaasOy90WntQkvLo9Y3tII8NSr50Af2SEtWMdM=;
        b=QHQiemI8+xZtVd2SxckfKKFsCLew7iCps+Z/+xCw5pDOXPKZIYZqyTDyRG9NlBrDRsG6LP
        cT9r0LQwBPY4EF1YziEBuF7eUPOD6sSOQ5fBUR2tubH0KIrZ++k0Zy1qWWariPqme3G7oN
        3Iqk3tssauMvUvZUvzVRnbAXfqI4Cj8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Icp0L9LUPKG1nmov9qWkNA-1; Thu, 18 Feb 2021 18:12:08 -0500
X-MC-Unique: Icp0L9LUPKG1nmov9qWkNA-1
Received: by mail-qk1-f199.google.com with SMTP id z19so2350482qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dE6cAOaasOy90WntQkvLo9Y3tII8NSr50Af2SEtWMdM=;
        b=bU5zOqGXUyAISb+PfyRsv3TOU7926xDsQxZmoTOErToxUhRBwYDlBeUc1GsTK4Ew0f
         /gD4cC4JyHLSg71zcCG3YB7TnwJ59kB3tOM4vtBW1cwLpiJ8B6TQVcm4XvUkDu/fL2Qz
         wdU5p9Vmfp40qF4IIyPZNbw2sM2KQXXpk2Ma4gUvo+v1XPPq/5NImoL7eg1OjFg5avb+
         e8/N472/0XeQnbOMfeLEq3WZ1TgArNlp02M74GIw0o8TMSXn/vnP0JCqkeOP5ybH2Vgi
         G7YifbjI7pDlzhEOy0H7jDw3ATPBDnkQL1BssusZJFzPFIMGImdmctgS92GkokiIFsF5
         0JSQ==
X-Gm-Message-State: AOAM532Dg8DkpH9BQTabHLAYnUsuhT8m5mes/LHCkCQXfMyJ6bZu/NWW
        I6cJr6NVriavWS+Rxce55It3eEtdHQJUziMf8lXGgs5gmGjltSY6M1x9FMzOh22i8CqqcVVI9GA
        EWeNqHP3s8+juqKDGpg9NvNhUY0q6MKY9yHJwbZ36qoXmmzLvd9yFRAq+gnWHuh8VJ6ZI+V3d9w
        ==
X-Received: by 2002:a37:27c8:: with SMTP id n191mr6700830qkn.146.1613689926695;
        Thu, 18 Feb 2021 15:12:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWtXzg806D3X1/9xAHfHtMWWudcrJTvGiuHxKFKciYfHvGxPXTrIKeyA4zWYlPt54g5V2HUw==
X-Received: by 2002:a37:27c8:: with SMTP id n191mr6700800qkn.146.1613689926437;
        Thu, 18 Feb 2021 15:12:06 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id j5sm4243160qth.80.2021.02.18.15.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 15:12:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 3/4] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
Date:   Thu, 18 Feb 2021 18:12:04 -0500
Message-Id: <20210218231204.15474-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210218230633.15028-1-peterx@redhat.com>
References: <20210218230633.15028-1-peterx@redhat.com>
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

