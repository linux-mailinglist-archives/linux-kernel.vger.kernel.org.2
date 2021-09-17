Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7440F847
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbhIQMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:49:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34718 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235476AbhIQMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:49:35 -0400
X-UUID: d6c91f5d42684a2bb1d58bef6c3e9e7a-20210917
X-UUID: d6c91f5d42684a2bb1d58bef6c3e9e7a-20210917
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 8314148; Fri, 17 Sep 2021 20:48:11 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 20:48:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Sep
 2021 20:48:04 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Sep 2021 20:48:03 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: [RESEND v4 1/3] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
Date:   Fri, 17 Sep 2021 20:48:01 +0800
Message-ID: <20210917124803.22871-2-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917124803.22871-1-wenbin.mei@mediatek.com>
References: <20210917124803.22871-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hs400 dly3 setting for mtk-sd yaml

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index e866e985549e..82768a807294 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -119,6 +119,18 @@ properties:
       If present, HS400 command responses are sampled on rising edges.
       If not present, HS400 command responses are sampled on falling edges.
 
+  mediatek,hs400-ds-dly3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Gear of the third delay line for DS for input data latch in data
+      pad macro, there are 32 stages from 0 to 31.
+      For different corner IC, the time is different about one step, it is
+      about 100ps.
+      The value is confirmed by doing scan and calibration to find a best
+      value with corner IC and it is valid only for HS400 mode.
+    minimum: 0
+    maximum: 31
+
   mediatek,latch-ck:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.25.1

