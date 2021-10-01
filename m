Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8C41E54D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351144AbhJAAGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:06:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51510 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238207AbhJAAGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:06:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54A2020242B;
        Fri,  1 Oct 2021 02:04:23 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1CC60200C87;
        Fri,  1 Oct 2021 02:04:23 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 8B2D940A77;
        Thu, 30 Sep 2021 17:04:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI flash
Date:   Thu, 30 Sep 2021 19:04:05 -0500
Message-Id: <20211001000417.15334-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211001000417.15334-1-leoyang.li@nxp.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing node for qspi flash.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index e2aa569ff404..522e1dc51059 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -286,6 +286,21 @@ tbi0: tbi-phy@8 {
 	};
 };
 
+&qspi {
+	num-cs = <2>;
+	status = "okay";
+
+	qflash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
+
 &sai2 {
 	status = "okay";
 };
-- 
2.25.1

