Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E351241666A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbhIWUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbhIWUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:14:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9972FC061756;
        Thu, 23 Sep 2021 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aMq+G4Ie3H99HQDR+8qltN5ikj4dzWaWF8WW822fQsg=; b=KXM+6zb0IHmzjZdb16ZmHORajO
        WFvtZrCuwyFQWi0GTs/7zd8sT4Oahptr7tj+9p9imiWMys8xiJkLDdt3P8kaiX/h+4ogUjd2QJUCC
        9CBEFK7F0bxJUMDEVacgJgILxA1ZgADfQ9R9LoglKxN1rWTf1lofd5qrdgYlUYs2aiZw=;
Received: from p200300ccff12c8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:c800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5X-000294-Lw; Thu, 23 Sep 2021 22:12:59 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5X-00AYlH-8A; Thu, 23 Sep 2021 22:12:59 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/5] ARM: dts: imx6sl: fixup of operating points
Date:   Thu, 23 Sep 2021 22:12:35 +0200
Message-Id: <20210923201238.2516844-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210923201238.2516844-1-andreas@kemnade.info>
References: <20210923201238.2516844-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make operating point definitions comply with binding
specifications.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl.dtsi | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 997b96c1c47b..c7d907c5c352 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -55,18 +55,16 @@ cpu@0 {
 			device_type = "cpu";
 			reg = <0x0>;
 			next-level-cache = <&L2>;
-			operating-points = <
+			operating-points =
 				/* kHz    uV */
-				996000  1275000
-				792000  1175000
-				396000  975000
-			>;
-			fsl,soc-operating-points = <
+				<996000  1275000>,
+				<792000  1175000>,
+				<396000  975000>;
+			fsl,soc-operating-points =
 				/* ARM kHz      SOC-PU uV */
-				996000          1225000
-				792000          1175000
-				396000          1175000
-			>;
+				<996000         1225000>,
+				<792000         1175000>,
+				<396000         1175000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			#cooling-cells = <2>;
 			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>,
-- 
2.30.2

