Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75B73DA23D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhG2Lf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:35:59 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39156 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhG2Lfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:35:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UhLNSTM_1627558548;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UhLNSTM_1627558548)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Jul 2021 19:35:48 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mempolicy: Use readable NUMA_NO_NODE macro instead of magic numer
Date:   Thu, 29 Jul 2021 19:35:43 +0800
Message-Id: <1b77c0ce21183fa86f4db250b115cf5e27396528.1627558356.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of mpol_misplaced() already use NUMA_NO_NODE to check
whether current page node is misplaced, thus using NUMA_NO_NODE
in mpol_misplaced() instead of magic number is more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/mempolicy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cedc816..038510d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2470,8 +2470,8 @@ static void sp_free(struct sp_node *n)
  * node id.  Policy determination "mimics" alloc_page_vma().
  * Called from fault path where we know the vma and faulting address.
  *
- * Return: -1 if the page is in a node that is valid for this policy, or a
- * suitable node ID to allocate a replacement page from.
+ * Return: NUMA_NO_NODE if the page is in a node that is valid for this
+ * policy, or a suitable node ID to allocate a replacement page from.
  */
 int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr)
 {
@@ -2482,7 +2482,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	int thiscpu = raw_smp_processor_id();
 	int thisnid = cpu_to_node(thiscpu);
 	int polnid = NUMA_NO_NODE;
-	int ret = -1;
+	int ret = NUMA_NO_NODE;
 
 	pol = get_vma_policy(vma, addr);
 	if (!(pol->flags & MPOL_F_MOF))
-- 
1.8.3.1

