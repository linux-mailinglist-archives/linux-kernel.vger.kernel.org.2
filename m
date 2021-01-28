Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24B307498
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhA1LT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:19:26 -0500
Received: from relay2.uni-heidelberg.de ([129.206.119.212]:58996 "EHLO
        relay2.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhA1LTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:19:24 -0500
X-IPAS-Result: =?us-ascii?q?A2D1AwCNnBJg/1BqzoFiHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+DDGtlg3pGriMBAQEBAQEBAQEJLAECBAEBhEqBegIlOBMCAwEBAQMCAwEBA?=
 =?us-ascii?q?QEGAQEBAQEGBIZfhXQGI1YQJQImAgIUKDSGLbUTgTKJIoEtgQ4qixuCSYIbh?=
 =?us-ascii?q?GiEBVYwgkw0giwEgkeBDoEDgh2PKgkXpmGCBgeeXwINIpMdj2eRX4Vlnm6Bb?=
 =?us-ascii?q?YF6Mz6DOFAZDZxrQzA3AgYKAQEDCVkBAYh0gkYBAQ?=
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2021 12:18:43 +0100
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1l55Jy-00037W-KT; Thu, 28 Jan 2021 12:18:42 +0100
Date:   Thu, 28 Jan 2021 12:18:42 +0100
From:   Hermann.Lauer@uni-heidelberg.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] ARM: dts: sun7i: a20: bananapro: Fix ethernet phy-mode
Message-ID: <20210128111842.GA11919@lemon.iwr.uni-heidelberg.de>
References: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
 <20210128094040.GD11559@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128094040.GD11559@lemon.iwr.uni-heidelberg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPi Pro needs TX and RX delay for Gbit to work reliable and avoid high
packet loss rates. The realtek phy driver overrides the settings of the
pull ups for the delays, so fix this for BananaPro.
    
Fix the phy-mode description to correctly reflect this so that the
implementation doesn't reconfigure the delays incorrectly. This
happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
rx/tx delay config").

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
