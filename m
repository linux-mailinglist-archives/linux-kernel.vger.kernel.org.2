Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E403B7B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhF3CiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:38:14 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33572 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232009AbhF3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:38:08 -0400
X-UUID: bb68e647902745cc82e25a7cd7b47ca0-20210630
X-UUID: bb68e647902745cc82e25a7cd7b47ca0-20210630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 337488588; Wed, 30 Jun 2021 10:35:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:35:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:35:34 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH 02/24] dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
Date:   Wed, 30 Jun 2021 10:34:42 +0800
Message-ID: <20210630023504.18177-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mt8195, we have a new IOMMU that is for INFRA IOMMU. its masters
mainly are PCIe and USB. Different with MM IOMMU, all these masters
connect with IOMMU directly, there is no mediatek,larbs property for
infra IOMMU.

Another thing is about PCIe ports. currently the function
"of_iommu_configure_dev_id" only support the id number is 1, But our
PCIe have two ports, one is for reading and the other is for writing.
see more about the PCIe patch in this patchset. Thus, I only list
the reading id here and add the other id in our driver.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../bindings/iommu/mediatek,iommu.yaml         | 14 +++++++++++++-
 .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
 include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 9b04630158c8..6f3ff631c06b 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -79,6 +79,7 @@ properties:
           - mediatek,mt8192-m4u  # generation two
           - mediatek,mt8195-iommu-vdo        # generation two
           - mediatek,mt8195-iommu-vpp        # generation two
+          - mediatek,mt8195-iommu-infra      # generation two
 
       - description: mt7623 generation one
         items:
@@ -129,7 +130,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - mediatek,larbs
   - '#iommu-cells'
 
 allOf:
@@ -161,6 +161,18 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      not:
+        properties:
+          compatible:
+            items:
+              enum:
+                - mediatek,mt8195-iommu-infra
+
+    then:
+      required:
+        - mediatek,larbs
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/memory/mt8195-memory-port.h b/include/dt-bindings/memory/mt8195-memory-port.h
index 783bcae8cdea..67afad848725 100644
--- a/include/dt-bindings/memory/mt8195-memory-port.h
+++ b/include/dt-bindings/memory/mt8195-memory-port.h
@@ -387,4 +387,22 @@
 #define M4U_PORT_L28_CAM_DRZS4NO_R1		MTK_M4U_ID(28, 5)
 #define M4U_PORT_L28_CAM_TNCSO_R1		MTK_M4U_ID(28, 6)
 
+/* infra iommu ports */
+/* PCIe1: read: BIT16; write BIT17. */
+#define M4U_PORT_INFRA_PCIE1			MTK_IFAIOMMU_PERI_ID(16)
+/* PCIe0: read: BIT18; write BIT19. */
+#define M4U_PORT_INFRA_PCIE0			MTK_IFAIOMMU_PERI_ID(18)
+#define M4U_PORT_INFRA_SSUSB_P3_R		MTK_IFAIOMMU_PERI_ID(20)
+#define M4U_PORT_INFRA_SSUSB_P3_W		MTK_IFAIOMMU_PERI_ID(21)
+#define M4U_PORT_INFRA_SSUSB_P2_R		MTK_IFAIOMMU_PERI_ID(22)
+#define M4U_PORT_INFRA_SSUSB_P2_W		MTK_IFAIOMMU_PERI_ID(23)
+#define M4U_PORT_INFRA_SSUSB_P1_1_R		MTK_IFAIOMMU_PERI_ID(24)
+#define M4U_PORT_INFRA_SSUSB_P1_1_W		MTK_IFAIOMMU_PERI_ID(25)
+#define M4U_PORT_INFRA_SSUSB_P1_0_R		MTK_IFAIOMMU_PERI_ID(26)
+#define M4U_PORT_INFRA_SSUSB_P1_0_W		MTK_IFAIOMMU_PERI_ID(27)
+#define M4U_PORT_INFRA_SSUSB2_R			MTK_IFAIOMMU_PERI_ID(28)
+#define M4U_PORT_INFRA_SSUSB2_W			MTK_IFAIOMMU_PERI_ID(29)
+#define M4U_PORT_INFRA_SSUSB_R			MTK_IFAIOMMU_PERI_ID(30)
+#define M4U_PORT_INFRA_SSUSB_W			MTK_IFAIOMMU_PERI_ID(31)
+
 #endif
diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
index 7d64103209af..2f68a0511a25 100644
--- a/include/dt-bindings/memory/mtk-memory-port.h
+++ b/include/dt-bindings/memory/mtk-memory-port.h
@@ -12,4 +12,6 @@
 #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
+#define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
+
 #endif
-- 
2.18.0

