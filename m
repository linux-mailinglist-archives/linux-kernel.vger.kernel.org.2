Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD591421C57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhJECK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:10:29 -0400
Received: from mx.socionext.com ([202.248.49.38]:24878 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhJECKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:10:18 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Oct 2021 11:08:28 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id F28742058B40;
        Tue,  5 Oct 2021 11:08:27 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 5 Oct 2021 11:08:27 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6732CB62B7;
        Tue,  5 Oct 2021 11:08:27 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/5] dt-bindings: clock: uniphier: Add clock binding for SoC-glue
Date:   Tue,  5 Oct 2021 11:08:25 +0900
Message-Id: <1633399706-1251-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633399706-1251-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633399706-1251-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update binding document for clocks implemented in SoC-glue.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/clock/socionext,uniphier-clock.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
index ee8d16a..d1ac311 100644
--- a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
@@ -46,6 +46,9 @@ properties:
           - socionext,uniphier-ld20-peri-clock
           - socionext,uniphier-pxs3-peri-clock
           - socionext,uniphier-nx1-peri-clock
+      - description: SoC-glue clock
+        enum:
+	  - socionext,uniphier-pro4-sg-clock
 
   "#clock-cells":
     const: 1
@@ -95,3 +98,16 @@ examples:
 
         // other nodes ...
     };
+
+  - |
+    soc-glue@5f800000 {
+        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
+        reg = <0x5f800000 0x2000>;
+
+        clock {
+            compatible = "socionext,uniphier-pro4-sg-clock";
+            #clock-cells = <1>;
+        };
+
+        // other nodes ...
+    };
-- 
2.7.4

