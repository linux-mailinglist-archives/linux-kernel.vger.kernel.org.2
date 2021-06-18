Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16F3AD1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhFRSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbhFRSPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:15:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0029AC06175F;
        Fri, 18 Jun 2021 11:13:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n7so11709833wri.3;
        Fri, 18 Jun 2021 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kn98Ll5NtpVpipbgUQvn4hSMRQNojtQUAei8tOm3g58=;
        b=NIX0oLDftDi6biHsi+LL0gntF8jwaNG+amkxSzoGyPBQI7xlAmcR3NfrZ54USdFQP4
         q1QegsItPIubfkqLRpRe+0HpO9mszszJ9Br7N+0RkFmDUCcgKnGiRMrq/QfCHZlMIAzj
         AAWcjADKNmqy6kcwwvqI2Km/yTMcdaRIkrxiBw+VwKZe9Sf7Q7D87H7ddAr195ElfWQH
         k3OgTjecka+toNHRxZXYD5NQ+re7SluV3OXE6xGbKKRkktxz8qRoaYIXLVXMxAYYcpcd
         +LrCFT8+nLsvOdnXT3gSrACevK8+AbHb13URNoQaCmz8sf0VHBeR6gnUPWS0YiY36qmH
         8qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kn98Ll5NtpVpipbgUQvn4hSMRQNojtQUAei8tOm3g58=;
        b=lkUOnerx+0uCVjhF4p5GxIRkjxS9gfg95H51yDqu1jFOYNjNBYqp8Jk+nIr63gB1qF
         WfyPekjij3PRvTbA9VLUE3i7sH1Sho1qXo+JX8+iAi5bTzYLrrihkT6igWjCWkgkZJcw
         lnTVk34dEnhA15qGBvEtFH9okHObPiR3vVGk3gJ0NH3QKUZKgL4HL1m8fsY7ZVUTR1Tj
         pMqqKqUtT+Dc7MJiEb4KmVpkirW+WaJkChGXrNwcP+NozlUEV8aeQpaxrYrZ3G8ZTMbJ
         fwnxIkfB/RYl0PFiG5IALuvhda8elAo0jrgvEYrKFlYRasUxUcM/ilv4ftilIuKfjSUl
         2xUA==
X-Gm-Message-State: AOAM531AphLPKyDortO3bKLRYYmCoAYDrC+0nkX8Ukp23S89ZMW1VLqo
        Ze8YUsaaotYuePJeCbPHGw==
X-Google-Smtp-Source: ABdhPJz8Y2F3LWyjxmZDk8cpgSz9/LhbtqqL7qNCHFkVV4MLCnbXc5uPbiQj0rJ2h/sY6FuHztbgYA==
X-Received: by 2002:adf:e502:: with SMTP id j2mr7001313wrm.275.1624040001599;
        Fri, 18 Jun 2021 11:13:21 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id l10sm9306782wrv.82.2021.06.18.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:13:21 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/5] arm64: dts: rockchip: Add RK3399 ROCK Pi 4B+ board
Date:   Fri, 18 Jun 2021 20:12:54 +0200
Message-Id: <20210618181256.27992-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210618181256.27992-1-knaerzche@gmail.com>
References: <20210618181256.27992-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROCK Pi 4B+ board is the successor of ROCK Pi 4B board.

Differences to the original version are
- has RK3399 OP1 SoC revision
- has eMMC (16 or 32 GB) soldered on board (no changes required,
  since it is enabled in rk3399-rock-pi-4.dtsi)
- dev boards have SPI flash soldered, but as per manufacturer response,
  this won't be the case for mass production boards

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
index 000000000000..dfad13d2ab24
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
+	model = "Radxa ROCK Pi 4B+";
+	compatible = "radxa,rockpi4b-plus", "radxa,rockpi4", "rockchip,rk3399";
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

