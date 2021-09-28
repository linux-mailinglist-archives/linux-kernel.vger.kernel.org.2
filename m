Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA241ABE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbhI1Jcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhI1JcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:22 -0400
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Sep 2021 02:30:38 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB70C061740;
        Tue, 28 Sep 2021 02:30:38 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 7279EC53;
        Tue, 28 Sep 2021 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821032;
        bh=OL+wLYUxy0gYzafQl0tDCAxXVTFEgMWaHXWJNw47X7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/IvhQUFC1S3knvGefzb8ZNayYDTTFr19IrAHEeDYC6Q5DfpKw3VdlTqSyzc5t5Se
         XulSt7S5QeHATdCj1zrjevkBi0vFd3fK80+9VW3srO+Zr29AfBgwckveDXhAkiRSjC
         2UauikC7JbsZsoSNtHgRL/r2vjRlLcfSEmvdY+3E=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] hwmon: (pmbus/lm25066) Support configurable sense resistor values
Date:   Tue, 28 Sep 2021 02:22:41 -0700
Message-Id: <20210928092242.30036-8-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The appropriate mantissa values for the lm25066 family's direct-format
current and power readings are a function of the sense resistor
employed between the SENSE and VIN pins of the chip.  Instead of
assuming that resistance is always the same 1mOhm as used in the
datasheet, allow it to be configured via a device-tree property
("shunt-resistor-micro-ohms").

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 Documentation/hwmon/lm25066.rst |  2 ++
 drivers/hwmon/pmbus/lm25066.c   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/hwmon/lm25066.rst b/Documentation/hwmon/lm25066.rst
index 9f1d7e4d3ca1..a2098eb24090 100644
--- a/Documentation/hwmon/lm25066.rst
+++ b/Documentation/hwmon/lm25066.rst
@@ -79,6 +79,8 @@ This driver does not auto-detect devices. You will have to instantiate the
 devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
 details.
 
+The shunt (sense) resistor value can be configured by a device tree property;
+see Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml for details.
 
 Platform data support
 ---------------------
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 18d5a76f346d..29e848bcd436 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -458,6 +458,7 @@ MODULE_DEVICE_TABLE(of, lm25066_of_match);
 static int lm25066_probe(struct i2c_client *client)
 {
 	int config;
+	u32 shunt;
 	struct lm25066_data *data;
 	struct pmbus_driver_info *info;
 	const struct __coeff *coeff;
@@ -535,6 +536,17 @@ static int lm25066_probe(struct i2c_client *client)
 		info->b[PSC_POWER] = coeff[PSC_POWER].b;
 	}
 
+	/*
+	 * Values in the TI datasheets are normalized for a 1mOhm sense
+	 * resistor; assume that unless DT specifies a value explicitly.
+	 */
+	if (of_property_read_u32(client->dev.of_node,
+	                         "shunt-resistor-micro-ohms", &shunt))
+		shunt = 1000;
+
+	info->m[PSC_CURRENT_IN] = info->m[PSC_CURRENT_IN] * shunt / 1000;
+	info->m[PSC_POWER] = info->m[PSC_POWER] * shunt / 1000;
+
 	return pmbus_do_probe(client, info);
 }
 
-- 
2.33.0

