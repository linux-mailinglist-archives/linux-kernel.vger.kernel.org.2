Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11B840B3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhINP5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhINP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:57:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6577C061767
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:56:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g14so24813588ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTnOJ7ylard1/aX3m1VvlpBsqx0IZmAAbb3lV2jCep4=;
        b=BWqrojW7vj7uWDsyXC8kYWJq8jqj8dsEw3Esi0XnFC4kQXcwMUJSdt37ApUyr+fsCI
         btV0JlX8iCULqI/d/R7Ffmwr0WwUKgV5/kbXCmTtH+YvEpNqJs4wiOeJD4usgUOEh0FZ
         vOApzLye/kvi7K3QM2nBeke+e8YNDBjqliWpkjuKHD5nQ0tACUhWq8rAV7bcWZR0KVKW
         IReeZcVdJcWw5Ja1tr3a5WRYZxjS4rpvkMAmpZPbg6lQ4sdW3wfPJPfZMDmh69qc2rzk
         f+W7xPHNvvv6kc1QvwwaDV6k2TIe8cCbtgjs4G0e/IMX4k5YKBJi8n92sg+oD4LSLSVo
         jwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTnOJ7ylard1/aX3m1VvlpBsqx0IZmAAbb3lV2jCep4=;
        b=A1wa5SyC8D+ExX64HgerumObzDoiLJx4SH1QTEMcM6q4iGoQQmfIT54nZSf49/vVJu
         OpAk9b+2jYihxrW+QJQ1h77nsAb8hQ8/ZF35nqz+50yySWAKxXor0vaIW2WAiWCzsjNG
         EPvenHCz3MSFj11bv9xQ/CFzriIWzuCLwRElBz6lOHELVToctdG8wxSLMdkhj8HAlD5l
         mWQ372nD7nSs94pc4ULg3/YzVrSxjWkNIKkraXcjC9ZL2L4AvjaQxT+R3TxWaRQKut4U
         Xq/MXAgSltPRq3ySPCStWg48j8GcoCeHLaFz7i3CUgRq8XZxo5Y9wbApkTcp9aGSIfs5
         FWPw==
X-Gm-Message-State: AOAM530bEQuMaq5of7NZW7WB5pPX5Xt+smW+AZB5iVxIOdceyQLOf5Cw
        Et6O9ljy/L0I5pBU/88xS9BCWQ==
X-Google-Smtp-Source: ABdhPJy6wmnT0mbGhg0Gq10Ai4jwQ2Y4H4ezws1HnynI6dvTRAXqjH5vwvyz6r7T3Lpya0Rg0EGtpg==
X-Received: by 2002:a2e:8881:: with SMTP id k1mr16304746lji.443.1631634975350;
        Tue, 14 Sep 2021 08:56:15 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z4sm1147589lfd.298.2021.09.14.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:56:14 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryu Euiyoul <ryu.real@samsung.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: clock: Add bindings definitions for Exynos850 CMU
Date:   Tue, 14 Sep 2021 18:56:05 +0300
Message-Id: <20210914155607.14122-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914155607.14122-1-semen.protsenko@linaro.org>
References: <20210914155607.14122-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock controller driver is designed to have separate instances for each
particular CMU. So clock IDs in this bindings header also start from 1
for each CMU.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/dt-bindings/clock/exynos850.h | 72 +++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 include/dt-bindings/clock/exynos850.h

diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
new file mode 100644
index 000000000000..2f0a7f619627
--- /dev/null
+++ b/include/dt-bindings/clock/exynos850.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Device Tree binding constants for Exynos850 clock controller.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_EXYNOS_850_H
+#define _DT_BINDINGS_CLOCK_EXYNOS_850_H
+
+/* CMU_TOP */
+#define DOUT_HSI_BUS			1
+#define DOUT_HSI_MMC_CARD		2
+#define DOUT_HSI_USB20DRD		3
+#define DOUT_PERI_BUS			4
+#define DOUT_PERI_UART			5
+#define DOUT_PERI_IP			6
+#define DOUT_CORE_BUS			7
+#define DOUT_CORE_CCI			8
+#define DOUT_CORE_MMC_EMBD		9
+#define DOUT_CORE_SSS			10
+#define TOP_NR_CLK			11
+
+/* CMU_HSI */
+#define GOUT_USB_RTC_CLK		1
+#define GOUT_USB_REF_CLK		2
+#define GOUT_USB_PHY_REF_CLK		3
+#define GOUT_USB_PHY_ACLK		4
+#define GOUT_USB_BUS_EARLY_CLK		5
+#define GOUT_GPIO_HSI_PCLK		6
+#define GOUT_MMC_CARD_ACLK		7
+#define GOUT_MMC_CARD_SDCLKIN		8
+#define GOUT_SYSREG_HSI_PCLK		9
+#define HSI_NR_CLK			10
+
+/* CMU_PERI */
+#define GOUT_GPIO_PERI_PCLK		1
+#define GOUT_HSI2C0_IPCLK		2
+#define GOUT_HSI2C0_PCLK		3
+#define GOUT_HSI2C1_IPCLK		4
+#define GOUT_HSI2C1_PCLK		5
+#define GOUT_HSI2C2_IPCLK		6
+#define GOUT_HSI2C2_PCLK		7
+#define GOUT_I2C0_PCLK			8
+#define GOUT_I2C1_PCLK			9
+#define GOUT_I2C2_PCLK			10
+#define GOUT_I2C3_PCLK			11
+#define GOUT_I2C4_PCLK			12
+#define GOUT_I2C5_PCLK			13
+#define GOUT_I2C6_PCLK			14
+#define GOUT_MCT_PCLK			15
+#define GOUT_PWM_MOTOR_PCLK		16
+#define GOUT_SPI0_IPCLK			17
+#define GOUT_SPI0_PCLK			18
+#define GOUT_SYSREG_PERI_PCLK		19
+#define GOUT_UART_IPCLK			20
+#define GOUT_UART_PCLK			21
+#define GOUT_WDT0_PCLK			22
+#define GOUT_WDT1_PCLK			23
+#define PERI_NR_CLK			24
+
+/* CMU_CORE */
+#define GOUT_CCI_ACLK			1
+#define GOUT_GIC_CLK			2
+#define GOUT_MMC_EMBD_ACLK		3
+#define GOUT_MMC_EMBD_SDCLKIN		4
+#define GOUT_SSS_ACLK			5
+#define GOUT_SSS_PCLK			6
+#define CORE_NR_CLK			7
+
+#endif /* _DT_BINDINGS_CLOCK_EXYNOS_850_H */
-- 
2.30.2

