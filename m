Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE75F3821F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhEPXIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:08:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbhEPXHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:07:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B014DB1F0;
        Sun, 16 May 2021 23:06:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
Subject: [PATCH 8/9] arm64: dts: rockchip: rk1808k-toybrick-m0: Enable eMMC
Date:   Mon, 17 May 2021 01:05:50 +0200
Message-Id: <20210516230551.12469-9-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516230551.12469-1-afaerber@suse.de>
References: <20210516230551.12469-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fake clocks (based on downstream kernel's debugfs clk_summary)
and enable eMMC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 .../boot/dts/rockchip/rk1808k-toybrick-m0.dts | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts b/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
index 15293a8576c6..aabe7a7034b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
+++ b/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
@@ -38,6 +38,34 @@ vdd_cpu: vdd-cpu {
 		regulator-max-microvolt = <850000>;
 		vin-supply = <&vcc3v3_pcie>;
 	};
+
+	hclk_emmc: hclk-emmc {
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		#clock-cells = <0>;
+		clock-output-names = "hclk_emmc";
+	};
+
+	sclk_emmc: sclk-emmc {
+		compatible = "fixed-clock";
+		clock-frequency = <297000000>;
+		#clock-cells = <0>;
+		clock-output-names = "sclk_emmc";
+	};
+
+	sclk_emmc_drv: sclk-emmc-drv {
+		compatible = "fixed-clock";
+		clock-frequency = <148500000>;
+		#clock-cells = <0>;
+		clock-output-names = "sclk_emmc_drv";
+	};
+
+	sclk_emmc_sample: sclk-emmc-sample {
+		compatible = "fixed-clock";
+		clock-frequency = <148500000>;
+		#clock-cells = <0>;
+		clock-output-names = "sclk_emmc_sample";
+	};
 };
 
 &cpu0 {
@@ -48,6 +76,16 @@ &cpu1 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&emmc {
+	status = "okay";
+	clocks = <&hclk_emmc>, <&sclk_emmc>, <&sclk_emmc_drv>, <&sclk_emmc_sample>;
+	clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+	cap-mmc-highspeed;
+	mmc-hs200-1_2v;
+	non-removable;
+	bus-width = <8>;
+};
+
 &gic {
 	/delete-property/ interrupts;
 };
-- 
2.31.1

