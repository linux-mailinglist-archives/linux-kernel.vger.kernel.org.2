Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12024597B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhKVW14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:27:56 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:59188 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhKVW1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:27:52 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 7ABC9261B44;
        Mon, 22 Nov 2021 23:24:43 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: apple: add #interrupt-cells property to pinctrl nodes
Date:   Mon, 22 Nov 2021 23:24:40 +0100
Message-Id: <20211122222440.21177-4-j@jannau.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122222440.21177-1-j@jannau.net>
References: <20211122222440.21177-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Required for devices trying to use pinctrl devices as interrupt
controller.

Fixes: 0a8282b83119 ("arm64: apple: Add pinctrl nodes")
Signed-off-by: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index fc8b2bb06ffe..c320c8baeb41 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -143,6 +143,7 @@ pinctrl_ap: pinctrl@23c100000 {
 			apple,npins = <212>;
 
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 190 IRQ_TYPE_LEVEL_HIGH>,
 				     <AIC_IRQ 191 IRQ_TYPE_LEVEL_HIGH>,
@@ -169,6 +170,7 @@ pinctrl_aop: pinctrl@24a820000 {
 			apple,npins = <42>;
 
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <AIC_IRQ 269 IRQ_TYPE_LEVEL_HIGH>,
@@ -189,6 +191,7 @@ pinctrl_nub: pinctrl@23d1f0000 {
 			apple,npins = <23>;
 
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 330 IRQ_TYPE_LEVEL_HIGH>,
 				     <AIC_IRQ 331 IRQ_TYPE_LEVEL_HIGH>,
@@ -209,6 +212,7 @@ pinctrl_smc: pinctrl@23e820000 {
 			apple,npins = <16>;
 
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 391 IRQ_TYPE_LEVEL_HIGH>,
 				     <AIC_IRQ 392 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.0

