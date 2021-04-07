Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED01C3576B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhDGVW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhDGVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96DCC0613D9;
        Wed,  7 Apr 2021 14:21:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a12so9668496wrq.13;
        Wed, 07 Apr 2021 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtFOY3jGwpepTPbYEqh8kZlA1Mb2wn1W95xoHay4I/4=;
        b=OgamkSyW+w07gNRyBMzhT94ZSxA0yKZVKdEjFwHwUpzS6iGTdn34mjv7A+ziE/ulq5
         HOGoiJ2aFpqW1xD/Y8ht2WVO9TwARKC5NviF+0i+gwf0MM4iyh9abIFDk283mRNT1LEc
         k+P2DmtY8FxPLMMX3nwrJz6D7jerBZZel0Clx9id1q1x34h7V5Fgxx1T8iTkNS2JcmvV
         y1G2BFSy8DWzo0RPfzjlVkgEk/hYm+z7Nzo6ltDZ/koNoiOgz+nZP7gSFuZ/Snz9ADg6
         0yvJs2cTNeOq2Dbb+0ZcY5i/ft7P1xANBQHfrEi9jWzBpKBJ3GLc0a0sDPSb8Vv6n8Np
         i5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtFOY3jGwpepTPbYEqh8kZlA1Mb2wn1W95xoHay4I/4=;
        b=PN9nzzSqt6Cferd1wWc45cw/y/JcOYx7ftRUk3mVdzRf5ugpfBKRl46XBJ/pv2vmU9
         XOd2ZEQKiZwgXl/mOSNb3ddev0zRbxOfPFRQOuGTwAcjWF5jpmAzAO9DA2QTBELXAP+B
         CA/VuX6OBUwtrbbHsKDGNiDeaLEix79hioKHif0DsRRkK775XZrY7FkT3SI4L5UaFnfM
         OWbTK+QTHUScscyzZnNz3cqJtwC01dRG1EhoVVwXa8tfQ7M4rChk4wzgexflJ1tk43hs
         DELfHWXShOc+ZwyCYPJq8srdpM0a/rKBimZSErZVfIRsbMb/uHn4wtA8qX/pCAoj+uaE
         NXGA==
X-Gm-Message-State: AOAM530er/Mn3xDYHYgRzW70oo6B9MGojnowQVCva5tfhui5dUg/ccae
        b+lT2yJq0hwI/jCua0Yop8M=
X-Google-Smtp-Source: ABdhPJwWolRKrmT5Do1plHObMIKs81M84YmjT2qaELjqxjXDo7Tr3gWVDmkiHXMDIA+/aVCR8YuFYw==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr6699744wrt.255.1617830493687;
        Wed, 07 Apr 2021 14:21:33 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:33 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 7/7] arm64: dts: imx8mm: add power-domains
Date:   Wed,  7 Apr 2021 23:21:22 +0200
Message-Id: <20210407212122.626137-8-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for HSIO and USB power-domains.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index a27e02bee6b4..028b8930db5a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mm-clock.h>
+#include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -600,6 +601,38 @@ src: reset-controller@30390000 {
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mm-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_hsiomix: power-domain@IMX8MM_POWER_DOMAIN_HSIOMIX {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_HSIOMIX>;
+						clocks = <&clk IMX8MM_CLK_USB_BUS>;
+					};
+
+					pgc_usb_otg1: power-domain@IMX8MM_POWER_DOMAIN_USB_OTG1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_USB_OTG1>;
+						power-domains = <&pgc_hsiomix>;
+					};
+
+					pgc_usb_otg2: power-domain@IMX8MM_POWER_DOMAIN_USB_OTG2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_USB_OTG2>;
+						power-domains = <&pgc_hsiomix>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
@@ -953,6 +986,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_usb_otg1>;
 				status = "disabled";
 			};
 
@@ -972,6 +1006,7 @@ usbotg2: usb@32e50000 {
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop2>;
 				fsl,usbmisc = <&usbmisc2 0>;
+				power-domains = <&pgc_usb_otg2>;
 				status = "disabled";
 			};
 
-- 
2.25.1

