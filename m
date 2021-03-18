Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA133FF63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCRGJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhCRGIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:08:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:08:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k24so753940pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fSrevoybFbbsL26TSxrZpRYYrBRYxB21pxWqc/6RRUU=;
        b=C/Es5d4upGpMtvw6iLJ6YHD0hNfbTZr6yw7tNDk5X/Xe5qyDK6eK6OzBrwNhqOKuzh
         KSUw8CpafEfYIM8e9KsmRJ/vBesl0/61oQaE5V+nqnR+6QYLuUEYmQDGI4sRPYigMUe9
         vhUTUf3YM+6q2mHdVXC+cjUa17nuGfe7MB210ZRAaaT/G78suluEgFWo39Q0CkMe26ct
         s3Pf4pIQ2Vhl5v//jFQi0DoKLamm85P4+pg8ZmS112RB+0WZCEfblOenyhlmrLbb52wA
         d2EZMMdUmofzZ1xl+QMnfYrzm4Y9tDhOGHy3144lD+lFvJXo8knMNyZJ5oN+l2WLhs3T
         Y/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSrevoybFbbsL26TSxrZpRYYrBRYxB21pxWqc/6RRUU=;
        b=jv5A9KqbyO+WmCgk51r/qiG/Yc0GJTzfnV/nnA/4NaW165X9RhirlA4KZpXurwLnLJ
         19To7yWTJoVr1xJooisMXQVpiNARQcGX4zodiYi7DzbiMMGSITG35oC81LdjLEQvMFpv
         Jw9qvuXn0UfVWsjiYcUj3miJLNPTm0E1V1l8NgWWI7TabaBIdra6BlVgi/4oK+6uUK1F
         upOUwb5BMgyZ3w82zFBJ8D3TtXC9DXWy71x7mFA6Zz4/FWws2Aabqb0fq0zkJkknqe1S
         px8KgBoN5gQFr2lbyWiDS5S+shz/GhrDSv3D5F1FDZXwEO7mGInKokY1z8ql7fPjJJLU
         Z+0Q==
X-Gm-Message-State: AOAM533/HXxhkyDvHwhSO6XzMzPMwkgbFFDkQlGIKnl8PzYZguSuRSif
        WsoRzUrz27PsDMqKV3oaVzAyPg==
X-Google-Smtp-Source: ABdhPJxyBke2WbfVFJChIlEXKlnhNRVbDUTIX8VvrjnbRYdaYH0emxFFu3+K+tEHdW67z/GrE4FOUg==
X-Received: by 2002:a63:905:: with SMTP id 5mr5515276pgj.337.1616047723477;
        Wed, 17 Mar 2021 23:08:43 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 68sm967353pfd.75.2021.03.17.23.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:08:43 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: [PATCH v2 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
Date:   Thu, 18 Mar 2021 14:08:11 +0800
Message-Id: <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615954045.git.greentime.hu@sifive.com>
References: <cover.1615954045.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe host controller DT bindings of SiFive FU740.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 .../bindings/pci/sifive,fu740-pcie.yaml       | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
new file mode 100644
index 000000000000..c25a91b18cd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sifive,fu740-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive fu740 PCIe host controller
+
+description:
+  SiFive fu740 PCIe host controller is based on the Synopsys DesignWare
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
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: mgmt
+
+  device_type:
+    const: pci
+
+  dma-coherent:
+    description: Indicates that the PCIe IP block can ensure the coherency
+
+  bus-range:
+    description: Range of bus numbers associated with this controller.
+
+  num-lanes: true
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
+    description: A phandle to the PCIe power up reset line
+
+  pwren-gpios:
+    description: Should specify the GPIO for controlling the PCI bus device power on
+
+  perstn-gpios:
+    description: Should specify the GPIO for controlling the PCI bus device reset
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - device_type
+  - dma-coherent
+  - bus-range
+  - ranges
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
+  - perstn-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie@e00000000 {
+        #address-cells = <3>;
+        #interrupt-cells = <1>;
+        #size-cells = <2>;
+        compatible = "sifive,fu740-pcie";
+        reg = <0xe 0x00000000 0x1 0x0
+               0xd 0xf0000000 0x0 0x10000000
+               0x0 0x100d0000 0x0 0x1000>;
+        reg-names = "dbi", "config", "mgmt";
+        device_type = "pci";
+        dma-coherent;
+        bus-range = <0x0 0xff>;
+        ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000        /* I/O */
+                  0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000      /* mem */
+                  0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000      /* mem */
+                  0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
+        num-lanes = <0x8>;
+        interrupts = <56 57 58 59 60 61 62 63 64>;
+        interrupt-names = "msi", "inta", "intb", "intc", "intd";
+        interrupt-parent = <&plic0>;
+        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+        interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
+                        <0x0 0x0 0x0 0x2 &plic0 58>,
+                        <0x0 0x0 0x0 0x3 &plic0 59>,
+                        <0x0 0x0 0x0 0x4 &plic0 60>;
+        clock-names = "pcie_aux";
+        clocks = <&prci PRCI_CLK_PCIE_AUX>;
+        resets = <&prci 4>;
+        pwren-gpios = <&gpio 5 0>;
+        perstn-gpios = <&gpio 8 0>;
+    };
-- 
2.30.2

