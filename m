Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964AE3C68A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 04:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhGMCwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 22:52:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14072 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhGMCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 22:52:50 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GP4ll1tB9zYrlr;
        Tue, 13 Jul 2021 10:46:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 10:49:59 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 10:49:59 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Ming Lei" <ming.lei@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] firmware: fix use-after-free in _request_firmware()
Date:   Tue, 13 Jul 2021 10:49:42 +0800
Message-ID: <20210713024942.2881-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

		CPU0			CPU1
__device_uncache_fw_images():		assign_fw():
					fw_cache_piggyback_on_request()
					<----- P0
	spin_lock(&fwc->name_lock);
	...
	list_del(&fce->list);
	spin_unlock(&fwc->name_lock);

	uncache_firmware(fce->name);
					<----- P1
					kref_get(&fw_priv->ref);

If CPU1 is interrupted at position P0, the new 'fce' has been added to the
list fwc->fw_names by the fw_cache_piggyback_on_request(). In this case,
CPU0 executes __device_uncache_fw_images() and will be able to see it when
it traverses list fwc->fw_names. Before CPU1 executes kref_get() at P1, if
CPU0 further executes uncache_firmware(), the count of fw_priv->ref may
decrease to 0, causing fw_priv to be released in advance.

Move kref_get() to the lock protection range of fwc->name_lock to fix it.

Fixes: ac39b3ea73aa ("firmware loader: let caching firmware piggyback on loading firmware")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/base/firmware_loader/main.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 4fdb8219cd08..2f267b8d2fd9 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -165,7 +165,7 @@ static inline int fw_state_wait(struct fw_priv *fw_priv)
 	return __fw_state_wait_common(fw_priv, MAX_SCHEDULE_TIMEOUT);
 }
 
-static int fw_cache_piggyback_on_request(const char *name);
+static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv);
 
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
@@ -707,10 +707,8 @@ int assign_fw(struct firmware *fw, struct device *device)
 	 * on request firmware.
 	 */
 	if (!(fw_priv->opt_flags & FW_OPT_NOCACHE) &&
-	    fw_priv->fwc->state == FW_LOADER_START_CACHE) {
-		if (fw_cache_piggyback_on_request(fw_priv->fw_name))
-			kref_get(&fw_priv->ref);
-	}
+	    fw_priv->fwc->state == FW_LOADER_START_CACHE)
+		fw_cache_piggyback_on_request(fw_priv);
 
 	/* pass the pages buffer to driver at the last minute */
 	fw_set_page_data(fw_priv, fw);
@@ -1257,11 +1255,11 @@ static int __fw_entry_found(const char *name)
 	return 0;
 }
 
-static int fw_cache_piggyback_on_request(const char *name)
+static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv)
 {
-	struct firmware_cache *fwc = &fw_cache;
+	const char *name = fw_priv->fw_name;
+	struct firmware_cache *fwc = fw_priv->fwc;
 	struct fw_cache_entry *fce;
-	int ret = 0;
 
 	spin_lock(&fwc->name_lock);
 	if (__fw_entry_found(name))
@@ -1269,13 +1267,12 @@ static int fw_cache_piggyback_on_request(const char *name)
 
 	fce = alloc_fw_cache_entry(name);
 	if (fce) {
-		ret = 1;
 		list_add(&fce->list, &fwc->fw_names);
+		kref_get(&fw_priv->ref);
 		pr_debug("%s: fw: %s\n", __func__, name);
 	}
 found:
 	spin_unlock(&fwc->name_lock);
-	return ret;
 }
 
 static void free_fw_cache_entry(struct fw_cache_entry *fce)
@@ -1506,9 +1503,8 @@ static inline void unregister_fw_pm_ops(void)
 	unregister_pm_notifier(&fw_cache.pm_notify);
 }
 #else
-static int fw_cache_piggyback_on_request(const char *name)
+static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv)
 {
-	return 0;
 }
 static inline int register_fw_pm_ops(void)
 {
-- 
2.25.1

