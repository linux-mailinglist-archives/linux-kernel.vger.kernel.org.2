Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D043E54D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhHJILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:11:35 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38552 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238003AbhHJIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:09:55 -0400
X-UUID: d19785ffb2154aa7b60ca584f1cb7e3f-20210810
X-UUID: d19785ffb2154aa7b60ca584f1cb7e3f-20210810
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1123762852; Tue, 10 Aug 2021 16:09:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:09:29 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:09:28 +0800
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
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v3 02/13] dt-bindings: memory: mediatek: Add mt8195 smi sub common
Date:   Tue, 10 Aug 2021 16:08:48 +0800
Message-ID: <20210810080859.29511-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding for smi-sub-common. The SMI block diagram like this:

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
its smi-common. meanwhile the sub-common only has one gals clock.

Additionally, add a new property "mediatek,smi_sub_common" for this
sub-common, this is needed in the IOMMU driver in which we create a device
link between smi-common and the IOMMU device. If we add the smi-sub-common
here, the IOMMU driver still need to find the smi-common device. thus,
add this bool property to indicate if it is sub-common.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
change note:
a. change mediatek, smi type from phandle-array to phandle from Rob.
b. Add a new bool property (mediatek,smi_sub_common) to indicate this is
   smi-sub-common. the reason is as above.
---
 .../mediatek,smi-common.yaml                  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 602592b6c3f5..26bb9903864b 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -38,6 +38,7 @@ properties:
           - mediatek,mt8192-smi-common
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
+          - mediatek,mt8195-smi-sub-common
 
       - description: for mt7623
         items:
@@ -67,6 +68,14 @@ properties:
     minItems: 2
     maxItems: 4
 
+  mediatek,smi:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the smi-common node above. Only for sub-common.
+
+  mediatek,smi_sub_common:
+    type: boolean
+    description: Indicate if this is smi-sub-common.
+
 required:
   - compatible
   - reg
@@ -93,6 +102,27 @@ allOf:
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
+        - mediatek,smi_sub_common
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

