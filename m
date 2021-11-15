Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC40244FDDF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 05:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhKOEXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 23:23:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42934 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230293AbhKOEXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:23:31 -0500
X-UUID: ea74a21bc256478ca49f5f3669924c9d-20211115
X-UUID: ea74a21bc256478ca49f5f3669924c9d-20211115
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1179444495; Mon, 15 Nov 2021 12:20:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 15 Nov 2021 12:20:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Nov 2021 12:20:32 +0800
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
Subject: [PATCH v15 1/4] dt-bindings: spmi: remove the constraint of reg property
Date:   Mon, 15 Nov 2021 12:20:27 +0800
Message-ID: <20211115042030.30293-2-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211115042030.30293-1-james.lo@mediatek.com>
References: <20211115042030.30293-1-james.lo@mediatek.com>
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

