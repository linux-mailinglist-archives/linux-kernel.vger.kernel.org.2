Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C372A3AAB42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFQFsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhFQFsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:48:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E979C0613A3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:46:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e33so4033556pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UKzT5tHNyrCtmsqkqYRrpb8fD178fqkEWWYV9zJ+Sw=;
        b=RCJlYV66QaV7p11YyDciyWIvseLVxMEpd3sIXfr5dEqljBi/gBcoDUTTN8WgrJn5IC
         ECJiUXcnNnzFwN2FB1g3V3z/GfGTOjbWpx5Ct/rOKNn3q6qhxPoko1mqXtGH3+03xWna
         h6yL/6puWOL6PymhwB6uugcb5zPPb0cYC/r3Mk+rnG0jo3i9PQOkzaX/ZED5mMSzlhai
         Ld/h2bJyQ80wcAiVzLczhk7Ht45dUajQHSoINkBGdb2yBTPN/Or55SJZuSXoAgOIYBVx
         MTA/ix8FmtVFJRyARsWe5G9o23P89v3elgtgELacPyCd1wF8S9mAXvUupOyH8rbaObll
         8myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UKzT5tHNyrCtmsqkqYRrpb8fD178fqkEWWYV9zJ+Sw=;
        b=NUlW30F/tWZMozh6EA3oxf1ZpirRKW+d42ySuAwndr5Q//xF1+ZWKTeJ2PCADj+1gX
         UWNsCT1nIjRyZWgKKaRJrAxZSFM1rMGf4u+4MaRPsAHMiOo1ArSYDjqGM60qv2mNJZ7X
         9AR/pv3F4ur4/y6aj8qQapf5JnGHCOvLinKmLpUFznla8+QubWtxkpmGsl5IjuBwJ/VX
         Af4y7wQkSkWGL/BD8hUAou3IxVoFhOCpjBtPcNpQlZb6hoSJvAErgS/CSGpUiS5l14Lu
         Cf1RBhiOr6gaBL8KmArmptP/grG71+J7F8kzGXBUDH3a9tZKoQ9MBNTWuP3Ax7veN90p
         Tb5g==
X-Gm-Message-State: AOAM530Htu18PeZnceKAZPZ5tZ/n9NzQU4oGw3BBJktRlcQcOCzeePMc
        +uuahVYM5KaDXM8qAM7AI3+5EmHa6a1sDQ==
X-Google-Smtp-Source: ABdhPJzi2FwVCB5GDMFuDu4AUnxjS6M7QI1kgRMbytxW4/MNqwel+SPlRhE8HmyndD3zQ21MHmLqig==
X-Received: by 2002:a63:1a4f:: with SMTP id a15mr3295630pgm.313.1623908793161;
        Wed, 16 Jun 2021 22:46:33 -0700 (PDT)
Received: from localhost.name ([122.177.46.2])
        by smtp.gmail.com with ESMTPSA id y27sm3882700pff.202.2021.06.16.22.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 22:46:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 4/5] arm64: dts: qcom: pmm8155au_2: Add base dts file
Date:   Thu, 17 Jun 2021 11:15:47 +0530
Message-Id: <20210617054548.353293-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617054548.353293-1-bhupesh.sharma@linaro.org>
References: <20210617054548.353293-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base DTS file for pmm8155au_2 along with GPIOs, power-on, rtc and vadc
nodes.

Cc: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi | 107 ++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
new file mode 100644
index 000000000000..0c7d7a66c0b5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pmm8155au-2-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmm8155au_2_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmic@4 {
+		compatible = "qcom,pmm8155au", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		power-on@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+
+			status = "disabled";
+		};
+
+		pmm8155au_2_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x4 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&pmm8155au_2_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmm8155au_2_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+		};
+
+		pmm8155au_2_gpios: gpio@c000 {
+			compatible = "qcom,pmm8155au-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@5 {
+		compatible = "qcom,pmm8155au", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.31.1

