Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9D402546
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbhIGIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242835AbhIGIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:40:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C92C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:39:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n5so13200838wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oz+Hr4rbZnT8MxqfF16y/QcdvWXwOuV/sANx8R9T0v0=;
        b=ttURaYZ3GOJrLfiRPVgP6FVt1sTn4/VjQ3JvUq4LS0dEDBsGsWxw1syT5yrRjMnusR
         ZXTp0q+DB+1ZHvy/fjom9NJV7cJBn7L8Ylqgw1rEmRCYk9Vr/pclGjEWmJNe48UmpO6F
         9Pilf3J37Uac9vF59TO/60Icd3P39suwl9BO6BfWJVRH0tXmh8/kk/6r6st0fVhySvuL
         F4rVlFtvAJxLrMO5rFu0DBikqxvljKrHI8Ia4r6FDoUoD1DJGMm7+A/M4IILsWtix8oF
         DZwIn2pd4TxcA1gjAvH0QkKcsr/5ovIJHsVgK35NoqpYrBp+6eJ6qbCHYSoykacMlB6D
         paHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oz+Hr4rbZnT8MxqfF16y/QcdvWXwOuV/sANx8R9T0v0=;
        b=fEr+s9EdnZTvyJzTyUreNFtzOoxYmfw1iSv2zXGA1CW3tdq4CwChioOrcdjehitx7b
         exZhsGE9tU8knFgbfRLoFnlzbpdzvh4pZLljVqIVSinTh8mG9QHQrjkPE89A2YUIgExU
         K/ebqdBB7Ym//0zuGUR7eOFw0hmUU8BOvdi1NNswSD/BDA6Y3H6HWGBZGF3hjvH+b2LF
         g19F+loDuj2wCIShp9I0VBsF4UON0GNGQQWpnT3gxBwBaaSF3ffXDJUS46rvqK3qCoCu
         Go6LV2t/2QxQAotqEHwCezjICEAXLeaJN5WRxWrtI/Kq+1Ke/tQi7r+3Cw4GsdGbJkMi
         mdbw==
X-Gm-Message-State: AOAM532CS6Q64zyR3VnoJEPUYQg2n3dpVICPSiGqMKqyeLnllRN4MMn2
        8AkYCyhpJREjQrtf6g4vQBAFeQ==
X-Google-Smtp-Source: ABdhPJzoBZMmsSD6ztdMvt5juS04ZdEQi35jGlbPEby6MJaVuXCnGNXgqWHtQvmCP6Ssf+r4FgiM4Q==
X-Received: by 2002:adf:de8f:: with SMTP id w15mr17787801wrl.277.1631003975036;
        Tue, 07 Sep 2021 01:39:35 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-3317-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6141:3317:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id m186sm1737027wme.48.2021.09.07.01.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:39:34 -0700 (PDT)
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
Subject: [PATCH 3/4] dt-bindings: phy: Add binding for Mediatek MT8195 HDMI PHY
Date:   Tue,  7 Sep 2021 10:37:20 +0200
Message-Id: <20210907083723.7725-4-granquet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210907083723.7725-1-granquet@baylibre.com>
References: <20210907083723.7725-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe Mediatek MT8195 HDMI PHY

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../phy/mediatek,mtk8195-hdmi-phy.yaml        | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml
new file mode 100644
index 000000000000..f03bd3af7fd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 MediaTek
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek High Definition Multimedia Interface (HDMI) PHY binding for mt8195
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+  - Chunfeng Yun <chunfeng.yun@mediatek.com>
+
+description: |
+  The HDMI PHY serializes the HDMI encoder's three channel 10-bit parallel
+  output and drives the HDMI pads.
+
+properties:
+  $nodename:
+    pattern: "^hdmi-phy@[0-9a-f]+$"
+
+  compatible:
+    - const: mediatek,mt8195-hdmi-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PLL reference clock
+
+  clock-names:
+    items:
+      - const: hdmi_xtal_sel
+
+  clock-output-names:
+    items:
+      - const: hdmi_txpll
+
+  "#phy-cells":
+    const: 0
+
+  "#clock-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-output-names
+  - "#phy-cells"
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    hdmi_phy: hdmi-phy@11d5f000 {
+        compatible = "mediatek,mt8195-hdmi-phy";
+        reg = <0 0x11d5f000 0 0x100>;
+        clocks = <&topckgen CLK_TOP_HDMI_XTAL>;
+        clock-names = "hdmi_xtal_sel";
+        clock-output-names = "hdmi_txpll";
+        #clock-cells = <0>;
+        #phy-cells = <0>;
+    };
+
+...
-- 
2.31.1

