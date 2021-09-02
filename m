Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5A3FEB7E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbhIBJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:43:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8997 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245185AbhIBJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:43:14 -0400
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H0bXn6MSKzYwXB;
        Thu,  2 Sep 2021 17:41:29 +0800 (CST)
Received: from compute.localdomain (10.175.112.70) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 17:42:13 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
        <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] percpu: remove obsolete comments of pcpu_chunk_populated()
Date:   Thu, 2 Sep 2021 17:47:23 +0800
Message-ID: <1630576043-21367-1-git-send-email-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b239f7daf553 ("percpu: set PCPU_BITMAP_BLOCK_SIZE to PAGE_SIZE")
removed the parameter 'for_alloc', so remove this comment.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 mm/percpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 7f2e0151c4e2..e1c20837a42a 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1520,9 +1520,6 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
  * Pages in [@page_start,@page_end) have been populated to @chunk.  Update
  * the bookkeeping information accordingly.  Must be called after each
  * successful population.
- *
- * If this is @for_alloc, do not increment pcpu_nr_empty_pop_pages because it
- * is to serve an allocation in that area.
  */
 static void pcpu_chunk_populated(struct pcpu_chunk *chunk, int page_start,
 				 int page_end)
-- 
2.26.0.106.g9fadedd

