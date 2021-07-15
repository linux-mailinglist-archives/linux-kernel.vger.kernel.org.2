Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3983C9E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbhGOMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:31:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6937 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhGOMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:31:55 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQYVZ0QWwz7tvn;
        Thu, 15 Jul 2021 20:25:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 20:29:00 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/3] mm/vmstat: correct some wrong comments
Date:   Thu, 15 Jul 2021 20:29:09 +0800
Message-ID: <20210715122911.15700-2-linmiaohe@huawei.com>
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

Correct wrong fls(mem+1) to fls(mem)+1 and remove the duplicated
comment with quiet_vmstat().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmstat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..57e8e7fda7aa 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -204,7 +204,7 @@ int calculate_normal_threshold(struct zone *zone)
 	 *
 	 * Some sample thresholds:
 	 *
-	 * Threshold	Processors	(fls)	Zonesize	fls(mem+1)
+	 * Threshold	Processors	(fls)	Zonesize	fls(mem)+1
 	 * ------------------------------------------------------------------
 	 * 8		1		1	0.9-1 GB	4
 	 * 16		2		2	0.9-1 GB	4
@@ -1873,11 +1873,6 @@ static void vmstat_update(struct work_struct *w)
 	}
 }
 
-/*
- * Switch off vmstat processing and then fold all the remaining differentials
- * until the diffs stay at zero. The function is used by NOHZ and can only be
- * invoked when tick processing is not active.
- */
 /*
  * Check if the diffs for a certain cpu indicate that
  * an update is needed.
-- 
2.23.0

