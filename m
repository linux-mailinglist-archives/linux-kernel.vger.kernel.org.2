Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6070036E384
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhD2DJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 23:09:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59258 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhD2DJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:09:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B60691A11E2;
        Thu, 29 Apr 2021 05:08:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7ADCF1A11FB;
        Thu, 29 Apr 2021 05:08:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26C3C402FC;
        Thu, 29 Apr 2021 05:08:07 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@gmail.com
Subject: [PATCH] ARM: dts: imx7d-sdb: Add HDMI audio sound card
Date:   Thu, 29 Apr 2021 10:52:35 +0800
Message-Id: <1619664755-12631-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HDMI audio sound card, the interface is sii902x.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index ac0751bc1177..4a0d83784d7d 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -164,6 +164,13 @@ sound {
 			"LINPUT1", "AMIC",
 			"AMIC", "MICB";
 	};
+
+	sound-hdmi {
+		compatible = "fsl,imx-audio-sii902x";
+		model = "sii902x-audio";
+		audio-cpu = <&sai3>;
+		hdmi-out;
+	};
 };
 
 &adc1 {
-- 
2.27.0

