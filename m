Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE796416EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbhIXJQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbhIXJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:16:20 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E7AC061574;
        Fri, 24 Sep 2021 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wkc6S9e/fnO2kcJG5mRsdS7XOKUTu7Z8TExyB8W3lIY=; b=cgI1raXMDn/Gg8sWhF+W5LGHYl
        rIk3QMeWPyBHQkQgjqpb2GPcp0VrYw5+i9FSQa+96rVUsMT+b/fApdeg/pGcY4BTuuYbb1V2Ee36W
        EKzVQhQCzbd07K40sd9yQ8vvUaueWWWTnwCuN1mdgg6eb8WkMocVZLe1tHgMtrW+9ba0=;
Received: from p200300ccff0ce8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:e800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mThI4-0002PU-IK; Fri, 24 Sep 2021 11:14:44 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mThI4-00AkUe-3q; Fri, 24 Sep 2021 11:14:44 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 5/5] ARM: dts: imx6sll: fix mmc compatibles
Date:   Fri, 24 Sep 2021 11:14:39 +0200
Message-Id: <20210924091439.2561931-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924091439.2561931-1-andreas@kemnade.info>
References: <20210924091439.2561931-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding specification only allows one compatible here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index d4a000c3dde7..5c4088893106 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -709,7 +709,7 @@ usbmisc: usbmisc@2184800 {
 			};
 
 			usdhc1: mmc@2190000 {
-				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
+				compatible = "fsl,imx6sll-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USDHC1>,
@@ -723,7 +723,7 @@ usdhc1: mmc@2190000 {
 			};
 
 			usdhc2: mmc@2194000 {
-				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
+				compatible = "fsl,imx6sll-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USDHC2>,
@@ -737,7 +737,7 @@ usdhc2: mmc@2194000 {
 			};
 
 			usdhc3: mmc@2198000 {
-				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
+				compatible = "fsl,imx6sll-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USDHC3>,
-- 
2.30.2

