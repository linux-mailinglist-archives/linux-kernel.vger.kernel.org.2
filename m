Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5C4453C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhKDN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:26:19 -0400
Received: from comms.puri.sm ([159.203.221.185]:42050 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhKDN0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:26:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id BB11EDFE3F;
        Thu,  4 Nov 2021 06:23:37 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cukb2HYcOONW; Thu,  4 Nov 2021 06:23:37 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v1 1/4] arm64: dts: split out a shared imx8mq-librem5-r3.dtsi description
Date:   Thu,  4 Nov 2021 14:22:10 +0100
Message-Id: <20211104132213.470498-2-martin.kepplinger@puri.sm>
In-Reply-To: <20211104132213.470498-1-martin.kepplinger@puri.sm>
References: <20211104132213.470498-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Librem 5 r3 ("Dogwood") and r4 ("Evergreen") revisions are quite
similar. Add a shared imx8mq-librem5-r3.dtsi description to be included
in r3 and later dts files in order to avoid duplication.

This is no change in the descriptions but only refactoring.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../boot/dts/freescale/imx8mq-librem5-r3.dts  | 25 ++-------------
 .../boot/dts/freescale/imx8mq-librem5-r3.dtsi | 32 +++++++++++++++++++
 .../boot/dts/freescale/imx8mq-librem5-r4.dts  | 16 ++--------
 3 files changed, 36 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
index cd3c3edd48fa..4533a84fb0b9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
@@ -1,14 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-// Copyright (C) 2020 Purism SPC <kernel@puri.sm>
+// Copyright (C) 2021 Purism SPC <kernel@puri.sm>
 
 /dts-v1/;
 
-#include "imx8mq-librem5.dtsi"
-
-/ {
-	model = "Purism Librem 5r3";
-	compatible = "purism,librem5r3", "purism,librem5", "fsl,imx8mq";
-};
+#include "imx8mq-librem5-r3.dtsi"
 
 &a53_opp_table {
 	opp-1000000000 {
@@ -16,22 +11,6 @@ opp-1000000000 {
 	};
 };
 
-&accel_gyro {
-	mount-matrix =  "1",  "0",  "0",
-			"0",  "1",  "0",
-			"0",  "0", "-1";
-};
-
-&bq25895 {
-	ti,battery-regulation-voltage = <4200000>; /* uV */
-	ti,charge-current = <1500000>; /* uA */
-	ti,termination-current = <144000>;  /* uA */
-};
-
 &buck3_reg {
 	regulator-always-on;
 };
-
-&proximity {
-	proximity-near-level = <25>;
-};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
new file mode 100644
index 000000000000..e872eb4b1cf9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2021 Purism SPC <kernel@puri.sm>
+
+/dts-v1/;
+
+/*
+ * This file describes hardware that is shared among r3 ("Dogwood") and
+ * later revisions of the Librem 5 so it has to be included in dts there.
+ */
+
+#include "imx8mq-librem5.dtsi"
+
+/ {
+	model = "Purism Librem 5r3";
+	compatible = "purism,librem5r3", "purism,librem5", "fsl,imx8mq";
+};
+
+&accel_gyro {
+	mount-matrix =  "1",  "0",  "0",
+			"0",  "1",  "0",
+			"0",  "0", "-1";
+};
+
+&bq25895 {
+	ti,battery-regulation-voltage = <4200000>; /* uV */
+	ti,charge-current = <1500000>; /* uA */
+	ti,termination-current = <144000>;  /* uA */
+};
+
+&proximity {
+	proximity-near-level = <25>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
index cbfb49aa2563..30d65bef6939 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
@@ -1,31 +1,19 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-// Copyright (C) 2020 Purism SPC <kernel@puri.sm>
+// Copyright (C) 2021 Purism SPC <kernel@puri.sm>
 
 /dts-v1/;
 
-#include "imx8mq-librem5.dtsi"
+#include "imx8mq-librem5-r3.dtsi"
 
 / {
 	model = "Purism Librem 5r4";
 	compatible = "purism,librem5r4", "purism,librem5", "fsl,imx8mq";
 };
 
-&accel_gyro {
-	mount-matrix =  "1",  "0",  "0",
-			"0",  "1",  "0",
-			"0",  "0", "-1";
-};
-
 &bat {
 	maxim,rsns-microohm = <1667>;
 };
 
-&bq25895 {
-	ti,battery-regulation-voltage = <4200000>; /* uV */
-	ti,charge-current = <1500000>; /* uA */
-	ti,termination-current = <144000>;  /* uA */
-};
-
 &led_backlight {
 	led-max-microamp = <25000>;
 };
-- 
2.30.2

