Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9E3A2683
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFJIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:22:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43961 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFJIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:22:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 20CB520014;
        Thu, 10 Jun 2021 08:20:52 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, helmut.grohne@intenta.de,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v23 05/18] dt-binding: memory: pl353-smc: Fix the example syntax and style
Date:   Thu, 10 Jun 2021 10:20:27 +0200
Message-Id: <20210610082040.2075611-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance the spacing, the comment style, add { }, remove (...).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/pl353-smc.txt | 48 ++++++++++---------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
index 105160c795a1..46e17f5bc45b 100644
--- a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
@@ -24,27 +24,29 @@ Required device node properties:
 			of the memory region requested by the device.
 
 Example:
-	smcc: memory-controller@e000e000
-			compatible = "arm,pl353-smc-r2p1", "arm,primecell";
-			clock-names = "memclk", "apb_pclk";
-			clocks = <&clkc 11>, <&clkc 44>;
-			reg = <0xe000e000 0x1000>;
-			#address-cells = <2>;
-			#size-cells = <1>;
-			ranges = <0x0 0x0 0xe1000000 0x1000000 //Nand CS Region
-				  0x1 0x0 0xe2000000 0x2000000 //SRAM/NOR CS Region
-				  0x2 0x0 0xe4000000 0x2000000>; //SRAM/NOR CS Region
-			nand_0: flash@e1000000 {
-				compatible = "arm,pl353-nand-r2p1"
-				reg = <0 0 0x1000000>;
-				(...)
-			};
-			nor0: flash@e2000000 {
-				compatible = "cfi-flash";
-				reg = <1 0 0x2000000>;
-			};
-			nor1: flash@e4000000 {
-				compatible = "cfi-flash";
-				reg = <2 0 0x2000000>;
-			};
+	smcc: memory-controller@e000e000 {
+		compatible = "arm,pl353-smc-r2p1", "arm,primecell";
+		clock-names = "memclk", "apb_pclk";
+		clocks = <&clkc 11>, <&clkc 44>;
+		reg = <0xe000e000 0x1000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0xe1000000 0x1000000 /* Nand CS region */
+			  0x1 0x0 0xe2000000 0x2000000 /* SRAM/NOR CS0 region */
+			  0x2 0x0 0xe4000000 0x2000000>; /* SRAM/NOR CS1 region */
+
+		nand_0: flash@e1000000 {
+			compatible = "arm,pl353-nand-r2p1";
+			reg = <0 0 0x1000000>;
+		};
+
+		nor0: flash@e2000000 {
+			compatible = "cfi-flash";
+			reg = <1 0 0x2000000>;
+		};
+
+		nor1: flash@e4000000 {
+			compatible = "cfi-flash";
+			reg = <2 0 0x2000000>;
+		};
 	};
-- 
2.27.0

