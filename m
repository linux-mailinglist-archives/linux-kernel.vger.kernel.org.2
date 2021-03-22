Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC09343748
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCVDOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:14:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45001 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229913AbhCVDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:14:03 -0400
X-UUID: 2b3d2160428f49918e588b65ff497329-20210322
X-UUID: 2b3d2160428f49918e588b65ff497329-20210322
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2147084606; Mon, 22 Mar 2021 11:13:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 11:13:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Mar 2021 11:13:53 +0800
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
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 02/13] dt-bindings: usb: mtk-xhci: add support wakeup for mt8183 and mt8192
Date:   Mon, 22 Mar 2021 11:13:41 +0800
Message-ID: <1616382832-28450-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1616382832-28450-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1616382832-28450-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 34153F5F572804E4BA4416630BBBB5E2DDE0C15BC5A42487ABD1F0C1697A794D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two HW of wakeup don't follow MediaTek internal IPM rule,
both use a specific way, like as early revision of mt8173.

Due to the index 2 already used by many DTS, it's better to keep
it unchanged for backward compatible, treat specific ones without
following IPM rule as revision 1.x, meanwhile reserve 3~10 for
later revisions with following the IPM rule.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 2246d29a5e4e..f5dff7fb5755 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -30,6 +30,7 @@ properties:
           - mediatek,mt7629-xhci
           - mediatek,mt8173-xhci
           - mediatek,mt8183-xhci
+          - mediatek,mt8192-xhci
       - const: mediatek,mtk-xhci
 
   reg:
@@ -131,10 +132,13 @@ properties:
         - description:
             The second cell represents the register base address of the glue
             layer in syscon
-        - description:
+        - description: |
             The third cell represents the hardware version of the glue layer,
-            1 is used by mt8173 etc, 2 is used by mt2712 etc
-          enum: [1, 2]
+            1 - used by mt8173 etc, revision 1 without following IPM rule;
+            2 - used by mt2712 etc, revision 2 following IPM rule;
+            11 - used by mt8183, specific 1.1;
+            12 - used by mt8192, specific 1.2;
+          enum: [1, 2, 11, 12]
 
   mediatek,u3p-dis-msk:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.18.0

