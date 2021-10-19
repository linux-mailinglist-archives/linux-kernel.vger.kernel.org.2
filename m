Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC543426B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhJTABA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 20:01:00 -0400
Received: from mx.socionext.com ([202.248.49.38]:38916 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhJTAAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:00:48 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 Oct 2021 08:58:33 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 6EF81206E701;
        Wed, 20 Oct 2021 08:58:33 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 20 Oct 2021 08:58:33 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 887FDB62E0;
        Wed, 20 Oct 2021 08:58:32 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 7/8] dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC
Date:   Wed, 20 Oct 2021 08:58:07 +0900
Message-Id: <1634687888-23900-8-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update AHCI-PHY binding document for UniPhier Pro4 SoC. Add a compatible
string, clock and reset lines for the SoC to the document.

Pro4 AHCI-PHY needs to control additional GIO clock line and reset lines
("pm", "tx", and "rx").

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml    | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
index 745c525ce6b9..67415f7ebe8c 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -16,6 +16,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - socionext,uniphier-pro4-ahci-phy
       - socionext,uniphier-pxs2-ahci-phy
       - socionext,uniphier-pxs3-ahci-phy
 
@@ -30,6 +31,9 @@ properties:
 
   clock-names:
     oneOf:
+      - items:          # for Pro4
+          - const: gio
+          - const: link
       - items:          # for PXs2
           - const: link
       - items:          # for others
@@ -37,12 +41,20 @@ properties:
           - const: phy
 
   resets:
-    maxItems: 2
+    minItems: 2
+    maxItems: 5
 
   reset-names:
-    items:
-      - const: link
-      - const: phy
+    oneOf:
+      - items:          # for Pro4
+          - const: gio
+          - const: link
+          - const: pm
+          - const: tx
+          - const: rx
+      - items:          # for others
+          - const: link
+          - const: phy
 
 required:
   - compatible
-- 
2.7.4

