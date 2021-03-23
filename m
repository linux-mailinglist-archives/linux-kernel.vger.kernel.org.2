Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CC346317
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhCWPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhCWPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:37:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80683C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:37:39 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lOj63-0006Fu-SA; Tue, 23 Mar 2021 16:37:31 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lOj62-0006Yk-5P; Tue, 23 Mar 2021 16:37:30 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel@pengutronix.de, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] driver core: add helper for deferred probe reason setting
Date:   Tue, 23 Mar 2021 16:37:13 +0100
Message-Id: <20210323153714.25120-2-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210323153714.25120-1-a.fatoum@pengutronix.de>
References: <20210323153714.25120-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have three places within the same file doing the same operation
of freeing this pointer and setting it anew. A helper makes this
arguably easier to read, so add one.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v2 -> v3:
 - fixed typo in commit message (Andy)
 - collected Andy's and Andrzej's Reviewed-by
v1 -> v2:
 - no change
---
 drivers/base/dd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e2cf3b29123e..4201baa1cc13 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -69,6 +69,12 @@ static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
  */
 static bool defer_all_probes;
 
+static void __device_set_deferred_probe_reason(const struct device *dev, char *reason)
+{
+	kfree(dev->p->deferred_probe_reason);
+	dev->p->deferred_probe_reason = reason;
+}
+
 /*
  * deferred_probe_work_func() - Retry probing devices in the active list.
  */
@@ -97,8 +103,7 @@ static void deferred_probe_work_func(struct work_struct *work)
 
 		get_device(dev);
 
-		kfree(dev->p->deferred_probe_reason);
-		dev->p->deferred_probe_reason = NULL;
+		__device_set_deferred_probe_reason(dev, NULL);
 
 		/*
 		 * Drop the mutex while probing each device; the probe path may
@@ -140,8 +145,7 @@ void driver_deferred_probe_del(struct device *dev)
 	if (!list_empty(&dev->p->deferred_probe)) {
 		dev_dbg(dev, "Removed from deferred list\n");
 		list_del_init(&dev->p->deferred_probe);
-		kfree(dev->p->deferred_probe_reason);
-		dev->p->deferred_probe_reason = NULL;
+		__device_set_deferred_probe_reason(dev, NULL);
 	}
 	mutex_unlock(&deferred_probe_mutex);
 }
@@ -220,11 +224,12 @@ void device_unblock_probing(void)
 void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf)
 {
 	const char *drv = dev_driver_string(dev);
+	char *reason;
 
 	mutex_lock(&deferred_probe_mutex);
 
-	kfree(dev->p->deferred_probe_reason);
-	dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
+	reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
+	__device_set_deferred_probe_reason(dev, reason);
 
 	mutex_unlock(&deferred_probe_mutex);
 }
-- 
2.29.2

