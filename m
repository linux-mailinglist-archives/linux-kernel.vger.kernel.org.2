Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69DF3AC796
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhFRJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:32:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8401 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232974AbhFRJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:32:16 -0400
X-UUID: 9d14a8d4983847708d1d4b7275e34529-20210618
X-UUID: 9d14a8d4983847708d1d4b7275e34529-20210618
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 439472831; Fri, 18 Jun 2021 17:29:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 17:29:33 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 17:29:32 +0800
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/13] dt-bindings: usb: mtu3: add support property role-switch-default-mode
Date:   Fri, 18 Jun 2021 17:29:08 +0800
Message-ID: <1624008558-16949-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C3FC8BE00671BD0439E5515C10ADDCB071F1D44DD82EF7172FF13985681084FB2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support optional property of role-switch-default-mode,
used to set default mode while usb role is USB_ROLE_NONE when use
usb-role-switch to switch mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
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

