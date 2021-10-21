Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4FD435AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJUGd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:33:56 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34108 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhJUGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:33:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ut7ARNj_1634797891;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ut7ARNj_1634797891)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Oct 2021 14:31:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     mhocko@kernel.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hugetlb_cgroup: Remove unused hugetlb_cgroup_from_counter macro
Date:   Thu, 21 Oct 2021 14:31:16 +0800
Message-Id: <f03b29b801fa9942466ab15334ec09988e124ae6.1634797639.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 726b7bbe ("hugetlb_cgroup: fix illegal access to memory"),
the hugetlb_cgroup_from_counter() macro is not used any more, remove it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb_cgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 5383023..79d9353 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -27,9 +27,6 @@
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
 
-#define hugetlb_cgroup_from_counter(counter, idx)                   \
-	container_of(counter, struct hugetlb_cgroup, hugepage[idx])
-
 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
 
 static inline struct page_counter *
-- 
1.8.3.1

