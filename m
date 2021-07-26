Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5823D5184
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 05:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhGZCdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 22:33:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7059 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGZCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 22:33:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GY4cj2FwhzYcmK;
        Mon, 26 Jul 2021 11:08:21 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 11:14:14 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 11:14:13 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <weiyongjun1@huawei.com>
CC:     Chen Wandun <chenwandun@huawei.com>
Subject: [PATCH] mm/vmalloc: add missing __GFP_HIGHMEM flag for vmalloc
Date:   Mon, 26 Jul 2021 11:23:33 +0800
Message-ID: <20210726032333.3404164-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct page array can also be allocated in highmem during vmalloc,
that will ease the low memory stress in 32bit system.

Fixes: f255935b9767 ("mm: cleanup the gfp_mask handling in __vmalloc_area_node")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3824dc16ce1c..8d9b0b08a6dc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2885,7 +2885,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
-		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
+		area->pages = __vmalloc_node(array_size, 1,
+					nested_gfp | __GFP_HIGHMEM, node,
 					area->caller);
 	} else {
 		area->pages = kmalloc_node(array_size, nested_gfp, node);
-- 
2.25.1

