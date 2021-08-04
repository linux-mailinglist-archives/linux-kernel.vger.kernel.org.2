Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB13E0370
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHDOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbhHDOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:38:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1377C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:37:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p5so2531825wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ZWPk7+tHwwQUoVBZmKXeuGPCR5jkfcKlPCiW0KLOiM=;
        b=Auz3Sqxy9OiRA7eMF6erDlUjpzk6k7FCOJQ/Ia6d8SiDfIvqQqzfqAMefWq+n2IsC4
         HnXKWTRyZrv5iupQo/zZJmiIYwhxIAzNG9NYCgp0TOb5AzKK6V2Z1MpGtZSj0gzWi2y9
         2/HfTd+ZM4A23c3lEYcSNqwBox8k8UeZ4LvxoepWjiqXacBOtYHO9F34hiIKoBK2Eztd
         +el3PvuCH94AZrd27hPdTD6jTTiN6THlezFhLnMA31iU63jQTjIaMUsVkwWiqfYqt1nr
         NL2v/NrNWDLnIRw300aoU87OdR8z3YLKCfS+uQ6Aw45k5C2aKaHHiXffyrmx50i7IDrV
         z3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ZWPk7+tHwwQUoVBZmKXeuGPCR5jkfcKlPCiW0KLOiM=;
        b=lXSqdT42CVuJRn1scoPSNhaqS1RjIMYq5Tclknj3b1K+KrktGpPiuFeSS8e/Otustq
         aHOmtwZ41PTncRV7SHgWyKji2NsAuLXBDC+SVbOhGy6E342e6PTimphOCQXQgSUJhuWM
         tzwk7ED/C0h/0HmD5g4lpDkw5o1nLJqZC+cuIIpF1w07hmmOvMXXhM/5JLw3ClK/9qUP
         XvjFdHTPc2AU6Rbl5DkkalGqB5o28ZUqifXsIftb2v4/MpitXWsESRo6aF+gxdX9bnLb
         2JPpCEwHXp4IF9fSO8zHGnqrgQMJRM3se00AP/VlQsB0RQGP/M8gYLi9Pn/IIxKdfP0u
         4oqQ==
X-Gm-Message-State: AOAM530U/96DJuhRbio9c0u/ZYI9bPVD26khSXpuFiJ5bVE/dRBpucJR
        FYVaVpDe+lyKKUqddB4vTx/CRgxqbEcZJw==
X-Google-Smtp-Source: ABdhPJznqTDQnE3lHtVT3M5ocBtDeSwhIDmqRg3Cym1DowVfbY6vQ6j1tHU5GNvgaL0yQx507T+y6g==
X-Received: by 2002:a5d:6184:: with SMTP id j4mr29617399wru.340.1628087870408;
        Wed, 04 Aug 2021 07:37:50 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id f17sm3362958wrt.18.2021.08.04.07.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:37:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/1] mfd: simple-mfd-i2c: Add support for registering devices via MFD cells
Date:   Wed,  4 Aug 2021 15:37:44 +0100
Message-Id: <20210804143744.689238-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
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
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

Michael, could you please test this on your platform to ensure I
         didn't break anything please?

 drivers/mfd/simple-mfd-i2c.c | 39 ++++++++++++++++++++++++++++--------
 drivers/mfd/simple-mfd-i2c.h | 27 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 8 deletions(-)
 create mode 100644 drivers/mfd/simple-mfd-i2c.h

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 87f684cff9a17..fec3f002a9119 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -2,39 +2,62 @@
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
+	if (simple_mfd_data->regmap_config)
+		regmap_config = simple_mfd_data->regmap_config;
+	else
+		regmap_config = &regmap_config_8r_8v;
 
-	regmap = devm_regmap_init_i2c(i2c, config);
+	regmap = devm_regmap_init_i2c(i2c, regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return devm_of_platform_populate(&i2c->dev);
+	if (!simple_mfd_data->mfd_cell)
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
index 0000000000000..a2a0bc45b4e3b
--- /dev/null
+++ b/drivers/mfd/simple-mfd-i2c.h
@@ -0,0 +1,27 @@
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
+ * Once the register map has been successfully initialised, any sub-devices
+ * represented by child nodes in Device Tree will be subsequently registered.
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
2.32.0.554.ge1b32706d8-goog

