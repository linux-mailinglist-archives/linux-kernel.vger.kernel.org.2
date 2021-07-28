Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72D3D8DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhG1M0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhG1M01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:27 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E466C061765;
        Wed, 28 Jul 2021 05:26:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o13so1930440qkk.9;
        Wed, 28 Jul 2021 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uH698onlFb0zdOqNkiqHo9urf543v0Pr1mp3r+HBGM=;
        b=rIvE0rGozi1TOAqnrNqWmFKUQewYXNoEvkddzcR1KvaBj5AsmfR0SlhyLFeBQoiWM8
         XG5du8LWProFfKYgrgLhb1apwVLfl6+hGDApfA1A834L84OMAEilyisnYHmEHZaeFEQ9
         qad6GjjjA42xyAIAzuZtzFwFEACzEGxfXfzl5SS9mfv+XxawFMk3sY0D2iW1h4lDzsDj
         qJOP4XlI1d67FiD9ivMrL5RP8pC5JNTpOEXgQklF19eOtpJ+4bA5A3i0wuNVKjEfW3dS
         RdP5nR+d3NkIhTDpl2xiP2mH08Z5u6MVPidhQ56l7SVTeNsgOIHWnrP59muOeTS9ujaM
         uYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uH698onlFb0zdOqNkiqHo9urf543v0Pr1mp3r+HBGM=;
        b=ibG/Dc0EScSOJHU53taJSV+8GyQA+sOuWoyGA64yFBdxvURZsA/R8DZTG76JA3Bc7l
         qY+yREoFKcQj8lAt+bYjfDoAcvTJGnudJ1bF2vYDUO6w/BOqbJpFFXfOzOR2E+BzwVUu
         D/pR1LZ3IsMo6t0PL/7V3bxMcogZNns9OkmyQGnT4lhPn7aqDx6D6DRke6kyjpoE1dtQ
         80wqvZm7TzeyNblYa4MXm1ZYbCuD3Q8+TE9wyIzzWyNpKnFumXcYRrTm0ixI/oKMiUhs
         +Xy8/nXOyDmV3XmWedjg/CH+ihlv6C+HhZqPQIczFijbvSjZlewexC3t0LLJOHWEJwyo
         O6QA==
X-Gm-Message-State: AOAM531+WPELALJOYw7Mk2tH7qk1QFQdR3oEHhPGpWaapG6jAw6mfdud
        Are1/wnD+cQSmJEYAwziWm8=
X-Google-Smtp-Source: ABdhPJxZkroOt8pi1Kf/X5/MO0H5rMQygepNgso+s1+n4QSswvJKlg5/LcDcgNIUHovgsjbXK1xLZw==
X-Received: by 2002:a05:620a:629:: with SMTP id 9mr26258526qkv.501.1627475183679;
        Wed, 28 Jul 2021 05:26:23 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:23 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 8/9] arm64: dts: rockchip: add usb2 nodes to rk3568 device tree
Date:   Wed, 28 Jul 2021 08:26:05 -0400
Message-Id: <20210728122606.697619-9-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the requisite nodes to the rk3568 device tree to enable the usb2
device controllers.
Includes the usb2phy nodes, usb2phy grf nodes, and usb2 controller
nodes.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 97 ++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 322971318d5a..ea254a58fc01 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -200,6 +200,50 @@ gic: interrupt-controller@fd400000 {
 		msi-controller;
 	};
 
+	usb_host0_ehci: usb@fd800000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xfd800000 0x0 0x40000>;
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
+			 <&cru PCLK_USB>, <&usb2phy1>;
+		phys = <&u2phy1_otg>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb@fd840000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xfd840000 0x0 0x40000>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
+			 <&cru PCLK_USB>, <&usb2phy1>;
+		phys = <&u2phy1_otg>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host1_ehci: usb@fd880000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xfd880000 0x0 0x40000>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
+			 <&cru PCLK_USB>, <&usb2phy1>;
+		phys = <&u2phy1_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host1_ohci: usb@fd8c0000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xfd8c0000 0x0 0x40000>;
+		interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
+			 <&cru PCLK_USB>, <&usb2phy1>;
+		phys = <&u2phy1_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	pmugrf: syscon@fdc20000 {
 		compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfdc20000 0x0 0x10000>;
@@ -210,6 +254,16 @@ grf: syscon@fdc60000 {
 		reg = <0x0 0xfdc60000 0x0 0x10000>;
 	};
 
+	usb2phy0_grf: syscon@fdca0000 {
+		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
+		reg = <0x0 0xfdca0000 0x0 0x8000>;
+	};
+
+	usb2phy1_grf: syscon@fdca8000 {
+		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
+		reg = <0x0 0xfdca8000 0x0 0x8000>;
+	};
+
 	pmucru: clock-controller@fdd00000 {
 		compatible = "rockchip,rk3568-pmucru";
 		reg = <0x0 0xfdd00000 0x0 0x1000>;
@@ -738,6 +792,49 @@ saradc: saradc@fe720000 {
 		status = "disabled";
 	};
 
+	usb2phy0: usb2-phy@fe8a0000 {
+		compatible = "rockchip,rk3568-usb2phy";
+		reg = <0x0 0xfe8a0000 0x0 0x10000>;
+		clocks = <&pmucru CLK_USBPHY0_REF>;
+		clock-names = "phyclk";
+		#clock-cells = <0>;
+		clock-output-names = "usb480m_phy";
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,usbgrf = <&usb2phy0_grf>;
+		status = "disabled";
+
+		u2phy0_host: host-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		u2phy0_otg: otg-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+	};
+
+	usb2phy1: usb2-phy@fe8b0000 {
+		compatible = "rockchip,rk3568-usb2phy";
+		reg = <0x0 0xfe8b0000 0x0 0x10000>;
+		clocks = <&pmucru CLK_USBPHY1_REF>;
+		clock-names = "phyclk";
+		#clock-cells = <0>;
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,usbgrf = <&usb2phy1_grf>;
+		status = "disabled";
+
+		u2phy1_host: host-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		u2phy1_otg: otg-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.25.1

