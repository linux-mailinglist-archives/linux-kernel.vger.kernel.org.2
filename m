Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F913EE8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbhHQIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:37:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54262 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238797AbhHQIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:37:31 -0400
X-UUID: 8975cf8402e34ad2b2c2bcc74fd50663-20210817
X-UUID: 8975cf8402e34ad2b2c2bcc74fd50663-20210817
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1827499843; Tue, 17 Aug 2021 16:36:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 16:36:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 17 Aug 2021 16:36:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 16:36:44 +0800
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
Subject: [PATCH RESEND 2/9] dt-bindings: usb: mtk-xhci: add compatible for mt8195
Date:   Tue, 17 Aug 2021 16:36:22 +0800
Message-ID: <1629189389-18779-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
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

