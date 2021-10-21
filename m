Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFC435AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhJUGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:34:00 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:42941 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231375AbhJUGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:33:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ut71kqf_1634797891;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ut71kqf_1634797891)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Oct 2021 14:31:32 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     mhocko@kernel.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hugetlb: Replace the obsolete hugetlb_instantiation_mutex in the comments
Date:   Thu, 21 Oct 2021 14:31:17 +0800
Message-Id: <4b3febeae37455ff7b74aa0aad16cc6909cf0926.1634797639.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 8382d914ebf7 ("mm, hugetlb: improve page-fault scalability"),
the hugetlb_instantiation_mutex lock had been replaced by
hugetlb_fault_mutex_table to serializes faults on the same logical page.
Thus update the obsolete hugetlb_instantiation_mutex related comments.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ee0db48..8902b07 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5012,7 +5012,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 
 /*
  * Hugetlb_cow() should be called with page lock of the original hugepage held.
- * Called with hugetlb_instantiation_mutex held and pte_page locked so we
+ * Called with hugetlb_fault_mutex_table held and pte_page locked so we
  * cannot race with other handlers or page migration.
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
-- 
1.8.3.1

