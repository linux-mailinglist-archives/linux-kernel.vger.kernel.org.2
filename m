Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529CD325090
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhBYNeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:34:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41230 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhBYNeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:34:17 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lFGlg-00022t-SO; Thu, 25 Feb 2021 14:33:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     finley.xiao@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cmuellner@linux.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: used range'd gpu opps on rk3399
Date:   Thu, 25 Feb 2021 14:33:21 +0100
Message-Id: <20210225133322.3420724-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225133322.3420724-1-heiko@sntech.de>
References: <20210225133322.3420724-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Similar to the cpu opps, also use opps with a range on the gpu.
(min, preferred, max). The voltage just needs to be higher than
the minimum and this allows the regulator more freedom if it
can't provide the exact voltage specified, but just say 5mV higher,
as can be seen on rk3399-puma which fails to scale panfrost voltages
nearly completely.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
index 20b0d60f7ee3..da41cd81ebb7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
@@ -79,27 +79,27 @@ gpu_opp_table: opp-table2 {
 
 		opp00 {
 			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1150000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <297000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1150000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1150000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <875000>;
+			opp-microvolt = <875000 875000 1150000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <925000>;
+			opp-microvolt = <925000 925000 1150000>;
 		};
 		opp05 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <1100000>;
+			opp-microvolt = <1100000 1100000 1150000>;
 		};
 	};
 };
-- 
2.29.2

