Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C1327332
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhB1Prl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhB1Pps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:48 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8FC061223
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so8300786plh.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8xuLB+PW3vzd/2H+nv/FYwlg2xPXL9X/0ZCidUY03A=;
        b=GTHfepeMME8ETHJ9D17UUQlIWYTFf4lYClQwCQIUOC1oKAGJgzR3euzonM0vWhJci7
         TSppLrKhyfNsWCsXIJqzg5FXr0v1J95UnRMiUrzOyX8byY+RtVKhUubnX9B9qNo442jJ
         Fnnv6pSzMiAS8udimqeZ651R7iVF1iwjSC0cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8xuLB+PW3vzd/2H+nv/FYwlg2xPXL9X/0ZCidUY03A=;
        b=arNhS+qH4PnVXI5aBxBAKtPj0+9AZypEdGno3tkTm/othXtNCDDh4IGC23g1o6ydR1
         HAiShrvjOGcwfgbBAIVusXQdsRx95W4TCtivr5+1CVD8b2oO3FJa2QTLbDX3F62rrnn6
         b8Rm5eh0YvFdmTGmLztgBWkjNVOTqLeeqlopxiYaLK+srJ3hNn9AbJQw3gmigbVFaQzn
         DEMVv1yAyZZFIt1unXchTDsWhkhJBjAbdLbtDy5W098ifRTsUmtizjmsftEemlgOXDAG
         ajElMSpQEqM6faNpOkbH8cBteNrTC79FbVK1lUEvfIHxFTANax1WyiDC3tgqNaQIhUEJ
         DbdA==
X-Gm-Message-State: AOAM530JLRK78UyEDAsEQJhJiR0wsx93O9i4F0vYqqNh2ue9TgMlUjCa
        2GxtV/m6COKS8DrsRtwVmR8KfQ==
X-Google-Smtp-Source: ABdhPJxfIBewbERSLjK/TGwJqJEMQTPLphwQZKKTzUvXvWHtlP24xZS8O3qwJbFmLnm3mZesUyhs+g==
X-Received: by 2002:a17:903:1cc:b029:de:98bb:d46d with SMTP id e12-20020a17090301ccb02900de98bbd46dmr11601415plh.54.1614527064698;
        Sun, 28 Feb 2021 07:44:24 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:44:24 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 10/10] ARM: dts: stm32: Add Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit
Date:   Sun, 28 Feb 2021 21:13:23 +0530
Message-Id: <20210228154323.76911-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board.

Genaral features:
- LCD 7" C.Touch
- microSD slot
- Ethernet 1Gb
- Wifi/BT
- 2x LVDS Full HD interfaces
- 3x USB 2.0
- 1x USB 3.0
- HDMI Out
- Mini PCIe
- MIPI CSI
- 2x CAN
- Audio Out

i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

i.Core STM32MP1 needs to mount on top of this Evaluation board for
creating complete i.Core STM32MP1 EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none 

 arch/arm/boot/dts/Makefile                    |  1 +
 .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6dc39bddaf7e..e86c46d7ca66 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1074,6 +1074,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp157a-microgea-stm32mp1-microdev2.0.dtb \
 	stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb \
 	stm32mp157a-icore-stm32mp1-ctouch2.dtb \
+	stm32mp157a-icore-stm32mp1-edimm2.2.dtb \
 	stm32mp157a-stinger96.dtb \
 	stm32mp157c-dhcom-pdk2.dtb \
 	stm32mp157c-dhcom-picoitx.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts
new file mode 100644
index 000000000000..ec9f1d1cd50f
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/dts-v1/;
+#include "stm32mp157.dtsi"
+#include "stm32mp157a-icore-stm32mp1.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxaa-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit";
+	compatible = "engicam,icore-stm32mp1-edimm2.2",
+		     "engicam,icore-stm32mp1", "st,stm32mp157";
+
+	aliases {
+		serial0 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	disable-wp;
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	st,neg-edge;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-1 = <&uart4_sleep_pins_a>;
+	pinctrl-2 = <&uart4_idle_pins_a>;
+	status = "okay";
+};
-- 
2.25.1

