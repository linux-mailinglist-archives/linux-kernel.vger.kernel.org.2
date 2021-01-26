Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30135304FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhA0Dht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:37:49 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:35362 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbhAZVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:54:29 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id F06B4ADF34E; Tue, 26 Jan 2021 22:53:43 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: google: make coreboot driver's remove callback return void
Date:   Tue, 26 Jan 2021 22:53:39 +0100
Message-Id: <20210126215339.706021-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All coreboot drivers return 0 unconditionally in their remove callback.
Also the device core ignores the return value of the struct
bus_type::remove(), so make the coreboot remove callback return void
instead of giving driver authors the illusion they could return an error
code here.

All drivers are adapted accordingly.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

there is no registerd maintainer of this code. I assume so Greg will
pick this up?!

Best regards
Uwe

 drivers/firmware/google/coreboot_table.c       | 5 ++---
 drivers/firmware/google/coreboot_table.h       | 2 +-
 drivers/firmware/google/framebuffer-coreboot.c | 4 +---
 drivers/firmware/google/memconsole-coreboot.c  | 4 +---
 drivers/firmware/google/vpd.c                  | 4 +---
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 0205987a4fd4..dc83ea118c67 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -46,14 +46,13 @@ static int coreboot_bus_probe(struct device *dev)
 
 static int coreboot_bus_remove(struct device *dev)
 {
-	int ret = 0;
 	struct coreboot_device *device = CB_DEV(dev);
 	struct coreboot_driver *driver = CB_DRV(dev->driver);
 
 	if (driver->remove)
-		ret = driver->remove(device);
+		driver->remove(device);
 
-	return ret;
+	return 0;
 }
 
 static struct bus_type coreboot_bus_type = {
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 7b7b4a6eedda..beb778674acd 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -72,7 +72,7 @@ struct coreboot_device {
 /* A driver for handling devices described in coreboot tables. */
 struct coreboot_driver {
 	int (*probe)(struct coreboot_device *);
-	int (*remove)(struct coreboot_device *);
+	void (*remove)(struct coreboot_device *);
 	struct device_driver drv;
 	u32 tag;
 };
diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index 916f26adc595..c6dcc1ef93ac 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -72,13 +72,11 @@ static int framebuffer_probe(struct coreboot_device *dev)
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
-static int framebuffer_remove(struct coreboot_device *dev)
+static void framebuffer_remove(struct coreboot_device *dev)
 {
 	struct platform_device *pdev = dev_get_drvdata(&dev->dev);
 
 	platform_device_unregister(pdev);
-
-	return 0;
 }
 
 static struct coreboot_driver framebuffer_driver = {
diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index d17e4d6ac9bc..74b5286518ee 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -91,11 +91,9 @@ static int memconsole_probe(struct coreboot_device *dev)
 	return memconsole_sysfs_init();
 }
 
-static int memconsole_remove(struct coreboot_device *dev)
+static void memconsole_remove(struct coreboot_device *dev)
 {
 	memconsole_exit();
-
-	return 0;
 }
 
 static struct coreboot_driver memconsole_driver = {
diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index d23c5c69ab52..ee6e08c0592b 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -298,14 +298,12 @@ static int vpd_probe(struct coreboot_device *dev)
 	return 0;
 }
 
-static int vpd_remove(struct coreboot_device *dev)
+static void vpd_remove(struct coreboot_device *dev)
 {
 	vpd_section_destroy(&ro_vpd);
 	vpd_section_destroy(&rw_vpd);
 
 	kobject_put(vpd_kobj);
-
-	return 0;
 }
 
 static struct coreboot_driver vpd_driver = {
-- 
2.29.2

