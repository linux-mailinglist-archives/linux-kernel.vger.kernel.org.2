Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51037BC72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhELMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhELMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:25:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C6C061574;
        Wed, 12 May 2021 05:24:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g14so26845863edy.6;
        Wed, 12 May 2021 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3fkGNgTzar9ObGlEMhUqMPhSTHb0gzcUEjoNSk/LcQs=;
        b=UneCKWhZjaHZPU1dTnKbSbQjfmEE0eRmjGlIyJ4C+XqoSMKXUAvhqArpa+ys7/yoXw
         Xx8dvJBAug+0lRL0uVdjndTv30c1yVTjeMhVVUnhfhBmgQmp36l4m9N2VUMqF0FAQb3X
         1E2DKIIpYjDv1pwGOITuA4GYfBap52ElON7ux2bFezwIZFz/+3ui4Ok8d0joDywhnxew
         0ZYvBHIxFDoBQdFKc5bQzDrRI7uSXsG+rocJnugSm1NQKyB4MdaqLcWnrLorpV5Xs1lE
         /Xyjbb4G5nzks2fvRYtCef6pkTRAydNSYWYEkmV1ZpQQhL3j3VPdYIzi5keGa5O9bhum
         q5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3fkGNgTzar9ObGlEMhUqMPhSTHb0gzcUEjoNSk/LcQs=;
        b=jqeJkFxioUY8Pl6dvNx4LQoCA2BTDeP8IgIWPcX5MnLd4Na/KAHYdwIn+8wWZcCqbg
         s5MZeNcC30qq/mrBMc9f2JNXIMwe9e85cH/XBer1UWf6vq0CZTGqeiyWrNAS7mWafA+1
         6WU+fc7dj4O40CweBX/PJbSOZByPf41VWb2EpGJ89MzA04hVX3KXsP582m2qp12udoHe
         fP8q0CuVKH/F0QGruuha6/JaXDVz6JVo124Tg8QbgfkH7eZQRebqmXNP6Ge9x5G2Xa1d
         wU1Aqv2ug6ae6MifWYryW/POzfz4HdKLYvKuzUi3uHCDTn1uM6DdERapK8D5Jyd2H7Q3
         Lz3A==
X-Gm-Message-State: AOAM531JuZcJYP0CZvW/rN9sg1w8NSX+nxPqboDR+d0iOm3LnDMkNEMi
        rKN5NUx6EUrHuqzwV5gyO1vRHjdTjZg=
X-Google-Smtp-Source: ABdhPJw48ciP8ei3rziBvI5AZPg+p+PfN26lbFAtiePNl5R+V0WyuVmfGwv09i2fVzzX3LVwl5G49w==
X-Received: by 2002:a05:6402:204c:: with SMTP id bc12mr42558805edb.35.1620822240902;
        Wed, 12 May 2021 05:24:00 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g17sm21459665edv.47.2021.05.12.05.23.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 05:24:00 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, kishon@ti.com,
        vkoul@kernel.org, jay.xu@rock-chips.com, shawn.lin@rock-chips.com,
        david.wu@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] ARM: dts: rockchip: move and restyle grf nodes rk3066/rk3188
Date:   Wed, 12 May 2021 14:23:45 +0200
Message-Id: <20210512122346.9463-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210512122346.9463-1-jbx6244@gmail.com>
References: <20210512122346.9463-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With grf.txt converted to YAML a lot of compatibles
did not have 'simple-mfd' added in the old binding.
That implies that if you have child nodes they need
to be documented.
Make the new layout fit for rk3066/rk3188,
move and restyle the grf nodes.
Remove rockchip,grf from usbphy node.
Add "#phy-cells", because it is a required property
by phy-provider.yaml
With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip rk3xxx.dtsi file only uses "syscon"
for the grf registers. Add "syscon", "simple-mfd"
compatible for rk3066/rk3188 to reduce notifications produced with:

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Changed compatibles:
"rockchip,rk3066-grf", "syscon", "simple-mfd"
"rockchip,rk3188-grf", "syscon", "simple-mfd"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 53 +++++++++++++++++++++++-------------------
 arch/arm/boot/dts/rk3188.dtsi  | 53 +++++++++++++++++++++++-------------------
 arch/arm/boot/dts/rk3xxx.dtsi  |  2 +-
 3 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 8e087c34b..30dcf557e 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -266,30 +266,6 @@
 		status = "disabled";
 	};
 
-	usbphy: phy {
-		compatible = "rockchip,rk3066a-usb-phy", "rockchip,rk3288-usb-phy";
-		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-
-		usbphy0: usb-phy@17c {
-			#phy-cells = <0>;
-			reg = <0x17c>;
-			clocks = <&cru SCLK_OTGPHY0>;
-			clock-names = "phyclk";
-			#clock-cells = <0>;
-		};
-
-		usbphy1: usb-phy@188 {
-			#phy-cells = <0>;
-			reg = <0x188>;
-			clocks = <&cru SCLK_OTGPHY1>;
-			clock-names = "phyclk";
-			#clock-cells = <0>;
-		};
-	};
-
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3066a-pinctrl";
 		rockchip,grf = <&grf>;
@@ -702,6 +678,35 @@
 	power-domains = <&power RK3066_PD_GPU>;
 };
 
+&grf {
+	compatible = "rockchip,rk3066-grf", "syscon", "simple-mfd";
+
+	usbphy: usbphy {
+		compatible = "rockchip,rk3066a-usb-phy",
+			     "rockchip,rk3288-usb-phy";
+		#phy-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		usbphy0: usb-phy@17c {
+			reg = <0x17c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+
+		usbphy1: usb-phy@188 {
+			reg = <0x188>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_xfer>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index f438170b4..41a912acb 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -214,30 +214,6 @@
 		};
 	};
 
-	usbphy: phy {
-		compatible = "rockchip,rk3188-usb-phy", "rockchip,rk3288-usb-phy";
-		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-
-		usbphy0: usb-phy@10c {
-			#phy-cells = <0>;
-			reg = <0x10c>;
-			clocks = <&cru SCLK_OTGPHY0>;
-			clock-names = "phyclk";
-			#clock-cells = <0>;
-		};
-
-		usbphy1: usb-phy@11c {
-			#phy-cells = <0>;
-			reg = <0x11c>;
-			clocks = <&cru SCLK_OTGPHY1>;
-			clock-names = "phyclk";
-			#clock-cells = <0>;
-		};
-	};
-
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3188-pinctrl";
 		rockchip,grf = <&grf>;
@@ -637,6 +613,35 @@
 	interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 };
 
+&grf{
+	compatible = "rockchip,rk3188-grf", "syscon", "simple-mfd";
+
+	usbphy: usbphy {
+		compatible = "rockchip,rk3188-usb-phy",
+			     "rockchip,rk3288-usb-phy";
+		#phy-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		usbphy0: usb-phy@10c {
+			reg = <0x10c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+
+		usbphy1: usb-phy@11c {
+			reg = <0x11c>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+	};
+};
+
 &gpu {
 	compatible = "rockchip,rk3188-mali", "arm,mali-400";
 	interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 755c946f1..d473552e8 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -256,7 +256,7 @@
 	};
 
 	grf: grf@20008000 {
-		compatible = "syscon";
+		compatible = "syscon", "simple-mfd";
 		reg = <0x20008000 0x200>;
 	};
 
-- 
2.11.0

