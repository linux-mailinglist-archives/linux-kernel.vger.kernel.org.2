Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6353D9994
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhG1XiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhG1XiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:38:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02AC061765;
        Wed, 28 Jul 2021 16:38:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ca5so7506225pjb.5;
        Wed, 28 Jul 2021 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/QVxjPMi8AJixP6Wwbg2ZVyBcu5V0oH60YocJQkA94=;
        b=FGyNKWO+gmtAa+GX93N920LrFv4PFfQyR0kGQPFK/tjs52W9xJ0w9l7IVZE5p8zzQq
         YXFCXNNsQm+ulwJKtmt/JCmhpObyr1Zk+u2Apx9mbDA/bMFC81Bu0v8AzEM2CfOkHD02
         fxv0Yrxqbct2d2iNsVlnvwJ2YJo0t3DGcbZPjtL2AZogDdMcbeud62+9wpDnx3qUqQZ7
         aHg7m7cMFiO6C28loHXBELT3wYQ/VamsHNtEntFV+EEvtsqPiClVjsZsJiZNwsfmNDZ+
         efVnZUetVsQ6xbiQBA3/zVqPRnJwBBwBD2mAEaPoMxybnj9iyqbn884rs4El+c3UVkdQ
         43lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/QVxjPMi8AJixP6Wwbg2ZVyBcu5V0oH60YocJQkA94=;
        b=KxdwDnEHoVdGRh3H8Z5dP6rArJCTAokgeFu1470ZYXATnltYV35cjUDCRDD9smMgAh
         AyY/W2d6UpprScA4EpumBcnH4fCr98OkZoaXWQGE5quH02iMNEOAdCCP1bLkbsDGwTeG
         VmoIkbGunual+XLaE/TJFgJDTVWAgvIRELP5a8hAv5SjbmWg+J3xbyjBfuR5hwcKcpr7
         4F3OC/zYNJDu1u+2NxVs2Xtamz+bBcQv8NCxWGwyVZQvLJwdaMvJcYvyX5FMSdDkxd4h
         MrIneXqu6rEXzfeLIPZCc0ftYNi+rdiTDClZQX8UpQwA4t7nNFOKxH30QbLYK2xiFjbi
         HWyQ==
X-Gm-Message-State: AOAM530ajG5kRbxQOo5HFT2X4ipf5E+f/BIB1d8gL63HIfR8vMuE1QWJ
        2p29ManGYpTlc2gkfB0iAkc=
X-Google-Smtp-Source: ABdhPJzgfJG8APAFvYd4OfauLS5m1ao6DwofZ+aPBVt3rdeE7e57tfWLWmNJKJU/uofDmoUxTS+LWQ==
X-Received: by 2002:a17:902:9688:b029:129:183a:2a61 with SMTP id n8-20020a1709029688b0290129183a2a61mr1988887plp.27.1627515489589;
        Wed, 28 Jul 2021 16:38:09 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id k37sm1038671pgm.84.2021.07.28.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:38:09 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 3/6] ARM: dts: aspeed: Common dtsi for Facebook AST2600 Network BMCs
Date:   Wed, 28 Jul 2021 16:37:52 -0700
Message-Id: <20210728233755.17963-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210728233755.17963-1-rentao.bupt@gmail.com>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This common descirption is included by all Facebook AST2600 Network BMC
platforms to minimize duplicated device entries across Facebook Network
BMC device trees.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/ast2600-facebook-netbmc-common.dtsi   | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi

diff --git a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
new file mode 100644
index 000000000000..e3b350c824d2
--- /dev/null
+++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	aliases {
+		mmc0 = &emmc;
+		spi1 = &spi1;
+		spi2 = &spi_gpio;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw vmalloc=640M";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	/*
+	 * GPIO-based SPI Master is required to access SPI TPM, because
+	 * full-duplex SPI transactions are not supported by ASPEED SPI
+	 * Controllers.
+	 */
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.0";
+
+#include "facebook-bmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.1";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash1@0 {
+				reg = <0x0 0x8000000>;
+				label = "flash1";
+			};
+		};
+	};
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
+
+&rtc {
+	status = "okay";
+};
-- 
2.17.1

