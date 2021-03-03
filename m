Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A332BAB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351832AbhCCLuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352982AbhCCEjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 23:39:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5EC061222
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 20:36:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id ba1so13352419plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 20:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWoZPWwwHGAL2k3xw9fvM4kJRs/zmeCKq0B2nkIcJR4=;
        b=LM2VJTa6dwSb4iya4bA/vucztZ/+oKJ1lQ6bb6j/SAJKwkfUp9pqylOQs1L2s4RUnb
         rSnbBEYGC+Iizjco+nHwIXIDtGAcDxPxmFfJR9JMhOhvP/CtyvS28e8Ai2O4IuoZIba4
         I2a5UCp4G2GdmvL1z+jYOcay1I+M47FLfURRkFAO53ExDcQGat06/cVjPEcqEuHaLfoL
         75pEs/aLr+TafWSP8qTmpBrS6XQIiaPTVsV/WpBrPfuvEmf6Zfd03EhK9tYT5Xjj+/+E
         0oJfSBIb79Cy7LKrYjVdWivmIzAQb1yktaw6F5hkrJPfguv6RbUsJ+0j3f/B+WT9D1Bt
         W/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWoZPWwwHGAL2k3xw9fvM4kJRs/zmeCKq0B2nkIcJR4=;
        b=qxq0s48z7p+vlt9h0LBKKm253Rz0IvdrNozTOvQ2g06vpnNPNN2VG7NZO9CK+4v8IE
         /V/JucD9IGdx35wqX+c7uRp4q3QsicM62GTYwaw0SJQZMtfRuf9oJ49DuuoP3rRJBNu6
         nwSUhLVK7NZmqqO1k0EZ/mjLWbNDXm5WhWSztSWEVwdL9BTmQKWIRleyPgPwZGkm3Xdn
         Zm87LDPV7gbinApwtFW7x0WBaBTOz1KrMyAzkjB4Kjds7BBGZl1zkhIAhZSYNusD+zfP
         iRikHyNOuCRpSc14thA2HkRTHN1RXlQtlVreeQwvKbKkLvUCj+08iSCM0+7lG8npqAdu
         mEoA==
X-Gm-Message-State: AOAM533xKuWO9aUzcZwy6vPzCWNka2PHZ+MPIbj3Htucz4BKyiZjOoUB
        oIeIUqkj+s34KhmuE++awclyom8q8EdX/w==
X-Google-Smtp-Source: ABdhPJx7rh3IugZsL2aR/MFqemF5+UFn22Ft5DDlrL1MGf0XQgYi2B5vcEm2nArB/TnevXg/Ox04kg==
X-Received: by 2002:a17:902:fe96:b029:e4:2f39:9083 with SMTP id x22-20020a170902fe96b02900e42f399083mr6522459plm.47.1614746203591;
        Tue, 02 Mar 2021 20:36:43 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id gf20sm5180896pjb.39.2021.03.02.20.36.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 20:36:43 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V9 3/4] of: unittest: Create overlay_common.dtsi and testcases_common.dtsi
Date:   Wed,  3 Mar 2021 10:06:19 +0530
Message-Id: <6d51a42f0174560cee8d4b98dc3a48944d190adb.1614745266.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1614745266.git.viresh.kumar@linaro.org>
References: <cover.1614745266.git.viresh.kumar@linaro.org>
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
 drivers/of/unittest-data/testcases.dts        | 23 ++---
 .../of/unittest-data/testcases_common.dtsi    | 19 ++++
 .../of/unittest-data/tests-interrupts.dtsi    | 11 +--
 5 files changed, 128 insertions(+), 106 deletions(-)
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
index a85b5e1c381a..b80d6009ad7a 100644
--- a/drivers/of/unittest-data/testcases.dts
+++ b/drivers/of/unittest-data/testcases.dts
@@ -2,19 +2,20 @@
 /dts-v1/;
 /plugin/;
 
+#include "testcases_common.dtsi"
+
 / {
+        /*
+	 * testcase data that intentionally results in an error is located here
+	 * instead of in testcases_common.dtsi so that the static overlay apply
+	 * tests will not include the error.
+         */
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
index ec175e800725..6c58fd61585c 100644
--- a/drivers/of/unittest-data/tests-interrupts.dtsi
+++ b/drivers/of/unittest-data/tests-interrupts.dtsi
@@ -62,11 +62,10 @@ testcase-device1 {
 			interrupts = <1>;
 		};
 
-		testcase-device2 {
-			compatible = "testcase-device";
-			interrupt-parent = <&test_intc2>;
-			interrupts = <1>; /* invalid specifier - too short */
-		};
+		/*
+		 * testcase data that intentionally results in an error is
+		 * located in testcases.dts instead of in this file so that the
+		 * static overlay apply tests will not include the error.
+                 */
 	};
-
 };
-- 
2.25.0.rc1.19.g042ed3e048af

