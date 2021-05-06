Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAA374E27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 05:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhEFD6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:58:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38696 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhEFD63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:58:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A2FB62015FC;
        Thu,  6 May 2021 05:57:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9844520313E;
        Thu,  6 May 2021 05:57:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 844BD402CF;
        Thu,  6 May 2021 05:57:17 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@gmail.com
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabresd: Add asrc support for wm8962 sound card
Date:   Thu,  6 May 2021 11:41:18 +0800
Message-Id: <1620272479-1219-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add asrc support for wm8962 sound card.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- none

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index f824c9abd11a..d20eaac6c5d6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -99,6 +99,7 @@ sound {
 		model = "wm8962-audio";
 		ssi-controller = <&ssi2>;
 		audio-codec = <&codec>;
+		audio-asrc = <&asrc>;
 		audio-routing =
 			"Headphone Jack", "HPOUTL",
 			"Headphone Jack", "HPOUTR",
-- 
2.27.0

