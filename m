Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764643987F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFBLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:22:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50944 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231937AbhFBLWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:22:42 -0400
X-UUID: 09a20c5f4b6d4ea69c03019157ff9138-20210602
X-UUID: 09a20c5f4b6d4ea69c03019157ff9138-20210602
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2044701966; Wed, 02 Jun 2021 19:20:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 19:20:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 19:20:53 +0800
From:   James Lo <james.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: mediatek: add compatible for MT8195 pwrap
Date:   Wed, 2 Jun 2021 19:20:49 +0800
Message-ID: <20210602112050.12338-2-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210602112050.12338-1-james.lo@mediatek.com>
References: <20210602112050.12338-1-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Chen <henryc.chen@mediatek.com>

This adds dt-binding documentation of pwrap for Mediatek MT8195
SoCs Platform.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index 8051c17e640e..d74a7a5ae9f2 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -27,6 +27,7 @@ Required properties in pwrap device node.
 	"mediatek,mt8135-pwrap" for MT8135 SoCs
 	"mediatek,mt8173-pwrap" for MT8173 SoCs
 	"mediatek,mt8183-pwrap" for MT8183 SoCs
+	"mediatek,mt8195-pwrap" for MT8195 SoCs
 	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
 - reg-names: Must include the following entries:
-- 
2.18.0

