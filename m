Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AF3FB8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhH3PYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:24:25 -0400
Received: from laubervilliers-656-1-228-164.w92-154.abo.wanadoo.fr ([92.154.28.164]:54018
        "EHLO ssq0.pkh.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbhH3PYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pkh.me; s=selector1;
        t=1630336609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=q/K70fg2XIvSdORvPi9aHyTtzWbQf+QQawoUXEWMd/E=;
        b=BZVV6u9tZoUsx/H0kQ6mrX9GBObotQ65MfZtbXpsBqN+t2k9eWuf0lW6vh5Y0UA5mZTTIx
        TorU492aRWcFIIvaFxLGElhB/or0VGa2Y3yac+WTKZb0pTIl/AvEubbH/ETL9q+vDjxqcI
        4K8McbevrH/Wfq7ix71LKsDm0iLfvJk=
Received: from localhost (ssq0.pkh.me [local])
        by ssq0.pkh.me (OpenSMTPD) with ESMTPA id 02164e4b;
        Mon, 30 Aug 2021 15:16:49 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20B=C5=93sch?= <u@pkh.me>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Willy Liu <willy.liu@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20B=C5=93sch?= <u@pkh.me>
Subject: [PATCH] arm64: dts: sun50i: h5: NanoPI Neo 2: phy-mode rgmii-id
Date:   Mon, 30 Aug 2021 17:16:45 +0200
Message-Id: <20210830151645.18018-1-u@pkh.me>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
config") network is broken on the NanoPi Neo 2.

This patch changes the phy-mode to use internal delays both for RX and
TX as has been done for other boards affected by the same commit.

Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
Signed-off-by: Clément Bœsch <u@pkh.me>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index 02f8e72f0cad..05486cccee1c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -75,7 +75,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.33.0

