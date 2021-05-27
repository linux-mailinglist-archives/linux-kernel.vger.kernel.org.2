Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1128B3937C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhE0VJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhE0VJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:09:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E633C061574;
        Thu, 27 May 2021 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wrfBx906CAcUfC7KWOT1YXQ50wHppB1mcK+ZUbjeBQo=; b=gLc286LMISIPMTHboduUKQzHIk
        nZWih5TD9N4LOV0BNOoMJbLspToFUZdGToy0TjJ68OiMDchcomL0qoKL1PPrJdsrItW3iV0c+wUWg
        RehpL2OYYVdc1DdmyCN6tIscvHMv9iIUY9W3ayKMb1mlLhX0XkkM2pZkZCccaLvPH/Rg=;
Received: from p200300ccff1430001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff14:3000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lmNEP-0005M1-24; Thu, 27 May 2021 23:07:53 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lmNEO-0000gy-Oc; Thu, 27 May 2021 23:07:52 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: imx6sl: add PXP module
Date:   Thu, 27 May 2021 23:07:42 +0200
Message-Id: <20210527210742.2609-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the EPDC is optional, all editions have the PXP module, so adding
it to the corresponding .dtsi
Information taken from freescale kernel, compared with the
reference manual and tested by a separate program.

Since it does not depend on external wiring, the
status = "disabled" is left out here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 997b96c1c47b..6be83e863f19 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -762,8 +762,11 @@
 			};
 
 			pxp: pxp@20f0000 {
+				compatible = "fsl,imx6sl-pxp", "fsl,imx6ull-pxp";
 				reg = <0x020f0000 0x4000>;
 				interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_PXP_AXI>;
+				clock-names = "axi";
 			};
 
 			epdc: epdc@20f4000 {
-- 
2.20.1

