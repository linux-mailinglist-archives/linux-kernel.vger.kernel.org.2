Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C7A348987
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCYGzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:55:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229629AbhCYGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:55:22 -0400
X-UUID: 8e26fe1a8cb547f7b3bbaa22c0ca7434-20210325
X-UUID: 8e26fe1a8cb547f7b3bbaa22c0ca7434-20210325
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 69018010; Thu, 25 Mar 2021 14:55:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 14:55:07 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 14:55:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Jie Qiu <jie.qiu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH RESEND v5 01/12] dt-bindings: phy: mediatek: dsi-phy: modify compatible dependence
Date:   Thu, 25 Mar 2021 14:54:47 +0800
Message-ID: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt7623-mipi-tx is compatible to mt2701-mipi-tx, and use
"mediatek,mt2701-mipi-tx" instead on MT7623, so modify
the compatible items to make dependence clear.

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v5: no changes
v4: add acked-by CK, and reviewed-by Rob
v3: modify commit message suggested by CK
v2: separate two patches suggested by CK
---
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
index 71d4acea1f66..6e4d795f9b02 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
@@ -19,11 +19,14 @@ properties:
     pattern: "^dsi-phy@[0-9a-f]+$"
 
   compatible:
-    enum:
-      - mediatek,mt2701-mipi-tx
-      - mediatek,mt7623-mipi-tx
-      - mediatek,mt8173-mipi-tx
-      - mediatek,mt8183-mipi-tx
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt7623-mipi-tx
+          - const: mediatek,mt2701-mipi-tx
+      - const: mediatek,mt2701-mipi-tx
+      - const: mediatek,mt8173-mipi-tx
+      - const: mediatek,mt8183-mipi-tx
 
   reg:
     maxItems: 1
-- 
2.18.0

