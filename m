Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93D3AAA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFQEwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhFQEwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:52:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130EC06175F;
        Wed, 16 Jun 2021 21:50:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4181155wmc.1;
        Wed, 16 Jun 2021 21:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASVo2MLoqVP1mLF6Nd3xdMslTrtZKM7Mb5C6XqAN9Os=;
        b=FHM8WTkrJ5sOVzzApmHO1kODYwLZheKZiN+Dv7007BCbcYQYVmxGSFAy+1wHvpZT8N
         p/bJu+/TqfBIGRtpgsEPdqKOvltEjWjCmENWI3Uao9PnBs2UY/qhPgW0NLrFMQ3rCa93
         I8Kia0V5WTLKTH4kUUQX7L/uQx7Zeh0q0wsp373RsupINBdP3zJ9DwflL7wG7NCoA7GI
         TMtSErfAzbe3QZ5wet/jwyYhcm3KWSHYeifs/qVr9EXW9uaVhY1BgRsRAw+ikR7PIgoi
         IoKltUU6dO0Ux/0r3fOj4ZeLfCD014ipoARQVFGvY8vRFyk1ZbCBmtV/l5VeU7x+xmKd
         VhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASVo2MLoqVP1mLF6Nd3xdMslTrtZKM7Mb5C6XqAN9Os=;
        b=Nqc4jC8Be43Vb0W6IpdGZL8VVPWwpF7rI6FibsSog8VZzPD2FpSniibDsasY7t8z+i
         KRo/ckG/7Y66vUREl1qz4JYrOKALEMR7jqzgazk6Vi4xSZZZI36wUkBvScmBoOPtft14
         jnm1G/5PMrGVCB+sCkbQPVdA69mYkbtWomM9TD5xxcLkbtcusNu1tfJ2Xfo2YXC+ZtGO
         /47ECSD0bA29ST1DZe52VLRubr5Fnfl9W7U04Yy+GYJeLFsEZMIbKVvW1rl9aoAsLvCH
         Z4HQ3a+PenVp/IgrUVJOUNJA18umHv1xmBkePd6Oz9AE+jTaMZn5PWqd7dov7rslRqmr
         gcjQ==
X-Gm-Message-State: AOAM531GA6waQI+1sL4nwCmAneTHQBVWwqqtTzK0613EaTnnb+byybDq
        K+kWOLXhhIESLiJ2zYRu1w==
X-Google-Smtp-Source: ABdhPJykCMd2j7kccm6Lk69DK/jMdpK2aAoJdzlwIytRotmEuFmHTkvf2l6vWkoFn0SfSipgLCeULw==
X-Received: by 2002:a05:600c:3ba2:: with SMTP id n34mr2705531wms.120.1623905402247;
        Wed, 16 Jun 2021 21:50:02 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id n13sm4587460wrg.75.2021.06.16.21.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:50:01 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add RK3399 Rock Pi 4b plus board
Date:   Thu, 17 Jun 2021 06:49:55 +0200
Message-Id: <20210617044955.598994-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617044955.598994-1-knaerzche@gmail.com>
References: <20210617044955.598994-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi 4b plus board is the successor of Rock Pi 4b board.

Differences to the original version are
- has RK3399 OP1 SoC revision
- has eMMC (16 or 32 GB) soldered on board (no changes required,
  since it is enabled in rk3399-rock-pi-4.dtsi)
- dev boards have SPI flash soldered, but as per manufacturer response,
  this won't be the case for mass production boards

I didn't add yet another compatible, since the small set of differences
are captured by the device tree.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3399-rock-pi-4b-plus.dts   | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index dbd7d37950f1..e867e5889d44 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
new file mode 100644
index 000000000000..ea68b8c9d9ba
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-op1-opp.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi 4B plus";
+	compatible = "radxa,rockpi4b", "radxa,rockpi4", "rockchip,rk3399";
+
+	aliases {
+		mmc2 = &sdio0;
+	};
+};
+
+&sdio0 {
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+	};
+};
-- 
2.27.0

