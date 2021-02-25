Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42184325092
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhBYNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:34:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41228 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhBYNeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:34:17 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lFGlg-00022t-Im; Thu, 25 Feb 2021 14:33:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     finley.xiao@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cmuellner@linux.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/3] arm64: dts: rockchip: synchronize rk3399 opps with vendor kernel
Date:   Thu, 25 Feb 2021 14:33:20 +0100
Message-Id: <20210225133322.3420724-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The vendor-kernel did increase the minimum voltage for some low frequency
opps to 825mV citing stability reasons. So do that in mainline as well
and also use the ranged notation the vendor-kernel switched to, to give
a bit more flexibility for different regulator setups.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi | 32 ++++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
index d6f1095abb04..20b0d60f7ee3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
@@ -10,28 +10,28 @@ cluster0_opp: opp-table0 {
 
 		opp00 {
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <825000 825000 1250000>;
 			clock-latency-ns = <40000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <825000 825000 1250000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <850000>;
+			opp-microvolt = <850000 850000 1250000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <925000>;
+			opp-microvolt = <925000 925000 1250000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <1000000>;
+			opp-microvolt = <1000000 1000000 1250000>;
 		};
 		opp05 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <1125000>;
+			opp-microvolt = <1125000 1125000 1250000>;
 		};
 	};
 
@@ -41,36 +41,36 @@ cluster1_opp: opp-table1 {
 
 		opp00 {
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <825000 825000 1250000>;
 			clock-latency-ns = <40000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <825000 825000 1250000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1250000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <875000>;
+			opp-microvolt = <875000 875000 1250000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <950000>;
+			opp-microvolt = <950000 950000 1250000>;
 		};
 		opp05 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <1025000>;
+			opp-microvolt = <1025000 1025000 1250000>;
 		};
 		opp06 {
 			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <1100000>;
+			opp-microvolt = <1100000 1100000 1250000>;
 		};
 		opp07 {
 			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1200000>;
+			opp-microvolt = <1200000 1200000 1250000>;
 		};
 	};
 
@@ -79,11 +79,11 @@ gpu_opp_table: opp-table2 {
 
 		opp00 {
 			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <825000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <297000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <825000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <400000000>;
-- 
2.29.2

