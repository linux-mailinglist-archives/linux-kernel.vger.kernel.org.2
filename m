Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF9D36C107
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhD0Ieb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:34:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17043 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhD0Iea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:34:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FTw2701V6zPrfX;
        Tue, 27 Apr 2021 16:30:39 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 27 Apr 2021
 16:33:38 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH] mm/sparse: Fix flags overlap in section_mem_map
Date:   Tue, 27 Apr 2021 08:30:19 +0000
Message-ID: <20210427083019.110184-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section_mem_map member of struct mem_section stores some flags and
the address of struct page array of the mem_section.

Additionally the node id of the mem_section is stored during early boot,
where the struct page array has not been allocated. In other words, the
higher bits of section_mem_map are used for two purpose, and the node id
should be clear properly after the early boot.

Currently the node id field is overlapped with the flag field and cannot
be clear properly. That overlapped bits would then be treated as
mem_section flags and may lead to unexpected side effects.

Define SECTION_NID_SHIFT using order_base_2 to ensure that the node id
field always locates after flags field. That's why the overlap occurs -
forgetting to increase SECTION_NID_SHIFT when adding new mem_section
flag.

Fixes: 326e1b8f83a4 ("mm/sparsemem: introduce a SECTION_IS_EARLY flag")
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 include/linux/mmzone.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946ce..b01694d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1325,7 +1325,7 @@ extern size_t mem_section_usage_size(void);
 #define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
 #define SECTION_MAP_LAST_BIT		(1UL<<5)
 #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
-#define SECTION_NID_SHIFT		3
+#define SECTION_NID_SHIFT		order_base_2(SECTION_MAP_LAST_BIT)
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
-- 
2.9.4

