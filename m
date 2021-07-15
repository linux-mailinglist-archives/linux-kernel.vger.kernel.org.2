Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987EB3C9E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhGOMcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:32:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11426 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhGOMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:31:55 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQYVt5qctzcdbd;
        Thu, 15 Jul 2021 20:25:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 20:29:00 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/3] mm/vmstat: remove unneeded return value
Date:   Thu, 15 Jul 2021 20:29:11 +0800
Message-ID: <20210715122911.15700-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210715122911.15700-1-linmiaohe@huawei.com>
References: <20210715122911.15700-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of pagetypeinfo_showfree and pagetypeinfo_showblockcount
are unused now. Remove them.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmstat.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 76aef9510f6d..6246bab9fae2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1452,7 +1452,7 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 }
 
 /* Print out the free pages at each order for each migatetype */
-static int pagetypeinfo_showfree(struct seq_file *m, void *arg)
+static void pagetypeinfo_showfree(struct seq_file *m, void *arg)
 {
 	int order;
 	pg_data_t *pgdat = (pg_data_t *)arg;
@@ -1464,8 +1464,6 @@ static int pagetypeinfo_showfree(struct seq_file *m, void *arg)
 	seq_putc(m, '\n');
 
 	walk_zones_in_node(m, pgdat, true, false, pagetypeinfo_showfree_print);
-
-	return 0;
 }
 
 static void pagetypeinfo_showblockcount_print(struct seq_file *m,
@@ -1501,7 +1499,7 @@ static void pagetypeinfo_showblockcount_print(struct seq_file *m,
 }
 
 /* Print out the number of pageblocks for each migratetype */
-static int pagetypeinfo_showblockcount(struct seq_file *m, void *arg)
+static void pagetypeinfo_showblockcount(struct seq_file *m, void *arg)
 {
 	int mtype;
 	pg_data_t *pgdat = (pg_data_t *)arg;
@@ -1512,8 +1510,6 @@ static int pagetypeinfo_showblockcount(struct seq_file *m, void *arg)
 	seq_putc(m, '\n');
 	walk_zones_in_node(m, pgdat, true, false,
 		pagetypeinfo_showblockcount_print);
-
-	return 0;
 }
 
 /*
-- 
2.23.0

