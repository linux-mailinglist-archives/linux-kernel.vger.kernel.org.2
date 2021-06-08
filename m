Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07939EB06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFHAyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:54:19 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:41296 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHAyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:54:18 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1580qIeK028106; Tue, 8 Jun 2021 09:52:18 +0900
X-Iguazu-Qid: 2wGqmO4szg6WmPAebj
X-Iguazu-QSIG: v=2; s=0; t=1623113538; q=2wGqmO4szg6WmPAebj; m=q6xwPIAojH4CuE4qrPKnf4+y94Ii/3K0PoCcmkgkk84=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 1580qHr5011516
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 8 Jun 2021 09:52:18 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id CA5CC10007C;
        Tue,  8 Jun 2021 09:52:17 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1580qHQt005963;
        Tue, 8 Jun 2021 09:52:17 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] arm64: dts: visconti: Add PWM support for TMPV7708 SoC
Date:   Tue,  8 Jun 2021 09:52:06 +0900
X-TSB-HOP: ON
Message-Id: <20210608005206.263238-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM node in TMPV7708's dtsi, and tmpv7708-rm-mbrc boards's dts.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts | 8 ++++++++
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi        | 9 +++++++++
 arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi   | 5 +++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
index bf0620afe117..29a4d9fc1e47 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
@@ -68,3 +68,11 @@ &wdt {
 &gpio {
 	status = "okay";
 };
+
+&pwm_mux {
+	groups = "pwm0_gpio16_grp", "pwm1_gpio17_grp", "pwm2_gpio18_grp", "pwm3_gpio19_grp";
+};
+
+&pwm {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 17934fd9a14c..4b4231ff43cf 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -432,6 +432,15 @@ wdt: wdt@28330000 {
 			reg = <0 0x28330000 0 0x1000>;
 			status = "disabled";
 		};
+
+		pwm: pwm@241c0000 {
+			compatible = "toshiba,visconti-pwm";
+			reg = <0 0x241c0000 0 0x1000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm_mux>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
index 34de00015a7f..a480c6ba5f5d 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
@@ -90,4 +90,9 @@ i2c8_pins: i2c8-pins {
 		groups = "i2c8_grp";
 		bias-pull-up;
 	};
+
+	pwm_mux: pwm_mux {
+		function = "pwm";
+	};
+
 };
-- 
2.31.1

