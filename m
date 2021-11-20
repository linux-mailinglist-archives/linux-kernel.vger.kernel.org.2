Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D704745805D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 21:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhKTUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 15:43:17 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:45878 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhKTUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 15:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=OaW8TBJK0gAZECqvr3Ggo3aumc1hO95J3CUsj9GFMQ8=;
        b=mabLrEzFzRJL+YYptFCeB/sz1i5hqust/baeYKzZVMPrkOTDRS7Sa0GvI2TPWMmDh3cW
        rHkfTMeCgtTDSp8vl54XpHpdljSdQ28x2Bw8ND9CxyzLA/pHinzbWuPcghaA4nNzGwB9fe
        fr0ysA0C54yQz8NapclIPsvxODcR+s/jzxhkVZX0Nj0GA/cBedK/smW/BpVYVBLoPgxt+6
        xM+uKWdx5ulWNhHhST+b7Lng0LbomLR+Y/p7fEs0Z9p7I9s2xYyJcJWzVsCoM6lPxxbeos
        jzXXJVAj4YkjndhA4lf3f2nH6cZKm7eTrN6mkDU3HYKjkGQ8kmJQUwMprgT4KJog==
Received: by filterdrecv-55446c4d49-vth2g with SMTP id filterdrecv-55446c4d49-vth2g-1-61995BFA-4
        2021-11-20 20:35:06.122575595 +0000 UTC m=+6905697.961899248
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-2-0 (SG)
        with ESMTP
        id ll3qRdD8TV28tob41iUjqA
        Sat, 20 Nov 2021 20:35:05.984 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id A6B62700297; Sat, 20 Nov 2021 13:35:05 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH 2/2] hwmon: (sht4x) Add device tree match table and document
 it
Date:   Sat, 20 Nov 2021 20:35:06 +0000 (UTC)
Message-Id: <20211120203443.2299276-2-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211120203443.2299276-1-davidm@egauge.net>
References: <20211120203443.2299276-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvOUtKsV6b3M6Ot72l?=
 =?us-ascii?Q?hFdy18UO7iblsn5FA0PxST4VBVpmeeiwiUZJ89J?=
 =?us-ascii?Q?JsNJVdX1UN2oLLAC5RMPG9Ja+z45q7yFONr5HrT?=
 =?us-ascii?Q?9IeX2d=2FIwPzQbXn4s5624kKI=2FFAfoiCanliXBOx?=
 =?us-ascii?Q?9zH3avQcKtfxTITW32vqX3VlWCwCIoudXxv250f?=
 =?us-ascii?Q?e+wTCLIfGbZrHhEi7Ov7w=3D=3D?=
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
 arch/arm/boot/dts/egauge-cpk.dts              |  5 ++
 drivers/hwmon/sht4x.c                         |  7 +++
 3 files changed, 62 insertions(+)
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
diff --git a/arch/arm/boot/dts/egauge-cpk.dts b/arch/arm/boot/dts/egauge-cpk.dts
index 17f85b2d54a2..ee8b52c92248 100644
--- a/arch/arm/boot/dts/egauge-cpk.dts
+++ b/arch/arm/boot/dts/egauge-cpk.dts
@@ -477,6 +477,11 @@ tmp102@48 {
 					reg = <0x48>;
 					pagesize = <16>;
 				};
+
+				sht4x@44 {
+					compatible = "sensirion,sht4x";
+					reg = <0x44>;
+				};
 			};
 
 			securam: sram@f8044000 {
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

