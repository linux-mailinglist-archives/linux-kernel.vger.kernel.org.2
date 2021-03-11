Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97463371F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhCKMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:03:53 -0500
Received: from comms.puri.sm ([159.203.221.185]:38976 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhCKMDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:03:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 00C80E0D7E;
        Thu, 11 Mar 2021 04:03:21 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gan9uhhySbxt; Thu, 11 Mar 2021 04:03:20 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, krzk@kernel.org
Cc:     kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 1/3] arm64: dts: imx8mq-librem5: Hog the correct gpio
Date:   Thu, 11 Mar 2021 13:02:57 +0100
Message-Id: <20210311120259.3310499-2-martin.kepplinger@puri.sm>
In-Reply-To: <20210311120259.3310499-1-martin.kepplinger@puri.sm>
References: <20210311120259.3310499-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

There was an additional alias in the specifier it hogged line 27
instead of line 1.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 2d248304432b..460ef0d86540 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -286,8 +286,9 @@ &gpio1 {
 
 	pmic-5v-hog {
 		gpio-hog;
-		gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
 		input;
+		lane-mapping = "pmic-5v";
 	};
 };
 
-- 
2.30.1

