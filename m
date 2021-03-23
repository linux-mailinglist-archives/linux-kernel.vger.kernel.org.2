Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5E345CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhCWLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCWLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:30:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168DC061574;
        Tue, 23 Mar 2021 04:30:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e33so11382936pgm.13;
        Tue, 23 Mar 2021 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRsC5Q0fuPtBSUGPCgcg2XHUK2jtOE73inoeWiuBT5M=;
        b=lrRSNSX/BJwprajjl8/tp2zNo7iDBPjbN1i51oSk9GPvhoe9lFMeX2Tgx6kDg4z8HT
         HHFUmstFB1q73SmHlOCxj/V8V6rDTCGW9cDUVXqYtJQnK//cNQlwNgxqgY0TsFfzFDEm
         mKqO1OZd/ptpqZKRafFcRi08xYPsB10DTPeHcfLWq5U4Wa/qSxX4IitfnSCkCRQ0E4Na
         Dq7C4Fp/BSCDUN4CZEd2zNgXDGo+r/3HotDxPnIuOIzvR+6yZmKS7pdXqcsAN7H5Y1Df
         ARdKN+gjdXtQkzKfOqUN4uXWkeoknC2ICljNKVDdUiecF5IYNn4LGnSdKc3iZZ4KO/kr
         g9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRsC5Q0fuPtBSUGPCgcg2XHUK2jtOE73inoeWiuBT5M=;
        b=dC7biyhQD5ENb2ryHg1dRXy8pE7H1yKQASHfKHnyl3lclp4FfYmcNc2bAmNJ4QdE15
         b8UX8AEXBdqkdj7fSmrqTyLyE9EISGCROzpDS+ojkAffTA7F7/XzFc/ybSwBcMlJgtzz
         jcf5Cyw4uTy4YIuGWxUnMWOBbHPlmA2sfptShCIrivIbqm8GEs/jN0su1L8jCWDR0/EU
         UhnX29z8pJvlvg8lX9OP8xi3T9J/hRX7M7Wcg3DdcGMtJz8Mc7FeEOqINzjehHzvTpYN
         GposPHamLAUIUO5wvF8HKPgtBCCWHoSIsM6u5eFpWQYrNPP3C4q1GzWMd6VLgxPBGS6V
         nZLA==
X-Gm-Message-State: AOAM532z1hUyd1PlyWcKJpJwrmPaOpmMu6ZjuzrP6PvgwgogKBYmJ2+k
        20E/HXPFoQcXldRSRapCsLM=
X-Google-Smtp-Source: ABdhPJwuWs43oZ7rXQMCOOPT5JtIgPSQ6nfR1Ck39FrkoAf6s2O6cjIQ8WAVYlkBbsu3LAsPYnvHNQ==
X-Received: by 2002:a17:902:b684:b029:e6:8efd:fb00 with SMTP id c4-20020a170902b684b02900e68efdfb00mr5129063pls.16.1616499027740;
        Tue, 23 Mar 2021 04:30:27 -0700 (PDT)
Received: from localhost.localdomain ([101.95.133.222])
        by smtp.gmail.com with ESMTPSA id f23sm16281824pfa.85.2021.03.23.04.30.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 04:30:27 -0700 (PDT)
From:   Dongjiu Geng <gengdongjiu1@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gengdongjiu1@gmail.com
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v8 1/2] dt-bindings: Document the hi3559a clock bindings
Date:   Tue, 23 Mar 2021 19:29:32 +0800
Message-Id: <1616498973-47067-2-git-send-email-gengdongjiu1@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616498973-47067-1-git-send-email-gengdongjiu1@gmail.com>
References: <1616498973-47067-1-git-send-email-gengdongjiu1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongjiu Geng <gengdongjiu@huawei.com>

Add DT bindings documentation for hi3559a SoC clock.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ++++++++
 include/dt-bindings/clock/hi3559av100-clock.h      | 165 +++++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
 create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h

diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
new file mode 100644
index 0000000..3ceb29c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/hisilicon,hi3559av100-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon SOC Clock for HI3559AV100
+
+maintainers:
+  - Dongjiu Geng <gengdongjiu@huawei.com>
+
+description: |
+  Hisilicon SOC clock control module which supports the clocks, resets and
+  power domains on HI3559AV100.
+
+  See also:
+    dt-bindings/clock/hi3559av100-clock.h
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hi3559av100-clock
+      - hisilicon,hi3559av100-shub-clock
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 2
+    description: |
+      First cell is reset request register offset.
+      Second cell is bit offset in reset request register.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@12010000 {
+            compatible = "hisilicon,hi3559av100-clock";
+            #clock-cells = <1>;
+            #reset-cells = <2>;
+            reg = <0x0 0x12010000 0x0 0x10000>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/hi3559av100-clock.h b/include/dt-bindings/clock/hi3559av100-clock.h
new file mode 100644
index 0000000..5fe7689
--- /dev/null
+++ b/include/dt-bindings/clock/hi3559av100-clock.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later or BSD-2-Clause */
+/*
+ * Copyright (c) 2019-2020, Huawei Tech. Co., Ltd.
+ *
+ * Author: Dongjiu Geng <gengdongjiu@huawei.com>
+ */
+
+#ifndef __DTS_HI3559AV100_CLOCK_H
+#define __DTS_HI3559AV100_CLOCK_H
+
+/*  fixed   rate    */
+#define HI3559AV100_FIXED_1188M     1
+#define HI3559AV100_FIXED_1000M     2
+#define HI3559AV100_FIXED_842M      3
+#define HI3559AV100_FIXED_792M      4
+#define HI3559AV100_FIXED_750M      5
+#define HI3559AV100_FIXED_710M      6
+#define HI3559AV100_FIXED_680M      7
+#define HI3559AV100_FIXED_667M      8
+#define HI3559AV100_FIXED_631M      9
+#define HI3559AV100_FIXED_600M      10
+#define HI3559AV100_FIXED_568M      11
+#define HI3559AV100_FIXED_500M      12
+#define HI3559AV100_FIXED_475M      13
+#define HI3559AV100_FIXED_428M      14
+#define HI3559AV100_FIXED_400M      15
+#define HI3559AV100_FIXED_396M      16
+#define HI3559AV100_FIXED_300M      17
+#define HI3559AV100_FIXED_250M      18
+#define HI3559AV100_FIXED_198M      19
+#define HI3559AV100_FIXED_187p5M    20
+#define HI3559AV100_FIXED_150M      21
+#define HI3559AV100_FIXED_148p5M    22
+#define HI3559AV100_FIXED_125M      23
+#define HI3559AV100_FIXED_107M      24
+#define HI3559AV100_FIXED_100M      25
+#define HI3559AV100_FIXED_99M       26
+#define HI3559AV100_FIXED_74p25M    27
+#define HI3559AV100_FIXED_72M       28
+#define HI3559AV100_FIXED_60M       29
+#define HI3559AV100_FIXED_54M       30
+#define HI3559AV100_FIXED_50M       31
+#define HI3559AV100_FIXED_49p5M     32
+#define HI3559AV100_FIXED_37p125M   33
+#define HI3559AV100_FIXED_36M       34
+#define HI3559AV100_FIXED_32p4M     35
+#define HI3559AV100_FIXED_27M       36
+#define HI3559AV100_FIXED_25M       37
+#define HI3559AV100_FIXED_24M       38
+#define HI3559AV100_FIXED_12M       39
+#define HI3559AV100_FIXED_3M        40
+#define HI3559AV100_FIXED_1p6M      41
+#define HI3559AV100_FIXED_400K      42
+#define HI3559AV100_FIXED_100K      43
+#define HI3559AV100_FIXED_200M      44
+#define HI3559AV100_FIXED_75M       75
+
+#define HI3559AV100_I2C0_CLK    50
+#define HI3559AV100_I2C1_CLK    51
+#define HI3559AV100_I2C2_CLK    52
+#define HI3559AV100_I2C3_CLK    53
+#define HI3559AV100_I2C4_CLK    54
+#define HI3559AV100_I2C5_CLK    55
+#define HI3559AV100_I2C6_CLK    56
+#define HI3559AV100_I2C7_CLK    57
+#define HI3559AV100_I2C8_CLK    58
+#define HI3559AV100_I2C9_CLK    59
+#define HI3559AV100_I2C10_CLK   60
+#define HI3559AV100_I2C11_CLK   61
+
+#define HI3559AV100_SPI0_CLK    62
+#define HI3559AV100_SPI1_CLK    63
+#define HI3559AV100_SPI2_CLK    64
+#define HI3559AV100_SPI3_CLK    65
+#define HI3559AV100_SPI4_CLK    66
+#define HI3559AV100_SPI5_CLK    67
+#define HI3559AV100_SPI6_CLK    68
+
+#define HI3559AV100_EDMAC_CLK     69
+#define HI3559AV100_EDMAC_AXICLK  70
+#define HI3559AV100_EDMAC1_CLK    71
+#define HI3559AV100_EDMAC1_AXICLK 72
+#define HI3559AV100_VDMAC_CLK     73
+
+/*  mux clocks  */
+#define HI3559AV100_FMC_MUX     80
+#define HI3559AV100_SYSAPB_MUX  81
+#define HI3559AV100_UART_MUX    82
+#define HI3559AV100_SYSBUS_MUX  83
+#define HI3559AV100_A73_MUX     84
+#define HI3559AV100_MMC0_MUX    85
+#define HI3559AV100_MMC1_MUX    86
+#define HI3559AV100_MMC2_MUX    87
+#define HI3559AV100_MMC3_MUX    88
+
+/*  gate    clocks  */
+#define HI3559AV100_FMC_CLK     90
+#define HI3559AV100_UART0_CLK   91
+#define HI3559AV100_UART1_CLK   92
+#define HI3559AV100_UART2_CLK   93
+#define HI3559AV100_UART3_CLK   94
+#define HI3559AV100_UART4_CLK   95
+#define HI3559AV100_MMC0_CLK    96
+#define HI3559AV100_MMC1_CLK    97
+#define HI3559AV100_MMC2_CLK    98
+#define HI3559AV100_MMC3_CLK    99
+
+#define HI3559AV100_ETH_CLK         100
+#define HI3559AV100_ETH_MACIF_CLK   101
+#define HI3559AV100_ETH1_CLK        102
+#define HI3559AV100_ETH1_MACIF_CLK  103
+
+/*  complex */
+#define HI3559AV100_MAC0_CLK                110
+#define HI3559AV100_MAC1_CLK                111
+#define HI3559AV100_SATA_CLK                112
+#define HI3559AV100_USB_CLK                 113
+#define HI3559AV100_USB1_CLK                114
+
+/* pll clocks */
+#define HI3559AV100_APLL_CLK                250
+#define HI3559AV100_GPLL_CLK                251
+
+#define HI3559AV100_CRG_NR_CLKS	            256
+
+#define HI3559AV100_SHUB_SOURCE_SOC_24M	    0
+#define HI3559AV100_SHUB_SOURCE_SOC_200M    1
+#define HI3559AV100_SHUB_SOURCE_SOC_300M    2
+#define HI3559AV100_SHUB_SOURCE_PLL         3
+#define HI3559AV100_SHUB_SOURCE_CLK         4
+
+#define HI3559AV100_SHUB_I2C0_CLK           10
+#define HI3559AV100_SHUB_I2C1_CLK           11
+#define HI3559AV100_SHUB_I2C2_CLK           12
+#define HI3559AV100_SHUB_I2C3_CLK           13
+#define HI3559AV100_SHUB_I2C4_CLK           14
+#define HI3559AV100_SHUB_I2C5_CLK           15
+#define HI3559AV100_SHUB_I2C6_CLK           16
+#define HI3559AV100_SHUB_I2C7_CLK           17
+
+#define HI3559AV100_SHUB_SPI_SOURCE_CLK     20
+#define HI3559AV100_SHUB_SPI4_SOURCE_CLK    21
+#define HI3559AV100_SHUB_SPI0_CLK           22
+#define HI3559AV100_SHUB_SPI1_CLK           23
+#define HI3559AV100_SHUB_SPI2_CLK           24
+#define HI3559AV100_SHUB_SPI3_CLK           25
+#define HI3559AV100_SHUB_SPI4_CLK           26
+
+#define HI3559AV100_SHUB_UART_CLK_32K       30
+#define HI3559AV100_SHUB_UART_SOURCE_CLK    31
+#define HI3559AV100_SHUB_UART_DIV_CLK       32
+#define HI3559AV100_SHUB_UART0_CLK          33
+#define HI3559AV100_SHUB_UART1_CLK          34
+#define HI3559AV100_SHUB_UART2_CLK          35
+#define HI3559AV100_SHUB_UART3_CLK          36
+#define HI3559AV100_SHUB_UART4_CLK          37
+#define HI3559AV100_SHUB_UART5_CLK          38
+#define HI3559AV100_SHUB_UART6_CLK          39
+
+#define HI3559AV100_SHUB_EDMAC_CLK          40
+
+#define HI3559AV100_SHUB_NR_CLKS            50
+
+#endif  /* __DTS_HI3559AV100_CLOCK_H */
+
-- 
2.7.4

