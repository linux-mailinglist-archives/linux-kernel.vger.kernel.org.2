Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AAE425C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhJGTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbhJGTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:43:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2063C061762
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 12:41:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r19so27699164lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46iuhOb9uD5HMcYrx3e2dCS6IBSe8aDIKLjR7qB7Wnw=;
        b=WTFx9T9C0qLb2ShAwHl4LdZ7kljyeIuarX39bl2xJ7vuEaerr9/CQiIKQ/S093wMmh
         tMGnaeJd0uK/Jt81rt2S/mIyji6wlbGc41uFBGZVMskxD/WgYd2gWB7YqwsOuq3uSqJX
         pB8jfxhU1mL7C3lw0sa/r6IJzv8dWIf/bxjKPv4gr6pfYOaOegpVSnyzqYiIPQmlJSaZ
         h9kNstHPAacH9OkL5VX+f6G23ZuhfgTLFgUk6to6U+48KiVz6Djcsi4396LkvVvybA2r
         PJimHajunXYEW7MKaEObuL96Msa66t1wnuRdGsv3WId0NJcMgGtHId6LcaE4FDCKlkgf
         RJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46iuhOb9uD5HMcYrx3e2dCS6IBSe8aDIKLjR7qB7Wnw=;
        b=Ss+dX+dWrgr86sQBHAhiFmJ0EyP4O64uC+iawtAFpC/DtSGAv5+0/ckHwKthCAEpWE
         igtnEvAkEf+vO0v75Fug1eSxBqNdPgrNzt98GuB36y7CUSideBkbo2ISLifPVv46nnV5
         okH+y/TVu7MdXzGHR6NbI9UzU7zGpCXaLpAO14raDOGOD85GfHukv2ZO6ouqRr6/ceif
         xUUrsjX/rLtYgnNyB+mQb3TnRUCDiMnHUWveQKoigpJE4YzMuHsv7P/S8LOra0rJE1rj
         OfT86SL2KuYS69aTZPmEkMLhw7DSLXCKEoOmhwH11+pGQz6GRhnjf3sOso+FD974PX2/
         zX3A==
X-Gm-Message-State: AOAM530teFvIf68HNjSQchenHhOH+HzJDKGznn5Vy/AOsFFBzQU4YG0q
        I5j1Pec3d3k2Glygrc0m8T27cQ==
X-Google-Smtp-Source: ABdhPJywEe3ssZX1R30cigIvdDneToqP9gIQk/6ExXsJJIqw5FZGY0VntlfY4kPbpDHG9Ucw/svIow==
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr5888412lfg.617.1633635680035;
        Thu, 07 Oct 2021 12:41:20 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id n7sm21269lft.309.2021.10.07.12.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:41:19 -0700 (PDT)
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
Subject: [PATCH v2 3/5] dt-bindings: clock: Add bindings definitions for Exynos850 CMU
Date:   Thu,  7 Oct 2021 22:41:11 +0300
Message-Id: <20211007194113.10507-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007194113.10507-1-semen.protsenko@linaro.org>
References: <20211007194113.10507-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock controller driver is designed to have separate instances for each
particular CMU. So clock IDs in this bindings header also start from 1
for each CMU.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
  - Added all clock ids
  - Added CLK_ prefix for all clock constants
  - Added R-b tag by Krzysztof Kozlowski
  - Added Ack tag by Rob Herring

 include/dt-bindings/clock/exynos850.h | 141 ++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 include/dt-bindings/clock/exynos850.h

diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
new file mode 100644
index 000000000000..a44c5f91d3c7
--- /dev/null
+++ b/include/dt-bindings/clock/exynos850.h
@@ -0,0 +1,141 @@
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
+#define CLK_FOUT_SHARED0_PLL		1
+#define CLK_FOUT_SHARED1_PLL		2
+#define CLK_FOUT_MMC_PLL		3
+#define CLK_MOUT_SHARED0_PLL		4
+#define CLK_MOUT_SHARED1_PLL		5
+#define CLK_MOUT_MMC_PLL		6
+#define CLK_MOUT_CORE_BUS		7
+#define CLK_MOUT_CORE_CCI		8
+#define CLK_MOUT_CORE_MMC_EMBD		9
+#define CLK_MOUT_CORE_SSS		10
+#define CLK_MOUT_DPU			11
+#define CLK_MOUT_HSI_BUS		12
+#define CLK_MOUT_HSI_MMC_CARD		13
+#define CLK_MOUT_HSI_USB20DRD		14
+#define CLK_MOUT_PERI_BUS		15
+#define CLK_MOUT_PERI_UART		16
+#define CLK_MOUT_PERI_IP		17
+#define CLK_DOUT_SHARED0_DIV3		18
+#define CLK_DOUT_SHARED0_DIV2		19
+#define CLK_DOUT_SHARED1_DIV3		20
+#define CLK_DOUT_SHARED1_DIV2		21
+#define CLK_DOUT_SHARED0_DIV4		22
+#define CLK_DOUT_SHARED1_DIV4		23
+#define CLK_DOUT_CORE_BUS		24
+#define CLK_DOUT_CORE_CCI		25
+#define CLK_DOUT_CORE_MMC_EMBD		26
+#define CLK_DOUT_CORE_SSS		27
+#define CLK_DOUT_DPU			28
+#define CLK_DOUT_HSI_BUS		29
+#define CLK_DOUT_HSI_MMC_CARD		30
+#define CLK_DOUT_HSI_USB20DRD		31
+#define CLK_DOUT_PERI_BUS		32
+#define CLK_DOUT_PERI_UART		33
+#define CLK_DOUT_PERI_IP		34
+#define CLK_GOUT_CORE_BUS		35
+#define CLK_GOUT_CORE_CCI		36
+#define CLK_GOUT_CORE_MMC_EMBD		37
+#define CLK_GOUT_CORE_SSS		38
+#define CLK_GOUT_DPU			39
+#define CLK_GOUT_HSI_BUS		40
+#define CLK_GOUT_HSI_MMC_CARD		41
+#define CLK_GOUT_HSI_USB20DRD		42
+#define CLK_GOUT_PERI_BUS		43
+#define CLK_GOUT_PERI_UART		44
+#define CLK_GOUT_PERI_IP		45
+#define TOP_NR_CLK			46
+
+/* CMU_HSI */
+#define CLK_MOUT_HSI_BUS_USER		1
+#define CLK_MOUT_HSI_MMC_CARD_USER	2
+#define CLK_MOUT_HSI_USB20DRD_USER	3
+#define CLK_MOUT_HSI_RTC		4
+#define CLK_GOUT_USB_RTC_CLK		5
+#define CLK_GOUT_USB_REF_CLK		6
+#define CLK_GOUT_USB_PHY_REF_CLK	7
+#define CLK_GOUT_USB_PHY_ACLK		8
+#define CLK_GOUT_USB_BUS_EARLY_CLK	9
+#define CLK_GOUT_GPIO_HSI_PCLK		10
+#define CLK_GOUT_MMC_CARD_ACLK		11
+#define CLK_GOUT_MMC_CARD_SDCLKIN	12
+#define CLK_GOUT_SYSREG_HSI_PCLK	13
+#define HSI_NR_CLK			14
+
+/* CMU_PERI */
+#define CLK_MOUT_PERI_BUS_USER		1
+#define CLK_MOUT_PERI_UART_USER		2
+#define CLK_MOUT_PERI_HSI2C_USER	3
+#define CLK_MOUT_PERI_SPI_USER		4
+#define CLK_DOUT_PERI_HSI2C0		5
+#define CLK_DOUT_PERI_HSI2C1		6
+#define CLK_DOUT_PERI_HSI2C2		7
+#define CLK_DOUT_PERI_SPI0		8
+#define CLK_GOUT_PERI_HSI2C0		9
+#define CLK_GOUT_PERI_HSI2C1		10
+#define CLK_GOUT_PERI_HSI2C2		11
+#define CLK_GOUT_GPIO_PERI_PCLK		12
+#define CLK_GOUT_HSI2C0_IPCLK		13
+#define CLK_GOUT_HSI2C0_PCLK		14
+#define CLK_GOUT_HSI2C1_IPCLK		15
+#define CLK_GOUT_HSI2C1_PCLK		16
+#define CLK_GOUT_HSI2C2_IPCLK		17
+#define CLK_GOUT_HSI2C2_PCLK		18
+#define CLK_GOUT_I2C0_PCLK		19
+#define CLK_GOUT_I2C1_PCLK		20
+#define CLK_GOUT_I2C2_PCLK		21
+#define CLK_GOUT_I2C3_PCLK		22
+#define CLK_GOUT_I2C4_PCLK		23
+#define CLK_GOUT_I2C5_PCLK		24
+#define CLK_GOUT_I2C6_PCLK		25
+#define CLK_GOUT_MCT_PCLK		26
+#define CLK_GOUT_PWM_MOTOR_PCLK		27
+#define CLK_GOUT_SPI0_IPCLK		28
+#define CLK_GOUT_SPI0_PCLK		29
+#define CLK_GOUT_SYSREG_PERI_PCLK	30
+#define CLK_GOUT_UART_IPCLK		31
+#define CLK_GOUT_UART_PCLK		32
+#define CLK_GOUT_WDT0_PCLK		33
+#define CLK_GOUT_WDT1_PCLK		34
+#define PERI_NR_CLK			35
+
+/* CMU_CORE */
+#define CLK_MOUT_CORE_BUS_USER		1
+#define CLK_MOUT_CORE_CCI_USER		2
+#define CLK_MOUT_CORE_MMC_EMBD_USER	3
+#define CLK_MOUT_CORE_SSS_USER		4
+#define CLK_MOUT_CORE_GIC		5
+#define CLK_DOUT_CORE_BUSP		6
+#define CLK_GOUT_CCI_ACLK		7
+#define CLK_GOUT_GIC_CLK		8
+#define CLK_GOUT_MMC_EMBD_ACLK		9
+#define CLK_GOUT_MMC_EMBD_SDCLKIN	10
+#define CLK_GOUT_SSS_ACLK		11
+#define CLK_GOUT_SSS_PCLK		12
+#define CORE_NR_CLK			13
+
+/* CMU_DPU */
+#define CLK_MOUT_DPU_USER		1
+#define CLK_DOUT_DPU_BUSP		2
+#define CLK_GOUT_DPU_CMU_DPU_PCLK	3
+#define CLK_GOUT_DPU_DECON0_ACLK	4
+#define CLK_GOUT_DPU_DMA_ACLK		5
+#define CLK_GOUT_DPU_DPP_ACLK		6
+#define CLK_GOUT_DPU_PPMU_ACLK		7
+#define CLK_GOUT_DPU_PPMU_PCLK		8
+#define CLK_GOUT_DPU_SMMU_CLK		9
+#define CLK_GOUT_DPU_SYSREG_PCLK	10
+#define DPU_NR_CLK			11
+
+#endif /* _DT_BINDINGS_CLOCK_EXYNOS_850_H */
-- 
2.30.2

