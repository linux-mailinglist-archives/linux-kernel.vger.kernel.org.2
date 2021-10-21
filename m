Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B6B435909
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhJUDne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 23:43:34 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26106 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJUDn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 23:43:28 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HZYBM4SSNz1DHlQ;
        Thu, 21 Oct 2021 11:39:23 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 11:41:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 11:41:10 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <weiyongjun1@huawei.com>, <huawei.libin@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/page_alloc: use clamp() to simplify code
Date:   Thu, 21 Oct 2021 11:48:30 +0800
Message-ID: <20211021034830.1049150-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses clamp() to simplify code in init_per_zone_wmark_min().

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 mm/page_alloc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..d0449212a824 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8460,16 +8460,12 @@ int __meminit init_per_zone_wmark_min(void)
 	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
 	new_min_free_kbytes = int_sqrt(lowmem_kbytes * 16);
 
-	if (new_min_free_kbytes > user_min_free_kbytes) {
-		min_free_kbytes = new_min_free_kbytes;
-		if (min_free_kbytes < 128)
-			min_free_kbytes = 128;
-		if (min_free_kbytes > 262144)
-			min_free_kbytes = 262144;
-	} else {
+	if (new_min_free_kbytes > user_min_free_kbytes)
+		min_free_kbytes = clamp(new_min_free_kbytes, 128, 262144);
+	else
 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
-	}
+
 	setup_per_zone_wmarks();
 	refresh_zone_stat_thresholds();
 	setup_per_zone_lowmem_reserve();
-- 
2.25.1

