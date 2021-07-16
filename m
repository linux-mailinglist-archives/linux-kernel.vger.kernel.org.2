Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8CA3CB62B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhGPKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbhGPKki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:40:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79AC06175F;
        Fri, 16 Jul 2021 03:37:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b2so555800plx.1;
        Fri, 16 Jul 2021 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOqh4iRv8bzMC1v4LkBjVvsD8Lkl7UjXzwLeX3pJkx8=;
        b=S+HZDh+6imXk19NG3CPuTcEbgILrztpxAmUk0TtpzjM7XS0iHTzqBM1cQOM86udfnW
         YeMeFqO9KZmtln4zin0hp9YkejLcs0SxhITpg4a3lIu6To685WU/rrTvBIim4KfQCkFR
         GUVr3WzXiAHTjcGdTAKs9yc4eQsKZXme4S2zeaz7xqfsY0uxtS38PhMRHqZIwscoNYvI
         ULNGGcNtKRcdm8tONmPoXIsduyt8h8z5mrX3HpT4LPtWKpmXSoQFTUKZqYQuw2E1GKjf
         ZHXqcGycinnFF+I/xUJfzpZwkXkxRJZlGZWsT9R2ba69iBc5vsNrsN2pJkn/AC5Lb6Qv
         h0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOqh4iRv8bzMC1v4LkBjVvsD8Lkl7UjXzwLeX3pJkx8=;
        b=bFg4f3GAjT7zEgpgYghxXw7u6McWvJeWNgz5CZPwfaTk5Eb5L47j+PX6OOz583oeGM
         eIE/0oZM7Koxo4+7fkeCmzH7We4wCo4eCUWosYIVllBptWp0BNn5IB/MqQHIavtSBSFX
         OkK1IRChu6jv7ZqRUs3rpmCct/pU86BvTi6YdfpYUm2JVvHzh65KLQVGqdI4shyXeTwm
         C75J2aU/dQiLt7ElhfEFtJZyug02lRm4Gq5aPtv3qz+sFFecZATW482u92+x+ZRnMBb/
         Kftf1JEQptitndxDSFapiFe//ObqAPrNYJjX2zBUN/1oN5gg3LfUC6jWjHN7KbWcCrm0
         pAVg==
X-Gm-Message-State: AOAM530r/Xbi4Embz8eYTcxadEqSUtB0smpOXa0vtv5cMPz0Qxjl79rg
        j6ij5VV8YnQmtNndqtfgqiE=
X-Google-Smtp-Source: ABdhPJzH+ZY1CMrp9Is4HwQkAVX+28YqBZJDdwXI/77fszRGkHSp3wSrVmA55QJTPYuYukJ2ugUzUA==
X-Received: by 2002:a17:90a:658c:: with SMTP id k12mr14765303pjj.167.1626431863792;
        Fri, 16 Jul 2021 03:37:43 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id d29sm10070111pfq.193.2021.07.16.03.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:37:43 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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
        Brian Kim <brian.kim@hardkernel.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 1/4] ARM: dts: meson8b: odroidc1: Add usb phy power node
Date:   Fri, 16 Jul 2021 10:36:33 +0000
Message-Id: <20210716103651.1455-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716103651.1455-1-linux.amoon@gmail.com>
References: <20210716103651.1455-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing usb phy power node for phy mode fix below warning.
P5V0 regulator suppy input voltage range to USB host controller.
As descriped in the C1+ schematics, GPIO GPIOAO_5 is used to
enable input power to USB ports, set it to Active Low.

[    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
[    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
		in node /soc/cbus@c1100000/phy@8820 failed

Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host
		controller on Odroid-C1/C1+ board)

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V1 > Fix the Input GPIO polarity from HIGH to LOW.

previous version
[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20190113181808.5768-1-linux.amoon@gmail.com

changes fix the vbus-suppy to phy-supply, drop enable usb0

    USB_PWR                       2    1      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c1108820.phy.0-phy     2                                 0mA     0mV     0mV
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index c440ef94e082..26e8f91e0950 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -32,6 +32,24 @@ emmc_pwrseq: emmc-pwrseq {
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
 
+	usb_pwr_en: regulator-usb-pwr-en {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_PWR";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		/*
+		 * signal name from schematics: USB_POWER - P5V0
+		 */
+		vin-supply = <&p5v0>;
+
+		/*
+		 * signal name from schematics: PWREN - GPIOAO.BIT5
+		 */
+		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		blue {
@@ -378,6 +396,7 @@ &uart_AO {
 
 &usb1_phy {
 	status = "okay";
+	phy-supply = <&usb_pwr_en>;
 };
 
 &usb1 {
-- 
2.32.0

