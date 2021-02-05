Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4015C31186B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBFChL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhBFCco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:44 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18EC08ECA2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:29:43 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id D58D6AEDEFB; Fri,  5 Feb 2021 23:28:59 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/5] dax-device: Properly handle drivers without remove callback
Date:   Fri,  5 Feb 2021 23:28:39 +0100
Message-Id: <20210205222842.34896-3-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all resources are allocated in .probe() using devm_ functions it
might make sense to not provide a .remove() callback. Then the right
thing is to just return success.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/dax/bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 72fc4b9b9ae6..2c9e3f6f615f 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -178,8 +178,12 @@ static int dax_bus_remove(struct device *dev)
 {
 	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
+	int ret = 0;
 
-	return dax_drv->remove(dev_dax);
+	if (dax_drv->remove)
+		ret = dax_drv->remove(dev_dax);
+
+	return ret;
 }
 
 static struct bus_type dax_bus_type = {
-- 
2.29.2

