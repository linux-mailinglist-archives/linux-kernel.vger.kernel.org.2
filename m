Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6512325E02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBZHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhBZHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:04:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so4796525plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGbkBiQEwVmIlJYtQZ8Wl6euLdItu5AR/MYKYomvVSs=;
        b=FNecKmCRz71KCLcGdO7xiYUXzOVMID3c5VgtODowiEiJEfEloSHpCn7h3zbuHSCBKT
         7ZX6cg/R9s4FDDfJE53EBdDG1qppjtx8fLFkvte9+13TCyO+lzb8T93saeqPCDn1QKl/
         FW4MZW4zIl9Xxnb0zF9NRFigXG//CxiSqTmSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGbkBiQEwVmIlJYtQZ8Wl6euLdItu5AR/MYKYomvVSs=;
        b=dMYRCMN0+3T9OFjzg2GLXr7/ISyD1+ALi7qzgg5oUM7mJJ7WowD/acOb5YJpJfBYNL
         S0b4Lns7sopcM0hRpbTHCAUaciz6SKJJ4GofELqgDp+LoF3hdKMQbKNGSwj+OC/8f+mc
         4JqTJV+LHv6ttx12c4fokUy2N/Kka9Mlo6kFKpouT98I74m1vqnw1AuspGC4qrG9tGNk
         Cp1HnKSqszRyvfJNmKbpAahNYjni7aHjIh14HYEvkqifxFrZQw9g2wF1RIXr9DDN67GM
         Z6u9GPXN3aU1V3uZq3d21XgbCMXzMAPaF2ZUyjPYLGGCHy0OmLLMdXbCkoU1Y6jZmdts
         qX4Q==
X-Gm-Message-State: AOAM53266AvBlm1v5H3kLugM7gDEgH+/0MkL0+HsMSYX7q+YD7IduQ0B
        rWBLBhkwJ4vTN9FWHW+J4TCg0Q==
X-Google-Smtp-Source: ABdhPJz7ZNzzEgIvSj23gpi851mLte5PllgPlCaq3CdZUAOaxbTgm8TacDW4E4Tx2Yq6vVtMGl92Fw==
X-Received: by 2002:a17:902:a412:b029:db:cf5a:8427 with SMTP id p18-20020a170902a412b02900dbcf5a8427mr1992430plq.48.1614323016398;
        Thu, 25 Feb 2021 23:03:36 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id f7sm7592156pjh.45.2021.02.25.23.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 23:03:36 -0800 (PST)
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
Subject: [PATCH v2 03/10] ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 board
Date:   Fri, 26 Feb 2021 12:32:57 +0530
Message-Id: <20210226070304.8028-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226070304.8028-1-jagan@amarulasolutions.com>
References: <20210226070304.8028-1-jagan@amarulasolutions.com>
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

MicroGEA STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

MicroGEA STM32MP1 needs to mount on top of this MicroDev 2.0 board
for creating complete MicroGEA STM32MP1 MicroDev 2.0 Carrier board.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Francesco Utel <francesco.utel@engicam.com>
Signed-off-by: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
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

