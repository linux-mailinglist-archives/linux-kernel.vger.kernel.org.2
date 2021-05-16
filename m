Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4F382003
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhEPQhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:37:02 -0400
Received: from mail-m17638.qiye.163.com ([59.111.176.38]:38144 "EHLO
        mail-m17638.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhEPQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:36:55 -0400
Received: from localhost.localdomain (unknown [58.199.17.113])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 934D61C045B;
        Mon, 17 May 2021 00:35:36 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     maxime@cerno.tech
Cc:     amadeus@jmu.edu.cn, devicetree@vger.kernel.org,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        lkft-triage@lists.linaro.org, naresh.kamboju@linaro.org,
        regressions@lists.linux.dev, robh+dt@kernel.org, wens@csie.org
Subject: [PATCH v2 2/2] dt-bindings: arm: Add NanoPi R1S H5
Date:   Mon, 17 May 2021 00:35:23 +0800
Message-Id: <20210516163523.9484-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210516163523.9484-1-amadeus@jmu.edu.cn>
References: <20210511081823.mmcrliomwtetcirx@gilmour>
 <20210516163523.9484-1-amadeus@jmu.edu.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQhpOS1YfShoeSU4ZTE4dH01VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6Czo*Fz8LETZWTQoiA0IY
        FCswFAJVSlVKTUlKSkNJQkhMSkhCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VUpCQlVKTFVKSkhZV1kIAVlBSUlJTTcG
X-HM-Tid: 0a7976087722d993kuws934d61c045b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for NanoPi R1S H5 board.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ec8108483b49..889128acf49a 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -275,6 +275,11 @@ properties:
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

