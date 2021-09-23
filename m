Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138D1416670
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbhIWUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243072AbhIWUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:14:35 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B29C061574;
        Thu, 23 Sep 2021 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kW62diCxazx7cmvJ28btPxsomgglHNhPOp5x8Jpgxms=; b=cDvk135WZA3IhQiXsPWmUSST+M
        Y5A4AGrERwV7FkuMBeRygrEcxxdV8i57OhO0QUzKX3ZcghhIAzMgPG1HdiGF0vk47lOkl1qT0l/gq
        pSg4mIiO5CCr2vMFpqz1CiS6+hSOv7Zip7xusbOd+itP+CCebXeMYNA/CWI+WTOkqEw0=;
Received: from p200300ccff12c8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:c800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5Y-00029G-5u; Thu, 23 Sep 2021 22:13:00 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5X-00AYlL-O7; Thu, 23 Sep 2021 22:12:59 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 3/5] ARM: dts: imx6sll: fixup of operating points
Date:   Thu, 23 Sep 2021 22:12:36 +0200
Message-Id: <20210923201238.2516844-4-andreas@kemnade.info>
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
 arch/arm/boot/dts/imx6sll.dtsi | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 04f8d637a501..0f148f498374 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -51,20 +51,18 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
-			operating-points = <
+			operating-points =
 				/* kHz    uV */
-				996000  1275000
-				792000  1175000
-				396000  1075000
-				198000	975000
-			>;
-			fsl,soc-operating-points = <
+				<996000  1275000>,
+				<792000  1175000>,
+				<396000  1075000>,
+				<198000	975000>;
+			fsl,soc-operating-points =
 				/* ARM kHz      SOC-PU uV */
-				996000          1175000
-				792000          1175000
-				396000          1175000
-				198000		1175000
-			>;
+				<996000         1175000>,
+				<792000         1175000>,
+				<396000         1175000>,
+				<198000		1175000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			#cooling-cells = <2>;
 			clocks = <&clks IMX6SLL_CLK_ARM>,
-- 
2.30.2

