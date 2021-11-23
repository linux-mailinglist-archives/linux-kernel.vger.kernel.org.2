Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5D45A1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhKWLts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:49:48 -0500
Received: from comms.puri.sm ([159.203.221.185]:48858 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236549AbhKWLtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 488A3E1AAB;
        Tue, 23 Nov 2021 03:46:07 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ROuOYu2hs1Ct; Tue, 23 Nov 2021 03:46:06 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, festevam@gmail.com,
        krzk@kernel.org, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] Revert "arm64: dts: imx8mq: Add interconnect for lcdif"
Date:   Tue, 23 Nov 2021 12:45:45 +0100
Message-Id: <20211123114545.411787-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ad1abc8a03fdbc05b3390962b15287d4e7c5db22.

The mxsfb driver handling imx8mq lcdif doesn't yet request the
interconnect request that's needed when the description is present
in the DT node.

So revert that description and bring it back when it's supported.

Fixes: ad1abc8a03fd ("arm64: dts: imx8mq: Add interconnect for lcdif")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 972766b67a15..92b47d91e697 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -11,7 +11,6 @@
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
-#include <dt-bindings/interconnect/imx8mq.h>
 #include "imx8mq-pinfunc.h"
 
 / {
@@ -524,8 +523,6 @@ lcdif: lcd-controller@30320000 {
 						  <&clk IMX8MQ_VIDEO_PLL1>,
 						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
 				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
-				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
-				interconnect-names = "dram";
 				status = "disabled";
 
 				port@0 {
-- 
2.30.2

