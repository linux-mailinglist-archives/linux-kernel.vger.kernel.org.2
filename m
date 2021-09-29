Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB06B41C1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbhI2Jsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245119AbhI2Jsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:48:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D85C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:46:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s21so3174027wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TEsDRiyoS/4OSMn47r8BWf1M3rX4YjYUeKvcYaH4Lw=;
        b=N4Ij3KaqTN6lCzIHUNYiS0hXtG8BxP1YsyVEsbtdMh6naQw4xDybUjSQ0smteyfRFr
         h7i1lbPa5OCh5a0YSiwTRNgVYTWKurZw+xYghnggMg12SDdOfrcl9CpryfDAbYVTvJpY
         UGcfcp3pOIUbR1iyB+MmXbIz311XBBD4gq78zZA5wTsGRooYXf1ZDkDziGKUiV6cdhSk
         4ItFnGUVtxgdDiO+dqt8vIwANMVY5MgNL8nGEZCtBj96TX2MdxS22PBGr28/C9RtOKAs
         h9bUR9ZYCvJNgwvUKFn4dLcqQ+TxAVei/ilUgtWEltJL340kzv2/rY04SB1Kt+r6Ro3m
         DppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TEsDRiyoS/4OSMn47r8BWf1M3rX4YjYUeKvcYaH4Lw=;
        b=F6LsWbyZQfWjqgHfvsCDdgHf6/BugHtnnKKfryERQEa/r3ob9kZRBpC4O+e4Qbm+Fu
         ia+rMuIlewgLmo0GdNILEnza+tw/a7tqAw2esjZjqKz1JqK4W1vHRBAMBDnTOqihWn5Z
         oT/8dK8rjtAA1YY56wfhTra+rWR3xpz+tIGdgHf+Qu/5ymXtA8x2DQY8JMLqhIihy6ZM
         qUpERXUFO6W7gudVuH/EWcg5dFbHXiknXdG0SXe3mB7Jy0jDTLXsfpmTqcVaTWDO6K+c
         Nac+1H5LvrCE//RJGn7VH7zG4nHjXmiHACUJGzy/5u92eOxOi9MZw/DcwVhA9n1o79Cr
         npJw==
X-Gm-Message-State: AOAM532CGepemos7YwtEFfNXrjdheKUCIMXJ7oiVvsUMt7rX8JkCY9Rl
        z8PylEdwXZj4ZmjAwuZk9xmhLQ==
X-Google-Smtp-Source: ABdhPJxoWBasUJskF/U8ajOUDOopKjdiX2cNUcJ5NjEaYxV81lHoLSDmAM6EpXMdEzCh/pwDTEXw7A==
X-Received: by 2002:adf:a115:: with SMTP id o21mr1617016wro.208.1632908813085;
        Wed, 29 Sep 2021 02:46:53 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-2cf3-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6240:2cf3:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id h7sm1751938wrx.14.2021.09.29.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 02:46:52 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: phy: Add binding for Mediatek MT8195 HDMI PHY
Date:   Wed, 29 Sep 2021 11:44:22 +0200
Message-Id: <20210929094425.745-2-granquet@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210929094425.745-1-granquet@baylibre.com>
References: <20210929094425.745-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe Mediatek MT8195 HDMI PHY

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../phy/mediatek,mtk8195-hdmi-phy.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml
new file mode 100644
index 0000000000000..6b39bb8c9dfe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml
@@ -0,0 +1,70 @@
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
+    hdmi_phy: hdmi-phy@11d5f000 {
+        compatible = "mediatek,mt8195-hdmi-phy";
+        reg = <0 0x11d5f000 0 0x100>;
+        clocks = <&topckgen 77>;
+        clock-names = "hdmi_xtal_sel";
+        clock-output-names = "hdmi_txpll";
+        #clock-cells = <0>;
+        #phy-cells = <0>;
+    };
+
+...
-- 
2.32.0

