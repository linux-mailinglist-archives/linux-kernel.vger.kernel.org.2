Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180D418888
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhIZMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:07:24 -0400
Received: from mout.web.de ([217.72.192.78]:46495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbhIZMHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632657928;
        bh=TEEjgedS2noV5Dy6L5x12ddie7wICTatEiDhvSv7+eA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WucMhGkLO7LECQcJKoYHoxhoHjh5yhWn/HfUbIZ3gyLRAnBYFVWcj1e/P87Haivba
         JcI+Rgu/HJxbi/fUANKmBlf8RZU/gXDbRihzw/yKbWzUpIHFHZDGDKRHbgXcHzyyQ/
         3XxpL92ujCN/ssKQFRDvZ0SVqvr9TUk4bSNNRZ+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.fritz.box ([94.217.148.121]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lo0V2-1n1cw42Ubw-00g0a2; Sun, 26
 Sep 2021 14:05:28 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v5 6/6] arm64: dts: ti: iot2050: Add support for product generation 2 boards
Date:   Sun, 26 Sep 2021 14:05:17 +0200
Message-Id: <cc868da8264324bde2c87d0c01d4763e3678c706.1632657917.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632657916.git.jan.kiszka@web.de>
References: <cover.1632657916.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LDeOLWnB228a0DiYu0vVS6BtsTyd1apM5nO0wjm/O4W/nibRoNW
 0tUJuSvJxaC0k3GjbGzm9tofI7C4YZE9HF5jI+V+rsr1uCoTpYfRILaWg7OaEXVzzYAt2x0
 QD+GDvdofkar6h+1Tr9Vd3my84sE3aRlODKhC8E8S8N1DgTwhY2gCCq8k2s8Zru+s0/pwld
 9fViY9t85ug6V4e1v1frQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gnxw1G9QzlI=:CYEHUqGZy1658i4ARIaSo0
 y+Pxh2amWZRiyDDxYsrLxPffCp9F7oWudU746B7X50Km9nopPNq9uFkevmEqqZ1J/Bw0axB2V
 q+b7Zx5CP8/LgXfGX5NtzUyAwVw9nuFM6rlEgrzaxPMhCawBbTzddTIJA3nyXZANG2B445EM0
 L6sti1sEIHVtvMzSr1deikCqt9cMzTGRAYsEUWrXt4hthnqCIAAO00sM93lwr2vRQGBQif4YC
 Mlv1/ov/khHl+DvHAaicpZ1L5PSUkbAHTR2gQlSvWv0xyzFVuPAFlZqmz4JpAasFv23Df1pkr
 9PTXGxU6VTyWeiPkyZoHgJT83H2AQ0oxdnUsugFj8Sax7a//LtmFMfAQVNMK8vtZ2zhggdEYu
 Cy/ynhpBHZk6UTHsePQdf0YSKjxH9nw1Lr4LjVTscQSlko7cz18RQobxtSZAc8tv2jmk4lByS
 KPPh5GveobeokPBHiR0Ptmn48ovb3OCQ1leFoCIZ911NKtJkIQEM8QPeDg/yuDhhDVTmuA8Nt
 PA90+yNpkAk1POxOpLph9gPzW3DZqa0jucocH72H3Rowk6EGSLMQ4gtpAdSq63KBNHHVjGYyN
 NeqlB3155P+lroSEwmCoAu1xwbc2js8ZGmBU9+Q6qDDuD2/t0GgRPBXcEpHFAiT86pi1fKQ8C
 RO2byUHfqavcl22PFFM+sZRujp6xSHDoQB3WS+N8S2XgBQSQ79/LmNMMmde1M6TApfYKjjv2v
 ydKb4XZ3IKORGaFVn0odPB46+IuN5Hca3KcJKZz/Oo88j1QLt2bC6ZqZ7ghj8eGqbm0eSCfeT
 vetjFIaf8uWkAprIBYouB1ZhnbckD3aB9DeT50+htAwKkUgA1fYapAbXWHz/Paabq3VpxbmeO
 AlryXncHs03CESGtFNV0z/+naVq+h1b0bCilCVE68TAJZL0zah62TCL9Ug03q2x3wcP7I5AMl
 Zf2qjVp20+hDWZSnU9Puh0DosByCOuDzXasKQ/Ql5b2BKpkHBb09lE2ML6jlCyLllPrKEUs2O
 HYMpObiK6+QlB4uwSq2uruCVlVbovBusEpzcuzyWxCpe8WoMTZVl9vITtvcO/HCAL8suK0NcS
 vCOnq8aGxWVzps=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This adds the devices trees for IOT2050 Product Generation 2 (PG2)
boards. We have Basic and an Advanced variants again, differing in
number of cores, RAM size, availability of eMMC and further details.
The major difference to PG1 is the used silicon revision (SR2.x on
PG2).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 +++++++++++++++++++
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 24 +++++++++
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 29 +++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.=
dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Make=
file
index d56c742f5a10..41a4bc96e6bd 100644
=2D-- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -8,7 +8,9 @@

 dtb-$(CONFIG_ARCH_K3) +=3D k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) +=3D k3-am6528-iot2050-basic.dtb
+dtb-$(CONFIG_ARCH_K3) +=3D k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced.dtb
+dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced-pg2.dtb

 dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-common-proc-board.dtb

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch=
/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
new file mode 100644
index 000000000000..e73458ca6900
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2021
+ *
+ * Authors:
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Common bits of the IOT2050 Basic and Advanced variants, PG2
+ */
+
+&main_pmx0 {
+	cp2102n_reset_pin_default: cp2102n-reset-pin-default {
+		pinctrl-single,pins =3D <
+			/* (AF12) GPIO1_24, used as cp2102 reset */
+			AM65X_IOPAD(0x01e0, PIN_OUTPUT, 7)
+		>;
+	};
+};
+
+&main_gpio1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&cp2102n_reset_pin_default>;
+	gpio-line-names =3D
+		"", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "CP2102N-RESET";
+};
+
+&dss {
+	/* Workaround needed to get DP clock of 154Mhz */
+	assigned-clocks =3D <&k3_clks 67 0>;
+};
+
+&serdes0 {
+	assigned-clocks =3D <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>=
;
+	assigned-clock-parents =3D <&k3_clks 153 7>, <&k3_clks 153 4>;
+};
+
+&dwc3_0 {
+	assigned-clock-parents =3D <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.=
e. PER0_PLL/48 */
+				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
+	phys =3D <&serdes0 PHY_TYPE_USB3 0>;
+	phy-names =3D "usb3-phy";
+};
+
+&usb0 {
+	maximum-speed =3D "super-speed";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch=
/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
new file mode 100644
index 000000000000..c62549a4b436
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *   Le Jin <le.jin@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 2
+ * 1 GB RAM, no eMMC, main_uart0 on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gat=
eways/simatic-iot2050.html
+ */
+
+/dts-v1/;
+
+#include "k3-am6528-iot2050-basic-common.dtsi"
+#include "k3-am65-iot2050-common-pg2.dtsi"
+
+/ {
+	compatible =3D "siemens,iot2050-basic-pg2", "ti,am654";
+	model =3D "SIMATIC IOT2050 Basic PG2";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/a=
rch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
new file mode 100644
index 000000000000..f00dc86d01b9
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *   Le Jin <le.jin@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation =
2
+ * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gat=
eways/simatic-iot2050.html
+ */
+
+/dts-v1/;
+
+#include "k3-am6548-iot2050-advanced-common.dtsi"
+#include "k3-am65-iot2050-common-pg2.dtsi"
+
+/ {
+	compatible =3D "siemens,iot2050-advanced-pg2", "ti,am654";
+	model =3D "SIMATIC IOT2050 Advanced PG2";
+};
+
+&mcu_r5fss0 {
+	/* lock-step mode not supported on this board */
+	ti,cluster-mode =3D <0>;
+};
=2D-
2.31.1

