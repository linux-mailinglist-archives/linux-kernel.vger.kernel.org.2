Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904663D999A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhG1Xi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhG1XiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:38:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696DC061757;
        Wed, 28 Jul 2021 16:38:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so6642206pjd.0;
        Wed, 28 Jul 2021 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ETDYI5aHUgNJ2eLOQXZCBAH75JlK7MVAdtoFHhJjoM=;
        b=b/ncV0g/VGQkAQblMXRu2wF+lOapWyRaOGZfWesgh5mjUJJ/0W2W5mwo7RtYHMSjmy
         GYOdL1XDE+ZQCXxYSWlII+soXyH7Ax4RxIemDPQkce3xQVRPYLXH5l/11UgW8usLthk7
         TnpxMlREH9JcECqREViS0j0E52dQhhAxGmqC3GGDcPfSlAAFwNs8pzS2NXi4iRYER4JT
         yJ6/QTh09lxzqBiFNGr+jto1DwMYux3/xDvJxP5Zk7Vh6sEpk7isOd3PtUONvWkivkga
         J+eA94+mhyYN21mYwI0VtuKwOH7dJj9rV68l5wolPBbPO8pQIbftr2QYtURrBWFe2tfC
         aUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ETDYI5aHUgNJ2eLOQXZCBAH75JlK7MVAdtoFHhJjoM=;
        b=dTDFMVJWd7On7lxjcEi0YJ6Ryz4E+DfatMmwL2kt778UA/MYeVk44exzZ9l9ktMT/a
         jzaym2OLN2Xc2FtVHueFQYLLeLWbZ3pqHcCzZJIgqdTwm2vSVSCS9zqWI0l2BXPYlD8y
         Ncl6K3uSLshRemRGHeJiBge/QzQtEJ7pHcRzAKjBz6rRp4zZwYBOqJGjZUFk2vzDlYh3
         G0OrP3a8c1435VcVALIENDW/M3f9X8NUFc6fv61J1ljp84bKFSqC2MbD57gmbh08ocTz
         MeCf3Aj48Jxm2lKin0+pSdA1PGW3v6m67jm4R/CowC9uB5sM+pnZI6gK53KuPS6jdVxq
         YydQ==
X-Gm-Message-State: AOAM533ysMZTKB2egheagAi3wGGBchN10E0+M5w+ibd89oDR3+YyiPui
        RPjfSrZWlg6IiFigK5th3f8=
X-Google-Smtp-Source: ABdhPJw03dLTz832OaFzA+9LsFftD1vUOzPJmzKQumy4x0kKUdSlQeavafXKqffBR+YNxc2OiZ69Rg==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr2220628pja.175.1627515492388;
        Wed, 28 Jul 2021 16:38:12 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id k37sm1038671pgm.84.2021.07.28.16.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:38:12 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 5/6] ARM: dts: aspeed: Add Facebook Elbert (AST2600) BMC
Date:   Wed, 28 Jul 2021 16:37:54 -0700
Message-Id: <20210728233755.17963-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210728233755.17963-1-rentao.bupt@gmail.com>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add initial version of device tree for Facebook Elbert (AST2600) BMC.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-facebook-elbert.dts   | 185 ++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 74c760038f28..7cbb982a7c8b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1411,6 +1411,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-facebook-cloudripper.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
+	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
new file mode 100644
index 000000000000..27b43fe099f1
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+/dts-v1/;
+
+#include "ast2600-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Elbert BMC";
+	compatible = "facebook,elbert-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart5;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+
+		/*
+		 * 8 child channels of PCA9548 2-0075.
+		 */
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+
+		/*
+		 * 8 child channels of PCA9548 5-0075.
+		 */
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	spi_gpio: spi-gpio {
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+	};
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&i2c2 {
+	i2c-switch@75 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux20: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux21: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux22: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux23: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c5 {
+	i2c-switch@75 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c-mux-idle-disconnect;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux28: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux29: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux30: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux31: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c11 {
+	status = "okay";
+};
-- 
2.17.1

