Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4978325091
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhBYNee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:34:34 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41226 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232008AbhBYNeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:34:17 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lFGlh-00022t-5Q; Thu, 25 Feb 2021 14:33:25 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     finley.xiao@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cmuellner@linux.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: drop separate opp table on rk3399-puma
Date:   Thu, 25 Feb 2021 14:33:22 +0100
Message-Id: <20210225133322.3420724-3-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225133322.3420724-1-heiko@sntech.de>
References: <20210225133322.3420724-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

We're using OPPs with a range now, so the fact that the cpu regulator
on puma can't provide the needed 5mV steps requested in the minimal
voltage values can be handled automatically by the opp framework.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 51 -------------------
 1 file changed, 51 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 4660416c8f38..6ae9032d85f4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -21,57 +21,6 @@ module_led: led-0 {
 		};
 	};
 
-	/*
-	 * Overwrite the opp-table for CPUB as this board uses a different
-	 * regulator (FAN53555) that only allows 10mV steps and therefore
-	 * can't reach the operation point target voltages from rk3399-opp.dtsi
-	 */
-	/delete-node/ opp-table1;
-	cluster1_opp: opp-table1 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp00 {
-			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <800000>;
-			clock-latency-ns = <40000>;
-		};
-		opp01 {
-			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <800000>;
-		};
-		opp02 {
-			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <830000>;
-			opp-suspend;
-		};
-		opp03 {
-			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <880000>;
-		};
-		opp04 {
-			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <950000>;
-		};
-		opp05 {
-			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <1030000>;
-		};
-		opp06 {
-			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <1100000>;
-		};
-		opp07 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1200000>;
-		};
-		opp08 {
-			opp-hz = /bits/ 64 <1992000000>;
-			opp-microvolt = <1230000>;
-			turbo-mode;
-		};
-	};
-
 	clkin_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
-- 
2.29.2

