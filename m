Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F6F3E431F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhHIJtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:49:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42162 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234712AbhHIJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:49:24 -0400
X-UUID: 4f5e425ed26043d0a2c43cc4a68fba75-20210809
X-UUID: 4f5e425ed26043d0a2c43cc4a68fba75-20210809
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1248555971; Mon, 09 Aug 2021 17:49:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Aug 2021 17:49:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Aug 2021 17:49:00 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <bicycle.tsai@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <cychiang@google.com>, <aaronyu@google.com>, <wenst@chromium.org>
Subject: [PATCH v3 9/9] dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1019-rt5682 document
Date:   Mon, 9 Aug 2021 17:48:55 +0800
Message-ID: <20210809094855.7169-10-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210809094855.7169-1-trevor.wu@mediatek.com>
References: <20210809094855.7169-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds document for mt8195 board with mt6359, rt1019 and rt5682

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../sound/mt8195-mt6359-rt1019-rt5682.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml

diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
new file mode 100644
index 000000000000..246c0875e64e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mt8195-mt6359-rt1019-rt5682.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8195 with MT6359, RT1019 and RT5682 ASoC sound card driver
+
+maintainers:
+  - Trevor Wu <trevor.wu@mediatek.com>
+
+description:
+  This binding describes the MT8195 sound card.
+
+properties:
+  compatible:
+    const: mediatek,mt8195_mt6359_rt1019_rt5682
+
+  mediatek,platform:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of MT8195 ASoC platform.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,platform
+
+examples:
+  - |
+
+    sound: mt8195-sound {
+        compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
+        mediatek,platform = <&afe>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&aud_pins_default>;
+    };
+
+...
-- 
2.18.0

