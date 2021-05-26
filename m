Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E03391506
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhEZKhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:37:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38594 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233986AbhEZKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:37:32 -0400
X-UUID: 9f90bc338cd843c4b6d706351941c69a-20210526
X-UUID: 9f90bc338cd843c4b6d706351941c69a-20210526
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1674691387; Wed, 26 May 2021 18:35:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 May 2021 18:35:55 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 18:35:55 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v8 1/4] dt-bindings: spmi: modify the constraint 'maxItems' to 'minItems'
Date:   Wed, 26 May 2021 18:35:41 +0800
Message-ID: <1622025344-31888-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1622025344-31888-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1622025344-31888-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraint of 'maxItem: 1' might be larger than 1, so we modify it
to 'minItem: 1'.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes since v7:
- no change.
---
 Documentation/devicetree/bindings/spmi/spmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
index 1739409..12dbf65 100644
--- a/Documentation/devicetree/bindings/spmi/spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
@@ -25,7 +25,7 @@ properties:
     pattern: "^spmi@.*"
 
   reg:
-    maxItems: 1
+    minItems: 1
 
   "#address-cells":
     const: 2
-- 
2.6.4

