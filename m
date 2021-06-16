Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ECB3A9972
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFPLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:46:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60757 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232512AbhFPLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:46:28 -0400
X-UUID: c3582cda440a4b91921dbf6692de4044-20210616
X-UUID: c3582cda440a4b91921dbf6692de4044-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 600057304; Wed, 16 Jun 2021 19:44:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 19:44:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 19:44:16 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>
Subject: [PATCH 2/9] dt-bindings: memory: mediatek: Add mt8195 smi sub common
Date:   Wed, 16 Jun 2021 19:43:39 +0800
Message-ID: <20210616114346.18812-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616114346.18812-1-yong.wu@mediatek.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding for smi-sub-common. The SMI block diagram
like this:

        IOMMU
         |  |
      smi-common
  ------------------
  |      ....      |
 larb0           larb7   <-max is 8

The smi-common connects with smi-larb and IOMMU. The maximum larbs number
that connects with a smi-common is 8. If the engines number is over 8,
sometimes we use a smi-sub-common which is nearly same with smi-common.
It supports up to 8 input and 1 output(smi-common has 2 output)

Something like:

        IOMMU
         |  |
      smi-common
  ---------------------
  |      |          ...
larb0  sub-common   ...   <-max is 8
      -----------
       |    |    ...   <-max is 8 too.
     larb2 larb5

We don't need extra SW setting for smi-sub-common, only the sub-common has
special clocks need to enable when the engines access dram.

If it is sub-common, it should have a "mediatek,smi" phandle to point to
its smi-common. also, the sub-common only has one gals clock.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../mediatek,smi-common.yaml                  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 6317025bd203..11515afdfb2e 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -38,6 +38,7 @@ properties:
           - mediatek,mt8192-smi-common
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
+          - mediatek,mt8195-smi-sub-common
 
       - description: for mt7623
         items:
@@ -69,6 +70,10 @@ properties:
     minItems: 2
     maxItems: 4
 
+  mediatek,smi:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: a phandle to the smi-common node above. Only for sub-common.
+
 required:
   - compatible
   - reg
@@ -95,6 +100,26 @@ allOf:
             - const: smi
             - const: async
 
+  - if:  # only for sub common
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8195-smi-sub-common
+    then:
+      required:
+        - mediatek,smi
+      properties:
+        clock:
+          items:
+            minItems: 3
+            maxItems: 3
+        clock-names:
+          items:
+            - const: apb
+            - const: smi
+            - const: gals0
+
   - if:  # for gen2 HW that have gals
       properties:
         compatible:
-- 
2.18.0

