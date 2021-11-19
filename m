Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E14568BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhKSDtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:49:20 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39260 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233268AbhKSDtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:49:19 -0500
X-UUID: d1e8c6124cd444eb94282c6eed588423-20211119
X-UUID: d1e8c6124cd444eb94282c6eed588423-20211119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 872389117; Fri, 19 Nov 2021 11:46:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 19 Nov 2021 11:46:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 11:46:15 +0800
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
Subject: [PATCH v16 1/4] dt-bindings: spmi: remove the constraint of reg property
Date:   Fri, 19 Nov 2021 11:46:10 +0800
Message-ID: <20211119034613.32489-2-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211119034613.32489-1-james.lo@mediatek.com>
References: <20211119034613.32489-1-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'reg' is controller specific so we shouldn't even be specifying it here.
Just remove it.

Signed-off-by: James Lo <james.lo@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spmi/spmi.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
index 1d243faef2f8..c1b06fa5c631 100644
--- a/Documentation/devicetree/bindings/spmi/spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
@@ -24,9 +24,6 @@ properties:
   $nodename:
     pattern: "^spmi@.*"
 
-  reg:
-    maxItems: 1
-
   "#address-cells":
     const: 2
 
-- 
2.18.0

