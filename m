Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522803E1EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbhHEW3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbhHEW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:28:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A2C0613D5;
        Thu,  5 Aug 2021 15:28:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so3890950pjy.0;
        Thu, 05 Aug 2021 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9LT5c4tP+6iUvbuWoRnR6t22aNd6IuBQug+MWgbe5s=;
        b=ZPCJEzMOhPSUqxp4L0TSYhFWztZWLhh35f2HJvZlLTzuLA8RFIXtk62x83QTspty6u
         SSBPjr4PoAY37sK41obXpmxb+sPKeaCW7MPfgxiz8iNABjZ33pUcG+8jl6IQHdk9wk7B
         0/ImVnPVFz/GCCO55U84bBMYokjvTxySHOYucN71B+i8EgBEcpuX+kTu7wiQraOJICS+
         viwn3V+71uE+gm1vTwxnh1tFFkPOi6l7Nyjl5eztVD+pp7vh1/fXErh2hsSE4BOR69KM
         bLCI/EFgWE8YZDafwXyekUjYSYj0XMoekkFYgjfetuby3VceVeCTllILIeFiGzRHliFg
         VX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9LT5c4tP+6iUvbuWoRnR6t22aNd6IuBQug+MWgbe5s=;
        b=H3SRmtTvb/vClI8d+DldbXrM21YGOMT0oCeK8JoVmf7E0lJSndYoOmXg4wjRoEDs+M
         DJR1latMl7szR90bzKYaVs/tO8J9aM4wh95VGiFHcrkjh4JzqkKKSuKMFxS+NIxINDit
         NrXAVS73yq1VKDYOEouQLLQzHc2KLjC7jTqD8CuwAjlQB+Eo/a19udjQDsIsM3ok3fbK
         63toc8iG94sU+bheESENIFCpNsz+da+Sz9JjiSbbZS+cgN9ufBe7g7AoOxomjoUrusQl
         4xKWNocaYoO4TDpd1z6ti77//g8UtUa45vS9eSLWVtUAOdDt8043EDjtf/Pb+8nQzQHC
         YRNg==
X-Gm-Message-State: AOAM533aVmWg9c/9jdcW1A/t3T6NsdFreEWW6qiowAfvX4AqICR4qPud
        vKW6z/zLmbUMihURo69h6Tw=
X-Google-Smtp-Source: ABdhPJwSY+vE1pIY8E/D9RMBmpll/OF+BznXsavGIkuc8bX33cwCLtR1l4eT0adYH0Q3BNYQC8vWLA==
X-Received: by 2002:aa7:8116:0:b029:346:8678:ce26 with SMTP id b22-20020aa781160000b02903468678ce26mr1572516pfi.15.1628202515238;
        Thu, 05 Aug 2021 15:28:35 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b26sm8082292pfo.47.2021.08.05.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:28:34 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 5/6] ARM: dts: aspeed: Add Facebook Elbert (AST2600) BMC
Date:   Thu,  5 Aug 2021 15:28:17 -0700
Message-Id: <20210805222818.8391-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805222818.8391-1-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add initial version of device tree for Facebook Elbert (AST2600) BMC.

Elbert is Facebook's next generation switch platform with an AST2600 BMC
integrated for health monitoring purpose.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - added more notes about the new platform in patch description.
  - "mac3" was disabled (because it was removed from Facebook AST2600
    NetBMC common dtsi). Will add "mac3" back when "fixed-link" is
    supported in the MAC driver.

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

