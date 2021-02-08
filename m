Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01391313179
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhBHLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:55:31 -0500
Received: from wilbur.contactoffice.com ([212.3.242.68]:51196 "EHLO
        wilbur.contactoffice.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhBHLfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:35:03 -0500
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2021 06:34:35 EST
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 50CB382D;
        Mon,  8 Feb 2021 12:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailfence.com;
        s=20160819-nLV10XS2; t=1612783501;
        bh=tmXcTFCoGUWy5tsn4CyiGIQkxw304rxNZgZLyGii41o=;
        h=Date:To:Subject:Reply-To:From:Cc:From;
        b=GLG/tkZ0kh2RnxP9SzZusjdW6pfbUhSVMxrfhq3VLbTuE11PEXP1lQIV144a5qxUF
         VxmGGrOml9ECD6YVoEl2qeVRFMLWcJxXkHWYAZr1r0aIVsuDfQ/vd8Fp3TDNr+D6L3
         MEr+G6f+h9BNsD4X758LMtfex50cPf/tP52DNr1uN0D2ecb3yNgVAG1fQ4bqzsdYQu
         l9Z38YdjsuhlTZjMGtsFCq96rPDlep8ZhXY3xnrguSYso6oCpM1p6+grW7ClvYkBel
         uZa2Q8Pt2tSiTghhcMNOb5fDmTC869P+s+SyGJqqVLE9C5yElNXGDAOwhmAU62ospV
         FonbPMhBfBAOw==
Date:   Mon, 8 Feb 2021 12:24:57 +0100 (CET)
Message-ID: <1243888060.510560.1612783497400@ichabod.co-bxl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
X-Priority: 3
Reply-To: "B.R. Oake" <broake@mailfence.com>
From:   "B.R. Oake" <broake@mailfence.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:276068926
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
delay config"), Ethernet no longer works on the Orange Pi Plus,
because that commit sets the RX/TX delay according to the phy-mode
property in the device tree, which is "rgmii", the wrong setting
for this board.

Following the example of others who fixed the same problem for
many other boards, this patch changes the phy-mode to "rgmii-id"
which gets Ethernet working again on this board.

Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
Fixes: 1dcd0095019a ("ARM: sun8i: orangepi-plus: Enable dwmac-sun8i")
Signed-off-by: B.R. Oake <broake@mailfence.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 97f497854e..d05fa679dc 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -85,7 +85,7 @@
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 
 	status = "okay";
 };
-- 
2.20.1

