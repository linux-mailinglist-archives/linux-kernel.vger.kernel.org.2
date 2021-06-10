Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C413A37ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhFJXcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:32:21 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41783 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhFJXcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:32:19 -0400
Received: by mail-wr1-f44.google.com with SMTP id o3so4028353wri.8;
        Thu, 10 Jun 2021 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhcSQy57Xk+molyTSgrm3dx5SrUlr/2mzbjEv/WNMOU=;
        b=jpnPaLg60jW07YzzHu0ChAhdSW5p348xAPpzJKBpHWzR4USG4MQxJD0GW2OGPTxp4q
         mktJnQp6hB2S5FttzxSrRVK6VFiPry8axeMQwF+st8FKHA9UxiEE7oLgGHgEvr4ZsAsS
         l/KFjye6H47nCGWIig+sQj5P4q/ZzJIqqJPTyMyKUhw4UIFB3ReobZTBbLu0YvGYSV0g
         iT6GQF7KNzlKXQT1o1bT2j77C0fFkevKJAqDNiSvnPYIuORExrrowxt4Qd4lnIkJXTaB
         s2efglSaUwdBnCmVOxMfHTO2W/ioZrkY3yg83DpYn25SoKHbAIqyUjCetIf71T8fsTrm
         FoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhcSQy57Xk+molyTSgrm3dx5SrUlr/2mzbjEv/WNMOU=;
        b=VF69jtjozifYxRUtD3293c9kZUSgudAvkKcsF+Cht6Fsn0euOq6MNqIMEs0Qcj1G4D
         5rIyDvszt5nLIkrX83j732DPxSHc9mPvjfEtHaEL5dMrZJyT2OWilNIcnQr7fecrDz+E
         Z4i/AVzseTEM509AlHS5czZ2p+X7+vYZ3Y8cIzsKGHgt1i2jOahM2+Q3IqAtRIOUlV3T
         mX+kcTiSq+nfE88MtuSiexVJGNPi46Lvub/lpUpHaGDa8WjEbugSwy15JCDD+xFs+nty
         TT96fMRhde5Y87g0AeCUnGQpvASQoGqkU1ZT3bMgL2sEX4SfmSdL2/IuZODgAul+SErR
         +AxA==
X-Gm-Message-State: AOAM532rNL/qqDDwwloI/XoDcwPSSYo/sytFMqs/1S5sFU7gtIXD9J/o
        yZtQY+iF0TG7rrh44uMAT/I=
X-Google-Smtp-Source: ABdhPJwoti1dul8w+JOC/xKhLILahBFZgQncf7h90KOztRCshJATWa5qRQ6fZ/ywaE3tcbDmwGwJow==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr793033wru.77.1623367749540;
        Thu, 10 Jun 2021 16:29:09 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id 31sm5561644wrc.96.2021.06.10.16.29.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 16:29:09 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] ARM: dts: NSP: Add DT files for Meraki MX65 series
Date:   Fri, 11 Jun 2021 00:27:17 +0100
Message-Id: <20210610232727.1383117-6-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610232727.1383117-1-mnhagan88@gmail.com>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MX65 Hardware info:
  - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
  - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
  - Storage: 1 GB (Micron MT29F8G08ABACA)
  - Networking: BCM58625 switch (2x 1GbE ports, used for WAN ports 1 & 2)
    2x Qualcomm QCA8337 switches (10x 1GbE ports, used for LAN ports 3-12)
  - PSE: Broadcom BCM59111KMLG connected to LAN ports 11 & 12
  - USB: 1x USB2.0
  - Serial: Internal header

As with the MX64, the MX65 has 2x Broadcom BCM43520KMLG on the PCI bus.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 298 ++++++++++++++++++
 arch/arm/boot/dts/bcm958625-meraki-mx65.dts   |  15 +
 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts  |  23 ++
 3 files changed, 336 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts

diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
new file mode 100644
index 000000000000..0ff78fb89b6d
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX65 series (Alamo).
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+#include "bcm958625-meraki-mx6x-common.dtsi"
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	aliases {
+		mdio-mux-mmio = &mdiomux0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		orange_power {
+			label = "orange:power";
+			gpios = <&gpioa 3 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		wan1_right {
+			label = "green:wan1-right";
+			gpios = <&gpioa 24 GPIO_ACTIVE_LOW>;
+		};
+
+		wan1_left {
+			label = "green:wan1-left";
+			gpios = <&gpioa 25 GPIO_ACTIVE_LOW>;
+		};
+
+		wan2_right {
+			label = "green:wan2-right";
+			gpios = <&gpioa 26 GPIO_ACTIVE_LOW>;
+		};
+
+		wan2_left {
+			label = "green:wan2-left";
+			gpios = <&gpioa 27 GPIO_ACTIVE_LOW>;
+		};
+
+		white_status {
+			label = "white:status";
+			gpios = <&gpioa 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	keys {
+		compatible = "gpio-keys-polled";
+		autorepeat;
+		poll-interval = <20>;
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpioa 8 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	mdio: mdio@18032000 {
+		compatible = "brcm,iproc-mdio";
+		reg = <0x18032000 0x8>;
+		#size-cells = <0>;
+		#address-cells = <1>;
+	};
+
+	mdiomux0: mdio-mux {
+		compatible = "mdio-mux-mmioreg";
+		reg = <0x18032000 0x4>;
+		mux-mask = <0x200>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mdio-parent-bus = <&mdio>;
+
+		mdio_ext: mdio@200 {
+			reg = <0x200>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	mdio-mii-mux {
+		compatible = "mdio-mux-mmioreg";
+		reg = <0x1803f1c0 0x4>;
+		mux-mask = <0x2000>;
+		mdio-parent-bus = <&mdio_ext>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mdio@0 {
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy_port6: phy@0 {
+				reg = <0>;
+			};
+
+			phy_port7: phy@1 {
+				reg = <1>;
+			};
+
+			phy_port8: phy@2 {
+				reg = <2>;
+			};
+
+			phy_port9: phy@3 {
+				reg = <3>;
+			};
+
+			phy_port10: phy@4 {
+				reg = <4>;
+			};
+
+			switch@10 {
+				compatible = "qca,qca8337";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x10>;
+				dsa,member = <1 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					port@0 {
+						reg = <0>;
+						label = "cpu";
+						ethernet = <&sgmii1>;
+						phy-mode = "sgmii";
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						label = "lan8";
+						phy-handle = <&phy_port6>;
+					};
+
+					port@2 {
+						reg = <2>;
+						label = "lan9";
+						phy-handle = <&phy_port7>;
+					};
+
+					port@3 {
+						reg = <3>;
+						label = "lan10";
+						phy-handle = <&phy_port8>;
+					};
+
+					port@4 {
+						reg = <4>;
+						label = "lan11";
+						phy-handle = <&phy_port9>;
+					};
+
+					port@5 {
+						reg = <5>;
+						label = "lan12";
+						phy-handle = <&phy_port10>;
+					};
+				};
+			};
+		};
+
+		mdio-mii@2000 {
+			reg = <0x2000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy_port1: phy@0 {
+				reg = <0>;
+			};
+
+			phy_port2: phy@1 {
+				reg = <1>;
+			};
+
+			phy_port3: phy@2 {
+				reg = <2>;
+			};
+
+			phy_port4: phy@3 {
+				reg = <3>;
+			};
+
+			phy_port5: phy@4 {
+				reg = <4>;
+			};
+
+			switch@10 {
+				compatible = "qca,qca8337";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x10>;
+				dsa,member = <2 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					port@0 {
+						reg = <0>;
+						label = "cpu";
+						ethernet = <&sgmii0>;
+						phy-mode = "sgmii";
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						label = "lan3";
+						phy-handle = <&phy_port1>;
+					};
+
+					port@2 {
+						reg = <2>;
+						label = "lan4";
+						phy-handle = <&phy_port2>;
+					};
+
+					port@3 {
+						reg = <3>;
+						label = "lan5";
+						phy-handle = <&phy_port3>;
+					};
+
+					port@4 {
+						reg = <4>;
+						label = "lan6";
+						phy-handle = <&phy_port4>;
+					};
+
+					port@5 {
+						reg = <5>;
+						label = "lan7";
+						phy-handle = <&phy_port5>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&srab {
+	compatible = "brcm,bcm58625-srab", "brcm,nsp-srab";
+	status = "okay";
+	dsa,member = <0 0>;
+
+	ports {
+		port@0 {
+			label = "wan1";
+			reg = <0>;
+		};
+
+		port@1 {
+			label = "wan2";
+			reg = <1>;
+		};
+
+		sgmii0: port@4 {
+			label = "sw0";
+			reg = <4>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		sgmii1: port@5 {
+			label = "sw1";
+			reg = <5>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		port@8 {
+			ethernet = <&amac2>;
+			label = "cpu";
+			reg = <8>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx65.dts b/arch/arm/boot/dts/bcm958625-meraki-mx65.dts
new file mode 100644
index 000000000000..aec86c3a4d05
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx65.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX65.
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-alamo.dtsi"
+
+/ {
+	model = "Cisco Meraki MX65";
+	compatible = "meraki,mx65", "brcm,bcm58625", "brcm,nsp";
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts b/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
new file mode 100644
index 000000000000..0045a33055c1
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX65W.
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-mx65x.dtsi"
+
+/ {
+	model = "Cisco Meraki MX65W";
+	compatible = "meraki,mx65w", "brcm,bcm58625", "brcm,nsp";
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
-- 
2.26.3

