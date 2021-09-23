Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5146416672
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbhIWUOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbhIWUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:14:36 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F45C061756;
        Thu, 23 Sep 2021 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2gQfhOyMww99Nox1w89jLTLPLatWkz7X2+EI/og1KSU=; b=FGoEhqOhYSHj7VqV81vju9S54w
        0uOdeopNtFvLphfi1DuPGs8Mvyjvttd93LQlE0nZrY+1qwamoRBo6QGgPVlHGLdm64bfuI1s0pJst
        edFuejRW/9sXMSdTBYv7Xi71OTaetRrVcjO1XTd/RmcgD/PR+t68OqT6qmB102P3Z+AM=;
Received: from p200300ccff12c8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:c800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5Z-00029m-5v; Thu, 23 Sep 2021 22:13:01 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5Y-00AYlT-Ng; Thu, 23 Sep 2021 22:13:00 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 5/5] ARM: dts: imx6sll: fix mmc compatibles
Date:   Thu, 23 Sep 2021 22:12:38 +0200
Message-Id: <20210923201238.2516844-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210923201238.2516844-1-andreas@kemnade.info>
References: <20210923201238.2516844-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding specification only allows one compatible here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sll.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 0f148f498374..36f546274135 100644
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

