Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E467B3F47A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhHWJdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:33:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:7159 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235961AbhHWJdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="217070404"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="217070404"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="507203877"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2021 02:32:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82F99D1; Mon, 23 Aug 2021 12:32:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 1/2] platform/x86: hp_accel: Remove _INI method call
Date:   Mon, 23 Aug 2021 12:32:21 +0300
Message-Id: <20210823093222.19544-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
References: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to ACPI specification the _INI method must be called
when device is enumerated first time. After that there is no need
to repeat the procedure. Convert the lis3lv02d_acpi_init() to be
a stub (Note, we may not remove it because it is called unconditionally
by the accelerometer main driver).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/lis3lv02d/lis3lv02d.h |  1 -
 drivers/platform/x86/hp_accel.c    | 14 +-------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.h b/drivers/misc/lis3lv02d/lis3lv02d.h
index 7ac788fae1b8..c394c0b08519 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.h
+++ b/drivers/misc/lis3lv02d/lis3lv02d.h
@@ -271,7 +271,6 @@ struct lis3lv02d {
 	int			regs_size;
 	u8                      *reg_cache;
 	bool			regs_stored;
-	bool			init_required;
 	u8                      odr_mask;  /* ODR bit mask */
 	u8			whoami;    /* indicates measurement precision */
 	s16 (*read_data) (struct lis3lv02d *lis3, int reg);
diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 8c0867bda828..54a4addc7903 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -78,23 +78,14 @@ static const struct acpi_device_id lis3lv02d_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
 
-
 /**
- * lis3lv02d_acpi_init - ACPI _INI method: initialize the device.
+ * lis3lv02d_acpi_init - initialize the device for ACPI
  * @lis3: pointer to the device struct
  *
  * Returns 0 on success.
  */
 static int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
 {
-	struct acpi_device *dev = lis3->bus_priv;
-	if (!lis3->init_required)
-		return 0;
-
-	if (acpi_evaluate_object(dev->handle, METHOD_NAME__INI,
-				 NULL, NULL) != AE_OK)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -359,7 +350,6 @@ static int lis3lv02d_add(struct acpi_device *device)
 	}
 
 	/* call the core layer do its init */
-	lis3_dev.init_required = true;
 	ret = lis3lv02d_init_device(&lis3_dev);
 	if (ret)
 		return ret;
@@ -407,14 +397,12 @@ static int lis3lv02d_suspend(struct device *dev)
 
 static int lis3lv02d_resume(struct device *dev)
 {
-	lis3_dev.init_required = false;
 	lis3lv02d_poweron(&lis3_dev);
 	return 0;
 }
 
 static int lis3lv02d_restore(struct device *dev)
 {
-	lis3_dev.init_required = true;
 	lis3lv02d_poweron(&lis3_dev);
 	return 0;
 }
-- 
2.32.0

