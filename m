Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD6359798
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhDIIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:20:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39385 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231611AbhDIIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:20:37 -0400
X-UUID: d5b6e4a5aca54aa38118c75fc61802f2-20210409
X-UUID: d5b6e4a5aca54aa38118c75fc61802f2-20210409
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 930740884; Fri, 09 Apr 2021 16:20:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 16:20:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 16:20:18 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nina Wu <Nina-CM.Wu@mediatek.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Subject: [PATCH v3 1/7] dt-bindings: devapc: Add 'vio-idx-num' field to support mt8192
Date:   Fri, 9 Apr 2021 16:19:31 +0800
Message-ID: <1617956377-4075-1-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 73CB98C62DCD7260EB51A402196B55563D4216F2B513B41DCC7713FF2CF616D52000:8
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

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/devapc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
index 31e4d3c..909e524 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
@@ -20,11 +20,17 @@ properties:
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
+    maxItems: 1
+
   interrupts:
     description: A single interrupt specifier
     maxItems: 1
-- 
2.6.4

