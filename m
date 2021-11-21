Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1331458550
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhKURS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:18:57 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:53168 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238450AbhKURSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:18:55 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id CA18B261B2F;
        Sun, 21 Nov 2021 18:15:48 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: apple: add #interrupt-cells property to pinctrl nodes
Date:   Sun, 21 Nov 2021 18:15:45 +0100
Message-Id: <20211121171545.27402-4-j@jannau.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211121171545.27402-1-j@jannau.net>
References: <20211121171545.27402-1-j@jannau.net>
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

