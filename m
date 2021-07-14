Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725963C827E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhGNKOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:14:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50698 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbhGNKOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:14:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 555371F42DC0
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/7] dt-bindings: mediatek: Add #reset-cells to mmsys system controller
Date:   Wed, 14 Jul 2021 12:11:36 +0200
Message-Id: <20210714121116.v2.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714101141.2089082-1-enric.balletbo@collabora.com>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
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

(no changes since v1)

 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 78c50733985c..ce958446558e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -17,6 +17,7 @@ Required Properties:
 	- "mediatek,mt8173-mmsys", "syscon"
 	- "mediatek,mt8183-mmsys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 For the clock control, the mmsys controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -28,4 +29,5 @@ mmsys: syscon@14000000 {
 	compatible = "mediatek,mt8173-mmsys", "syscon";
 	reg = <0 0x14000000 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
-- 
2.30.2

