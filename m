Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7F308677
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhA2HaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhA2H26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:28:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5BCC061797
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i63so5677921pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGwObSDNhpTlCqU8x6dXBIYlNo68oQYaoM82x8ri0qg=;
        b=Ka2nLljTKsgHHL6xIl2fDVxg51v2ofmJOrKkj3Kp7txrwojwxCA4YY2CJmmB9cW1Cd
         dMVbgD1J0VtZLI34fsuLgeEvstcvaBlCULhsKzhQiV1rBzNiHoxaWlSIGDYqLa/NTRYL
         EOOnQ8Im2mCuCnERfSsyVCIomsjulMvRODf7msjiBPR8w39fk6N0fiJmEKzj5k9wST1E
         L32849rlAHXvVGr5+NQ+aSXfiSdiCs8ZJtxWMBsUClN9ICn884TTbaO7G/npEnacSezQ
         xgnaRuJeriOdDo1BLkHgncm86UQMcycVCnO8O+4HR912jWBmDG3KHF+A4RwdwfIX/kCi
         9vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGwObSDNhpTlCqU8x6dXBIYlNo68oQYaoM82x8ri0qg=;
        b=owoeTazFuXVGsrsPS3Sv4J0+baRvWXKfDsGUikaWU32dPjEthtlacKuZbCxyFb8AJx
         yKECrGYHcDkeqi3R0KFBrxmyIbkggzoJvqVi/mqbKUnOik8iM7wDPulsr/nHPxVmkcWt
         nKdZuB+H+EkjDTji9jGzbJQOXN1+TJHn0KH321djZ29jNVHwlB1C05Y2wa8X0WEQjpAy
         h0HN2fP8VWOgl8m5q+08pnVhpoyNiXayxSQg8ZUksH7zjsvlX2b+Zz1nR5f8TcLMf6w1
         ppCqMenvlZ8ET6gr3gYj6Vb9A9KC02ElUaBNJwuWnA3nAO3D9muTcEdU7w+eTyn3xMVr
         krsw==
X-Gm-Message-State: AOAM53244s5NwN4IC+yEaqmxONw2V4yjqePu9SW7T2rp++BT5XXpyfqR
        VMRw05877HVHAekXfw1dZsowZw==
X-Google-Smtp-Source: ABdhPJysbqC5C0W+pMMGBr1PgM9yq1y/e9oFwVZ2jWYLDxDgdG859ZtUjBA5KEvWyR763uyawu6hog==
X-Received: by 2002:aa7:8f13:0:b029:1bd:f965:66d8 with SMTP id x19-20020aa78f130000b02901bdf96566d8mr3211704pfr.80.1611905268786;
        Thu, 28 Jan 2021 23:27:48 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id g15sm7474300pfb.30.2021.01.28.23.27.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 23:27:48 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH V7 5/6] of: unittest: Create overlay_common.dtsi and testcases_common.dtsi
Date:   Fri, 29 Jan 2021 12:54:09 +0530
Message-Id: <585e77b8c8a613103f3251af969514f2aa6d0e0d.1611904394.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611904394.git.viresh.kumar@linaro.org>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to build-test the same unit-test files using fdtoverlay tool,
move the device nodes from the existing overlay_base.dts and
testcases_common.dts files to .dtsi counterparts. The .dts files now
include the new .dtsi files, resulting in exactly the same behavior as
earlier.

The .dtsi files can now be reused for compile time tests using
fdtoverlay (will be done by a later commit).

This is required because the base files passed to fdtoverlay tool
shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
tag).

Note that this commit also moves "testcase-device2" node to
testcases.dts from tests-interrupts.dtsi, as this node has a deliberate
error in it and is only relevant for runtime testing done with
unittest.c.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
 drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
 drivers/of/unittest-data/testcases.dts        | 18 ++--
 .../of/unittest-data/testcases_common.dtsi    | 19 ++++
 .../of/unittest-data/tests-interrupts.dtsi    |  7 --
 5 files changed, 118 insertions(+), 107 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
 create mode 100644 drivers/of/unittest-data/testcases_common.dtsi

diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
index 99ab9d12d00b..ab9014589c5d 100644
--- a/drivers/of/unittest-data/overlay_base.dts
+++ b/drivers/of/unittest-data/overlay_base.dts
@@ -2,92 +2,4 @@
 /dts-v1/;
 /plugin/;
 
-/*
- * Base device tree that overlays will be applied against.
- *
- * Do not add any properties in node "/".
- * Do not add any nodes other than "/testcase-data-2" in node "/".
- * Do not add anything that would result in dtc creating node "/__fixups__".
- * dtc will create nodes "/__symbols__" and "/__local_fixups__".
- */
-
-/ {
-	testcase-data-2 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		electric_1: substation@100 {
-			compatible = "ot,big-volts-control";
-			reg = < 0x00000100 0x100 >;
-			status = "disabled";
-
-			hvac_1: hvac-medium-1 {
-				compatible = "ot,hvac-medium";
-				heat-range = < 50 75 >;
-				cool-range = < 60 80 >;
-			};
-
-			spin_ctrl_1: motor-1 {
-				compatible = "ot,ferris-wheel-motor";
-				spin = "clockwise";
-				rpm_avail = < 50 >;
-			};
-
-			spin_ctrl_2: motor-8 {
-				compatible = "ot,roller-coaster-motor";
-			};
-		};
-
-		rides_1: fairway-1 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "ot,rides";
-			status = "disabled";
-			orientation = < 127 >;
-
-			ride@100 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "ot,roller-coaster";
-				reg = < 0x00000100 0x100 >;
-				hvac-provider = < &hvac_1 >;
-				hvac-thermostat = < 29 > ;
-				hvac-zones = < 14 >;
-				hvac-zone-names = "operator";
-				spin-controller = < &spin_ctrl_2 5 &spin_ctrl_2 7 >;
-				spin-controller-names = "track_1", "track_2";
-				queues = < 2 >;
-
-				track@30 {
-					reg = < 0x00000030 0x10 >;
-				};
-
-				track@40 {
-					reg = < 0x00000040 0x10 >;
-				};
-
-			};
-		};
-
-		lights_1: lights@30000 {
-			compatible = "ot,work-lights";
-			reg = < 0x00030000 0x1000 >;
-			status = "disabled";
-		};
-
-		lights_2: lights@40000 {
-			compatible = "ot,show-lights";
-			reg = < 0x00040000 0x1000 >;
-			status = "disabled";
-			rate = < 13 138 >;
-		};
-
-		retail_1: vending@50000 {
-			reg = < 0x00050000 0x1000 >;
-			compatible = "ot,tickets";
-			status = "disabled";
-		};
-
-	};
-};
-
+#include "overlay_common.dtsi"
diff --git a/drivers/of/unittest-data/overlay_common.dtsi b/drivers/of/unittest-data/overlay_common.dtsi
new file mode 100644
index 000000000000..08874a72556e
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_common.dtsi
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Base device tree that overlays will be applied against.
+ *
+ * Do not add any properties in node "/".
+ * Do not add any nodes other than "/testcase-data-2" in node "/".
+ * Do not add anything that would result in dtc creating node "/__fixups__".
+ * dtc will create nodes "/__symbols__" and "/__local_fixups__".
+ */
+
+/ {
+	testcase-data-2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		electric_1: substation@100 {
+			compatible = "ot,big-volts-control";
+			reg = < 0x00000100 0x100 >;
+			status = "disabled";
+
+			hvac_1: hvac-medium-1 {
+				compatible = "ot,hvac-medium";
+				heat-range = < 50 75 >;
+				cool-range = < 60 80 >;
+			};
+
+			spin_ctrl_1: motor-1 {
+				compatible = "ot,ferris-wheel-motor";
+				spin = "clockwise";
+				rpm_avail = < 50 >;
+			};
+
+			spin_ctrl_2: motor-8 {
+				compatible = "ot,roller-coaster-motor";
+			};
+		};
+
+		rides_1: fairway-1 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "ot,rides";
+			status = "disabled";
+			orientation = < 127 >;
+
+			ride@100 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "ot,roller-coaster";
+				reg = < 0x00000100 0x100 >;
+				hvac-provider = < &hvac_1 >;
+				hvac-thermostat = < 29 > ;
+				hvac-zones = < 14 >;
+				hvac-zone-names = "operator";
+				spin-controller = < &spin_ctrl_2 5 &spin_ctrl_2 7 >;
+				spin-controller-names = "track_1", "track_2";
+				queues = < 2 >;
+
+				track@30 {
+					reg = < 0x00000030 0x10 >;
+				};
+
+				track@40 {
+					reg = < 0x00000040 0x10 >;
+				};
+
+			};
+		};
+
+		lights_1: lights@30000 {
+			compatible = "ot,work-lights";
+			reg = < 0x00030000 0x1000 >;
+			status = "disabled";
+		};
+
+		lights_2: lights@40000 {
+			compatible = "ot,show-lights";
+			reg = < 0x00040000 0x1000 >;
+			status = "disabled";
+			rate = < 13 138 >;
+		};
+
+		retail_1: vending@50000 {
+			reg = < 0x00050000 0x1000 >;
+			compatible = "ot,tickets";
+			status = "disabled";
+		};
+
+	};
+};
+
diff --git a/drivers/of/unittest-data/testcases.dts b/drivers/of/unittest-data/testcases.dts
index a85b5e1c381a..04b9e7bb30d9 100644
--- a/drivers/of/unittest-data/testcases.dts
+++ b/drivers/of/unittest-data/testcases.dts
@@ -2,19 +2,15 @@
 /dts-v1/;
 /plugin/;
 
+#include "testcases_common.dtsi"
+
 / {
 	testcase-data {
-		changeset {
-			prop-update = "hello";
-			prop-remove = "world";
-			node-remove {
-			};
+		testcase-device2 {
+			compatible = "testcase-device";
+			interrupt-parent = <&test_intc2>;
+			interrupts = <1>; /* invalid specifier - too short */
 		};
 	};
+
 };
-#include "tests-phandle.dtsi"
-#include "tests-interrupts.dtsi"
-#include "tests-match.dtsi"
-#include "tests-address.dtsi"
-#include "tests-platform.dtsi"
-#include "tests-overlay.dtsi"
diff --git a/drivers/of/unittest-data/testcases_common.dtsi b/drivers/of/unittest-data/testcases_common.dtsi
new file mode 100644
index 000000000000..19292bbb4cbb
--- /dev/null
+++ b/drivers/of/unittest-data/testcases_common.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	testcase-data {
+		changeset {
+			prop-update = "hello";
+			prop-remove = "world";
+			node-remove {
+			};
+		};
+	};
+};
+
+#include "tests-phandle.dtsi"
+#include "tests-interrupts.dtsi"
+#include "tests-match.dtsi"
+#include "tests-address.dtsi"
+#include "tests-platform.dtsi"
+#include "tests-overlay.dtsi"
diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
index ec175e800725..0e5914611107 100644
--- a/drivers/of/unittest-data/tests-interrupts.dtsi
+++ b/drivers/of/unittest-data/tests-interrupts.dtsi
@@ -61,12 +61,5 @@ testcase-device1 {
 			interrupt-parent = <&test_intc0>;
 			interrupts = <1>;
 		};
-
-		testcase-device2 {
-			compatible = "testcase-device";
-			interrupt-parent = <&test_intc2>;
-			interrupts = <1>; /* invalid specifier - too short */
-		};
 	};
-
 };
-- 
2.25.0.rc1.19.g042ed3e048af

