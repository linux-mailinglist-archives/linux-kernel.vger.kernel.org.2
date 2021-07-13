Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9233C3C69F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhGMFz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhGMFzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:55:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82836C0613DD;
        Mon, 12 Jul 2021 22:53:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p17so9990744plf.12;
        Mon, 12 Jul 2021 22:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lmng85Px0u83llASk+gk5rLgTOQ6j6LNMSKSt4jMIeI=;
        b=HM9+khwIbE9awn14IA/b6gDroV2+LORNN7AdsQSFBtmzJ22vchCVTor7Jw2ieUqR9Z
         HXFmq/Rq5fMRiGYFCf4pRBfU6GnzpboUCVozgRPqug0OJBYenXciDngP48dxjYL05+RF
         ZAXdtqxbz+Ur2j0VmB5sU1MXhOWgL7cyF9fg6VB8EQIuA5Cz7thVWLDs4nKYzLANITrI
         jcR7MrbGlMEy+jGCCMCcWgTKF9Q5euNBpoupzwd8Vcf82NyIg6L1ICWaM02+QX4FrkyF
         ij5SUNIQU5gYrFNOjGWveoYWsp8lBtUH0iUwBGs4Ek0Xkm8ChFM5y4+jQF3s6PhEhCYZ
         RDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lmng85Px0u83llASk+gk5rLgTOQ6j6LNMSKSt4jMIeI=;
        b=azRhBJQngoVhHbIDhZacr0Ga284AqZzJ7LZFXQmxv/H6uTgSSHIR1WWQF4Xz4QaQgv
         eT/wOm+/nU7S3C6MLH7uidUCZEaNg4cI4tdZfuMvClOExFPlVu8zVIJQ/W282y9LSPEy
         zHZa4vFJjNQBNPixe+EnxTU1RoCrei01M4Qo5MrMDV+rKckhswd6prO98mS4Afj8gxbq
         G6LJl9OBApqz1xB/DHtpQsD8ttd9L3SGZDi12s9X/S6xk5ZT9kPzV3Ygb+QcvnLhgbQP
         TxKuSwE/tWWwrXzyaVdXc9ChX2DwCpgAQxAIws2edJ0dR36Grs0HkGF8uWe9VKRS88uQ
         9qiA==
X-Gm-Message-State: AOAM530x42pocBitWvKbvO4pjd2Y+P9GhtMIj0CJ6JOmUmzBphTPL+Hs
        71IkhqCrg/LWVJCTOInjKf2Y3uM8HOI=
X-Google-Smtp-Source: ABdhPJwTq9nwszpBMHHsyvcPH3Z+S8RDoz5Pl7U1c/xalzChkAACyz7SaZKkAeJe60mg+uGUG5V/uQ==
X-Received: by 2002:a17:90a:cd01:: with SMTP id d1mr17784189pju.106.1626155583078;
        Mon, 12 Jul 2021 22:53:03 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id x19sm17755198pfa.104.2021.07.12.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 22:53:02 -0700 (PDT)
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
        devicetree@vger.kernel.org
Subject: [PATCHv1 1/3] ARM: dts: meson8b: odroidc1: Add usb phy power node
Date:   Tue, 13 Jul 2021 05:52:13 +0000
Message-Id: <20210713055227.1142-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713055227.1142-1-linux.amoon@gmail.com>
References: <20210713055227.1142-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing usb phy power node for phy mode fix below warning.

[    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
[    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
		in node /soc/cbus@c1100000/phy@8820 failed

Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host
		controller on Odroid-C1/C1+ board)

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
previous version
[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20190113181808.5768-1-linux.amoon@gmail.com

changes fix the vbus-suppy to phy-supply, drop enable usb0

# sudo cat /sys/kernel/debug/regulator/regulator_summary
    USB_PWR                       2    1      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c1108820.phy.0-phy     2                                 0mA     0mV     0mV
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index c440ef94e082..ced1ec1c4878 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -32,6 +32,25 @@ emmc_pwrseq: emmc-pwrseq {
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
+		 * signal name from schematics: USB_POWER
+		 */
+		vin-supply = <&p5v0>;
+
+		/*
+		 * signal name from schematics: PWREN
+		 */
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		blue {
@@ -378,6 +397,7 @@ &uart_AO {
 
 &usb1_phy {
 	status = "okay";
+	phy-supply = <&usb_pwr_en>;
 };
 
 &usb1 {
-- 
2.32.0

