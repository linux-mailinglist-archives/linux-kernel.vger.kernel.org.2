Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01308458060
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 21:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhKTUoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 15:44:04 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:11648 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhKTUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 15:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=pGcTRSrZpH8OcO+c2YTkQwVJBmV23KR1vDtsPqnti5M=;
        b=NHABS7BVzvqegvAyncB31iK5X5G0B197+Z/gfSXkN+ISnpfc4IDZ37ulw0ZRXxHXPR6R
        Tqu49ZYZ7KoqWBYBbPHz5P7Umk1k4aqluZRDCvC9QR9QZ8d3tiGKZZCuQZcBmHBywOEfzU
        zC2n2l9PcQhnV2GfDR1aC+y4gEQU0KHuz4sQQzBsUSSRRW+gsX1qyWZIFHIWW7Ng19oU+d
        WLJMi2Z/I4dHTlfh6NDv//Cpetf8WYFlrqeGs1U9L1UcCzWvZ97iJ3P2GWLrwb683wylLP
        jH3jzV+iB8kC3ShXSsffX5BU+BHo5z9tO0RiITSudXfdMTz/9vH8WPrvOt01b0JA==
Received: by filterdrecv-656998cfdd-ngmx2 with SMTP id filterdrecv-656998cfdd-ngmx2-1-61995D5B-6
        2021-11-20 20:40:59.184025275 +0000 UTC m=+5174019.480259924
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-5-1 (SG)
        with ESMTP
        id 7wN_pJ5sTCi_UYswl6wEyg
        Sat, 20 Nov 2021 20:40:59.053 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 2CD2F7002B2; Sat, 20 Nov 2021 13:40:58 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 2/2] hwmon: (sht4x) Add device tree match table and
 document it
Date:   Sat, 20 Nov 2021 20:40:59 +0000 (UTC)
Message-Id: <20211120204053.2299501-2-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211120204053.2299501-1-davidm@egauge.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvA8oAjtvYg7WnEhH=2F?=
 =?us-ascii?Q?dw91Ij2D1DVsWISMmT+H0oZXjWX6h4p6YE6+okN?=
 =?us-ascii?Q?PltGUV8J0NXodoJbBOUsyw4oUNUxP6Qn4A7Svfw?=
 =?us-ascii?Q?NaHZH1ypfnOB=2FxBOPehno0KAePT3ZA8I4Wz1PRR?=
 =?us-ascii?Q?OZT9FRF50jycLOtGxKcrhNfz9rr4qVJ+jpjDHGE?=
 =?us-ascii?Q?=2FMi2CTH5IsEtC4X9w=2F5hA=3D=3D?=
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables automatic loading of the sht4x module via a device
tree table entry.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 .../bindings/hwmon/sensirion,sht4x.yaml       | 50 +++++++++++++++++++
 drivers/hwmon/sht4x.c                         |  7 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
new file mode 100644
index 000000000000..588c2e37b035
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sensirion,sht4x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SHT4x Humidity and Temperature Sensor IC
+
+maintainers:
+  - Navin Sankar Velliangiri navin@linumiz.com
+
+description: |
+  The SHT4x is a high-accuracy digital humidity and temperature sensor
+  designed especially for battery-driven high-volume consumer
+  electronics applications.  For further information refere to
+  Documentation/hwmon/sht4x.rst
+
+  This binding document describes the binding for the hardware monitor
+  portion of the driver.
+
+properties:
+  compatible:
+    enum:
+      - sensirion,sht4x
+
+  reg:
+    const: 0x44
+    description:
+      The I2c base address of the SHT4x.  0x44 for all chip versions
+      except for SHT41-BD1B, where it is 0x45.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clock-frequency = <400000>;
+
+      sht4x@44 {
+        compatible = "sensirion,sht4x";
+        reg = <0x44>;
+      };
+    };
+...
diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index 3415d7a0e0fc..6e53d81e32d4 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -281,9 +281,16 @@ static const struct i2c_device_id sht4x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sht4x_id);
 
+static const struct of_device_id sht4x_of_match[] = {
+	{ .compatible = "sensirion,sht4x" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sht4x_of_match);
+
 static struct i2c_driver sht4x_driver = {
 	.driver = {
 		.name = "sht4x",
+		.of_match_table = sht4x_of_match
 	},
 	.probe		= sht4x_probe,
 	.id_table	= sht4x_id,
-- 
2.25.1

