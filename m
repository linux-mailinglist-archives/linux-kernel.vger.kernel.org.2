Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFA35EE40
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349631AbhDNHTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:19:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37014 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347296AbhDNHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:18:58 -0400
X-UUID: 5468d15b82944f95af8263ab08f0d24d-20210414
X-UUID: 5468d15b82944f95af8263ab08f0d24d-20210414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 808155614; Wed, 14 Apr 2021 15:18:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 15:18:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 15:18:33 +0800
From:   <Yz.Wu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Seiya Wang <seiya.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Ryan Wu <Yz.Wu@mediatek.com>
Subject: [PATCH v5 1/2] dt-bindings: nvmem: mediatek: add support for MediaTek mt8192 SoC
Date:   Wed, 14 Apr 2021 15:17:48 +0800
Message-ID: <1618384669-30070-2-git-send-email-Yz.Wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1618384669-30070-1-git-send-email-Yz.Wu@mediatek.com>
References: <1618384669-30070-1-git-send-email-Yz.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2153594E3DC16CB8EE200EA279803974DB3C9AA670F07EACE53D9D6F10F45B2E2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wu <Yz.Wu@mediatek.com>

This updates dt-binding documentation for MediaTek mt8192

Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
---
This patch is based on v5.12-rc2.
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index ef93c3b..dbd4da8 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -7,6 +7,7 @@ Required properties:
 	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
 	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
 	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
+		  "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
 	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
 - reg: Should contain registers location and length
 
-- 
2.6.4

