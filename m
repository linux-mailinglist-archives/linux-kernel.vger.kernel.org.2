Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3930CFA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 00:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhBBXHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 18:07:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:46405 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234178AbhBBXHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:07:18 -0500
IronPort-SDR: 93AmQRtO6H5jiIumPDnBci64ZeZeAJm8vVNI6AIC9R2VExyEuDdbxGFesSgovo/6X8SXftOeR/
 /IiTOONf3mcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="168057653"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="168057653"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:06:36 -0800
IronPort-SDR: SbboyzEzvKEZlnYVW/pRewGsiMfXCnW4BRE6HhZqjBMfPIvcCEWYs+7w4mw467y31/GTt1gqGO
 +y/33G95j98A==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="579211239"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.22.86])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:06:35 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
Date:   Tue,  2 Feb 2021 15:06:31 -0800
Message-Id: <20210202230631.198950-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port enable is not complete until ACK = 0. Change
__afu_port_enable() to guarantee that the enable process
is complete by polling for ACK == 0.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v3:
  - afu_port_err_clear() changed to prioritize port_enable failure over
    other a detected mismatch in port errors.
  - reorganized code in port_reset() to be more readable.
v2:
  - Fixed typo in commit message
---
 drivers/fpga/dfl-afu-error.c |  8 ++++----
 drivers/fpga/dfl-afu-main.c  | 31 ++++++++++++++++++++++---------
 drivers/fpga/dfl-afu.h       |  2 +-
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index c4691187cca9..2ced610059cc 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -52,7 +52,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct platform_device *pdev = to_platform_device(dev);
 	void __iomem *base_err, *base_hdr;
-	int ret = -EBUSY;
+	int enable_ret = 0, ret = -EBUSY;
 	u64 v;
 
 	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
@@ -102,12 +102,12 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	/* Clear mask */
 	__afu_port_err_mask(dev, false);
 
-	/* Enable the Port by clear the reset */
-	__afu_port_enable(pdev);
+	/* Enable the Port by clearing the reset */
+	enable_ret = __afu_port_enable(pdev);
 
 done:
 	mutex_unlock(&pdata->lock);
-	return ret;
+	return enable_ret ? enable_ret : ret;
 }
 
 static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 753cda4b2568..729eb306062e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -21,6 +21,9 @@
 
 #include "dfl-afu.h"
 
+#define RST_POLL_INVL 10 /* us */
+#define RST_POLL_TIMEOUT 1000 /* us */
+
 /**
  * __afu_port_enable - enable a port by clear reset
  * @pdev: port platform device.
@@ -32,7 +35,7 @@
  *
  * The caller needs to hold lock for protection.
  */
-void __afu_port_enable(struct platform_device *pdev)
+int __afu_port_enable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
 	WARN_ON(!pdata->disable_count);
 
 	if (--pdata->disable_count != 0)
-		return;
+		return 0;
 
 	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
 
@@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
 	v = readq(base + PORT_HDR_CTRL);
 	v &= ~PORT_CTRL_SFTRST;
 	writeq(v, base + PORT_HDR_CTRL);
-}
 
-#define RST_POLL_INVL 10 /* us */
-#define RST_POLL_TIMEOUT 1000 /* us */
+	/*
+	 * HW clears the ack bit to indicate that the port is fully out
+	 * of reset.
+	 */
+	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
+			       !(v & PORT_CTRL_SFTRST_ACK),
+			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
+		dev_err(&pdev->dev, "timeout, failure to enable device\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
 
 /**
  * __afu_port_disable - disable a port by hold reset
@@ -111,9 +124,9 @@ static int __port_reset(struct platform_device *pdev)
 
 	ret = __afu_port_disable(pdev);
 	if (!ret)
-		__afu_port_enable(pdev);
+		return ret;
 
-	return ret;
+	return __afu_port_enable(pdev);
 }
 
 static int port_reset(struct platform_device *pdev)
@@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
 static int port_enable_set(struct platform_device *pdev, bool enable)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&pdata->lock);
 	if (enable)
-		__afu_port_enable(pdev);
+		ret = __afu_port_enable(pdev);
 	else
 		ret = __afu_port_disable(pdev);
 	mutex_unlock(&pdata->lock);
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 576e94960086..e5020e2b1f3d 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -80,7 +80,7 @@ struct dfl_afu {
 };
 
 /* hold pdata->lock when call __afu_port_enable/disable */
-void __afu_port_enable(struct platform_device *pdev);
+int __afu_port_enable(struct platform_device *pdev);
 int __afu_port_disable(struct platform_device *pdev);
 
 void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
-- 
2.25.1

