Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0609240FE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbhIQQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232180AbhIQQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631897471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VDHAOThaMHoseHUQ432qzhgijX2FLFoEAGXvQBtEyCE=;
        b=N4kEAelz6M/hGAEHKzT8+YVcqKjU2TXsdwY76twT82nZGI2Z1QxHyt4P+iANu4+JRVdXhn
        bORDrtex9wmzpomHxkwXCMXyTlPQZzyyeyo7TnHNoeNIhQlu9MheVjjdb8HQtA0eWrxfzd
        7J4L3BfRTT4OXWeWWi8FU2IvrKc3a7c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-z09lbFynNH-TU6Mv0V8JPw-1; Fri, 17 Sep 2021 12:51:10 -0400
X-MC-Unique: z09lbFynNH-TU6Mv0V8JPw-1
Received: by mail-qk1-f197.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so67527415qko.16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDHAOThaMHoseHUQ432qzhgijX2FLFoEAGXvQBtEyCE=;
        b=51ulprCPFa6497w/zITSG/wpHSu8q1InMkK50DQ9J15h4T+L44Hb2UzJSgPsnLqeD7
         uwmIwvb4PvK89uDsOjl2vQRBnJIkfHYhK92ER8IioceUCZdX5UIfo7WtgxHa2C7koPLh
         TqHuyVSeMN2cIWhMPoQTKtCfPqj1SEMkB08wuzbmLhhT3wBMDXKlfIU6wzYPHvxia7q/
         cvqq2/gS5ELvYFPRomtBvHr7H2aa2R4MmNfIQNc9dgaNu9Wzyi60iOkrNK+BuEPHI9N2
         w2mquLRV0bF8bBWyQOAu2th0wiHeepDLvxdkruOBXWue7nj6puusmVhYbb+2NaGJp1YS
         QD0w==
X-Gm-Message-State: AOAM530j0fjSu+v2VzX/4G52G8Y4f6DL+ShgJwyJgVuMvUuaQzdL1q3e
        BX1bYbo1ntyWTMUp+RdptBkqXJU4TjBJzF+LtudfxRILB/2TKQxFNI079Me5bzgtpO7VL9ZAof0
        H1TzShYLohupDR2l2SNvEOH29
X-Received: by 2002:ae9:e8d2:: with SMTP id a201mr10763238qkg.347.1631897470241;
        Fri, 17 Sep 2021 09:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNoUNhd4p+MbQu/md9JIosMUKEdV122juI5QM2JvWfkK8kCuicWJjvOFgAhIeeZJtMVJxulw==
X-Received: by 2002:ae9:e8d2:: with SMTP id a201mr10763224qkg.347.1631897470019;
        Fri, 17 Sep 2021 09:51:10 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id 10sm4896924qtu.66.2021.09.17.09.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:51:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
Date:   Fri, 17 Sep 2021 12:51:08 -0400
Message-Id: <20210917165108.9341-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove __unmap_hugepage_range() from the header file, because it is only used
in hugetlb.c.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 10 ----------
 mm/hugetlb.c            |  6 +++---
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1faebe1cd0ed..3cbf60464398 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -143,9 +143,6 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
 			  struct page *ref_page);
-void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-				unsigned long start, unsigned long end,
-				struct page *ref_page);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo(void);
@@ -385,13 +382,6 @@ static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95dc7b83381f..d394d9545c4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4426,9 +4426,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	return ret;
 }
 
-void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			    unsigned long start, unsigned long end,
-			    struct page *ref_page)
+static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end,
+				   struct page *ref_page)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-- 
2.31.1

