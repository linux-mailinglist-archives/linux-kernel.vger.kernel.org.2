Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD83EE56F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhHQESJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbhHQESG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:18:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86DC061764;
        Mon, 16 Aug 2021 21:17:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so2778743pjn.4;
        Mon, 16 Aug 2021 21:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFbf5MZvdHne2nfZzSqkqs09pAcRMOYPxHTfv7PVwSk=;
        b=gIdDzzrbItxf9RBdIOJGtF1f1VKiW5B81efUiKJIM5vqEKjS7oaj8l2DsTlGL6NhFS
         pN/dDl8WnWH/0KBbCXmvvTm2SddGx/fi9o4bYMqTNuBg9Ok76Q6NlhRXy+SeVZZjWyYj
         ljxtinJfGm1kAVJfWKWy7PsHuLQNAwKxD6ao0wignJAajpAehmE6Yzb0CdrjH75Bd6GS
         D6UQhDQ2Dz+/zTz1ANlr8RcyT9oA4J2vRwP7MEeGOGiA1go4rEy2kpcCJXjzdh1A/Qwt
         +dc+xZVLYZ40/Y1RAreCe+c2Yr/kMk2vQoql/JX3TYrqGDzpO9Dv/YWUWb7+mTBsaJ3b
         12rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFbf5MZvdHne2nfZzSqkqs09pAcRMOYPxHTfv7PVwSk=;
        b=Q6Z/To4tsARXjaUxmsIqDJJaRPzUqK/KgyNgOzOidfPv4rbDhvc85BiYkUg3JlW4gK
         K0cqZ9EB9893e8vdyGq1MxVC0B8naVCy7cIMu6tKx7LokJlmrhS16U8oh0u8RKYrvYzi
         K4qqsldlNd7QVum58QqR51ccg01a/fQBjA3Nek2YwLmSlrcUBXo/MjPIK1NYJhPpcAtT
         keX13DKMN/bxzmHy2fu9YDfWFHFtBsFu83Hr4Iykc8Pmlj/lOABfAdpOkO/GUlQSeeSH
         trhXEGCiq8xtns5MFbIFbsxW4exdsEYvsZjqV+aWk46SC/i4SbwzN4PzysKAZuU2qrYQ
         Ll9Q==
X-Gm-Message-State: AOAM532mzLEXIF4KcXShmIJQIMybYg4EFKxjg+aVLptAhUtncJBqvlDV
        TJLOM0Hz2KGJlzRcMNvJ+n8=
X-Google-Smtp-Source: ABdhPJwUmgJHOYZGmqb7CZ/IPnyklBdcoU5GSH6oVqioOWLbpzvI57uFAQR+YepvUxw6cA9JFgqcEA==
X-Received: by 2002:a17:90a:9308:: with SMTP id p8mr1457358pjo.119.1629173853769;
        Mon, 16 Aug 2021 21:17:33 -0700 (PDT)
Received: from archl-on1.. ([103.51.72.143])
        by smtp.gmail.com with ESMTPSA id g11sm705676pfo.166.2021.08.16.21.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 21:17:33 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Subject: [PATCHv3 1/6] ARM: dts: meson8b: odroidc1: Add usb phy power node
Date:   Tue, 17 Aug 2021 09:45:35 +0530
Message-Id: <20210817041548.1276-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817041548.1276-1-linux.amoon@gmail.com>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing usb phy power node for usb node fix below warning.
P5V0 regulator supply input voltage range to USB host controller.
As described in the C1+ schematics, GPIO GPIOAO_5 is used to
enable input power to USB ports, set it to Active Low.

[    1.260772] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
[    1.260784] dwc2 c90c0000.usb: Looking up vbus-supply property in
		mode /soc/usb@c90c0000 failed

Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host
		controller on Odroid-C1/C1+ board)

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2 > changes gpio polarity ACTIVE_HIGH to ACTIVE_LOW.
     Fix the source power from phy-supply to vbus-supply.

[1] https://lore.kernel.org/linux-devicetree/20210716103651.1455-2-linux.amoon@gmail.com/

V1 > Fix the Input GPIO polarity from HIGH to LOW.

previous version
[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20190113181808.5768-1-linux.amoon@gmail.com

changes fix the vbus-suppy to phy-supply, drop enable usb0

    USB_PWR                       2    1      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c1108820.phy.0-phy     2                                 0mA     0mV     0mV
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index c440ef94e082..30ec6a7f20c7 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -32,6 +32,23 @@ emmc_pwrseq: emmc-pwrseq {
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
 
+	usb_pwr_en: regulator-usb-pwr-en {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_OTG_PWR";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		/*
+		 * signal name from schematics: USB_POWER - P5V0
+		 */
+		vin-supply = <&p5v0>;
+		/*
+		 * signal name from schematics: PWREN - GPIOAO.BIT5
+		 */
+		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		blue {
@@ -119,7 +136,6 @@ vcc_3v3: regulator-vcc-3v3 {
 		regulator-name = "VCC3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-
 		vin-supply = <&p5v0>;
 	};
 
@@ -382,4 +398,5 @@ &usb1_phy {
 
 &usb1 {
 	status = "okay";
+	vbus-supply = <&usb_pwr_en>;
 };
-- 
2.32.0

