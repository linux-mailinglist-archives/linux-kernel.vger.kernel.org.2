Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B92340CDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhIOUYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:24:31 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41123 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhIOUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:24:30 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 88F46221E6;
        Wed, 15 Sep 2021 22:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631737388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AZkOIOVxYEU9K3hL387iMzqC693gOZa4X6dtkYrx7z0=;
        b=wEhO+9KE3mVREpOA4yzw/wQjrXm9kVIhgNqnUx1uG1JBlZiKL1OjsTSkX1d2c6F7Ii3gM+
        5wzW5h68aWwT1binubXnUByRPO5fJmPlaxrhZEDOVhxD0GYFeZu3eieSA3K8VRpNqakAcD
        zObniXfmtvqpDghZt1oY4/haep5bEZs=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: fix eSDHC2 node
Date:   Wed, 15 Sep 2021 22:22:59 +0200
Message-Id: <20210915202259.3000923-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the LS1028A this instance of the eSDHC controller is intended for
either an eMMC or eSDIO card. It doesn't provide a card detect pin and
its IO voltage is fixed at 1.8V.

Remove the bogus broken-cd property, instead add the non-removable
property. Fix the voltage-ranges property and set it to 1.8V only.

Fixes: 491d3a3fc113 ("arm64: dts: ls1028a: Add esdhc node in dts")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index ef771bfad11c..8cee1f79e5c0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -407,9 +407,9 @@ esdhc1: mmc@2150000 {
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>; /* fixed up by bootloader */
 			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
-			voltage-ranges = <1800 1800 3300 3300>;
+			voltage-ranges = <1800 1800>;
 			sdhci,auto-cmd12;
-			broken-cd;
+			non-removable;
 			little-endian;
 			bus-width = <4>;
 			status = "disabled";
-- 
2.30.2

