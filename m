Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF545DD73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbhKYPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355993AbhKYPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:30:19 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC2DC0613B3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:22:43 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:1511:ffa3:275:45dd])
        by andre.telenet-ops.be with bizsmtp
        id NfNd260055CGg7701fNd9B; Thu, 25 Nov 2021 16:22:43 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGa4-000DL1-NC; Thu, 25 Nov 2021 16:22:36 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGa4-000gNf-8D; Thu, 25 Nov 2021 16:22:36 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: interrupt-controller: sifive,plic: Fix number of interrupts
Date:   Thu, 25 Nov 2021 16:22:33 +0100
Message-Id: <20211125152233.162868-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve human readability and enable automatic validation, the tuples
in "interrupts-extended" properties should be grouped using angle
brackets.  As the DT bindings lack an upper bound on the number of
interrupts, thus assuming one, proper grouping is currently flagged as
an error.

Fix this by adding the missing "maxItems", limiting it to 9 interrupts
(one interrupt for a system management core, and two interrupts per core
for other cores), which should be sufficient for now.

Group the tuples in the example.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../interrupt-controller/sifive,plic-1.0.0.yaml      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 08d5a57ce00ff446..198b373f984f3438 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -61,6 +61,7 @@ properties:
 
   interrupts-extended:
     minItems: 1
+    maxItems: 9
     description:
       Specifies which contexts are connected to the PLIC, with "-1" specifying
       that a context is not present. Each node pointed to should be a
@@ -89,12 +90,11 @@ examples:
       #interrupt-cells = <1>;
       compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
       interrupt-controller;
-      interrupts-extended = <
-        &cpu0_intc 11
-        &cpu1_intc 11 &cpu1_intc 9
-        &cpu2_intc 11 &cpu2_intc 9
-        &cpu3_intc 11 &cpu3_intc 9
-        &cpu4_intc 11 &cpu4_intc 9>;
+      interrupts-extended = <&cpu0_intc 11>,
+                            <&cpu1_intc 11>, <&cpu1_intc 9>,
+                            <&cpu2_intc 11>, <&cpu2_intc 9>,
+                            <&cpu3_intc 11>, <&cpu3_intc 9>,
+                            <&cpu4_intc 11>, <&cpu4_intc 9>;
       reg = <0xc000000 0x4000000>;
       riscv,ndev = <10>;
     };
-- 
2.25.1

