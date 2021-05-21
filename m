Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4247A38C98C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhEUOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:53:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:21068 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhEUOxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:53:52 -0400
IronPort-SDR: FOXPFyPNAjcE2CXF9SL27yKug9UBnajkIzwziwBxa5rX8J58Gd2VU4cSkEyhn6IAlgZxzjWOz7
 1bFz2KBTKhxw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="287040184"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287040184"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 07:52:29 -0700
IronPort-SDR: ZefJEzXEiUWQHBcRR4lw36LzYwpJ7zEPfbnpxytcSmXb8mmM7rR7WzKi2uxoFfyjrWoZzT1S/S
 H00O/akNSkAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="440957277"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2021 07:52:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20DD023A; Fri, 21 May 2021 17:52:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] usb: phy: isp1301: Deduplicate of_find_i2c_device_by_node()
Date:   Fri, 21 May 2021 17:52:43 +0300
Message-Id: <20210521145243.87911-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is using open-coded variant of of_find_i2c_device_by_node().
Replace it by the actual call to the above mentioned API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/phy/phy-isp1301.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/phy/phy-isp1301.c b/drivers/usb/phy/phy-isp1301.c
index 6cf6fbd39237..ad3d57f1c273 100644
--- a/drivers/usb/phy/phy-isp1301.c
+++ b/drivers/usb/phy/phy-isp1301.c
@@ -142,24 +142,17 @@ static struct i2c_driver isp1301_driver = {
 
 module_i2c_driver(isp1301_driver);
 
-static int match(struct device *dev, const void *data)
-{
-	const struct device_node *node = (const struct device_node *)data;
-	return (dev->of_node == node) &&
-		(dev->driver == &isp1301_driver.driver);
-}
-
 struct i2c_client *isp1301_get_client(struct device_node *node)
 {
-	if (node) { /* reference of ISP1301 I2C node via DT */
-		struct device *dev = bus_find_device(&i2c_bus_type, NULL,
-						     node, match);
-		if (!dev)
-			return NULL;
-		return to_i2c_client(dev);
-	} else { /* non-DT: only one ISP1301 chip supported */
-		return isp1301_i2c_client;
-	}
+	struct i2c_client *client;
+
+	/* reference of ISP1301 I2C node via DT */
+	client = of_find_i2c_device_by_node(node);
+	if (client)
+		return client;
+
+	/* non-DT: only one ISP1301 chip supported */
+	return isp1301_i2c_client;
 }
 EXPORT_SYMBOL_GPL(isp1301_get_client);
 
-- 
2.30.2

