Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9931B11C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBNQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:02:36 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38458 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbhBNQC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:02:28 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EG05Jr025333;
        Sun, 14 Feb 2021 08:01:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=n9zf8QHFLUqQTf8PitdGZPwDZP8tkX3o5L3QGJdyvD4=;
 b=VjGyL9k20JVROA6mAtAqmJegxdtQWbB5Ymo2e66tOKsn5w9sYdSsxrOj/4AET6upDItx
 HcSbx8vB4GtJcOCofVJuDbm5l+9CHRoG1TP51b+YGVVFAUJZKAoFEj/U95A7pE9YNdyR
 tFK+DaM2PlYqHybhDXN6vOVkv8SOLSDLfcxUDvPfQxS9qqOCz8LmJyJideeJgWGHJfID
 Qk23gsH5rPW0s6YKdBqdcHq/jxaEyGuto9G6+gVyLkRZZsrsLPUAsl4QSguL5IYT+TVv
 cUF2bXxwTYEVtGu3tVPAePA4lDj7kRem2j5Chzn0p9RCYPthFTeQoP+rY0aOlloz+xYI cw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36pf5tswnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 08:01:25 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Feb
 2021 08:01:23 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Feb
 2021 08:01:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 14 Feb 2021 08:01:23 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 5B2693F7043;
        Sun, 14 Feb 2021 08:01:19 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 2/4] devicetree/bindings: add support for CP110 UTMI driver
Date:   Sun, 14 Feb 2021 18:01:06 +0200
Message-ID: <20210214160108.3879-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214160108.3879-1-kostap@marvell.com>
References: <20210214160108.3879-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add DTS binding for Marvell CP110 UTMI driver

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt | 78 ++++++++++++++++++--
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
index aa99ceec73b0..b66066249861 100644
--- a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
@@ -1,30 +1,56 @@
-MVEBU A3700 UTMI PHY
---------------------
+MVEBU UTMI PHY
+---------------
 
 USB2 UTMI+ PHY controllers can be found on the following Marvell MVEBU SoCs:
 * Armada 3700
+* Armada 7k/8k (on the CP110)
+* Armada CN913x (on the CP115)
 
 On Armada 3700, there are two USB controllers, one is compatible with the USB2
 and USB3 specifications and supports OTG. The other one is USB2 compliant and
 only supports host mode. Both of these controllers come with a slightly
 different UTMI PHY.
 
+On Armada 7k/8k and CN913x, there are two host and one device USB controllers.
+Each of two exiting UTMI PHYs could be connected to either USB host or USB device
+controller.
+The USB device controller can only be connected to a single UTMI PHY port:
+                    0.H----- USB HOST0
+UTMI PHY0  --------/
+                    0.D-----0
+                             \------ USB DEVICE
+                    1.D-----1
+UTMI PHY1  --------\
+                    1.H----- USB HOST1
+
+
 Required Properties:
 
 - compatible: Should be one of:
 	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
-	        the USB2 host-only controller.
+	        the USB2 host-only controller (for Armada3700 only).
 	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
-	        the USB3 and USB2 OTG capable controller.
+	        the USB3 and USB2 OTG capable controller (for Armada3700 only.
+	      * "marvell,cp110-utmi-phy" (for Armada 7k/8k or CN913x only).
 - reg: PHY IP register range.
 - marvell,usb-misc-reg: handle on the "USB miscellaneous registers" shared
 			region covering registers related to both the host
-			controller and the PHY.
-- #phy-cells: Standard property (Documentation: phy-bindings.txt) Should be 0.
+			controller and the PHY (for Armada3700 only).
+- marvell,system-controller: should contain a phandle to the system
+			     controller node (for Armada 7k/8k or CN913x only)
+- #phy-cells: Standard property (Documentation: phy-bindings.txt.
+		Should be 0 (for Armada3700 only).
+
+
+Required properties (child nodes, for Armada 7k/8k/CN913x only):
+
+- reg: UTMI PHY port ID (0 or 1).
+- #phy-cells : Should be 0.
 
 
 Example:
 
+Armada3700
 	usb2_utmi_host_phy: phy@5f000 {
 		compatible = "marvell,armada-3700-utmi-host-phy";
 		reg = <0x5f000 0x800>;
@@ -36,3 +62,43 @@ Example:
 		compatible = "marvell,armada-3700-usb2-host-misc", "syscon";
 		reg = <0x5f800 0x800>;
 	};
+
+Armada 7k/8k/CN913x
+
+	cp0_utmi: utmi@580000 {
+		compatible = "marvell,cp110-utmi-phy";
+		reg = <0x580000 0x2000>;
+		marvell,system-controller = <&cp0_syscon0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		cp0_utmi0: phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		cp0_utmi1: phy@1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
+
+	cp0_usb3_0 {
+		status = "okay";
+		usb-phy = <&cp0_usb3_0_phy0>;
+		phys = <&cp0_utmi0>;
+		phy-names = "utmi";
+		/* UTMI0 is connected to USB host controller (default mode) */
+		dr_mode = "host";
+	};
+
+	cp0_usb3_1 {
+		status = "okay";
+		usb-phy = <&cp0_usb3_0_phy1>;
+		phys = <&cp0_utmi1>;
+		phy-names = "utmi";
+		/* UTMI1 is connected to USB device controller */
+		dr_mode = "peripheral";
+	};
+
-- 
2.17.1

