Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD01F450173
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhKOJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:34:29 -0500
Received: from mx.socionext.com ([202.248.49.38]:19778 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236492AbhKOJeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:34:08 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 15 Nov 2021 18:30:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 94258205D965;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 15 Nov 2021 18:30:57 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3F2043DD60;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
Received: from scorpio.e01.socionext.com (aries.syh.socionext.com [10.213.112.88])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 23C38B6292;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 1/4] ARM: dts: milbeaut: add a clock node for M10V
Date:   Mon, 15 Nov 2021 18:30:53 +0900
Message-Id: <1636968656-14033-2-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636968656-14033-1-git-send-email-sugaya.taichi@socionext.com>
References: <1636968656-14033-1-git-send-email-sugaya.taichi@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clock node for the platform of the Milbeaut M10V.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/boot/dts/milbeaut-m10v.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/milbeaut-m10v.dtsi b/arch/arm/boot/dts/milbeaut-m10v.dtsi
index aa7c6ca..28aee25 100644
--- a/arch/arm/boot/dts/milbeaut-m10v.dtsi
+++ b/arch/arm/boot/dts/milbeaut-m10v.dtsi
@@ -65,6 +65,13 @@
 			      <0x1d002000 0x1000>; /* CPU I/f base and size */
 		};
 
+		clk: clock-ctrl@1d021000 {
+			compatible = "socionext,milbeaut-m10v-ccu";
+			#clock-cells = <1>;
+			reg = <0x1d021000 0x1000>;
+			clocks = <&uclk40xi>;
+		};
+
 		timer@1e000050 { /* 32-bit Reload Timers */
 			compatible = "socionext,milbeaut-timer";
 			reg = <0x1e000050 0x20>;
-- 
2.7.4

