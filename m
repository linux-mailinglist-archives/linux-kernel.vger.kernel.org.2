Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1325545B69E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhKXIk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:40:58 -0500
Received: from comms.puri.sm ([159.203.221.185]:42820 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241202AbhKXIkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:40:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 15D83E1429;
        Wed, 24 Nov 2021 00:37:14 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0HhirIqFwwTD; Wed, 24 Nov 2021 00:37:13 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh@kernel.org
Subject: [PATCH] arm64: dts: imx8mq: remove interconnect property from lcdif
Date:   Wed, 24 Nov 2021 09:37:03 +0100
Message-Id: <20211124083703.730243-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mxsfb driver handling imx8mq lcdif doesn't yet request the
interconnect bandwidth that's needed at runtime when the description is
present in the DT node.

So remove that description and bring it back when it's supported.

Fixes: ad1abc8a03fd ("arm64: dts: imx8mq: Add interconnect for lcdif")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

revision history
----------------
this patch replaces the wrong 1:1 revert previously sent:
https://lore.kernel.org/linux-arm-kernel/20211123114545.411787-1-martin.kepplinger@puri.sm/


 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 972766b67a15..71bf497f99c2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -524,8 +524,6 @@ lcdif: lcd-controller@30320000 {
 						  <&clk IMX8MQ_VIDEO_PLL1>,
 						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
 				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
-				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
-				interconnect-names = "dram";
 				status = "disabled";
 
 				port@0 {
-- 
2.30.2

