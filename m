Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8638B3B3F56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhFYId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:33:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33861 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFYId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:33:26 -0400
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5ADA71BF218;
        Fri, 25 Jun 2021 08:31:02 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        thomas.petazzoni@bootlin.com, herve.codina@bootlin.com,
        devicetree@vger.kernel.org
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6qdl-sr-som: Increase the PHY reset duration to 10ms
Date:   Fri, 25 Jun 2021 10:30:51 +0200
Message-Id: <20210625083051.3691737-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet for the AR803x PHY present on this SoM recommends that the
reset line is asserted low for 10ms, so that the PHY has time to
properly reset the internal blocks.

The previous value of 2ms was found to be problematic on some setups,
causing intermittent issues where the PHY would be unresponsive
every once in a while on some sytems, with a low occurence (it typically
took around 30 consecutive reboots to encounter the issue).

Bumping the delay to the 10ms recommended value makes the issue
dissapear, with more than 2500 consecutive reboots performed without the
issue showing-up.

Fixes: 208d7baf8085 ("ARM: imx: initial SolidRun HummingBoard support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Hervé Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
index 0ad8ccde0cf8..a54dafce025b 100644
--- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
@@ -54,7 +54,7 @@ &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
 	phy-mode = "rgmii-id";
-	phy-reset-duration = <2>;
+	phy-reset-duration = <10>;
 	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-- 
2.25.4

