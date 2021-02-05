Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D233106FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBEIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:46:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12435 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBEIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:46:26 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DX89W3TXJzjJG1;
        Fri,  5 Feb 2021 16:44:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 16:45:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlb_cgroup: use helper pages_per_huge_page() in hugetlb_cgroup
Date:   Fri, 5 Feb 2021 03:45:13 -0500
Message-ID: <20210205084513.29624-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could use helper function pages_per_huge_page() to get the number of
pages in a hstate to simplify the code slightly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb_cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 8909e075d441..86b5cc128584 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -113,7 +113,7 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 			rsvd_parent);
 
 		limit = round_down(PAGE_COUNTER_MAX,
-				   1 << huge_page_order(&hstates[idx]));
+				   pages_per_huge_page(&hstates[idx]));
 
 		ret = page_counter_set_max(
 			hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx),
@@ -466,7 +466,7 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
 	counter = &h_cg->hugepage[idx];
 
 	limit = round_down(PAGE_COUNTER_MAX,
-			   1 << huge_page_order(&hstates[idx]));
+			   pages_per_huge_page(&hstates[idx]));
 
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_RSVD_USAGE:
@@ -513,7 +513,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 		return ret;
 
 	idx = MEMFILE_IDX(of_cft(of)->private);
-	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));
+	nr_pages = round_down(nr_pages, pages_per_huge_page(&hstates[idx]));
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_RSVD_LIMIT:
-- 
2.19.1

