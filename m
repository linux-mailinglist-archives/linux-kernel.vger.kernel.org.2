Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FE3DB533
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhG3Iur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:50:47 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41356 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230335AbhG3Iup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:50:45 -0400
X-UUID: f90a8406a6de4ed9a75b9328355a312f-20210730
X-UUID: f90a8406a6de4ed9a75b9328355a312f-20210730
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 528263771; Fri, 30 Jul 2021 16:50:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Jul 2021 16:50:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Jul 2021 16:50:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 03/11] dt-bindings: usb: mtk-xhci: add compatible for mt8195
Date:   Fri, 30 Jul 2021 16:49:54 +0800
Message-ID: <1627635002-24521-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 USB controllers on MT8195, the controllers (IP1~IP3,
exclude IP0) have a wrong default SOF/ITP interval which is
calculated from the frame counter clock 24Mhz by default, but
in fact, the frame counter clock is 48Mhz, so we should set
the accurate interval according to 48Mhz. Here add a new compatible
for MT8195, it's also supported in driver. But the first controller
(IP0) has no such issue, we prefer to use generic compatible,
e.g. mt8192's compatible.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 61a0e550b5d6..753e043e5327 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -31,6 +31,7 @@ properties:
           - mediatek,mt8173-xhci
           - mediatek,mt8183-xhci
           - mediatek,mt8192-xhci
+          - mediatek,mt8195-xhci
       - const: mediatek,mtk-xhci
 
   reg:
-- 
2.18.0

