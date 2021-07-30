Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A853F3DB9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhG3OCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhG3OCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:02:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E249CC06175F;
        Fri, 30 Jul 2021 07:02:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d2so6443466qto.6;
        Fri, 30 Jul 2021 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXIfKSGWJ9mlCbWNNx/N/vTZPaRHrXle0JFg+o3znXk=;
        b=IRORz5zxXvGhatsjJBkQeTsDqRAVIW2moZPm8a3A2FpA+x1l4SmqH6ZcDSJP/cTEvC
         cLVXBlu0p5qrmxqqCshaq7Aookh/YLzmDEW/P4jSpL5CLrTalq++nsCmsInAGfL+jeLI
         znCCkvmwEZeBAac05xmmBwPw+IWX4LTeNM7s3qov1HQsVVHd2S+u022c+sEEEJDBXSX7
         Y6Aev2cXnjoReP5TUgkQj0CJ/eY9gOxGr46x6QY9LrDpkysFu3CUGBvjtu6S+X/Gg3gE
         hi8djPx+7GbH7UKy3APsIyMqtm9oeNtEQg7zBrr5Lm+1iT6sjt3utYAsvqDjYRIhXEbl
         1JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXIfKSGWJ9mlCbWNNx/N/vTZPaRHrXle0JFg+o3znXk=;
        b=Z+1CB/VR/oDEyfMuZrCW63PQQoa5eWpnR3KU6+3oCWs5n0/XUJT33YGS1b9cPiUMp1
         Nkhv1xyTgfcBUr++IfaUByTIIpZ2U4QAgE26nPP4jMzjUcvc3eWHvu6SiBrBcfjdpMzz
         9Obn1xjhQvPFghg+TFbt/cnu3xCfnXrUWYIze/rnInkxmdQW7askZ5ndMo6L9jFmhg6C
         vEPu8hvawIiiP5l/V6QouWRzk69inDkkr/UQD5pQZOX4uxNO0RMfUQQsON4Dik42xEry
         7FKVTVk24xFWRKhSv4WmODwWr1yBjBb2xreJStVrSr+//i71SQC/dla5wb1wBmY1CUJj
         bkmw==
X-Gm-Message-State: AOAM533RD34BqtvX/C+92Xeh0nHtZ6bEa5rhr5Hf7aQ+Twlzt1DJoza2
        LzD9lQCG7aboEJbdP1AcRcc=
X-Google-Smtp-Source: ABdhPJzpf3kEwfAPYGXdtI3m6k2LvxwAaDiSzmfIgXSx9Uiog8YtJdEewUXG65zxN4RxMlDDbgHhOQ==
X-Received: by 2002:a05:622a:310:: with SMTP id q16mr2426708qtw.168.1627653752991;
        Fri, 30 Jul 2021 07:02:32 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b33d:da64:8d94:ff34])
        by smtp.gmail.com with ESMTPSA id r16sm948992qke.73.2021.07.30.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:02:32 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: add thermal fan control to rockpro64
Date:   Fri, 30 Jul 2021 10:02:10 -0400
Message-Id: <20210730140210.728367-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockpro64 had a fan node since
commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
however it was never tied into the thermal driver for automatic control.

Add the links to the thermal node to permit the kernel to handle this
automatically.
Borrowed from the (rk3399-khadas-edge.dtsi).

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

Changelog:
v2:
Adjusted fan setpoints for less noise

 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6bff8db7d33e..0d79e6ae1c3a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -69,6 +69,7 @@ diy_led: led-1 {
 
 	fan: pwm-fan {
 		compatible = "pwm-fan";
+		cooling-levels = <0 100 150 200 255>;
 		#cooling-cells = <2>;
 		fan-supply = <&vcc12v_dcin>;
 		pwms = <&pwm1 0 50000 0>;
@@ -245,6 +246,34 @@ &cpu_b1 {
 	cpu-supply = <&vdd_cpu_b>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_warm: cpu_warm {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_hot: cpu_hot {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map2 {
+			trip = <&cpu_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map3 {
+			trip = <&cpu_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -281,6 +310,34 @@ &gpu {
 	status = "okay";
 };
 
+&gpu_thermal {
+	trips {
+		gpu_warm: gpu_warm {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		gpu_hot: gpu_hot {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&gpu_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map2 {
+			trip = <&gpu_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-rising-time-ns = <168>;
-- 
2.25.1

