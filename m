Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532A4428EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhJKNvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:51:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28918 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhJKNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:49:40 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSg3h0brDzbmlY;
        Mon, 11 Oct 2021 21:43:12 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 21:47:38 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 21:47:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>
Subject: [PATCH] regmap: Fix possible double-free in regcache_rbtree_exit()
Date:   Mon, 11 Oct 2021 21:55:26 +0800
Message-ID: <20211011135526.282115-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In regcache_rbtree_insert_to_block(), when 'present' realloc failed,
the 'blk' which is supposed to assign to 'rbnode->block' will be freed,
so 'rbnode->block' points a freed memory, in the error handling path of
regcache_rbtree_init(), 'rbnode->block' will be freed again in
regcache_rbtree_exit(), KASAN will report double-free as follows:

BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390
Call Trace:
 dump_stack_lvl+0xe2/0x152
 print_address_description.constprop.7+0x21/0x150
 kasan_report_invalid_free+0x6f/0xa0
 __kasan_slab_free+0x125/0x140
 slab_free_freelist_hook+0x10d/0x240
 kfree+0xce/0x390
 regcache_rbtree_exit+0x15d/0x1a0
 regcache_rbtree_init+0x224/0x2c0
 regcache_init+0x88d/0x1310
 __regmap_init+0x3151/0x4a80
 __devm_regmap_init+0x7d/0x100
 madera_spi_probe+0x10f/0x333 [madera_spi]
 spi_probe+0x183/0x210
 really_probe+0x285/0xc30

Set rbnode->block to NULL when the 'present' realloc failed to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 3f4ff561bc88b ("regmap: rbtree: Make cache_present bitmap per node")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/regmap/regcache-rbtree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index cfa29dc89bbf..125111688399 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -287,6 +287,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 				   GFP_KERNEL);
 		if (!present) {
 			kfree(blk);
+			rbnode->block = NULL;
 			return -ENOMEM;
 		}
 
-- 
2.25.1

