Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BC3AD6E0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 04:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhFSC6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 22:58:20 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8279 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhFSC6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 22:58:17 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G6Kzj1gypz1BP4Z;
        Sat, 19 Jun 2021 10:50:57 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 10:56:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>, <nathan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/zbud: fix unused function warnings when CONFIG_ZPOOL is disabled
Date:   Sat, 19 Jun 2021 10:55:08 +0800
Message-ID: <20210619025508.1239386-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several -Wunused-function warnings when CONFIG_ZPOOL is disabled.
As zbud won't do anything when CONFIG_ZPOOL is disabled, we can make zbud
depends on ZPOOL and eliminate the CONFIG_ZPOOL macro in zbud.c to fix
these warnings.

Fixes: 962b7e9ad124 ("mm/zbud: don't export any zbud API")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
Hi, Andrew:
Please feel free to merge this patch with
mm-zbud-dont-export-any-zbud-api.patch.
Many thanks!
---
 mm/Kconfig |  1 +
 mm/zbud.c  | 10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 8f748010f7ea..5dc28e9205e0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -674,6 +674,7 @@ config ZPOOL
 
 config ZBUD
 	tristate "Low (Up to 2x) density storage for compressed pages"
+	depends on ZPOOL
 	help
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to two compressed pages per physical
diff --git a/mm/zbud.c b/mm/zbud.c
index 3f61304405cb..6348932430b8 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -111,10 +111,8 @@ struct zbud_pool {
 	struct list_head lru;
 	u64 pages_nr;
 	const struct zbud_ops *ops;
-#ifdef CONFIG_ZPOOL
 	struct zpool *zpool;
 	const struct zpool_ops *zpool_ops;
-#endif
 };
 
 /*
@@ -526,8 +524,6 @@ static u64 zbud_get_pool_size(struct zbud_pool *pool)
  * zpool
  ****************/
 
-#ifdef CONFIG_ZPOOL
-
 static int zbud_zpool_evict(struct zbud_pool *pool, unsigned long handle)
 {
 	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
@@ -618,7 +614,6 @@ static struct zpool_driver zbud_zpool_driver = {
 };
 
 MODULE_ALIAS("zpool-zbud");
-#endif /* CONFIG_ZPOOL */
 
 static int __init init_zbud(void)
 {
@@ -626,19 +621,14 @@ static int __init init_zbud(void)
 	BUILD_BUG_ON(sizeof(struct zbud_header) > ZHDR_SIZE_ALIGNED);
 	pr_info("loaded\n");
 
-#ifdef CONFIG_ZPOOL
 	zpool_register_driver(&zbud_zpool_driver);
-#endif
 
 	return 0;
 }
 
 static void __exit exit_zbud(void)
 {
-#ifdef CONFIG_ZPOOL
 	zpool_unregister_driver(&zbud_zpool_driver);
-#endif
-
 	pr_info("unloaded\n");
 }
 
-- 
2.23.0

