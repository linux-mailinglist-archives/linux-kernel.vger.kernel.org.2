Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B4414255
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhIVHKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:10:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49570 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232946AbhIVHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:10:20 -0400
X-UUID: 2f1ef4d03d324bf2a7c477cac4f4bcf8-20210922
X-UUID: 2f1ef4d03d324bf2a7c477cac4f4bcf8-20210922
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2078548824; Wed, 22 Sep 2021 15:08:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 22 Sep 2021 15:08:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Sep 2021 15:08:46 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-jh Lin <jason-jh.lin@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] dt-bindings: mailbox: fix incorrect gce.h file paths
Date:   Wed, 22 Sep 2021 15:08:45 +0800
Message-ID: <20210922070845.5108-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few *gce.h file paths are not in 'dt-bindings/gce/<chip>-gce.h'
format. To fix it, replace 'dt-binding' with 'dt-bindings'

Fixes: 0553fb51686e ("dt-bindings: mailbox: add definition for mt8195")
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index 89a59b9c81f9..98fe37e8b17b 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -40,8 +40,8 @@ Optional properties for a client mutex node:
   defined in 'dt-bindings/gce/<chip>-gce.h'.
 
 Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h',
-'dt-binding/gce/mt8183-gce.h', 'dt-binding/gce/mt8192-gce.h',
-'dt-binding/gce/mt8195-gce.h' or 'dt-bindings/gce/mt6779-gce.h'.
+'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8192-gce.h',
+'dt-bindings/gce/mt8195-gce.h' or 'dt-bindings/gce/mt6779-gce.h'.
 Such as sub-system ids, thread priority, event ids.
 
 Example:
-- 
2.18.0

