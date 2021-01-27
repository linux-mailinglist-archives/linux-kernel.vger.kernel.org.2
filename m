Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D15A306787
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhA0XHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhA0XCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:02:12 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:01:28 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 21E01AE0D2C; Thu, 28 Jan 2021 00:01:27 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] dax-device: Fix error path in dax_driver_register
Date:   Thu, 28 Jan 2021 00:01:23 +0100
Message-Id: <20210127230124.109522-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127230124.109522-1-uwe@kleine-koenig.org>
References: <20210127230124.109522-1-uwe@kleine-koenig.org>
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
index 618d462975ba..498c60333d60 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1417,7 +1417,15 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
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

