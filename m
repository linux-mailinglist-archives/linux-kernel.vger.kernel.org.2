Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F893118B8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBFCb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBFCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:30:58 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDC6C08EC87
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:29:40 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 745DAAEDEF9; Fri,  5 Feb 2021 23:28:58 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/5] dax-device: Prevent registering drivers without probe callback
Date:   Fri,  5 Feb 2021 23:28:38 +0100
Message-Id: <20210205222842.34896-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus probe function dax_bus_probe() calls the probe callback without
checking it to be non-NULL. Prevent a NULL pointer exception if a driver
without a probe function is registered by refusing to register this
driver.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/dax/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 737b207c9e30..72fc4b9b9ae6 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1392,6 +1392,13 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
 	struct device_driver *drv = &dax_drv->drv;
 	int rc = 0;
 
+	/*
+	 * dax_bus_probe() calls dax_drv->probe() unconditionally.
+	 * So better be safe than sorry and ensure it is provided.
+	 */
+	if (!dax_drv->probe)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&dax_drv->ids);
 	drv->owner = module;
 	drv->name = mod_name;
-- 
2.29.2

