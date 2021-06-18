Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A06E3AC797
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhFRJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:32:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:11507 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231889AbhFRJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:32:17 -0400
X-UUID: 813f0951ef584fc7babf48fcbc595ccf-20210618
X-UUID: 813f0951ef584fc7babf48fcbc595ccf-20210618
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 303529478; Fri, 18 Jun 2021 17:29:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 17:29:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 17:29:27 +0800
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
Subject: [PATCH v2 02/13] dt-bindings: usb: mtu3: add optional property to disable usb2 ports
Date:   Fri, 18 Jun 2021 17:29:07 +0800
Message-ID: <1624008558-16949-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5AEDD7370945D48D47C1A2B0A6D43D16778BAA0684B631B9D08DECBF7DF2D10F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to disable specific usb2 host ports, it's useful when
a usb2 port is disabled on some platforms, but enabled on others for
the same SoC, another case is that the different package may support
different number of ports.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index 2cac7a87ce36..3e6f2750f48d 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -166,6 +166,12 @@ properties:
     description: The mask to disable u3ports, bit0 for u3port0,
       bit1 for u3port1, ... etc
 
+  mediatek,u2p-dis-msk:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The mask to disable u2ports, bit0 for u2port0,
+      bit1 for u2port1, ... etc; but can't disable u2port0 if dual role mode
+      is enabled, so will be skipped in this case.
+
 # Required child node when support dual-role
 patternProperties:
   "^usb@[0-9a-f]+$":
-- 
2.18.0

