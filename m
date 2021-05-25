Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EDE38FA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhEYFy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:54:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55346 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230218AbhEYFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:54:57 -0400
X-UUID: df01a852024a41bb85a78c05ad220b1b-20210525
X-UUID: df01a852024a41bb85a78c05ad220b1b-20210525
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 92647660; Tue, 25 May 2021 13:53:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 13:53:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 13:53:14 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Nina Wu <Nina-CM.Wu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 1/7] dt-bindings: devapc: Add 'vio-idx-num' field to support mt8192
Date:   Tue, 25 May 2021 13:53:00 +0800
Message-ID: <1621921986-20578-1-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

For new ICs, there are multiple devapc HWs for different subsys.
We add a field 'vio-idx-num' in DT to indicate the number of
devices controlled by each devapc.
To be backward compatible with old ICs which have only one devapc
HW, this field is not required. The 'vio-idx-num' info will be set
in compatible data instead.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/devapc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
index 31e4d3c..69abd03 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
@@ -20,11 +20,16 @@ properties:
   compatible:
     enum:
       - mediatek,mt6779-devapc
+      - mediatek,mt8192-devapc
 
   reg:
     description: The base address of devapc register bank
     maxItems: 1
 
+  mediatek,vio-idx-num:
+    description: The number of the devices controlled by devapc
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   interrupts:
     description: A single interrupt specifier
     maxItems: 1
-- 
2.6.4

