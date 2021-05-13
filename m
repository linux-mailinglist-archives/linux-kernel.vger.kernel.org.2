Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5B37FD28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhEMST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:19:57 -0400
Received: from mail.manjaro.org ([176.9.38.148]:36522 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhEMST4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:19:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id DA66922111A;
        Thu, 13 May 2021 20:18:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z8FFyIV5ygwk; Thu, 13 May 2021 20:18:42 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] ARM: dts: sun8i: v3s: add pwm controller to v3s dts
Date:   Thu, 13 May 2021 20:20:00 +0200
Message-Id: <20210513182000.2068223-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3s and V3 SoCs feature a pwm controller identical to the
one used in the Allwinner A20.
This commit adds it to the V3s dtsi.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 770f5a25ab4c..22bc5ab4c3ca 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -433,6 +433,14 @@ wdt0: watchdog@1c20ca0 {
 			clocks = <&osc24M>;
 		};
 
+		pwm: pwm@1c21400 {
+			compatible = "allwinner,sun7i-a20-pwm";
+			reg = <0x01c21400 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		lradc: lradc@1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x400>;
-- 
2.30.1

