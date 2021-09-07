Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEB402548
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbhIGIk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbhIGIkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:40:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F78C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:39:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n5so13201080wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tmdXYabHBlH0lzTR2aGEg4jjkPTidI1mG07cS/MQyTc=;
        b=b3dS4AUF3x8YJP0MHj9VQNJzu+5FaEBv2n1zRCv3YXmTXTkGkm+SQIVEeNELn0Ckbi
         S6aAexEhIXCCSetvenP4sRLVOQiZZPluj+9Tojdmc/XdQPToUkLX+WhtHtZqAsVToK9R
         PKS1wKnI7TIigejl8kDKT2AWgebp9s5WaMQTkWEHQRfGdtdh4UcGYFD4jHuJ1p71coHa
         El4whTjb3Qj8bHoRpMKmQp7CWpUgqYCHlI+wSwN/zANsgburryHCFv55vYf0q0eEqDjp
         rl/pSLdm4qvpRm9QMmkWJvbHVa00DnEaeRUnLyeeARI7qWzXs+uKnJIZxrxC9dxXW99j
         qnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tmdXYabHBlH0lzTR2aGEg4jjkPTidI1mG07cS/MQyTc=;
        b=QktrtdcfQGw041ugA8O5Eh5ZgjSxDDkAZoPO2uSxoiHiyV0s85SUV/0L+/TFOu3B5L
         5fBsfahUwc146cxWOIa7MvFJpEhHdiKMivjr5Q5i6b3Wc60m+efsiG8ihbk4ri/YB2Or
         4LIrbJNz1rqeI/eJT6oAQlwZTXZnxxd4e/bq2XNGSSKxnYSQwC9mBH3YI9KhhiBy9KAs
         EN1OwB2Km2/Z+aMvSjkl+5G2xTV9Lvv6X781BY7OxY796ldl1+J75/3r/FeRsUQemF05
         QSUJz8FdKIzAyBNNmDnBjkWj3RSviniCr/5txV4btPZ5M5kbU0qh+5QB1FoDE/bFBZF3
         kEWg==
X-Gm-Message-State: AOAM532wOQ3wgAAwOg+8VfRTdEaGxCdqefbOzUULlNWTYUXZeiaDz8WG
        rmxxkErKIDARWqGsYsnj9ZH04Q==
X-Google-Smtp-Source: ABdhPJyDgiMvPKHxYxRk/TRfiki81RSVnZoaBVGMlrlfdZYclA0TZPFkDpfqZUikhceozNhYswoUCA==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr17418975wre.26.1631003979019;
        Tue, 07 Sep 2021 01:39:39 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-3317-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6141:3317:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id m186sm1737027wme.48.2021.09.07.01.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:39:38 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH 4/4] dt-bindings: display: mediatek: add MT8195 hdmi bindings
Date:   Tue,  7 Sep 2021 10:37:21 +0200
Message-Id: <20210907083723.7725-5-granquet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210907083723.7725-1-granquet@baylibre.com>
References: <20210907083723.7725-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mediatek HDMI and HDMI-DDC bindings for MT8195 SoC.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 46 +++++++++
 .../mediatek/mediatek,mt8195-hdmi.yaml        | 99 +++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
new file mode 100644
index 000000000000..ae3cc0ae457f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
@@ -0,0 +1,46 @@
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
+    #include <dt-bindings/clock/mt8195-clk.h>
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
index 000000000000..b5d5f7f79c71
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
@@ -0,0 +1,99 @@
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
+      - description: HDMI clock for vpp_split module
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
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    hdmi0: hdmi@1c300000 {
+      compatible = "mediatek,mt8195-hdmi";
+      reg = <0 0x1c300000 0 0x1000>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_HDMI_TX>;
+      clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D4>,
+             <&topckgen CLK_TOP_MSDCPLL_D2>,
+             <&topckgen CLK_TOP_HDMI_APB>,
+             <&topckgen CLK_TOP_UNIVPLL_D4_D8>,
+             <&topckgen CLK_TOP_HDCP>,
+             <&topckgen CLK_TOP_HDCP_24M>,
+             <&vppsys1 CLK_VPP1_VPP_SPLIT_HDMI>;
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
+      cec = <&cec>;
+      ddc-i2c-bus = <&hdmiddc0>;
+      status = "disabled";
+    };
+
+...
-- 
2.31.1

