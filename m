Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570453821F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhEPXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:07:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232079AbhEPXHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:07:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04EC7B1FE;
        Sun, 16 May 2021 23:06:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: rockchip: rk1808: Add CPU operating points
Date:   Mon, 17 May 2021 01:05:51 +0200
Message-Id: <20210516230551.12469-10-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516230551.12469-1-afaerber@suse.de>
References: <20210516230551.12469-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Associate operating points with both CPU nodes.
Data source is the shipping TB-RK1808M0 DTB.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/rockchip/rk1808.dtsi | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk1808.dtsi b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
index b4a71c5c8be7..82614c47f144 100644
--- a/arch/arm64/boot/dts/rockchip/rk1808.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
@@ -32,7 +32,10 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <74>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -40,6 +43,7 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
@@ -57,6 +61,66 @@ CPU_SLEEP: cpu-sleep {
 		};
 	};
 
+	cpu0_opp_table: cpu0-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <800000 800000 950000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1296000000 {
+			opp-hz = /bits/ 64 <1296000000>;
+			opp-microvolt = <825000 825000 950000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <850000 850000 950000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <875000 875000 950000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <900000 900000 950000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
 	arm-pmu {
 		compatible = "arm,cortex-a35-pmu";
 		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.31.1

