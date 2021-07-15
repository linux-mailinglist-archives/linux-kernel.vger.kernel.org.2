Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1431D3C9B14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhGOJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39846 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240811AbhGOJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:12 -0400
X-UUID: 02198b48fa0e46dfaad654d02069c5e3-20210715
X-UUID: 02198b48fa0e46dfaad654d02069c5e3-20210715
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2082326475; Thu, 15 Jul 2021 17:08:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:13 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:12 +0800
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
Subject: [PATCH v3 02/13] dt-bindings: usb: mtu3: add optional property to disable usb2 ports
Date:   Thu, 15 Jul 2021 17:07:47 +0800
Message-ID: <1626340078-29111-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Due to there is property 'mediatek,u3p-dis-msk', prefer to use
a similar name for the similar opertions, not spell out 'mask'
as suggested by Rob.

v2~3: no changes
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

