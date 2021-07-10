Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37973C3515
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhGJPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhGJPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 11:13:57 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20060C0613DD;
        Sat, 10 Jul 2021 08:11:12 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d1so9969494qto.4;
        Sat, 10 Jul 2021 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jH/4akIMNvo3VlMCPvDnCUu6i4iqvkKnvLcFgPTVNd4=;
        b=tGw4KDuuclT1Zfmr90UCdDwbJggllCoFbVlRg90z3vprfkAPMErhhXswmpTOdyIef+
         rQ9URnhf/TjtJJdkW+dsh2uXhDK4YJ+L/WNh7gflUPn0PG7cQ42gSAWKJwDBuDyk77eT
         bYnrsjYW+Rq79iAKwjWqh9zEiygVZkBUuYYXN/tXfU6AzNahaEhvNH4Fak7+LO+gkGLs
         Qh4FDiOvddsR0Sgt9Lo8BjiI/1M6qaqySaI2V6gmF/qbzEAQjWaINXRkOLDl+E1F6hlq
         Zva88ubmasyornnDvNGgv1KtRSOI5lHlCJ3J7q57VP1p8tbKwhAcKT1jhY6LubFeihSX
         d06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jH/4akIMNvo3VlMCPvDnCUu6i4iqvkKnvLcFgPTVNd4=;
        b=BU/Cx87OA1L3OQ0YJcuxfRztFCBNz+ajs/i5tNpzltecrsN0Vn5by2Qz1dLTAAKAHL
         15V5TdrVKzrdSXNXtFje5E+uDZQhg9xIsJ+ZPdzTiJINKavGbXc8UEu3KJ5kvDUZGYMn
         oZxL7SsrynI5FALHH+zIWMAqKvkdABAM83ybgiu5flm67qPgWHi1KIHTfh+OUqFgNeWl
         +o4jh/iD1dbTAgYmeFwpLkqKy3Tl4/OGU7wJgZpDV7kcC0jm+bIPwUE3F1mKWH/ny6lm
         ng/ctJtmHP9O1n82Zk4sL0twWSGD8v8lMlySW+4NldpPSHgokpWYZXWAizxRP8XC/Xjz
         V22A==
X-Gm-Message-State: AOAM531N7gVSm+NWGmhTTsDAu5X0QEziEXifW1X/5sWxUVwmTraWYkMw
        bnVjeAGE8qLf1GG2UDhRCq4=
X-Google-Smtp-Source: ABdhPJzQ81SaNMCVTWvSDKKHTF8XmIjtFPsqZvvnFm23/yrWcCzxkoGzsS9i08hg7N4UvaJRTieQjw==
X-Received: by 2002:ac8:dc9:: with SMTP id t9mr38904025qti.293.1625929871247;
        Sat, 10 Jul 2021 08:11:11 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:ecc6:5233:6153:7b36])
        by smtp.gmail.com with ESMTPSA id w14sm3445482qtc.55.2021.07.10.08.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 08:11:11 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 2/4] arm64: dts: rockchip: split rk3568 device tree
Date:   Sat, 10 Jul 2021 11:10:32 -0400
Message-Id: <20210710151034.32857-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210710151034.32857-1-pgwipeout@gmail.com>
References: <20210710151034.32857-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the rk3566 inclusion, split apart the rk3568 specific
nodes into a separate device tree.
This allows us to create the rk3566 device tree without deleting nodes.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 48 ++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 36 ------------------
 2 files changed, 48 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
new file mode 100644
index 000000000000..da01a59f6f26
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+
+#include "rk356x.dtsi"
+
+/ {
+	compatible = "rockchip,rk3568";
+
+	qos_pcie3x1: qos@fe190080 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190080 0x0 0x20>;
+	};
+
+	qos_pcie3x2: qos@fe190100 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190100 0x0 0x20>;
+	};
+
+	qos_sata0: qos@fe190200 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190200 0x0 0x20>;
+	};
+};
+
+&cpu0_opp_table {
+	opp-1992000000 {
+		opp-hz = /bits/ 64 <1992000000>;
+		opp-microvolt = <1150000 1150000 1150000>;
+	};
+};
+
+&power {
+	power-domain@RK3568_PD_PIPE {
+		reg = <RK3568_PD_PIPE>;
+		clocks = <&cru PCLK_PIPE>;
+		pm_qos = <&qos_pcie2x1>,
+			 <&qos_pcie3x1>,
+			 <&qos_pcie3x2>,
+			 <&qos_sata0>,
+			 <&qos_sata1>,
+			 <&qos_sata2>,
+			 <&qos_usb3_0>,
+			 <&qos_usb3_1>;
+		#power-domain-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 2737f26775ff..fb4ae22b827a 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -13,8 +13,6 @@
 #include <dt-bindings/thermal/thermal.h>
 
 / {
-	compatible = "rockchip,rk3568";
-
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -121,11 +119,6 @@ opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
 			opp-microvolt = <1050000 1050000 1150000>;
 		};
-
-		opp-1992000000 {
-			opp-hz = /bits/ 64 <1992000000>;
-			opp-microvolt = <1150000 1150000 1150000>;
-		};
 	};
 
 	firmware {
@@ -334,20 +327,6 @@ power-domain@RK3568_PD_RKVENC {
 					 <&qos_rkvenc_wr_m0>;
 				#power-domain-cells = <0>;
 			};
-
-			power-domain@RK3568_PD_PIPE {
-				reg = <RK3568_PD_PIPE>;
-				clocks = <&cru PCLK_PIPE>;
-				pm_qos = <&qos_pcie2x1>,
-					 <&qos_pcie3x1>,
-					 <&qos_pcie3x2>,
-					 <&qos_sata0>,
-					 <&qos_sata1>,
-					 <&qos_sata2>,
-					 <&qos_usb3_0>,
-					 <&qos_usb3_1>;
-				#power-domain-cells = <0>;
-			};
 		};
 	};
 
@@ -431,21 +410,6 @@ qos_pcie2x1: qos@fe190000 {
 		reg = <0x0 0xfe190000 0x0 0x20>;
 	};
 
-	qos_pcie3x1: qos@fe190080 {
-		compatible = "rockchip,rk3568-qos", "syscon";
-		reg = <0x0 0xfe190080 0x0 0x20>;
-	};
-
-	qos_pcie3x2: qos@fe190100 {
-		compatible = "rockchip,rk3568-qos", "syscon";
-		reg = <0x0 0xfe190100 0x0 0x20>;
-	};
-
-	qos_sata0: qos@fe190200 {
-		compatible = "rockchip,rk3568-qos", "syscon";
-		reg = <0x0 0xfe190200 0x0 0x20>;
-	};
-
 	qos_sata1: qos@fe190280 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe190280 0x0 0x20>;
-- 
2.25.1

