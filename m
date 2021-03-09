Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9680331C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 02:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCIBWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 20:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhCIBWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 20:22:22 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02900C061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 17:22:11 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u4so18573587ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 17:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RxYnecloaGvVUTXfLbyGGnFAcsYJu5ZgYtu8FBQ5fBc=;
        b=LCKdRI2yDlmKErcJM0u5rRo35wCCUgmxsRZX30cARJru5O+9N28v7xS5xcjd7lx7qg
         LukOl5cSKvz38CEGTC85VsoBfPc3Ra4AFQs5sJJV9CotnFYp4Ks8LIZUuv1WwL6JFqp3
         NL7UNf1YfPqAEgoAbUwz23ttY4aAybjUTxun1bgiCKp+z/DsRoLAiYxJwuCYb/6wdBpP
         wu80L6TPND27PxYr1z0bAgSY9fih+BQvkN55zgKi8D/POpct/bPsMLq5gkSHUleu+3Mv
         3HeWoBR74op+m5U8NGjp/z8rDO8HcK9Iiu2uTL9K4l4jld3+wFovyAuOHOZq4KzVcNaZ
         mioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RxYnecloaGvVUTXfLbyGGnFAcsYJu5ZgYtu8FBQ5fBc=;
        b=LMlFRNoeRgkHGiPK+YESaEsv6cw04CCC8cmLH+VNhMZk7TAfpUdYlzmxtFIpDW/I66
         G++FlyY06g2+90K+aVFGONtOKF1ZCVqPuFW055/eXCEBDc49yXsBKPYXYdq3FDSJkuRN
         L5JIXz7pwi3eC99CLgqJcqPdpT7f6f6xVIif4b/JjRD+R/k2tlqlMg5Ck7KcDiOotU/1
         EPGuMGCjCwn3bhNgtTdEHeh/2nizySuIks5oRisp6Bu3oPgJUpbwJ14an4YGqZuG127E
         1eoX/WKMKPS1TMqSZFWOqE0T0a8oALPSnIbI7jWslN3MpogD6VFQnMxDH8nX9MBViwXt
         LJvA==
X-Gm-Message-State: AOAM530pTC/lGqRodDPckeob7EIdwfke+Nr2m3WvmkpR3nBwRpn5eZ51
        keCXfnnRLqdEAKiOYOlM86jH9Q==
X-Google-Smtp-Source: ABdhPJxzN23lxW9jmifFdPJhsdhPzsOdKGADxu6jPQV1o55WrXjtjoy0Eozu0nrhhcEVp/DiMqKvSg==
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr16046309ljj.284.1615252928545;
        Mon, 08 Mar 2021 17:22:08 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.6.dhcp.mipt-telecom.ru. [81.5.99.6])
        by smtp.gmail.com with ESMTPSA id o11sm1538395lfu.157.2021.03.08.17.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 17:22:08 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] dts: r40: add second ethernet support
Date:   Tue,  9 Mar 2021 04:21:16 +0300
Message-Id: <20210309012116.2944-3-boger@wirenboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309012116.2944-1-boger@wirenboard.com>
References: <20210309012116.2944-1-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 (aka V40, A40i, T3) has two different Ethernet IP
called EMAC and GMAC.
EMAC only support 10/100 Mbit in MII mode,
while GMAC support both 10/100 (MII) and 10/100/1000 (RGMII).

In contrast to A10/A20 where GMAC and EMAC share the same pins
making EMAC somewhat pointless, on R40 EMAC can be routed to port H.
Both EMAC (on port H) and GMAC (on port A)
 can be then enabled at the same time, allowing for two ethernet ports.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index d5ad3b9efd12..c31386e421b1 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -217,6 +217,20 @@
 			#size-cells = <1>;
 			ranges;
 
+			sram_a: sram@0 {
+				compatible = "mmio-sram";
+				reg = <0x00000000 0xc000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00000000 0xc000>;
+
+				emac_sram: sram-section@8000 {
+					compatible = "allwinner,sun4i-a10-sram-a3-a4";
+					reg = <0x8000 0x4000>;
+					status = "okay";
+				};
+			};
+
 			sram_c: sram@1d00000 {
 				compatible = "mmio-sram";
 				reg = <0x01d00000 0xd0000>;
@@ -541,6 +555,33 @@
 				drive-strength = <40>;
 			};
 
+			emac_pa_pins: emac-pa-pins {
+				pins = "PA0", "PA1", "PA2",
+				       "PA3", "PA4", "PA5", "PA6",
+				       "PA7", "PA8", "PA9", "PA10",
+				       "PA11", "PA12", "PA13", "PA14",
+				       "PA15", "PA16";
+				function = "emac";
+			};
+
+			emac_ph_pins: emac-ph-pins {
+				pins = "PH8", "PH9", "PH10", "PH11",
+				       "PH14", "PH15", "PH16", "PH17",
+				       "PH18","PH19", "PH20", "PH21",
+				       "PH22", "PH23", "PH24", "PH25",
+				       "PH26", "PH27";
+				function = "emac";
+			};
+
+			emac_pa_pins: emac-pa-pins {
+				pins = "PA0", "PA1", "PA2",
+				       "PA3", "PA4", "PA5", "PA6",
+				       "PA7", "PA8", "PA9", "PA10",
+				       "PA11", "PA12", "PA13", "PA14",
+				       "PA15", "PA16";
+				function = "emac";
+			};
+
 			i2c0_pins: i2c0-pins {
 				pins = "PB0", "PB1";
 				function = "i2c0";
@@ -885,6 +926,24 @@
 			};
 		};
 
+		emac: ethernet@1c0b000 {
+			compatible = "allwinner,sun4i-r40-emac";
+			reg = <0x01c0b000 0x1000>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_EMAC>;
+			resets = <&ccu RST_BUS_EMAC>;
+			allwinner,sram = <&emac_sram 1>;
+			status = "disabled";
+		};
+
+		emac_mdio: mdio@1c0b080 {
+			compatible = "allwinner,sun4i-a10-mdio";
+			reg = <0x01c0b080 0x14>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mbus: dram-controller@1c62000 {
 			compatible = "allwinner,sun8i-r40-mbus";
 			reg = <0x01c62000 0x1000>;
-- 
2.17.1

