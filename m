Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFD312782
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBGVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 16:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBGVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 16:16:22 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ABCC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 13:15:41 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 59707AF2DF8; Sun,  7 Feb 2021 22:15:39 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: platform: Emit a warning if a remove callback returned non-zero
Date:   Sun,  7 Feb 2021 22:15:37 +0100
Message-Id: <20210207211537.19992-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core ignores the return value of a bus' remove callback. However
a driver returning an error code is a hint that there is a problem,
probably a driver author who expects that returning e.g. -EBUSY has any
effect.

The right thing to do would be to make struct platform_driver::remove()
return void. With the immense number of platform drivers this is however a
big quest and I hope to prevent at least a few new drivers that return an
error code here.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/base/platform.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 95fd1549f87d..1a869e277109 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1461,13 +1461,16 @@ static int platform_remove(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
-	int ret = 0;
 
-	if (drv->remove)
-		ret = drv->remove(dev);
+	if (drv->remove) {
+		int ret = drv->remove(dev);
+
+		if (ret)
+			dev_warn(_dev, "remove callback returned a non-zero value. This will be ignored.\n");
+	}
 	dev_pm_domain_detach(_dev, true);
 
-	return ret;
+	return 0;
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.29.2

