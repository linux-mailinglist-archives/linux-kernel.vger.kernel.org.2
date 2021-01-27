Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4378A306789
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhA0XIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:08:16 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:46168 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhA0XCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:02:10 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id E2374AE0D2A; Thu, 28 Jan 2021 00:01:26 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] device-dax: Prevent registering drivers without probe or remove callback
Date:   Thu, 28 Jan 2021 00:01:22 +0100
Message-Id: <20210127230124.109522-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus probe and remove functions (dax_bus_probe and dax_bus_remove
respectively) call these functions without checking them to be non-NULL.
Add a check to prevent a NULL pointer exception.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/dax/bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 737b207c9e30..618d462975ba 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1392,6 +1392,14 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
 	struct device_driver *drv = &dax_drv->drv;
 	int rc = 0;
 
+	/*
+	 * dax_bus_probe() calls dax_drv->probe() unconditionally and
+	 * dax_bus_remove() calls dax_drv->remove() unconditionally. So better
+	 * be safe than sorry and ensure these are provided.
+	 */
+	if (!dax_drv->probe || !dax_drv->remove)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&dax_drv->ids);
 	drv->owner = module;
 	drv->name = mod_name;

base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
2.29.2

