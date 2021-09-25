Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBA8418452
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhIYUQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:16:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44272 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhIYUQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:16:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYMo113946;
        Sat, 25 Sep 2021 15:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632600874;
        bh=zSfQUFbwbG9BKEY5GIqtZhwns1qQjKvy+IIFfs7G8AM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OP0M6TOvzLhosRgQ3NZng6TJhM4S+Yu2QZLSXIoPFNekRZIK5m4Ws/APaLm72MTtz
         hRRNos4nkwiVqnMjiCWN7zpYseOLC+9VrNvdP3aXaVEzB+AZZAUigRiKv5qO/7v4Rk
         xoEwSNo7CHuYmk3q/P0lF29jJ0S/gj/rB7r8IirU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18PKEYlO130213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Sep 2021 15:14:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 25
 Sep 2021 15:14:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 25 Sep 2021 15:14:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEY3Y005879;
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
Subject: [PATCH V2 1/4] dt-bindings: arm: ti: Add missing compatibles for j721e/j7200 evms
Date:   Sat, 25 Sep 2021 15:14:27 -0500
Message-ID: <20210925201430.11678-2-nm@ti.com>
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

Add compatibles for j721e and j7200 evms to allow for newer platforms
to distinguish themselves.

While doing this, maintain support for older style of description where
the board compatibility was not required.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes in V2:
* Modified such that legacy style of compatibles (of just SoC alone) is
  still valid
* Made the capability of providing a board specific compatible as an
  alternate scheme
* No longer dependent on rproc cleanup and platforms hosted in
  downstream trees remain compatible

V1: https://lore.kernel.org/all/20210915121937.27702-2-nm@ti.com/

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index c5aa362e4026..cefb06424a4a 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -28,12 +28,20 @@ properties:
           - const: ti,am654
 
       - description: K3 J721E SoC
-        items:
+        oneOf:
           - const: ti,j721e
+          - items:
+              - enum:
+                  - ti,j721e-evm
+              - const: ti,j721e
 
       - description: K3 J7200 SoC
-        items:
+        oneOf:
           - const: ti,j7200
+          - items:
+              - enum:
+                  - ti,j7200-evm
+              - const: ti,j7200
 
       - description: K3 AM642 SoC
         items:
-- 
2.32.0

