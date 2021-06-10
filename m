Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F203A37E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFJXbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhFJXa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:30:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE331C0617A6;
        Thu, 10 Jun 2021 16:28:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso7553763wmi.3;
        Thu, 10 Jun 2021 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyK9z77KPeuihLjFv6CL15mYQ8zBPJwgwgxafmnnN4I=;
        b=GtV8tYpbysk23WR8WYdoLRG0IuES2TyMPeFoyWMZhkihp+JDhGcRInM9PnfPDcdpVQ
         aIpYR9KtjmTYavCP1G0mYCwQNOSnXgzC+CpyPzkMDY/mkOOSLZuwBUYrOQAvxs1du7JU
         VZqlBMNqfE4e72fBODuNlyri4cFqkOD0fiFOPUd/Sm5ophgBP04JPCTO06Rk5II0i3Tg
         Fhc08Q8mjfUU/syBEhN9UU8EnWZ3Ygzy8NRyJQPUhvDobOfUiHpquFAyYV/I4sJpAclT
         9SyPjRtK83/oV0pkJ9jcL2cXFpSEKokcGsBtYZTgnVNP8m5C1IdQQQyEF3d7mZJ2z1qT
         auEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyK9z77KPeuihLjFv6CL15mYQ8zBPJwgwgxafmnnN4I=;
        b=cIgIrt/oOszpAK+n/Hm8kfLYkZKIN9kQlp1MOIH2byPM8TIl+98DopsBhboAFPF9cB
         +Ubc4ARGN6DwY/m9j2DGCd3iuYS+d3QcdAYqudH15aQgCZ+VlsePNRrt+PwGfXR5ivl7
         HQQUkz1yOcxiZJd0stix27hvUinsblRFmKZKJzIDLi5lPnS0YvFQoHJkY7lK/yeRVLff
         36sucZjNfR7SB7LWhyqsElm6K6GnjPcw45pjC5Olg3HvI4ovQhKRneL9Hv40ekCIybdF
         vhi885A1dGfoQidFzNa8f2jKZ/pUlYdKJmnBwluIzGHkAdLSjjtVWUQM5g7qZcwqomrR
         yV1A==
X-Gm-Message-State: AOAM531kAdz3+2IFZ8ycIDtKBcXYEGjgo4glnt7P1lsfO4taAvqmzKBc
        58Jee3/8LAzpNZooyvi5GVU=
X-Google-Smtp-Source: ABdhPJxReN3yGxJyKbpYbQ91cIEM+68PrNx6S/fpAPT7jFhtMq+7YBxVgjndmP7se65wYIpXEAAaBQ==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr17396630wmq.121.1623367727547;
        Thu, 10 Jun 2021 16:28:47 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id g186sm4324045wme.6.2021.06.10.16.28.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 16:28:47 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/5] ARM: dts: NSP: Add common bindings for MX64/MX65
Date:   Fri, 11 Jun 2021 00:27:15 +0100
Message-Id: <20210610232727.1383117-4-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610232727.1383117-1-mnhagan88@gmail.com>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bindings are required for all Meraki MX64/MX65 devices.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 .../dts/bcm958625-meraki-mx6x-common.dtsi     | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi

diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
new file mode 100644
index 000000000000..47a30dedf7b3
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Common Bindings for Cisco Meraki MX64 (Kingpin) and MX65 (Alamo) devices.
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+#include "bcm-nsp.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x80000000>;
+	};
+
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		red {
+			label = "red:led";
+			pwms = <&pwm 1 50000>;
+		};
+
+		green {
+			label = "green:led";
+			pwms = <&pwm 2 50000>;
+		};
+
+		blue {
+			label = "blue:led";
+			pwms = <&pwm 3 50000>;
+		};
+	};
+};
+
+&L2 {
+	arm,io-coherent;
+	prefetch-data = <1>;
+	prefetch-instr = <1>;
+};
+
+&uart0 {
+	clock-frequency = <62500000>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	at24@50 {
+		compatible = "atmel,24c64";
+		pagesize = <32>;
+		reg = <0x50>;
+	};
+};
+
+&amac2 {
+	status = "okay";
+};
+
+&nand {
+	nandcs@0 {
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
+			label = "senao_nvram";
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
+&qspi {
+	status = "disabled";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pwm {
+	status = "okay";
+	#pwm-cells = <2>;
+	chan0 {
+		channel = <1>;
+		active_low = <1>;
+		};
+	chan1 {
+		channel = <2>;
+		active_low = <1>;
+	};
+	chan2 {
+		channel = <3>;
+		active_low = <1>;
+	};
+};
+
+&ccbtimer1 {
+	status = "disabled";
+};
+
+&sata_phy {
+	status = "disabled";
+};
-- 
2.26.3

