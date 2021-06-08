Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EFC39F01A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhFHIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49258 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230414AbhFHH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:59:57 -0400
X-UUID: e8b6c510f11f4b85ae010398e53fec28-20210608
X-UUID: e8b6c510f11f4b85ae010398e53fec28-20210608
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 566930608; Tue, 08 Jun 2021 15:58:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:57:59 +0800
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
Subject: [PATCH 04/23] dt-bindings: usb: mtu3: add wakeup interrupt
Date:   Tue, 8 Jun 2021 15:57:30 +0800
Message-ID: <1623139069-8173-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an dedicated interrupt which is usually EINT to support runtime PM,
meanwhile add "interrupt-names" property, for backward compatibility,
it's optional and used when wakeup interrupt exists

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
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

