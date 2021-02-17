Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157B531D816
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBQLVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:21:01 -0500
Received: from comms.puri.sm ([159.203.221.185]:33992 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhBQLUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:20:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DF06AE1320;
        Wed, 17 Feb 2021 03:20:12 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id huagXCmOblDH; Wed, 17 Feb 2021 03:20:11 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 4/5] arm64: dts: librem5: protect some partitions of the nor-flash
Date:   Wed, 17 Feb 2021 12:19:43 +0100
Message-Id: <20210217111944.1416-5-martin.kepplinger@puri.sm>
In-Reply-To: <20210217111944.1416-1-martin.kepplinger@puri.sm>
References: <20210217111944.1416-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie <angus@akkea.ca>

These sections should be read only as they contain important data.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index c2bbbdeb93e3..3c0462f81b3a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -258,6 +258,22 @@
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "protected0";
+			reg = <0x00000000 0x00030000>;
+			read-only;
+		};
+		partition@30000 {
+			label = "protected1";
+			reg = <0x00030000 0x00010000>;
+			read-only;
+		};
+		partition@40000 {
+			label = "rw";
+			reg = <0x00040000 0x001C0000>;
+		};
 	};
 };
 
-- 
2.20.1

