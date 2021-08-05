Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8893E10A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbhHEI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHEI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:56:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AEC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 01:56:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c9so5477960wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShTZj+HIAeLpiq9YvD+6pHmtdjVO68mn7AFkKA0+vc8=;
        b=aOHovJdNObp9K7lLrz3Ph4D1/eFfv+qkCoCGmptK5mt8SdusqOG/RJkxOtjJ9pCS25
         gkCzloVHb4CpRhTLm0WP3TxavvhiNC4uxG+0KhEe65iBGIjFL+1JnAq9HN0AYEE424D6
         fYjFl8fcAMsH2Rg3ehXeKU1z7ta25L4MnxVdywF/kSo9jlh78crDYIHCr4hLLx4OATRC
         D1SQbS5ugYw28NKwt71GDkNAM8jiVg52q4JIQI/kfptOg3a8zvA88PB+ZRIv4IwEAqpy
         M0mDQ1i6+dzL6stS6SASCivLb5+CuGmkLdgEkK9oCNu6fAelwfLYcsdGDwAqZOkOZr58
         ydpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShTZj+HIAeLpiq9YvD+6pHmtdjVO68mn7AFkKA0+vc8=;
        b=mUl9WEcsCYETVRydhbNOAagat1z5aBS5sRdPK0MR+6uF2Wq6+X7ADLXh3tx/xS2DK5
         mUPnc0v8yaJUD8tOVaGvG0Mac2SWsLRyqRK8iaNq+qPAW1ClzwWCaH826u7gFnRYmr/k
         hm88UHLwenUiQSTjrDbg1ypDDgO7Ku/+fkQ2fPIPPkDEN48vuNj/iR8CXcxm1pQ8yl21
         XMhgLeGW1NU6xUbFCLPo81T/nSj/B8WIiHOgPZ6TAmcv5y3z7z4DFvtNo9R06/ecQeCt
         YA3cnc98hXI971Ze5lb26NzUUT9ptscsBLYTfTBRPQid/vdzShglCSYBMsljbVD30vyS
         kzlg==
X-Gm-Message-State: AOAM5300QhwMPc9AKc5ZDtMugATtsv05e+BcfwFsxAatvk8gPZ3SgwgX
        xt3t3DEHH2OlrtTgbu4ZSL+p8Q==
X-Google-Smtp-Source: ABdhPJybwz4TiJiuC7dy1v3KbuLmu60twVjOp2sL/z0tM65W9LwawmNRLQh/dX0Z0Yh6+TBiOJPAiA==
X-Received: by 2002:adf:db07:: with SMTP id s7mr4078662wri.106.1628153780889;
        Thu, 05 Aug 2021 01:56:20 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id o28sm1116144wms.14.2021.08.05.01.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 01:56:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Alistair Francis <alistair23@gmail.com>
Subject: [PATCH v2 1/1] mfd: simple-mfd-i2c: Add support for registering devices via MFD cells
Date:   Thu,  5 Aug 2021 09:56:11 +0100
Message-Id: <20210805085611.864188-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More devices are cropping up requiring only Regmap initialisation and
child registration functionality.  We currently only support that if
all required devices are represented by their own Device Tree nodes
complete with compatible strings.

However, not everyone is happy with adding empty nodes that provide no
additional device information into the Device Tree.

Rather than have a plethora of mostly empty, function-less drivers in
MFD, we'll support those simple cases in here instead via MFD cells.

Cc: Michael Walle <michael@walle.cc>
Cc: Mark Brown <broonie@kernel.org>
Cc: Alistair Francis <alistair23@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
v2:
 - Check for empty of_device_id .data entry 

 drivers/mfd/simple-mfd-i2c.c | 41 +++++++++++++++++++++++++++++-------
 drivers/mfd/simple-mfd-i2c.h | 32 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 8 deletions(-)
 create mode 100644 drivers/mfd/simple-mfd-i2c.h

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 87f684cff9a17..583e8c7924af0 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -2,39 +2,64 @@
 /*
  * Simple MFD - I2C
  *
+ * Author(s):
+ * 	Michael Walle <michael@walle.cc>
+ * 	Lee Jones <lee.jones@linaro.org>
+ *
  * This driver creates a single register map with the intention for it to be
  * shared by all sub-devices.  Children can use their parent's device structure
  * (dev.parent) in order to reference it.
  *
  * Once the register map has been successfully initialised, any sub-devices
- * represented by child nodes in Device Tree will be subsequently registered.
+ * represented by child nodes in Device Tree or via the MFD cells in this file
+ * will be subsequently registered.
  */
 
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 
-static const struct regmap_config simple_regmap_config = {
+#include "simple-mfd-i2c.h"
+
+static const struct regmap_config regmap_config_8r_8v = {
 	.reg_bits = 8,
 	.val_bits = 8,
 };
 
 static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 {
-	const struct regmap_config *config;
+	const struct simple_mfd_data *simple_mfd_data;
+	const struct regmap_config *regmap_config;
 	struct regmap *regmap;
+	int ret;
+
+	simple_mfd_data = device_get_match_data(&i2c->dev);
 
-	config = device_get_match_data(&i2c->dev);
-	if (!config)
-		config = &simple_regmap_config;
+	/* If no regmap_config is specified, use the default 8reg and 8val bits */
+	if (!simple_mfd_data || !simple_mfd_data->regmap_config)
+		regmap_config = &regmap_config_8r_8v;
+	else
+		regmap_config = simple_mfd_data->regmap_config;
 
-	regmap = devm_regmap_init_i2c(i2c, config);
+	regmap = devm_regmap_init_i2c(i2c, regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return devm_of_platform_populate(&i2c->dev);
+	/* If no MFD cells are spedified, use register the DT child nodes instead */
+	if (!simple_mfd_data || !simple_mfd_data->mfd_cell)
+		return devm_of_platform_populate(&i2c->dev);
+
+	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
+				   simple_mfd_data->mfd_cell,
+				   simple_mfd_data->mfd_cell_size,
+				   NULL, 0, NULL);
+	if (!ret)
+		dev_err(&i2c->dev, "Failed to add child devices\n");
+
+	return ret;
 }
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
diff --git a/drivers/mfd/simple-mfd-i2c.h b/drivers/mfd/simple-mfd-i2c.h
new file mode 100644
index 0000000000000..7cb2bdd347d97
--- /dev/null
+++ b/drivers/mfd/simple-mfd-i2c.h
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Simple MFD - I2C
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ *
+ * This driver creates a single register map with the intention for it to be
+ * shared by all sub-devices.  Children can use their parent's device structure
+ * (dev.parent) in order to reference it.
+ *
+ * This driver creates a single register map with the intention for it to be
+ * shared by all sub-devices.  Children can use their parent's device structure
+ * (dev.parent) in order to reference it.
+ *
+ * Once the register map has been successfully initialised, any sub-devices
+ * represented by child nodes in Device Tree or via the MFD cells in the
+ * associated C file will be subsequently registered.
+ */
+
+#ifndef __MFD_SIMPLE_MFD_I2C_H
+#define __MFD_SIMPLE_MFD_I2C_H
+
+#include <linux/mfd/core.h>
+#include <linux/regmap.h>
+
+struct simple_mfd_data {
+	const struct regmap_config *regmap_config;
+	const struct mfd_cell *mfd_cell;
+	size_t mfd_cell_size;
+};
+
+#endif /* __MFD_SIMPLE_MFD_I2C_H */
-- 
2.32.0.605.g8dce9f2422-goog

