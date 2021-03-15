Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DB933B2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhCOMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:43:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhCOMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:43:21 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lLmZ6-0004ha-7f
        for linux-kernel@vger.kernel.org; Mon, 15 Mar 2021 12:43:20 +0000
Received: by mail-wr1-f72.google.com with SMTP id h21so14919176wrc.19
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEJ+dGSoJaOl9b6R9srU6s0ehbSLR30XvLByv0VyyrI=;
        b=XmgAZ2fIYjDH5sBkRtQFYXECzu8L1jQq0Gs1AL95G+bGpbcAsHx5Obq3XX+kGzg1LL
         1OI4XaqPwoIvyc838/lqxYJXtA3+tLnlP3TsFoDxt+P+UDnGQsbExQIHHOMQxh9NAEaR
         c7ki1KBJZHrOwYvRKdN2zcVjvZsBG+jQ9Sx19K/gv3HDskExx1mElX7SxKDPOFg6vkO6
         8VPWTexnz+6k/q+Vx/lkYJMiAGYGVnyxll+LKhr4Q3/B5shLQsx/TPXNChd/q3zZxSA2
         fvIbmQtYSWcACbL5ss4amqOxfms/GGcWAIiQqaBR8cmxFvWvIRU/yvNahzEYR17ZhDm5
         /m+Q==
X-Gm-Message-State: AOAM5300DZPZ4keorPX7mC1M64qIJflhCo03Y00tsNFaK7DIXuCnHeoA
        Gwo7Hb1a+HgqEm42TtjL0ppemf8O8Ck6tdHfyP1Hn1Vv7I7Z2wZr9hJ+WsRcPwsd+JlJ0XTasW+
        Djk2QmFaUj37KTIQUs7rKEYbAat+G5GeyHy/4CYQAiA==
X-Received: by 2002:a05:600c:1405:: with SMTP id g5mr25401441wmi.140.1615812199950;
        Mon, 15 Mar 2021 05:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWKQZx0GO/2hrw67COu0zD8W7FJdfl5S0esHLhy6NvwmcURPYJI8gyxRsk5tRJGfpgw7MVNQ==
X-Received: by 2002:a05:600c:1405:: with SMTP id g5mr25401423wmi.140.1615812199808;
        Mon, 15 Mar 2021 05:43:19 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id r10sm14410094wmh.45.2021.03.15.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:43:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] ARM: dts: exynos: white-space cleanups
Date:   Mon, 15 Mar 2021 13:43:12 +0100
Message-Id: <20210315124313.114842-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315124313.114842-1-krzysztof.kozlowski@canonical.com>
References: <20210315124313.114842-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixups some white-space issues.  Checkpatch reported:

  WARNING: Block comments should align the * on each line
  WARNING: please, no spaces at the start of a line
  ERROR: code indent should use tabs where possible

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../boot/dts/exynos4412-odroid-common.dtsi    |  2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts      |  3 +-
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 48 +++++++++----------
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi     | 28 +++++------
 4 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index eebe6a3952ce..333f83e93880 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -2,7 +2,7 @@
 /*
  * Common definition for Hardkernel's Exynos4412 based ODROID-X/X2/U2/U3 boards
  * device tree source
-*/
+ */
 
 #include <dt-bindings/sound/samsung-i2s.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 0e9d626e740a..440135d0ff2a 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -84,7 +84,8 @@ hub@1 {
 			ethernet: usbether@1 {
 				compatible = "usb0424,ec00";
 				reg = <1>;
-				local-mac-address = [00 00 00 00 00 00]; /* Filled in by a bootloader */
+				/* Filled in by a bootloader */
+				local-mac-address = [00 00 00 00 00 00];
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
index 3a3b2fafefdd..7f187a3dedcc 100644
--- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
@@ -7,41 +7,41 @@
  */
 
 &ppmu_dmc0 {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_dmc0_3: ppmu-event3-dmc0 {
-		       event-name = "ppmu-event3-dmc0";
-	       };
-       };
+	events {
+		ppmu_dmc0_3: ppmu-event3-dmc0 {
+			event-name = "ppmu-event3-dmc0";
+		};
+	};
 };
 
 &ppmu_dmc1 {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_dmc1_3: ppmu-event3-dmc1 {
-		       event-name = "ppmu-event3-dmc1";
-	       };
-       };
+	events {
+		ppmu_dmc1_3: ppmu-event3-dmc1 {
+			event-name = "ppmu-event3-dmc1";
+		};
+	};
 };
 
 &ppmu_leftbus {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_leftbus_3: ppmu-event3-leftbus {
-		       event-name = "ppmu-event3-leftbus";
-	       };
-       };
+	events {
+		ppmu_leftbus_3: ppmu-event3-leftbus {
+			event-name = "ppmu-event3-leftbus";
+		};
+	};
 };
 
 &ppmu_rightbus {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_rightbus_3: ppmu-event3-rightbus {
-		       event-name = "ppmu-event3-rightbus";
-	       };
-       };
+	events {
+		ppmu_rightbus_3: ppmu-event3-rightbus {
+			event-name = "ppmu-event3-rightbus";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index d0aa18443a69..9599ba8ba798 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -235,13 +235,13 @@ gpx0: gpx0 {
 		interrupt-parent = <&combiner>;
 		#interrupt-cells = <2>;
 		interrupts = <23 0>,
-		             <24 0>,
-		             <25 0>,
-		             <25 1>,
-		             <26 0>,
-		             <26 1>,
-		             <27 0>,
-		             <27 1>;
+			     <24 0>,
+			     <25 0>,
+			     <25 1>,
+			     <26 0>,
+			     <26 1>,
+			     <27 0>,
+			     <27 1>;
 	};
 
 	gpx1: gpx1 {
@@ -252,13 +252,13 @@ gpx1: gpx1 {
 		interrupt-parent = <&combiner>;
 		#interrupt-cells = <2>;
 		interrupts = <28 0>,
-		             <28 1>,
-		             <29 0>,
-		             <29 1>,
-		             <30 0>,
-		             <30 1>,
-		             <31 0>,
-		             <31 1>;
+			     <28 1>,
+			     <29 0>,
+			     <29 1>,
+			     <30 0>,
+			     <30 1>,
+			     <31 0>,
+			     <31 1>;
 	};
 
 	gpx2: gpx2 {
-- 
2.25.1

