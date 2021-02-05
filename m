Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6EF3119DB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBFCbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBFCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:30:58 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC0BC08EC35
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:29:03 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 37AB9AEDEFD; Fri,  5 Feb 2021 23:29:01 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/5] dax-device: Fix error path in dax_driver_register
Date:   Fri,  5 Feb 2021 23:28:40 +0100
Message-Id: <20210205222842.34896-4-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static variable match_always_count is supposed to track if there is
a driver registered that has .match_always set. If driver_register()
fails, the previous increment must be undone.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/dax/bus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 2c9e3f6f615f..bc425f1c52bd 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1420,7 +1420,15 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
 	mutex_unlock(&dax_bus_lock);
 	if (rc)
 		return rc;
-	return driver_register(drv);
+
+	rc = driver_register(drv);
+	if (rc && dax_drv->match_always) {
+		mutex_lock(&dax_bus_lock);
+		match_always_count -= dax_drv->match_always;
+		mutex_unlock(&dax_bus_lock);
+	}
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(__dax_driver_register);
 
-- 
2.29.2

