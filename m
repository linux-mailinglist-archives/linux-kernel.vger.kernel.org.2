Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DAF4204DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 04:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhJDCOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 22:14:18 -0400
Received: from mx.socionext.com ([202.248.49.38]:29786 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhJDCOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 22:14:16 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Oct 2021 11:12:27 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 7B48C2059034;
        Mon,  4 Oct 2021 11:12:27 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Oct 2021 11:12:27 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id DE589B62B7;
        Mon,  4 Oct 2021 11:12:26 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] ASoC: dt-bindings: uniphier: Add description of each port number
Date:   Mon,  4 Oct 2021 11:12:26 +0900
Message-Id: <1633313546-23258-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To eliminate FIXME, add descriptions of what each port number is
associated with.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/sound/socionext,uniphier-aio.yaml     | 22 +++++++++++++++++++++-
 .../bindings/sound/socionext,uniphier-evea.yaml    |  6 +++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
index 55ae198..70f62ec 100644
--- a/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
@@ -46,7 +46,27 @@ properties:
 
 patternProperties:
   "^port@[0-9]$":
-    description: FIXME, Need to define what each port is.
+    description: |
+      Port number of DT node is specified by the following DAI channels that
+      depends on SoC.
+      ld11-aio,ld20-aio:
+        0: hdmi
+        1: pcmin2
+        2: line
+        3: hpcmout1
+        4: pcmout3
+        5: hiecout1
+        6: epcmout2
+        7: epcmout3
+        8: hieccompout1
+      pxs2-aio:
+        0: hdmi
+        1: line
+        2: aux
+        3: hiecout1
+        4: iecout1
+        5: hieccompout1
+        6: ieccompout1
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
index 48ddfcb..be6acfd 100644
--- a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
@@ -40,7 +40,11 @@ properties:
 
 patternProperties:
   "^port@[0-9]$":
-    description: FIXME, Need to define what each port is.
+    description: |
+      Port number of DT node is specified by the following DAI channels.
+        0: line1
+        1: hp
+        2: line2
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
-- 
2.7.4

