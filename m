Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BAC431828
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhJRLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:53:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56548 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229569AbhJRLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:53:31 -0400
X-UUID: b68fa2e4eea844aa93dc442b28bddf92-20211018
X-UUID: b68fa2e4eea844aa93dc442b28bddf92-20211018
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1198654547; Mon, 18 Oct 2021 19:51:17 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 19:51:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Oct
 2021 19:51:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 19:51:16 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Benson Leung" <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH] dt-bindings: mfd: change naming of mediatek rpmsg property
Date:   Mon, 18 Oct 2021 19:51:11 +0800
Message-ID: <20211018115111.14096-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change from "mtk,rpmsg-name" to "mediatek,rpmsg-name" to sync with the
vendor name defined in vendor-prefixes.yaml.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d793dd0316b7..0faa4da6c7c8 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -59,7 +59,7 @@ properties:
       whether this nvram is present or not.
     type: boolean
 
-  mtk,rpmsg-name:
+  mediatek,rpmsg-name:
     description:
       Must be defined if the cros-ec is a rpmsg device for a Mediatek
       ARM Cortex M4 Co-processor. Contains the name pf the rpmsg
-- 
2.18.0

