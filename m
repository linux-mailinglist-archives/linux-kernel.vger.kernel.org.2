Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE738C06C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhEUHLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:11:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5644 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhEUHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:11:02 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fmd2J02fGz16Q7m;
        Fri, 21 May 2021 15:06:48 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 15:09:35 +0800
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 21
 May 2021 15:09:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/swapfile: move scan_swap_map() under CONFIG_HIBERNATION
Date:   Fri, 21 May 2021 15:08:55 +0800
Message-ID: <20210521070855.2015094-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should move scan_swap_map() under CONFIG_HIBERNATION since the only
caller of this function is get_swap_page_of_type() which is also under
CONFIG_HIBERNATION. And this fixes the unused-function warning of
scan_swap_map().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
Hi Andrew,
  Please feel free to merge this with
mm-swapfile-move-get_swap_page_of_type-under-config_hibernation.patch
---
 mm/swapfile.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4e7628b82e63..53d2161edfc0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1037,21 +1037,6 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
 }
 
-static unsigned long scan_swap_map(struct swap_info_struct *si,
-				   unsigned char usage)
-{
-	swp_entry_t entry;
-	int n_ret;
-
-	n_ret = scan_swap_map_slots(si, usage, 1, &entry);
-
-	if (n_ret)
-		return swp_offset(entry);
-	else
-		return 0;
-
-}
-
 int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 {
 	unsigned long size = swap_entry_size(entry_size);
@@ -1789,6 +1774,21 @@ int free_swap_and_cache(swp_entry_t entry)
 
 #ifdef CONFIG_HIBERNATION
 
+static unsigned long scan_swap_map(struct swap_info_struct *si,
+				   unsigned char usage)
+{
+	swp_entry_t entry;
+	int n_ret;
+
+	n_ret = scan_swap_map_slots(si, usage, 1, &entry);
+
+	if (n_ret)
+		return swp_offset(entry);
+	else
+		return 0;
+
+}
+
 swp_entry_t get_swap_page_of_type(int type)
 {
 	struct swap_info_struct *si = swap_type_to_swap_info(type);
-- 
2.23.0

