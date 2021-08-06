Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE13E307B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbhHFUpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbhHFUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:45:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36088C0613CF;
        Fri,  6 Aug 2021 13:45:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l18so12595248wrv.5;
        Fri, 06 Aug 2021 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aoqpuygPFTPpZbPvJjLMKEd6jtzvkdTL12kqRjIbbc=;
        b=JIxB7o2KF77Eczxpr0Nqtu9dF1oEsUUzcp0JF0Vj8WJt8h+Y0q0JPjdJ5K0LduYyOW
         IQJs5IEHpTMgmBuyGcPd8UHX6XtgWv0plCu4zpnc0ysbnf/2j4/vV+xEb/nZmDEB4/MZ
         bwM2El85v2S+bSiKP7DmniWSqkawfRwzazT3hoYKCRX54pqgpWsPP7LPT7cV/+yUjR3D
         Yh+RaEYgVPKLyHnIllws1pwgfsj35TrklOuGuDU89V1U0pSKpk+2RrToItIuqCa8Acqg
         S5EConHaZXhgfF8Nijg/MiSOS+g1Sdrryu8d+l80/VJGuVm+qysjzngwTO5cphhob6Y+
         Wv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aoqpuygPFTPpZbPvJjLMKEd6jtzvkdTL12kqRjIbbc=;
        b=AHw8MhV07P+oMoOSaapAjLXwiTkpCCpZOlsisR7tdI6/kFzoVqfoPoBc2gLSHQ7hJR
         KVdgTdj2UFTiFxvTyYIpKm/aXHHdZYKsIv2fjFYogDLz7CgGblyrzy5CEwIPOqjgLvzl
         KYFxC4scnT7703qpSAFy/LfbgCau70iFFNnO2wxXCqgH6ilZJEUfbk6yPeStB9MXI7+u
         oLYdwK2sWfpgfHNj809yNQGyQ0b94aAPfZUu6C3ggGj6x7twXzcgldB0ww8VCC9kaRWw
         pYbu0w6nsFeJjPG+J6km0/Qc5OeGXmgkJygug5Jz8hj+EsS3z8Z/dqNsBFBPfimWA1aG
         zbjw==
X-Gm-Message-State: AOAM530tBCBSk438LT8m0L8MXF/t1zIBjcRA7JGpYaIgLj7Ua1gng1pU
        0wgWX2KHWtJnL8foJodUQvxSsHxWWQY=
X-Google-Smtp-Source: ABdhPJxAObjD6fRA0SogD6Ki/nBvjD1RavORpv9+x4gri+QQeAV9kMShSoEBNrcfnioVz7Fnt6nh1A==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr12723792wru.421.1628282703887;
        Fri, 06 Aug 2021 13:45:03 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id u23sm12844445wmc.24.2021.08.06.13.45.03
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 06 Aug 2021 13:45:03 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/5] ARM: dts: NSP: Add common bindings for MX64/MX65
Date:   Fri,  6 Aug 2021 21:44:32 +0100
Message-Id: <20210806204446.2981299-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210806204446.2981299-1-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bindings are required for all Meraki MX64/MX65 devices. These
common bindings include memory (2GB), PWM LEDs, AMAC, I2C (AT24), NAND
partitions, EHCI, OHCI and pinctrl.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 .../dts/bcm958625-meraki-mx6x-common.dtsi     | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi

diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
new file mode 100644
index 000000000000..bcdd38954f1d
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Common Bindings for Cisco Meraki MX64 (Kingpin) and MX65 (Alamo) devices.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+#include "bcm-nsp.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		led-1 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_RED>;
+			pwms = <&pwm 1 50000>;
+			max-brightness = <255>;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			pwms = <&pwm 2 50000>;
+			max-brightness = <255>;
+		};
+
+		led-3 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_BLUE>;
+			pwms = <&pwm 3 50000>;
+			max-brightness = <255>;
+		};
+	};
+};
+
+&amac2 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	at24@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+		read-only;
+	};
+};
+
+&nand_controller {
+	nand@0 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <1024>;
+
+		brcm,nand-oob-sector-size = <27>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition@80000 {
+			label = "shmoo";
+			reg = <0x80000 0x80000>;
+			read-only;
+		};
+
+		partition@100000 {
+			label = "bootkernel1";
+			reg = <0x100000 0x300000>;
+		};
+
+		partition@400000 {
+			label = "nvram";
+			reg = <0x400000 0x100000>;
+		};
+
+		partition@500000 {
+			label = "bootkernel2";
+			reg = <0x500000 0x300000>;
+		};
+
+		partition@800000 {
+			label = "ubi";
+			reg = <0x800000 0x3f700000>;
+		};
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_leds>;
+
+	pwm_leds: pwm_leds {
+		function = "pwm";
+		groups = "pwm1_grp", "pwm2_grp", "pwm3_grp";
+	};
+};
+
+&pwm {
+	status = "okay";
+	#pwm-cells = <2>;
+};
+
+&uart0 {
+	clock-frequency = <62500000>;
+	status = "okay";
+};
-- 
2.26.3

