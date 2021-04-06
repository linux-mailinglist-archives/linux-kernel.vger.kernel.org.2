Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB46354FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbhDFJ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhDFJ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:27:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB27C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:26:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t20so7130647plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VNvgoMCwBJ4qAY6BZk+dyDnZlWGBkmlYJoxs1bRA1pY=;
        b=S+KGgiyjxSAZdD6ZNm7uZ8nGdfluaQAIzvOhqdrpbMceSlIpV0An8P/z6PdFre3pgU
         qlzLem+2zCyfmj21AN+VQbttQbWNWJYlRmc6CO5agbskF9FG7vZSfHCbNkxpBcH7zZl7
         E9Kn99ZoA52dveAbQQ03XAjBgM3tML2Bmldai5k3IRLxPUqtVZWOXOPp2PS9d/xBawvh
         uRSTaDewwiJ1Xp6/UiquY5tzKrjTS1cW/PZaqG3S9WCvb0PKfnDp3PzyXFtTx06UdSnS
         1WSWGo9Z/mitHIiHJc30LsP7xCrfoSAjbIseYJSLcdLTKpzh35eU5jCwOnaFAhxyT5e2
         LTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNvgoMCwBJ4qAY6BZk+dyDnZlWGBkmlYJoxs1bRA1pY=;
        b=ok0QuQ6FUA2CwSok+3rcj0xNvPm7kp6O6gJ8ELqisBNNSqGVHJL4/0oO6jiLH9oQsw
         q0HwhIza3VILkKr6yjv2jIaAOkKyO9zwUvMmYOHvWoiEJzJs8i1bqqU8Wd9YBkQXbvfo
         VOxPSi2GfQgKXC2yAGlFOPNhPnMHlmXnyNWIaMp++kSWcAzjWvhlE8YuDr/wBcQ7CqED
         sl5G26V1HAYlaRmtZgkGILlAR4YnskpB/Ko07q8+93kKGFW+8IOEM1bQLjv7PvfcCr5b
         wA/4Nw+byf3alaPTZ19Gjhbxa9zuo5aMdspJiAUww0TTeM7X9XTbEFGbqOkp7qEX1YWF
         YDMA==
X-Gm-Message-State: AOAM531Ab34bavqDaz3urUp0vZP7QGB3giH0NGemajIE2xkZFCZ9W5aa
        p4qycGW8BLOMuthg/8RX8c1VsA==
X-Google-Smtp-Source: ABdhPJySNFCXJXbLl9o36Cay9J7MFFMi1TQEERdA8BRRtVezfvM2q6zR0A1WuBqpto44qZZsEibwtg==
X-Received: by 2002:a17:902:e84e:b029:e6:cbe6:34b5 with SMTP id t14-20020a170902e84eb02900e6cbe634b5mr28799734plg.42.1617701217171;
        Tue, 06 Apr 2021 02:26:57 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w7sm13685589pff.208.2021.04.06.02.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:26:56 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v5 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
Date:   Tue,  6 Apr 2021 17:26:32 +0800
Message-Id: <20210406092634.50465-5-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406092634.50465-1-greentime.hu@sifive.com>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe host controller DT bindings of SiFive FU740.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 .../bindings/pci/sifive,fu740-pcie.yaml       | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
new file mode 100644
index 000000000000..b03cbb9b6602
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sifive,fu740-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive FU740 PCIe host controller
+
+description: |+
+  SiFive FU740 PCIe host controller is based on the Synopsys DesignWare
+  PCI core. It shares common features with the PCIe DesignWare core and
+  inherits common properties defined in
+  Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+maintainers:
+  - Paul Walmsley <paul.walmsley@sifive.com>
+  - Greentime Hu <greentime.hu@sifive.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: sifive,fu740-pcie
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: mgmt
+
+  num-lanes:
+    const: 8
+
+  msi-parent: true
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
+
+  resets:
+    description: A phandle to the PCIe power up reset line.
+    maxItems: 1
+
+  pwren-gpios:
+    description: Should specify the GPIO for controlling the PCI bus device power on.
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - dma-coherent
+  - num-lanes
+  - interrupts
+  - interrupt-names
+  - interrupt-parent
+  - interrupt-map-mask
+  - interrupt-map
+  - clock-names
+  - clocks
+  - resets
+  - pwren-gpios
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        #include <dt-bindings/clock/sifive-fu740-prci.h>
+
+        pcie@e00000000 {
+            compatible = "sifive,fu740-pcie";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            reg = <0xe 0x00000000 0x0 0x80000000>,
+                  <0xd 0xf0000000 0x0 0x10000000>,
+                  <0x0 0x100d0000 0x0 0x1000>;
+            reg-names = "dbi", "config", "mgmt";
+            device_type = "pci";
+            dma-coherent;
+            bus-range = <0x0 0xff>;
+            ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000>,      /* I/O */
+                     <0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000>,    /* mem */
+                     <0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000>,    /* mem */
+                     <0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
+            num-lanes = <0x8>;
+            interrupts = <56>, <57>, <58>, <59>, <60>, <61>, <62>, <63>, <64>;
+            interrupt-names = "msi", "inta", "intb", "intc", "intd";
+            interrupt-parent = <&plic0>;
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
+                            <0x0 0x0 0x0 0x2 &plic0 58>,
+                            <0x0 0x0 0x0 0x3 &plic0 59>,
+                            <0x0 0x0 0x0 0x4 &plic0 60>;
+            clock-names = "pcie_aux";
+            clocks = <&prci PRCI_CLK_PCIE_AUX>;
+            resets = <&prci 4>;
+            pwren-gpios = <&gpio 5 0>;
+            reset-gpios = <&gpio 8 0>;
+        };
+    };
-- 
2.30.2

