Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CDE43FAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhJ2Kl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:41:59 -0400
Received: from mx.socionext.com ([202.248.49.38]:20602 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbhJ2Klm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:41:42 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Oct 2021 19:39:12 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 43DEB203F6D9;
        Fri, 29 Oct 2021 19:39:12 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Oct 2021 19:39:12 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id AEAE9B62E0;
        Fri, 29 Oct 2021 19:39:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 7/8] dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC
Date:   Fri, 29 Oct 2021 19:39:06 +0900
Message-Id: <1635503947-18250-8-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update AHCI-PHY binding document for UniPhier Pro4 SoC. Add a compatible
string, clock and reset lines for the SoC to the document.

Pro4 AHCI-PHY needs to control additional GIO clock line and reset lines
("pm", "tx", and "rx").

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml   | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
index 745c525ce6b9..3b400a85b44a 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -16,6 +16,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - socionext,uniphier-pro4-ahci-phy
       - socionext,uniphier-pxs2-ahci-phy
       - socionext,uniphier-pxs3-ahci-phy
 
@@ -26,23 +27,35 @@ properties:
     const: 0
 
   clocks:
+    minItems: 1
     maxItems: 2
 
   clock-names:
     oneOf:
       - items:          # for PXs2
           - const: link
+      - items:          # for Pro4
+          - const: link
+          - const: gio
       - items:          # for others
           - const: link
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
+          - const: link
+          - const: gio
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

