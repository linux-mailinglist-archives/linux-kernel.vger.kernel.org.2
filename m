Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883873716C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhECOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:40:34 -0400
Received: from mail-m17638.qiye.163.com ([59.111.176.38]:19994 "EHLO
        mail-m17638.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhECOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:40:32 -0400
Received: from amadeus-VLT-WX0.lan (unknown [120.37.186.143])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 7619C1C015B;
        Mon,  3 May 2021 22:32:16 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/2] dt-bindings: arm: Add NanoPi R1S H5
Date:   Mon,  3 May 2021 22:32:02 +0800
Message-Id: <20210503143202.21795-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0JDS1ZKGB0YS0NPSE5KTBlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Iyo4GT8QME0SFBMNSAE8
        CkswCh5VSlVKTUlLS05JSEhNQkNOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpJ
        S1VITFVKQ01VSk9IWVdZCAFZQUpDTEk3Bg++
X-HM-Tid: 0a7932a4e032d993kuws7619c1c015b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for NanoPi R1S H5 board.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ac750025a2eb..2f2ae5a8f3aa 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -269,6 +269,11 @@ properties:
           - const: friendlyarm,nanopi-r1
           - const: allwinner,sun8i-h3
 
+      - description: FriendlyARM NanoPi R1S H5
+        items:
+          - const: friendlyarm,nanopi-r1s-h5
+          - const: allwinner,sun50i-h5
+
       - description: FriendlyARM ZeroPi
         items:
           - const: friendlyarm,zeropi
-- 
2.17.1

