Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4B3B42F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFYMQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:16:23 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36135 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFYMQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:16:20 -0400
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8348F40004;
        Fri, 25 Jun 2021 12:13:57 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        thomas.petazzoni@bootlin.com, herve.codina@bootlin.com,
        devicetree@vger.kernel.org
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: imx6qdl-sr-som: Increase the PHY reset duration to 10ms
Date:   Fri, 25 Jun 2021 14:13:53 +0200
Message-Id: <20210625121353.3698240-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AR803x PHY used on this modules seems to require the reset line to
be asserted for around 10ms in order to avoid rare cases where the PHY
gets stuck in an incoherent state that prevents it to function
correctly.

The previous value of 2ms was found to be problematic on some setups,
causing intermittent issues where the PHY would be unresponsive
every once in a while on some sytems, with a low occurrence (it typically
took around 30 consecutive reboots to encounter the issue).

Bumping the delay to the 10ms makes the issue dissapear, with more than
2500 consecutive reboots performed without the issue showing-up.

Fixes: 208d7baf8085 ("ARM: imx: initial SolidRun HummingBoard support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Hervé Codina <herve.codina@bootlin.com>
---
This V2 was quickly resent, since the commit-log was incorrect.

v2 : Reworded the commit-log to remove an incorrect mention of the
datasheet. Add a comment to the DT to explicitly explain the issue.

 arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
index 0ad8ccde0cf8..f86efd0ccc40 100644
--- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
@@ -54,7 +54,13 @@ &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
 	phy-mode = "rgmii-id";
-	phy-reset-duration = <2>;
+
+	/*
+	 * The PHY seems to require a long-enough reset duration to avoid
+	 * some rare issues where the PHY gets stuck in an inconsistent and
+	 * non-functional state at boot-up. 10ms proved to be fine .
+	 */
+	phy-reset-duration = <10>;
 	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-- 
2.25.4

