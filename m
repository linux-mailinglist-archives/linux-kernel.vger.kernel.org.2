Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB51460208
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356449AbhK0Wlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 17:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356377AbhK0Wja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 17:39:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302BC061761
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 14:32:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so27248032wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 14:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6M4A/tb5uMp/41DxndVqEzSE2hGblNz4wYiEfFPyfnc=;
        b=hwCAOxXXwF6ism7IqxUqUx5YEWM699I2gzxWPjLbsuhqAxeANw0tyg2ZkoEsmxQhBM
         0b9iSdg7x66rGyWrLH6auVrWWQH3b6wJHVYutnVJGMcpWtEWhVcKQ1KljEf74zibFqOA
         puBg08DDqOC3z87KQ50CkrfgL9gPq+6CAqIoKygr48PdbKBFJNjqnbNo9WATYhpe3bE6
         lrMKH8RO+IdMTR+m3qWxiP/CFKtgNSdTXcw64hF/0TC4NwQcnOBcaPDVhH5ypKx//uqa
         PgaLKZK70je7WrCZ+0G55F2vKk1OFzLy2L7p1Vxi9s3gVQz9W14deADmTszNCUGxKFMJ
         Viow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6M4A/tb5uMp/41DxndVqEzSE2hGblNz4wYiEfFPyfnc=;
        b=RGDikKgC6Li+pwkyzzz6uIWNAAtYjV4tX2+6uyCzkDD0tk7v+yOq9GpiuqxZln4EZN
         EFRMR+24dUeiH/AYSgdAkmdTiIr8g8otnvIK3U76IjQO61WUsQLX7q5rSoqu4pXpfP3G
         aLKCXYxOSuaxW0ppffc6jySqSm507hrPsBXkXy/7i4hmHwKBZ5TZVo8WIkfD78WjZVk2
         MgS+BFjLmdewxeMv6JHMttUYVnha1oDYzTLWowzO+d011xJSCJEjrwJOe+HVhsf28BSt
         1mTlLCHj2++IfIEeXu8k5Jcts9fC8Y5/yEvhlsIZmtjyY43e2mlero0xd5w2hiG8Is1y
         OzKg==
X-Gm-Message-State: AOAM533/Q2l2wsOHRcQzqsNpOOImHhSfTQv80nRIqBEL1NNueb/AZXeH
        9RPw7Dex7pKuYn+nToqRtXKT3w==
X-Google-Smtp-Source: ABdhPJwdbLpH8JwPS05Q7nu7RvXbREcA2Cct0x3S38Z74xtvi6I8L2Y3D4yJGspddD2iZgy5JeAMBw==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr23285781wrt.65.1638052378118;
        Sat, 27 Nov 2021 14:32:58 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id v6sm14801124wmh.8.2021.11.27.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 14:32:57 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: soc: samsung: Add Exynos USIv2 bindings doc
Date:   Sun, 28 Nov 2021 00:32:47 +0200
Message-Id: <20211127223253.19098-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211127223253.19098-1-semen.protsenko@linaro.org>
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document USIv2 IP-core bindings.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/soc/samsung/exynos-usi-v2.yaml   | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi-v2.yaml

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi-v2.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi-v2.yaml
new file mode 100644
index 000000000000..d7466aa463dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi-v2.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/exynos-usi-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung's Exynos USIv2 (Universal Serial Interface) binding
+
+maintainers:
+  - Sam Protsenko <semen.protsenko@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  USIv2 IP-core provides selectable serial protocol (UART, SPI or High-Speed
+  I2C); only one can be chosen at a time. It is modeled as a node with zero or
+  more child nodes, each representing a serial sub-node device. The mode setting
+  selects which particular function will be used.
+
+  Refer to next bindings documentation for information on protocol subnodes that
+  can exist under USI node:
+
+  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
+  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
+  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
+
+properties:
+  $nodename:
+    pattern: "^usi@[0-9a-f]+$"
+
+  compatible:
+    const: samsung,exynos-usi-v2
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus (APB) clock
+      - description: Operating clock for UART/SPI/I2C protocol
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: ipclk
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should be phandle/offset pair. The phandle to System Register syscon node
+      (for the same domain where this USIv2 controller resides) and the offset
+      of SW_CONF register for this USIv2 controller.
+
+  samsung,mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Selects USIv2 function (which serial protocol to use). Refer to
+      <include/dt-bindings/soc/samsung,exynos-usi-v2.h> for valid USI mode
+      values.
+
+  samsung,clkreq-on:
+    type: boolean
+    description:
+      Enable this property if underlying protocol requires the clock to be
+      continuously provided without automatic gating. As suggested by SoC
+      manual, it should be set in case of SPI/I2C slave, UART Rx and I2C
+      multi-master mode. Usually this property is needed if USI mode is set
+      to "UART".
+
+      This property is optional.
+
+patternProperties:
+  # All other properties should be child nodes
+  "^.*@[0-9a-f]+$":
+    type: object
+    description: Child node describing underlying USIv2 serial protocol
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+  - samsung,sysreg
+  - samsung,mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/samsung,exynos-usi-v2.h>
+
+    usi_uart: usi@138200c0 {
+        compatible = "samsung,exynos-usi-v2";
+        reg = <0x138200c0 0x20>;
+        samsung,sysreg = <&sysreg_peri 0x1010>;
+        samsung,mode = <USI_V2_UART>;
+        samsung,clkreq-on; /* needed for UART mode */
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+        clock-names = "pclk", "ipclk";
+        status = "disabled";
+
+        serial_0: serial@13820000 {
+            compatible = "samsung,exynos850-uart";
+            reg = <0x13820000 0xc0>;
+            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+            clock-names = "uart", "clk_uart_baud0";
+            status = "disabled";
+        };
+    };
-- 
2.30.2

