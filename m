Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2B3F9892
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 13:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245072AbhH0LyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 07:54:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34768 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S245046AbhH0LyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 07:54:22 -0400
X-UUID: abe9e8603bd64d54aa33f25ca3e699cb-20210827
X-UUID: abe9e8603bd64d54aa33f25ca3e699cb-20210827
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1245542271; Fri, 27 Aug 2021 19:53:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 19:53:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 19:53:28 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
Date:   Fri, 27 Aug 2021 19:53:24 +0800
Message-ID: <1630065205-7618-2-git-send-email-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630065205-7618-1-git-send-email-wenbin.mei@mediatek.com>
References: <1630065205-7618-1-git-send-email-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hs400 dly3 setting for mtk-sd yaml

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index e866e98..08aaa4aa 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -119,6 +119,13 @@ properties:
       If present, HS400 command responses are sampled on rising edges.
       If not present, HS400 command responses are sampled on falling edges.
 
+  mediatek,hs400-ds-dly3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      HS400 DS dly3 delay setting.
+    minimum: 0
+    maximum: 31
+
   mediatek,latch-ck:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
1.9.1

