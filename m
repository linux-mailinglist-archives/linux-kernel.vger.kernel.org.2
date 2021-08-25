Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116323F7324
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbhHYK1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:27:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48060 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbhHYK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:27:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AE0041F43704
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        eizan@chromium.org, drinkcat@chromium.org, chunkuang.hu@kernel.org,
        kernel@collabora.com, Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/7] dt-bindings: mediatek: Add #reset-cells to mmsys system controller
Date:   Wed, 25 Aug 2021 12:26:27 +0200
Message-Id: <20210825122613.v3.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825102632.601614-1-enric.balletbo@collabora.com>
References: <20210825102632.601614-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmsys system controller exposes a set of memory client resets and
needs to specify the #reset-cells property in order to advertise the
number of cells needed to describe each of the resets.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- Based on top of the patch that converts mmsys to schema

 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 2d4ff0ce387b..96ca16927a06 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -42,6 +42,9 @@ properties:
   "#clock-cells":
     const: 1
 
+  '#reset-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -55,4 +58,5 @@ examples:
         compatible = "mediatek,mt8173-mmsys", "syscon";
         reg = <0x14000000 0x1000>;
         #clock-cells = <1>;
+        #reset-cells = <1>;
     };
-- 
2.30.2

