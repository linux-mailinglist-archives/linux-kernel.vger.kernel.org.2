Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5763C9B07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbhGOJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39806 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240806AbhGOJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:11 -0400
X-UUID: 82972917008242eba55ff6f6751f7293-20210715
X-UUID: 82972917008242eba55ff6f6751f7293-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1919446963; Thu, 15 Jul 2021 17:08:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:14 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:13 +0800
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
Subject: [PATCH v3 03/13] dt-bindings: usb: mtu3: add support property role-switch-default-mode
Date:   Thu, 15 Jul 2021 17:07:48 +0800
Message-ID: <1626340078-29111-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support optional property of role-switch-default-mode,
used to set default mode while usb role is USB_ROLE_NONE when use
usb-role-switch to switch mode.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add Acked-by Rob
v2: no changes
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index 3e6f2750f48d..104f1f7edaf0 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -116,6 +116,10 @@ properties:
     description: Support role switch.
     type: boolean
 
+  role-switch-default-mode:
+    enum: [host, peripheral]
+    default: host
+
   connector:
     $ref: /connector/usb-connector.yaml#
     description:
@@ -184,6 +188,7 @@ patternProperties:
 dependencies:
   connector: [ 'usb-role-switch' ]
   port: [ 'usb-role-switch' ]
+  role-switch-default-mode: [ 'usb-role-switch' ]
   wakeup-source: [ 'mediatek,syscon-wakeup' ]
 
 required:
@@ -288,6 +293,7 @@ examples:
         wakeup-source;
         dr_mode = "otg";
         usb-role-switch;
+        role-switch-default-mode = "host";
         #address-cells = <1>;
         #size-cells = <1>;
         ranges;
-- 
2.18.0

