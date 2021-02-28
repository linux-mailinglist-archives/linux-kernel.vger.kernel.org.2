Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0A327327
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhB1PpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhB1PpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62226C061793
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u12so9610083pjr.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6WSIYsNrAru6Z+XvtGV79Wwrq0QV1p1Ln5wNYNQ8b0=;
        b=HZ3gg9DausHDeekPsWy3tHJ5h0Dw7ZrX+BBJbYdqLq+I3K1/LRCgaoyGV+13sZgfGL
         z0E5B0S3o1C5/CJDLhcvn9WQAjTzFs033y8NEhwyrQNj8UljI4nj2d0TX1gs775aQU5i
         X7XTjKTJmRH+6kJZgy1dvNOR8Rw/ObR1ESOLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6WSIYsNrAru6Z+XvtGV79Wwrq0QV1p1Ln5wNYNQ8b0=;
        b=IdJuGN8TzyeSfKmniHZnO7MYsvb6USURH99I/ekA9y+6KDfXxuhwiUwwIHhMz51D9P
         gNvqTv2RRjfaBIUrDl5Nigc8TURbZKElX3Y5vlDMd6LZGRXU1mvNON/HQs+J+C6fGFK7
         7/apby4r62wRcary/CD3UnrOME3/rGrvhyL8HIKyZsedmUT+xYGyOioGgrCeLjXWASjP
         dybzPe7TJYIXV0aKu6z3DFMYYbVlOHVZYeTfjvYpV13wRjKpFNl1n4e/OAmf6lOsbiZE
         p4xzwb1sEJVtjY6fkMqpFvrTjEBSSCroYJ9NjtCYrRYz14kPaymk+gPSjNEMZow4QNVb
         wqBA==
X-Gm-Message-State: AOAM5325HvKKoaYRkceNATiEb1x/rgEBqLcBNMHeG2L12+XTHRYuvmph
        TU5P/BcG/DtW4XTkq3pTOUI8yA==
X-Google-Smtp-Source: ABdhPJw7Z3Xn/Fxu82m92Dr0IamukR34Lgx1kWrxp1gL1fJeogQ9QncSBipTxC68/fvG34VW39NYCg==
X-Received: by 2002:a17:902:b410:b029:e3:284e:4e0b with SMTP id x16-20020a170902b410b02900e3284e4e0bmr11992151plr.33.1614527034961;
        Sun, 28 Feb 2021 07:43:54 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:43:54 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Francesco Utel <francesco.utel@engicam.com>,
        Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v3 03/10] ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 board
Date:   Sun, 28 Feb 2021 21:13:16 +0530
Message-Id: <20210228154323.76911-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroDev 2.0 is a general purpose miniature carrier board with CAN,
LTE and LVDS panel interfaces.

Genaral features:
- Ethernet 10/100
- USB Type A
- Audio Out
- microSD
- LVDS panel connector
- Wifi/BT (option)
- UMTS LTE with sim connector (option)

MicroGEA STM32MP1 is a STM32MP157A based Micro SoM.

MicroGEA STM32MP1 needs to mount on top of this MicroDev 2.0 board
for creating complete MicroGEA STM32MP1 MicroDev 2.0 Carrier board.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Francesco Utel <francesco.utel@engicam.com>
Signed-off-by: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- updated commit message
Changes for v2:
- don't create carrier board dtsi, add it in final dts.

 arch/arm/boot/dts/Makefile                    |  1 +
 ...32mp157a-microgea-stm32mp1-microdev2.0.dts | 55 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9f9f3e49132a..b4a9cd071f99 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1071,6 +1071,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp157a-dhcor-avenger96.dtb \
 	stm32mp157a-dk1.dtb \
 	stm32mp157a-iot-box.dtb \
+	stm32mp157a-microgea-stm32mp1-microdev2.0.dtb \
 	stm32mp157a-stinger96.dtb \
 	stm32mp157c-dhcom-pdk2.dtb \
 	stm32mp157c-dhcom-picoitx.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts
new file mode 100644
index 000000000000..7a75868164dc
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/dts-v1/;
+#include "stm32mp157.dtsi"
+#include "stm32mp157a-microgea-stm32mp1.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxaa-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Engicam MicroGEA STM32MP1 MicroDev 2.0 Carrier Board";
+	compatible = "engicam,microgea-stm32mp1-microdev2.0",
+		     "engicam,microgea-stm32mp1", "st,stm32mp157";
+
+	aliases {
+		serial0 = &uart4;
+		serial1 = &uart8;
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
+	vmmc-supply = <&vdd>;
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
+
+/* J31: RS323 */
+&uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart8_pins_a>;
+	status = "okay";
+};
-- 
2.25.1

