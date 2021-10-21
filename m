Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF37435AED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhJUGeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:34:06 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42591 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231392AbhJUGdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:33:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ut72tZR_1634797892;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ut72tZR_1634797892)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Oct 2021 14:31:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     mhocko@kernel.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hugetlb: Remove redundant validation in has_same_uncharge_info()
Date:   Thu, 21 Oct 2021 14:31:18 +0800
Message-Id: <97fc68d3f8d34f63c204645e10d7a718997e50b7.1634797639.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of has_same_uncharge_info() has accessed the original file_region
and new file_region, and they are impossible to be NULL now. So we can remove
the file_region validation in has_same_uncharge_info() to simplify the code.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8902b07..5922629 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -333,8 +333,7 @@ static bool has_same_uncharge_info(struct file_region *rg,
 				   struct file_region *org)
 {
 #ifdef CONFIG_CGROUP_HUGETLB
-	return rg && org &&
-	       rg->reservation_counter == org->reservation_counter &&
+	return rg->reservation_counter == org->reservation_counter &&
 	       rg->css == org->css;
 
 #else
-- 
1.8.3.1

