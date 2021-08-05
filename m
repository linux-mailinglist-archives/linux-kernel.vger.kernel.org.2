Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA743E1EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbhHEW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbhHEW2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:28:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE67C0617A0;
        Thu,  5 Aug 2021 15:28:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mt6so12488029pjb.1;
        Thu, 05 Aug 2021 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lw6gEfo2Nw0mBe3S5xni2/OM/VRr81Ls+EqynsWDkMc=;
        b=aOcpCuuQ0oZecIVFgmbyx/nUvanBWvhzq2rfR/nVSM0vyTA3cNp7Z8RlCAWGJ7c9zg
         xuZ371oGoGa3EfR8yul5t/RSNzV9G11LIBo4G7oR892flIJExRxaU4rJRbrcFXgDMmdm
         KmgJv2gfQ+P8AURFIwp+ZphhLAwFhf/HbISR2u8yUAkNkHnDxQLqO5wgkCNOyQFe8do5
         5aUfD1+gaCN7gveWCB16RT+f/Oiu+xknX5OlyIX7vcgE5O9Gknr6gMih+FHiVOfNQ931
         dSsAmE8PHrWH6TXla+tkxw7+OSyZ6noX3ogHoBRG33VJIfi2jkQwpgZgXg35N8bhBIsO
         7Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lw6gEfo2Nw0mBe3S5xni2/OM/VRr81Ls+EqynsWDkMc=;
        b=ONroWSAsBJR2GdB6q6Fyn9e8sYQHH+PsVzO3lkxHVuvW3UsQxpozBBUVSGEC5v8798
         HbtBLenkX2Pkt3Csq8d21mCRr54dPdEXRzAaSOo2Y+O6D6hvhRaobFlDumpf4+frClAk
         RbV721NdvP+vU9YxLGIQI6ygZ3SQmb7bNK3f6NBHIpjEhypfhbwasu/uu5rKCunnlhEt
         E1scyQLUwVIuJXi4SXsZLNOjuF8V/jtGAkdA8sfU6HKlmP6n5A++PDcH49UDj5TfSR1x
         rgXXlTJ57x+D8KFPr2WvgpMD7cFHsB0hSbIxSBnZQFxnRbCMy9ntFRiFtHmKfF8wFpq7
         qBAQ==
X-Gm-Message-State: AOAM533SwkhAHJRxpBCT/C+Vs73vKQCDv0hd92tBqHvjvJV1AxDquHFb
        VAMnCGxOMNwUbRbL2Bdrw08=
X-Google-Smtp-Source: ABdhPJzOXA2xJb3hzf499cQvBTj3sFISjd2xApvkTjWJm88fkqrqkVChquuhHW4AnYTQa+r8MGVViA==
X-Received: by 2002:a62:36c5:0:b029:32b:83fa:3a3e with SMTP id d188-20020a6236c50000b029032b83fa3a3emr1603833pfa.52.1628202512620;
        Thu, 05 Aug 2021 15:28:32 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b26sm8082292pfo.47.2021.08.05.15.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:28:32 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 3/6] ARM: dts: aspeed: Common dtsi for Facebook AST2600 Network BMCs
Date:   Thu,  5 Aug 2021 15:28:15 -0700
Message-Id: <20210805222818.8391-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805222818.8391-1-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This common descirption is included by all Facebook AST2600 Network BMC
platforms to minimize duplicated device entries across Facebook Network
BMC device trees.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - "mac3" is removed from the dtsi (moved to platform dts files).

 .../dts/ast2600-facebook-netbmc-common.dtsi   | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi

diff --git a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
new file mode 100644
index 000000000000..051de5bec345
--- /dev/null
+++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
@@ -0,0 +1,169 @@
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

