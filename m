Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599E439F00E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhFHH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:59:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49231 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229507AbhFHH74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:59:56 -0400
X-UUID: 7b7042cc4b0642e3884ba160ae5d8eee-20210608
X-UUID: 7b7042cc4b0642e3884ba160ae5d8eee-20210608
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 44543316; Tue, 08 Jun 2021 15:58:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:57:59 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:57:58 +0800
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
Subject: [PATCH 03/23] dt-bindings: usb: mtu3: add support property role-switch-default-mode
Date:   Tue, 8 Jun 2021 15:57:29 +0800
Message-ID: <1623139069-8173-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support optional property of role-switch-default-mode,
used to set default mode while usb role is USB_ROLE_NONE when use
usb-role-switch to switch mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
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

