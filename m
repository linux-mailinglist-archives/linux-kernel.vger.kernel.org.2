Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B677F34582F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCWHDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:03:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40127 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230027AbhCWHDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:03:17 -0400
X-UUID: 55823da1ace9481ab4d84e11ee78ea42-20210323
X-UUID: 55823da1ace9481ab4d84e11ee78ea42-20210323
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 236312453; Tue, 23 Mar 2021 15:03:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 15:03:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 15:03:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 03/13] dt-bindings: usb: mtu3: support wakeup for mt8183 and mt8192
Date:   Tue, 23 Mar 2021 15:02:45 +0800
Message-ID: <1616482975-17841-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 06083E03F698BB93F8CDF59FEEB148AB30D0C063C14A9DD0834AC0CEE057678F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two HW of wakeup don't follow MediaTek internal IPM rule,
and both use a specific way, like as early revision of mt8173.

Due to the index 2 already used by many DTS, it's better to keep
it unchanged for backward compatibility, treat specific ones without
following IPM rule as revision 1.x, meanwhile reserve 3~99 for
later revision that following the IPM rule.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: modify revision format
---
 .../devicetree/bindings/usb/mediatek,mtu3.yaml         | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index f5c04b9d2de9..8e37403520ff 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt2712-mtu3
           - mediatek,mt8173-mtu3
           - mediatek,mt8183-mtu3
+          - mediatek,mt8192-mtu3
       - const: mediatek,mtu3
 
   reg:
@@ -152,10 +153,13 @@ properties:
         - description:
             The second cell represents the register base address of the glue
             layer in syscon
-        - description:
+        - description: |
             The third cell represents the hardware version of the glue layer,
-            1 is used by mt8173 etc, 2 is used by mt2712 etc
-          enum: [1, 2]
+            1 - used by mt8173 etc, revision 1 without following IPM rule;
+            2 - used by mt2712 etc, revision 2 with following IPM rule;
+            101 - used by mt8183, specific 1.01;
+            102 - used by mt8192, specific 1.02;
+          enum: [1, 2, 101, 102]
 
   mediatek,u3p-dis-msk:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.18.0

