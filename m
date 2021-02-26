Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D3326163
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBZKhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:37:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46893 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231143AbhBZKew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:34:52 -0500
X-UUID: 7016f27a04724db7a83e88e44f8f10b3-20210226
X-UUID: 7016f27a04724db7a83e88e44f8f10b3-20210226
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1184735566; Fri, 26 Feb 2021 18:33:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Feb 2021 18:33:52 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Feb 2021 18:33:46 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hanks.chen@mediatek.com>,
        <wsd_upstream@mediatek.com>, mtk22786 <Mason.Zhang@mediatek.com>
Subject: [PATCH v1 1/2] dt-binding: mediatek: mt6779: update spi document
Date:   Fri, 26 Feb 2021 18:26:15 +0800
Message-ID: <20210226102614.9265-1-Mason.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mtk22786 <Mason.Zhang@mediatek.com>

this patch update spi document for MT6779 SOC.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 9e43721fa7d6..7bae7eef26c7 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -13,6 +13,7 @@ Required properties:
     - mediatek,mt8183-spi: for mt8183 platforms
     - "mediatek,mt8192-spi", "mediatek,mt6765-spi": for mt8192 platforms
     - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
+    - "mediatek,mt6779-spi", "mediatek,mt6765-spi": for mt6779 platforms
 
 - #address-cells: should be 1.
 
-- 
2.18.0

