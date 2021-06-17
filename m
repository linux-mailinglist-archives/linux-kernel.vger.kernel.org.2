Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FB83AAF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFQJNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:13:17 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7349 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhFQJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:13:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5GQc5qlYz6y5G;
        Thu, 17 Jun 2021 17:07:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:11:04 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:11:04 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] pstore: remove unnecessary oom message
Date:   Thu, 17 Jun 2021 17:10:54 +0800
Message-ID: <20210617091054.1547-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/pstore/platform.c |  4 +---
 fs/pstore/ram_core.c | 15 ++++-----------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b9614db48b1d..752c2338af6c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -752,10 +752,8 @@ void pstore_get_backend_records(struct pstore_info *psi,
 		int rc;
 
 		record = kzalloc(sizeof(*record), GFP_KERNEL);
-		if (!record) {
-			pr_err("out of memory creating record\n");
+		if (!record)
 			break;
-		}
 		pstore_record_init(record, psi);
 
 		record->size = psi->read(record);
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index fe5305028c6e..7da890505025 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -301,10 +301,8 @@ void persistent_ram_save_old(struct persistent_ram_zone *prz)
 	if (!prz->old_log) {
 		persistent_ram_ecc_old(prz);
 		prz->old_log = kmalloc(size, GFP_KERNEL);
-	}
-	if (!prz->old_log) {
-		pr_err("failed to allocate buffer\n");
-		return;
+		if (!prz->old_log)
+			return;
 	}
 
 	prz->old_log_size = size;
@@ -429,11 +427,8 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 	}
 
 	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		pr_err("%s: Failed to allocate array for %u pages\n",
-		       __func__, page_count);
+	if (!pages)
 		return NULL;
-	}
 
 	for (i = 0; i < page_count; i++) {
 		phys_addr_t addr = page_start + i * PAGE_SIZE;
@@ -578,10 +573,8 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	int ret = -ENOMEM;
 
 	prz = kzalloc(sizeof(struct persistent_ram_zone), GFP_KERNEL);
-	if (!prz) {
-		pr_err("failed to allocate persistent ram zone\n");
+	if (!prz)
 		goto err;
-	}
 
 	/* Initialize general buffer state. */
 	raw_spin_lock_init(&prz->buffer_lock);
-- 
2.25.1


