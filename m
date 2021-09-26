Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C2418889
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhIZMH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:07:26 -0400
Received: from mout.web.de ([212.227.17.11]:43277 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhIZMHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
        s=dbaedf251592; t=1632657928;
        bh=+vHOWrkPb1sSZ91BYj3MQjUGez3FIoNWvLTaLDtzVUM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YmBY3GlrKZY01zBtdqkFi7aMax0BMy4RhMUU5vt3OdY1IG05D/s9T04dxNE10sPS5
         B7rAzdhl0anUPdHEZQFg21TKVKgJNoPfR9WV4l7fayII4Z6SYSebJo94FZ0RdDl3Uc
         hBp3f7QfdV1mThV49Cfa6qSrYtLdw3FWuzphSQf4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.fritz.box ([94.217.148.121]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bhz-1mo3tI48Nr-00st09; Sun, 26
 Sep 2021 14:05:28 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v5 5/6] arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
Date:   Sun, 26 Sep 2021 14:05:16 +0200
Message-Id: <31fece05f9728a852c0632985c4fa537cced4ece.1632657917.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632657916.git.jan.kiszka@web.de>
References: <cover.1632657916.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gzXeEhXWwqZSo5abWKAopAKbgKhn+KlRVBMCAkFlsmUjgNFhCAJ
 8Jb9KxIDNp5XMRMJ2hBmuDVdlRJ8mH0OzEMxAT0hs3ylx+l1ZDAH76jIzNfBkawv1eRZkFP
 D7WQoHf5yMqL5n33Vg5LA6e5gvdOMoDg7+XvyLBnUaQ6hE4mBE++avEdaxYL53Z/ObnLxwL
 KO4h9X8Dvm1qx0wdHZ0UA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+kH0dlX3++I=:ZSTSvxd3QOFSKgwtrxAqa0
 fsrjF3ayd0+C3a0wkcTU9uyo/0poQUEZQtuDBNARcXtqmkxncin5XFrqDjEy+JxjhO2Fe6jvu
 mvvHvxRs3Q/ToRI07ZGmVq2gn5aQW90TJneSch3Eq9mqTnsb8aj94erLuEOr/h0cCRmESz0R0
 HxwmIj6u5Qhw8yJ9h948OI96Qgb+brBq072u0b6ICuKaO47jlNgyOhrjbVfkv23aXngUM2WSV
 ixMvDLTAy+m9PSZvwoWHOBR5UaODLasYcyW9NmH4fljp+2l6BegOulbuxQsvTPFAkkg8k1wwL
 ZgD1wVGEn56wAFUD7qguFCXv9juqy0h+elPPxiecIMN6eZQGUL0Zj6gTXNYLoQc6Q+iwsb+SC
 dWnwIjuyphBEtJ0XWba3cNqWV7CSKF6gsVpXz9E9O5iAQYd8emm5MWMP0WMleY9pJSuG1S6YP
 xIf710YwtAlncOylTf7WXrUBgSyMUV66ioOkQ8V83LpWwuxMJV5KHx0Zi5gIaw4IaixSRyrgu
 mK5gYAaTq2fGB7Nel8rqwJF1ld08pl16kLwxHjdjL2/s07+xNUPuyyhGof2rsddsyVADNo/bx
 LmtbUmshefQMZ/pXtYgXFlHl3RyNJZnQwnfnsren77QOBK/+wDKOPn9g52JG3VwzziRnBLTd5
 QXCehTYLc+tV5VegxM3YJmtzHwIDPS+wGXz59B1+5pSxUMF19SwA2CLK5Sif5aO8Y3oN++fPI
 1/dLHYT+cuV1Fi4d2F4yB/R628zjcnvAXZ/6+Qg7ZJBhanQgBX8RHgGdmohf5QT/z+SwIbrcr
 tk5QhhMYZhogK2jrFcWC+tIKJvpmtzobW34x8HAVfcqi3Nm86JD6Rhelwe/JNMevwhzPa2llM
 QODkTN9WteVUxT4JNc03BKykNuxkh+y11XEZB2IjHTKBHSHMXrGs/SkPwzYU5EXTG0tlYkukZ
 MDRAYExdddWt9wZg8K/FpLhftgyDouCVUSM7LGLgnL8Tct8EgqXrOPkoalA2zR4gJCLF+y+p6
 x7ecHJHr+dyQo81o0kKQavPBOyTvFtEnO/Sc2p5trgCUT+fRao/NwRNg5UwSbT53Jt0GG2e8A
 bfCm68DVkY3cvs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The current IOT2050 devices are Product Generation 1 (PG1), using SR1.0
AM65x silicon. Upcoming PG2 devices will use SR2.x SoCs and will
therefore need separate device trees. Prepare for that by factoring out
common bits that will be shared across both generations.

At this chance, drop a link to the product homepage to in the top-level
dts files. Also fix a typo in my email address in some headers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 +++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 35 +-----------
 ...ts =3D> k3-am6528-iot2050-basic-common.dtsi} | 12 +---
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 56 +++----------------
 ...=3D> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
 .../dts/ti/k3-am6548-iot2050-advanced.dts     | 50 +++--------------
 6 files changed, 67 insertions(+), 140 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts =3D> k3-am6528-i=
ot2050-basic-common.dtsi} (80%)
 copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts =3D> k3-am654=
8-iot2050-advanced-common.dtsi} (85%)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch=
/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
new file mode 100644
index 000000000000..51f902fa35a7
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2021
+ *
+ * Authors:
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Common bits of the IOT2050 Basic and Advanced variants, PG1
+ */
+
+&dss {
+	assigned-clocks =3D <&k3_clks 67 2>;
+	assigned-clock-parents =3D <&k3_clks 67 5>;
+};
+
+&serdes0 {
+	status =3D "disabled";
+};
+
+&sdhci1 {
+	no-1-8-v;
+};
+
+&tx_pru0_0 {
+	status =3D "disabled";
+};
+
+&tx_pru0_1 {
+	status =3D "disabled";
+};
+
+&tx_pru1_0 {
+	status =3D "disabled";
+};
+
+&tx_pru1_1 {
+	status =3D "disabled";
+};
+
+&tx_pru2_0 {
+	status =3D "disabled";
+};
+
+&tx_pru2_1 {
+	status =3D "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm=
64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index b29537088289..65da226847f4 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -4,13 +4,11 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * Common bits of the IOT2050 Basic and Advanced variants
+ * Common bits of the IOT2050 Basic and Advanced variants, PG1 and PG2
  */

-/dts-v1/;
-
 #include "k3-am654.dtsi"
 #include <dt-bindings/phy/phy.h>

@@ -557,7 +555,6 @@ &sdhci1 {
 	pinctrl-0 =3D <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm =3D <50>;
 	disable-wp;
-	no-1-8-v;
 };

 &usb0 {
@@ -631,10 +628,6 @@ dpi_out: endpoint {
 	};
 };

-&serdes0 {
-	status =3D "disabled";
-};
-
 &pcie0_rc {
 	status =3D "disabled";
 };
@@ -738,27 +731,3 @@ &icssg1_mdio {
 &icssg2_mdio {
 	status =3D "disabled";
 };
-
-&tx_pru0_0 {
-	status =3D "disabled";
-};
-
-&tx_pru0_1 {
-	status =3D "disabled";
-};
-
-&tx_pru1_0 {
-	status =3D "disabled";
-};
-
-&tx_pru1_1 {
-	status =3D "disabled";
-};
-
-&tx_pru2_0 {
-	status =3D "disabled";
-};
-
-&tx_pru2_1 {
-	status =3D "disabled";
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm=
64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
similarity index 80%
copy from arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
copy to arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 94bb5dd39122..4a9bf7d7c07d 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -4,20 +4,14 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6528-based (dual-core) IOT2050 Basic variant
- * 1 GB RAM, no eMMC, main_uart0 on connector X30
+ * Common bits of the IOT2050 Basic variant, PG1 and PG2
  */

-/dts-v1/;
-
 #include "k3-am65-iot2050-common.dtsi"

 / {
-	compatible =3D "siemens,iot2050-basic", "ti,am654";
-	model =3D "SIMATIC IOT2050 Basic";
-
 	memory@80000000 {
 		device_type =3D "memory";
 		/* 1G RAM */
@@ -61,6 +55,6 @@ &main_uart0 {
 };

 &mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
+	/* lock-step mode not supported on Basic boards */
 	ti,cluster-mode =3D <0>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm=
64/boot/dts/ti/k3-am6528-iot2050-basic.dts
index 94bb5dd39122..87928ff28214 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
@@ -4,63 +4,21 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6528-based (dual-core) IOT2050 Basic variant
+ * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 1
  * 1 GB RAM, no eMMC, main_uart0 on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gat=
eways/simatic-iot2050.html
  */

 /dts-v1/;

-#include "k3-am65-iot2050-common.dtsi"
+#include "k3-am6528-iot2050-basic-common.dtsi"
+#include "k3-am65-iot2050-common-pg1.dtsi"

 / {
 	compatible =3D "siemens,iot2050-basic", "ti,am654";
 	model =3D "SIMATIC IOT2050 Basic";
-
-	memory@80000000 {
-		device_type =3D "memory";
-		/* 1G RAM */
-		reg =3D <0x00000000 0x80000000 0x00000000 0x40000000>;
-	};
-
-	cpus {
-		cpu-map {
-			/delete-node/ cluster1;
-		};
-		/delete-node/ cpu@100;
-		/delete-node/ cpu@101;
-	};
-
-	/delete-node/ l2-cache1;
-};
-
-/* eMMC */
-&sdhci0 {
-	status =3D "disabled";
-};
-
-&main_pmx0 {
-	main_uart0_pins_default: main-uart0-pins-default {
-		pinctrl-single,pins =3D <
-			AM65X_IOPAD(0x01e4, PIN_INPUT,  0)  /* (AF11) UART0_RXD */
-			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)  /* (AE11) UART0_TXD */
-			AM65X_IOPAD(0x01ec, PIN_INPUT,  0)  /* (AG11) UART0_CTSn */
-			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)  /* (AD11) UART0_RTSn */
-			AM65X_IOPAD(0x0188, PIN_INPUT,  1)  /* (D25) UART0_DCDn */
-			AM65X_IOPAD(0x018c, PIN_INPUT,  1)  /* (B26) UART0_DSRn */
-			AM65X_IOPAD(0x0190, PIN_OUTPUT, 1)  /* (A24) UART0_DTRn */
-			AM65X_IOPAD(0x0194, PIN_INPUT,  1)  /* (E24) UART0_RIN */
-		>;
-	};
-};
-
-&main_uart0 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&main_uart0_pins_default>;
-};
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
-	ti,cluster-mode =3D <0>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/=
arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
similarity index 85%
copy from arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
copy to arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index ec9617c13cdb..d25e8b26187f 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -4,10 +4,9 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6548-based (quad-core) IOT2050 Advanced variant
- * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ * Common bits of the IOT2050 Advanced variant, PG1 and PG2
  */

 /dts-v1/;
@@ -15,9 +14,6 @@
 #include "k3-am65-iot2050-common.dtsi"

 / {
-	compatible =3D "siemens,iot2050-advanced", "ti,am654";
-	model =3D "SIMATIC IOT2050 Advanced";
-
 	memory@80000000 {
 		device_type =3D "memory";
 		/* 2G RAM */
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/=
arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
index ec9617c13cdb..077f165bdc68 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
@@ -4,57 +4,21 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6548-based (quad-core) IOT2050 Advanced variant
+ * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation =
1
  * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gat=
eways/simatic-iot2050.html
  */

 /dts-v1/;

-#include "k3-am65-iot2050-common.dtsi"
+#include "k3-am6548-iot2050-advanced-common.dtsi"
+#include "k3-am65-iot2050-common-pg1.dtsi"

 / {
 	compatible =3D "siemens,iot2050-advanced", "ti,am654";
 	model =3D "SIMATIC IOT2050 Advanced";
-
-	memory@80000000 {
-		device_type =3D "memory";
-		/* 2G RAM */
-		reg =3D <0x00000000 0x80000000 0x00000000 0x80000000>;
-	};
-};
-
-&main_pmx0 {
-	main_mmc0_pins_default: main-mmc0-pins-default {
-		pinctrl-single,pins =3D <
-			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)  /* (B25) MMC0_CLK */
-			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP,   0)  /* (B27) MMC0_CMD */
-			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP,   0)  /* (A26) MMC0_DAT0 */
-			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP,   0)  /* (E25) MMC0_DAT1 */
-			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP,   0)  /* (C26) MMC0_DAT2 */
-			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP,   0)  /* (A25) MMC0_DAT3 */
-			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP,   0)  /* (E24) MMC0_DAT4 */
-			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP,   0)  /* (A24) MMC0_DAT5 */
-			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP,   0)  /* (B26) MMC0_DAT6 */
-			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP,   0)  /* (D25) MMC0_DAT7 */
-			AM65X_IOPAD(0x01b8, PIN_OUTPUT_PULLUP,  7)  /* (B23) MMC0_SDWP */
-			AM65X_IOPAD(0x01b4, PIN_INPUT_PULLUP,   0)  /* (A23) MMC0_SDCD */
-			AM65X_IOPAD(0x01b0, PIN_INPUT,          0)  /* (C25) MMC0_DS */
-		>;
-	};
-};
-
-/* eMMC */
-&sdhci0 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&main_mmc0_pins_default>;
-	bus-width =3D <8>;
-	non-removable;
-	ti,driver-strength-ohm =3D <50>;
-	disable-wp;
-};
-
-&main_uart0 {
-	status =3D "disabled";
 };
=2D-
2.31.1

