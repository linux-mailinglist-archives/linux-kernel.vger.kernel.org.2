Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8218B3C9B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhGOJLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:19 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44364 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240810AbhGOJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:11 -0400
X-UUID: 64458e8ace49461eab24f717575ee1fc-20210715
X-UUID: 64458e8ace49461eab24f717575ee1fc-20210715
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1973841917; Thu, 15 Jul 2021 17:08:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:15 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:14 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v3 04/13] dt-bindings: usb: mtu3: add wakeup interrupt
Date:   Thu, 15 Jul 2021 17:07:49 +0800
Message-ID: <1626340078-29111-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an dedicated interrupt which is usually EINT to support runtime PM,
meanwhile add "interrupt-names" property, for backward compatibility,
it's optional and used when wakeup interrupt exists

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add Acked-by Rob
v2: no changes
---
 .../devicetree/bindings/usb/mediatek,mtu3.yaml      | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index 104f1f7edaf0..77db1233516e 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -38,7 +38,18 @@ properties:
       - const: ippc
 
   interrupts:
-    maxItems: 1
+    description:
+      use "interrupts-extended" when the interrupts are connected to the
+      separate interrupt controllers
+    minItems: 1
+    items:
+      - description: SSUSB device controller interrupt
+      - description: optional, wakeup interrupt used to support runtime PM
+
+  interrupt-names:
+    items:
+      - const: device
+      - const: wakeup
 
   power-domains:
     description: A phandle to USB power domain node to control USB's MTCMOS
-- 
2.18.0

