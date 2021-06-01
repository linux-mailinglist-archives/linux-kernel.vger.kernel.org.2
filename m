Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B56239786C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhFAQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhFAQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:50:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260F6C06174A;
        Tue,  1 Jun 2021 09:48:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i13so18180407edb.9;
        Tue, 01 Jun 2021 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8yrT0K2LfeXhIzhR/5QWBV3kbYfUc/He2mmnHviDt4=;
        b=jA46gtlB32jvqbaHFH9jvsdOlOHKjWDjyRLRCJcEBBCKrBB2uCTJZMeJkkuy1uF7M+
         3TmncLhd5DOkG72wA9Rd8mmT5+m2Se1i2OIabtgfaFRjV8oHI0VvJUONxpKYZ7iysIR3
         3Y70T1sHaA889A1Usd7AmaAeWq/0DuWn8FmZFvBEK5cYBvUZ2Q8ip8F27RnoAA+Nw8iE
         WKkxKoWOIofMPLYWKViOqLq7d0CJKEsVtQmjHUEeRK4mL5+nHtPyhT5F0Ofi6tM1/Uku
         MayRehNB9R1KjmTUaA8yspDbFysFCiv4HDzvM/SV6GPz9GRBIf4uJFHNLzMwYSEdH1tJ
         SjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B8yrT0K2LfeXhIzhR/5QWBV3kbYfUc/He2mmnHviDt4=;
        b=i24NXuiMybjmbORQGjuvipINNEb204csA/22OsnPsnjyAtwaN+qFFGflMylrNY5k75
         I0W/YmFkrGsI9y1eZM82YJQ0T8kqA+PPFsCqUYI8KC16pIQWMfgkZngJf2Yk7Jfv1EZy
         uU2ZCYbTIEt+ACODckam64vQp1NlpovnF/U1id9M/qvA9cOmeBW0Wff3obqN5S7z94Ij
         NFb9hYOKzQE1FEVUurVoukaYXt4MzplKfu0tSuU151QCyyklWzcXNOMXu1O4HYz6C1eK
         qJAqtuqNGc87BZgyd6iIBdBgkWBEATwlVg0CCxjB1cnTOR/TvJU+/rRAeo4X6ZJiN7tJ
         VM6A==
X-Gm-Message-State: AOAM530TeYFEPEypWQSpxm9z4rTlHqfhkj8wleGD8recITcGSl4eB9Ry
        0BIcuEE6kkkx4I/b5/hVC2s=
X-Google-Smtp-Source: ABdhPJwYFb76+ATm+1vcRtbPA1ti1sxM+CUyTpVJbs5DshpTnTSjevMP61I9Rp6PBQKTVhgIVA5Llw==
X-Received: by 2002:a05:6402:40d0:: with SMTP id z16mr34296115edb.104.1622566096823;
        Tue, 01 Jun 2021 09:48:16 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q18sm8327750edd.3.2021.06.01.09.48.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:48:16 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] arm64: dts: rockchip: add USB support to rk3308.dtsi
Date:   Tue,  1 Jun 2021 18:48:00 +0200
Message-Id: <20210601164800.7670-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210601164800.7670-1-jbx6244@gmail.com>
References: <20210601164800.7670-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Schramm <t.schramm@manjaro.org>

The Rockchip RK3308 features an integrated USB 2.0 phy, an USB OTG
controller and OHCI/EHCI interfaces.
This patch adds all of those to the RK3308 dtsi and thereby enables USB
support on the RK3308.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed:
  restyle
  limit grf reg size
  change sub nodename
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 74 +++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index b815ce73e..a185901ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -164,7 +164,7 @@
 
 	grf: grf@ff000000 {
 		compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
-		reg = <0x0 0xff000000 0x0 0x10000>;
+		reg = <0x0 0xff000000 0x0 0x08000>;
 
 		reboot-mode {
 			compatible = "syscon-reboot-mode";
@@ -177,6 +177,42 @@
 		};
 	};
 
+	usb2phy_grf: syscon@ff008000 {
+		compatible = "rockchip,rk3308-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xff008000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy: usb2phy@100 {
+			compatible = "rockchip,rk3308-usb2phy";
+			reg = <0x100 0x10>;
+			assigned-clocks = <&cru USB480M>;
+			assigned-clock-parents = <&u2phy>;
+			clocks = <&cru SCLK_USBPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy";
+			#clock-cells = <0>;
+			status = "disabled";
+
+			u2phy_otg: otg-port {
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			u2phy_host: host-port {
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	detect_grf: syscon@ff00b000 {
 		compatible = "rockchip,rk3308-detect-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff00b000 0x0 0x1000>;
@@ -579,6 +615,42 @@
 		status = "disabled";
 	};
 
+	usb20_otg: usb@ff400000 {
+		compatible = "rockchip,rk3308-usb", "rockchip,rk3066-usb",
+			     "snps,dwc2";
+		reg = <0x0 0xff400000 0x0 0x40000>;
+		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG>;
+		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
+		phys = <&u2phy_otg>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
+	usb_host_ehci: usb@ff440000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xff440000 0x0 0x10000>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host_ohci: usb@ff450000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xff450000 0x0 0x10000>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	sdmmc: mmc@ff480000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff480000 0x0 0x4000>;
-- 
2.11.0

