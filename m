Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C6231F709
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBSKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:05:58 -0500
Received: from comms.puri.sm ([159.203.221.185]:38316 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhBSKFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:05:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2F1D0E1FE2;
        Fri, 19 Feb 2021 02:05:15 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lDB19GLjup7c; Fri, 19 Feb 2021 02:05:14 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 2/5] arm64: dts: librem5: Drop assigned-clocks from SAI2
Date:   Fri, 19 Feb 2021 11:04:36 +0100
Message-Id: <20210219100439.9428-3-martin.kepplinger@puri.sm>
In-Reply-To: <20210219100439.9428-1-martin.kepplinger@puri.sm>
References: <20210219100439.9428-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

IMX8MQ_AUDIO_PLL1 and IMX8MQ_AUDIO_PLL2 are setup to the same rates
right on the clock controller.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 06a4799b6aeb..c2bbbdeb93e3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1051,8 +1051,6 @@
 	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
 	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
 	assigned-clock-rates = <24576000>;
-	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
-	assigned-clock-rates = <786432000>, <722534400>;
 	status = "okay";
 };
 
-- 
2.20.1

