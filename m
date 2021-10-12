Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5147E42B0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhJMAIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:08:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33292 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236054AbhJMAI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:08:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C2126202E3F;
        Wed, 13 Oct 2021 02:06:22 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8647D202E3E;
        Wed, 13 Oct 2021 02:06:22 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B34C840A85;
        Tue, 12 Oct 2021 17:06:21 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH v3 05/17] ARM: dts: ls1021a-qds: Add node for QSPI flash
Date:   Tue, 12 Oct 2021 18:58:11 -0500
Message-Id: <20211012235824.31096-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211012235824.31096-1-leoyang.li@nxp.com>
References: <20211012235824.31096-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing node for qspi flash.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index e2aa569ff404..8982ba2c14c2 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -286,6 +286,20 @@ tbi0: tbi-phy@8 {
 	};
 };
 
+&qspi {
+	status = "okay";
+
+	flash@0 {
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

