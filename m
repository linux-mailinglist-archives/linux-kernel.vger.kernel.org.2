Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA9B41C1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbhI2Jsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245119AbhI2Jsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:48:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:46:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h15so1576649wrc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mwf1tKg1O0N4TdrAHDKMubF2cwo9nO/+84LsL8mnCUg=;
        b=EK96bY45esZeXSedAHzaXDD/97/7pEB2Ec1TlsHkD4e2go+rNg577bZ5PJAlUIs8B8
         Z4y3LZ20BMQVmfHNXRs6g0vcBiWN4UKZmhwOdo6RtykBus9rnfXCaSE9T24hiQkl1EEr
         yJgqKcJt7e7de39HZ2lYtpadF7nlHmpY3L80X6rrkKPN24WXcn/nhd2WIrTgnqr56fcM
         QK5AnjWaxg2zsBY2b9VWuqGOia+Dw5QJyMekFjYA2pkai8W+s8SaLSSaY3x/JMnTAU09
         BK/PyPJW5gXZGNkWjB2eG+1TJNOlZxYvW1YmkSPj4ceLchjcwfrdxGe5svJcVLdteN3w
         zTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mwf1tKg1O0N4TdrAHDKMubF2cwo9nO/+84LsL8mnCUg=;
        b=kT/xe4tHROTLD3qi4tM1YPXTpl9aFR+WyQqH0DIVDUCsu9yAGozYx4KxT3Op6kPQFA
         5KFLEIbFQLicKOMnZA/3OkOaMhC/6foxNb3wXd6vLcABM6rJhZlE/eGRyWE24R923s+5
         pDa70zIPLh/lp0qgPWOBxOB/jA9QsE4y4NvtOSvF4hT/b8MsXJGCOBEsrguV8YdtKVJs
         ruqCq3FxkdrDzXuFOrg39z87NitSihoxWJ/D7uAYYKZyjE3kpDnPd5iDAjFVX4lnRNEJ
         FDv8Oz7VigebbGo3pTItDwEEcWXPgDO5j7g1xTmZ6/nb3Bgtw5AHp5qqdgxTSEXcsAHP
         qHKg==
X-Gm-Message-State: AOAM531VewcdDhHYZPjTtNpayq77/3JAkkni/aU4BFV6R3Z6HwsvVZco
        MKLGRers4qexckezvS1xQ44bnA==
X-Google-Smtp-Source: ABdhPJxCZB5y9/24ZxId/CvDAmaWQ9JH8Sym9cvk3b1JSHbLkJIcqxj5WU+LObOEzlSfu8A5xUrM5g==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr5521254wrd.31.1632908814812;
        Wed, 29 Sep 2021 02:46:54 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-2cf3-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6240:2cf3:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id h7sm1751938wrx.14.2021.09.29.02.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 02:46:54 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] dt-bindings: display: mediatek: add MT8195 hdmi bindings
Date:   Wed, 29 Sep 2021 11:44:23 +0200
Message-Id: <20210929094425.745-3-granquet@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210929094425.745-1-granquet@baylibre.com>
References: <20210929094425.745-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mediatek HDMI and HDMI-DDC bindings for MT8195 SoC.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 45 +++++++++
 .../mediatek/mediatek,mt8195-hdmi.yaml        | 98 +++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
new file mode 100644
index 0000000000000..3c80bcebe6d30
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek HDMI DDC Device Tree Bindings for mt8195
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  The HDMI DDC i2c controller is used to interface with the HDMI DDC pins.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-hdmi-ddc
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ddc-i2c
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    hdmiddc0: ddc_i2c {
+      compatible = "mediatek,mt8195-hdmi-ddc";
+      clocks = <&clk26m>;
+      clock-names = "ddc-i2c";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
new file mode 100644
index 0000000000000..17e542809a4e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek HDMI Encoder Device Tree Bindings for mt8195
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  The Mediatek HDMI encoder can generate HDMI 1.4a or MHL 2.0 signals from
+  its parallel input.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-hdmi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PLL divider
+      - description: PLL divider
+      - description: HDCP engine clock
+      - description: PLL divider
+      - description: HDCP engine clock
+      - description: Bus clock
+      - description: Clock for splitting HDMI/DGI into two pipes
+
+  clock-names:
+    items:
+      - const: univpll_d6_d4
+      - const: msdcpll_d2
+      - const: hdmi_apb_sel
+      - const: univpll_d4_d8
+      - const: hdcp_sel
+      - const: hdcp24_sel
+      - const: split_hdmi
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: hdmi
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - ddc-i2c-bus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    hdmi0: hdmi@1c300000 {
+      compatible = "mediatek,mt8195-hdmi";
+      reg = <0 0x1c300000 0 0x1000>;
+      power-domains = <&spm 25>;
+      clocks = <&topckgen 153>,
+             <&topckgen 86>,
+             <&topckgen 78>,
+             <&topckgen 146>,
+             <&topckgen 73>,
+             <&topckgen 74>,
+             <&vppsys1 44>;
+      clock-names = "univpll_d6_d4",
+        "msdcpll_d2",
+        "hdmi_apb_sel",
+        "univpll_d4_d8",
+        "hdcp_sel",
+        "hdcp24_sel",
+        "split_hdmi";
+      interrupts = <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH 0>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&hdmi_pin>;
+      phys = <&hdmi_phy>;
+      phy-names = "hdmi";
+      ddc-i2c-bus = <&hdmiddc0>;
+      status = "disabled";
+    };
+
+...
-- 
2.32.0

