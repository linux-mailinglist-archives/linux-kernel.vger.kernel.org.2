Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E1B422847
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhJENvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:51:15 -0400
Received: from comms.puri.sm ([159.203.221.185]:43662 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234546AbhJENvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:51:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 86373E1249;
        Tue,  5 Oct 2021 06:49:23 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ryny3xB225vi; Tue,  5 Oct 2021 06:49:22 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org, shawnguo@kernel.org
Subject: [PATCH v2 1/7] arm64: dts: imx8mq-librem5: add reset gpio to mantix panel description
Date:   Tue,  5 Oct 2021 15:48:56 +0200
Message-Id: <20211005134902.2138731-2-martin.kepplinger@puri.sm>
In-Reply-To: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
References: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing description for the reset gpio to the panels DT
description.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 3f7524400a63..0609b591ec5a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1010,6 +1010,7 @@ lcd_panel: panel@0 {
 		vddi-supply = <&reg_lcd_1v8>;
 		backlight = <&backlight_dsi>;
 		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+		mantix,tp-rstn-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
 
 		port {
 			panel_in: endpoint {
-- 
2.30.2

