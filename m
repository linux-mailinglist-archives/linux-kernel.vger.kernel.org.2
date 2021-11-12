Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A7244E151
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 06:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhKLFLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 00:11:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56330 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229750AbhKLFLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 00:11:08 -0500
X-UUID: 9620bafe8da7494fba0dfe0683bf34ae-20211112
X-UUID: 9620bafe8da7494fba0dfe0683bf34ae-20211112
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 306126200; Fri, 12 Nov 2021 13:08:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Nov 2021 13:08:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 13:08:12 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <bgolaszewski@baylibre.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: mediatek: add mt8195 pericfg compatible
Date:   Fri, 12 Nov 2021 13:08:10 +0800
Message-ID: <20211112050811.21202-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20211112050811.21202-1-tinghan.shen@mediatek.com>
References: <20211112050811.21202-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add mt8195 pericfg compatible to binding document.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index 8723dfe34bab..611f666f359d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -26,6 +26,7 @@ properties:
               - mediatek,mt8135-pericfg
               - mediatek,mt8173-pericfg
               - mediatek,mt8183-pericfg
+              - mediatek,mt8195-pericfg
               - mediatek,mt8516-pericfg
           - const: syscon
       - items:
-- 
2.18.0

