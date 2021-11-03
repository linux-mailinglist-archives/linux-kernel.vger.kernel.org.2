Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7E443E13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhKCINK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:13:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41324 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230431AbhKCINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:13:05 -0400
X-UUID: 0356dc1af4a6438189e85a4b187178f4-20211103
X-UUID: 0356dc1af4a6438189e85a4b187178f4-20211103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1570755053; Wed, 03 Nov 2021 16:10:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 3 Nov 2021 16:10:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 3 Nov 2021 16:10:23 +0800
From:   James Lo <james.lo@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [RESEND, v13 1/4] dt-bindings: spmi: modify the constraint of reg property
Date:   Wed, 3 Nov 2021 16:10:18 +0800
Message-ID: <20211103081021.9917-2-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211103081021.9917-1-james.lo@mediatek.com>
References: <20211103081021.9917-1-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraint of reg may larger than 1, so we modify to
'minItem: 1' and 'maxItem: 2'.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spmi/spmi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
index 1d243faef2f8..f29183a45adc 100644
--- a/Documentation/devicetree/bindings/spmi/spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
@@ -25,7 +25,8 @@ properties:
     pattern: "^spmi@.*"
 
   reg:
-    maxItems: 1
+    maxItems: 2
+    minItems: 1
 
   "#address-cells":
     const: 2
-- 
2.18.0

