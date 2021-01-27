Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4689305A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhA0Lo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:44:59 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64044 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236763AbhA0L3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:29:00 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RBPapB006057;
        Wed, 27 Jan 2021 03:27:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=k7d4X8goxuZCijpd6d7sqcdtJ0P1u4i5URmJRNyq6Z4=;
 b=UGxqrGACTw7IyiSrVNmhWl4AgETjY4/UUuNjso8fUkKboJQ6bjf+rnacXrolvnrn0Lhr
 jkvmOJ7c76HlQE/C054t5vbmR+A0FOoIWI2a7CCdjiwXTAaFvlXdq8jl62JZrG/figpn
 lvxApmGHCf2KK41RFTDZCuW+Iscl8ZSwkyoF+bareSTkkqgj34LZvpym55RQ9IE8J+fl
 eAJAJ+nUQcQvTyx35mceZbvCUixnw9tCWorF2cME8h8ljmnk8QVfpjXXrKmi5OH+/4Tx
 TeqRewH9YXrHZ5W8oYjlyohzOCU5IoEFW/o6H7lxXhFQk9Ibo/X+wyymLybwPzvELwRG pw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 368j1ubd7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 03:27:56 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:27:55 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:27:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 03:27:55 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 151663F703F;
        Wed, 27 Jan 2021 03:27:50 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <lkundrak@v3.sk>,
        <linux@armlinux.org.uk>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 2/4] devicetree/bindings: add support for CP110 UTMI driver
Date:   Wed, 27 Jan 2021 13:27:17 +0200
Message-ID: <20210127112719.30632-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127112719.30632-1-kostap@marvell.com>
References: <20210127112719.30632-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_04:2021-01-27,2021-01-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add DTS binding for Marvell CP110 UTMI driver

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt | 69 ++++++++++++++++++--
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
index aa99ceec73b0..109888ba9d2d 100644
--- a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
@@ -1,30 +1,61 @@
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
+
+
+Optional Properties (child nodes, for Armada 7k/8k/CN913x only)::
 
+- marvell,cp110-utmi-device-mode: request the driver to connect the UTMI PHY
+				  port to USB device controller.
 
 Example:
 
+Armada3700
 	usb2_utmi_host_phy: phy@5f000 {
 		compatible = "marvell,armada-3700-utmi-host-phy";
 		reg = <0x5f000 0x800>;
@@ -36,3 +67,29 @@ Example:
 		compatible = "marvell,armada-3700-usb2-host-misc", "syscon";
 		reg = <0x5f800 0x800>;
 	};
+
+Armada 7k/8k/CN913x
+
+	CP11X_LABEL(utmi): utmi@580000 {
+		compatible = "marvell,cp110-utmi-phy";
+		reg = <0x580000 0x2000>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		CP11X_LABEL(utmi0): phy@0 {
+			/* UTMI PHY port-0 is connected to USB Host controller-0 */
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		CP11X_LABEL(utmi1): phy@1 {
+			/* UTMI PHY port-1 is connected to USB device controller */
+			reg = <1>;
+			#phy-cells = <0>;
+			marvell,cp110-utmi-device-mode;
+		};
+	};
+
+
-- 
2.17.1

