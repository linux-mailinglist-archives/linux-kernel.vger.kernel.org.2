Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD358307331
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhA1JvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:51:23 -0500
Received: from relay2.uni-heidelberg.de ([129.206.119.212]:44560 "EHLO
        relay2.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhA1Juy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:50:54 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 04:50:53 EST
X-IPAS-Result: =?us-ascii?q?A2AcBQAuhhJg/1BqzoFiHQEBAQEJARIBBQUBQIFPgwxsY?=
 =?us-ascii?q?oN6Ro86kXqMbgEBAQEBAQEBAQksAQIEAQGGRAIlOBMCAwEBAQMCAwEBAQEGA?=
 =?us-ascii?q?QEBAQEGBIZehXQGIzAmECUCJgICFCg0hi20e4EyiQqBRIEOKo1kD4FNP4Roh?=
 =?us-ascii?q?AWBBoJMNIIsBIJHgQ6BA4IdjysJF6ZfgVksB4FogRGBHQuaPAINIpMYj2SRX?=
 =?us-ascii?q?IVlnmaBbYF6MxokgzhQGQ2ca0MwNwIGCgEBAwlZAQGIdIJGAQE?=
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2021 10:40:41 +0100
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1l53n7-000363-3S; Thu, 28 Jan 2021 10:40:41 +0100
Date:   Thu, 28 Jan 2021 10:40:41 +0100
From:   Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ARM: dts: sun7i: a20: bananapro: Fix ethernet phy-mode
Message-ID: <20210128094040.GD11559@lemon.iwr.uni-heidelberg.de>
References: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPi Pro needs TX and RX delay for Gbit to work reliable and avoid high
packet loss rates. The realtek phy driver overrides the settings of the
pull ups for the delays, so fix this for BananaPro.

Fixes: 10662a33dcd9 ("ARM: dts: sun7i: Add dts file for Bananapro board")
Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>
---
 arch/arm/boot/dts/sun7i-a20-bananapro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -110,7 +110,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-supply = <&reg_gmac_3v3>;
 	status = "okay";
 };

