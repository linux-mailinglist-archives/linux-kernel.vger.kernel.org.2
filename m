Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA4F3E54D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhHJIKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:10:10 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38296 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237998AbhHJIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:09:45 -0400
X-UUID: 07a1e378b886474ca18a1156777111ee-20210810
X-UUID: 07a1e378b886474ca18a1156777111ee-20210810
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1973722585; Tue, 10 Aug 2021 16:09:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:09:18 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:09:17 +0800
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
Subject: [PATCH v3 01/13] dt-bindings: memory: mediatek: Add mt8195 smi binding
Date:   Tue, 10 Aug 2021 16:08:47 +0800
Message-ID: <20210810080859.29511-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8195 smi supporting in the bindings.

In mt8195, there are two smi-common HW, one is for vdo(video output),
the other is for vpp(video processing pipe). They connect with different
smi-larbs, then some setting(bus_sel) is different. Differentiate them
with the compatible string.

Something like this:

    IOMMU(VDO)          IOMMU(VPP)
       |                   |
 SMI_COMMON_VDO      SMI_COMMON_VPP
 ----------------     ----------------
  |      |   ...      |      |     ...
larb0 larb2  ...    larb1 larb3    ...

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 +++++-
 .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index e87e4382807c..602592b6c3f5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -16,7 +16,7 @@ description: |
   MediaTek SMI have two generations of HW architecture, here is the list
   which generation the SoCs use:
   generation 1: mt2701 and mt7623.
-  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183 and mt8192.
+  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183, mt8192 and mt8195.
 
   There's slight differences between the two SMI, for generation 2, the
   register which control the iommu port is at each larb's register base. But
@@ -36,6 +36,8 @@ properties:
           - mediatek,mt8173-smi-common
           - mediatek,mt8183-smi-common
           - mediatek,mt8192-smi-common
+          - mediatek,mt8195-smi-common-vdo
+          - mediatek,mt8195-smi-common-vpp
 
       - description: for mt7623
         items:
@@ -98,6 +100,8 @@ allOf:
             - mediatek,mt6779-smi-common
             - mediatek,mt8183-smi-common
             - mediatek,mt8192-smi-common
+            - mediatek,mt8195-smi-common-vdo
+            - mediatek,mt8195-smi-common-vpp
 
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 2353f6cf3c80..eaeff1ada7f8 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt8173-smi-larb
           - mediatek,mt8183-smi-larb
           - mediatek,mt8192-smi-larb
+          - mediatek,mt8195-smi-larb
 
       - description: for mt7623
         items:
@@ -74,6 +75,7 @@ allOf:
         compatible:
           enum:
             - mediatek,mt8183-smi-larb
+            - mediatek,mt8195-smi-larb
 
     then:
       properties:
@@ -108,6 +110,7 @@ allOf:
               - mediatek,mt6779-smi-larb
               - mediatek,mt8167-smi-larb
               - mediatek,mt8192-smi-larb
+              - mediatek,mt8195-smi-larb
 
     then:
       required:
-- 
2.18.0

