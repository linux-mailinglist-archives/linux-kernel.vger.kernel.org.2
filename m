Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3041844E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhIYUQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:16:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45094 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhIYUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:16:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYW2106714;
        Sat, 25 Sep 2021 15:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632600874;
        bh=t1bOpzOJo2cMIiuz/p4lAYab6oa4/M0RXeQ+THur2Fg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rTcAdWWt7RNM14IjyMqvJnPOnWDIffFo98hD+J0ZO5l2QuOznmIqEOOXjB2vBhMgX
         VewmGToLpHyBSP24D4grPhGO8EN22vm14xUQ2lC/QlbtTRu/MaUK9Swothf0d46wC8
         W2BVBmyNpEL+NcCjJ9Q6tIeGvHnJkwe/3A2rserw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18PKEYbN125808
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Sep 2021 15:14:34 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 25
 Sep 2021 15:14:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 25 Sep 2021 15:14:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYd6087832;
        Sat, 25 Sep 2021 15:14:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/4] dt-bindings: arm: ti: am642/am654: Allow for SoC only compatibles
Date:   Sat, 25 Sep 2021 15:14:28 -0500
Message-ID: <20210925201430.11678-3-nm@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210925201430.11678-1-nm@ti.com>
References: <20210925201430.11678-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain consistency in K3 SoCs by allowing AM654 and AM642 platforms
just state SoC compatibles without specific board specific compatibles
aligned with what we have done for J721E/J7200 platforms as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Motivation to introduce in V2:
* Retain consistency with both "soc only" and "board specific" as two
  schemes we support across k3.

V1:  did'nt exist

 .../devicetree/bindings/arm/ti/k3.yaml        | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index cefb06424a4a..30c3f5c70014 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -20,12 +20,15 @@ properties:
     oneOf:
 
       - description: K3 AM654 SoC
-        items:
-          - enum:
-              - ti,am654-evm
-              - siemens,iot2050-basic
-              - siemens,iot2050-advanced
+        oneOf:
           - const: ti,am654
+          - items:
+              - enum:
+                  - ti,am654-evm
+                  - siemens,iot2050-basic
+                  - siemens,iot2050-advanced
+              - const: ti,am654
+
 
       - description: K3 J721E SoC
         oneOf:
@@ -44,11 +47,13 @@ properties:
               - const: ti,j7200
 
       - description: K3 AM642 SoC
-        items:
-          - enum:
-              - ti,am642-evm
-              - ti,am642-sk
+        oneOf:
           - const: ti,am642
+          - items:
+              - enum:
+                  - ti,am642-evm
+                  - ti,am642-sk
+              - const: ti,am642
 
 additionalProperties: true
 
-- 
2.32.0

