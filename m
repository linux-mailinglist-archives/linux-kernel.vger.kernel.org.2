Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76073AE589
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFUJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:05:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34528 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230235AbhFUJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:05:07 -0400
X-UUID: c5b69166141a4ac187950597b1933db1-20210621
X-UUID: c5b69166141a4ac187950597b1933db1-20210621
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2064436223; Mon, 21 Jun 2021 17:02:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Jun 2021 17:02:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Jun 2021 17:02:08 +0800
From:   <kewei.xu@mediatek.com>
To:     <bbrezillon@kernel.org>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-i3c@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>, Kewei Xu <kewei.xu@mediatek.com>
Subject: [PATCH V2 2/3] dt-bindings: i2c: add attribute default-timing-adjust
Date:   Mon, 21 Jun 2021 17:01:53 +0800
Message-ID: <1624266114-21539-3-git-send-email-kewei.xu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1624266114-21539-1-git-send-email-kewei.xu@mediatek.com>
References: <1624266114-21539-1-git-send-email-kewei.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kewei Xu <kewei.xu@mediatek.com>

Add attribute default-timing-adjust for DT-binding document.

Fixes: be5ce0e97cc7 ("i2c: mediatek: Add i2c ac-timing adjust support")
Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
index 7c4915bc..7b80a11 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
@@ -33,6 +33,8 @@ Optional properties:
   - mediatek,have-pmic: platform can control i2c form special pmic side.
     Only mt6589 and mt8135 support this feature.
   - mediatek,use-push-pull: IO config use push-pull mode.
+  - mediatek,default-timing-adjust: use default timing calculation, no timing
+    adjustment.
 
 Example:
 
-- 
1.9.1

