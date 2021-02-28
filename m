Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1445C327331
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhB1PrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhB1Pp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:28 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DCDC06121F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:16 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w18so9759617pfu.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CHgLBLNwp00CSu9enbMWXNQFa3eNCIxJJuhtUOjDOI=;
        b=YUOHoexZFQPkQ6f1gln7dc5ro9qAby/6xYD4bNG4C8jyp25VYzcu4LrCGaBtnfJ9r0
         cHUrdxllB5qj6d7U7CfBuSq1LYuLn7DAyMbsxeo7/tw5Vw+sW9qir4ffsxEyzAyNyv8y
         +glBtazGgh8+7sM21spB90FQO0XY3aFzpiwbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CHgLBLNwp00CSu9enbMWXNQFa3eNCIxJJuhtUOjDOI=;
        b=ci97E2WAr3SVXiagCOfDvdrks3tH5O3ZWq/Hn8DR9lnywkWkcVTa15htQZ0tEkXcS7
         P+rqJk4HyKk0eSdZLnB0KJ4Bq5iZLsqj0fIg/SEiI4YCMMAuoLP9UcuQ0hTpVsUc/VM7
         PKQrmktPxT8xtYqeMBf3wFpJLMBnMZzhSnRiS+DnArC4QMkGNtYwUe/8phNsfTqyoNQy
         EkFsbYWO4XBpvibx/kvla69aRg3MzmKKchTUBIdY/RaT/A821bW/J84YSR0i5aO6Uzqv
         GyZu5/naSOVPrJUBhveioAljcyLZ8UyNcF3SMO8sWNdXisxH7ca/81+oHlPJlQM24NRl
         mp3w==
X-Gm-Message-State: AOAM5311n9azbvT8dlkIFND7GP5KRYrZrX2FuvRBQIZkY26+jMI73qOf
        cLrnZ80aTLZYsIWAIrmybIMGPA==
X-Google-Smtp-Source: ABdhPJxvlNdVMJIi54zN47bhPrOsU6Tlnj5RwiY8EFZ379RR9BGWTMD9YVzJxveb1qusNF2mKVL0+w==
X-Received: by 2002:a62:7e0c:0:b029:1ed:a474:3367 with SMTP id z12-20020a627e0c0000b02901eda4743367mr11708590pfc.10.1614527056216;
        Sun, 28 Feb 2021 07:44:16 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:44:15 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 08/10] ARM: dts: stm32: Add Engicam i.Core STM32MP1 C.TOUCH 2.0
Date:   Sun, 28 Feb 2021 21:13:21 +0530
Message-Id: <20210228154323.76911-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
board.

Genaral features:
- Ethernet 10/100
- Wifi/BT
- USB Type A/OTG
- Audio Out
- CAN
- LVDS panel connector

i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

i.Core STM32MP1 needs to mount on top of this Carrier board for
creating complete i.Core STM32MP1 C.TOUCH 2.0 board.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none 

 arch/arm/boot/dts/Makefile                    |  1 +
 .../stm32mp157a-icore-stm32mp1-ctouch2.dts    | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1332622a3f9f..6dc39bddaf7e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1073,6 +1073,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp157a-iot-box.dtb \
 	stm32mp157a-microgea-stm32mp1-microdev2.0.dtb \
 	stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb \
+	stm32mp157a-icore-stm32mp1-ctouch2.dtb \
 	stm32mp157a-stinger96.dtb \
 	stm32mp157c-dhcom-pdk2.dtb \
 	stm32mp157c-dhcom-picoitx.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts
new file mode 100644
index 000000000000..d3058a036c74
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts
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
+	model = "Engicam i.Core STM32MP1 C.TOUCH 2.0";
+	compatible = "engicam,icore-stm32mp1-ctouch2",
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

