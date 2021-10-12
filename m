Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBD42A381
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhJLLnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:43:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:63556 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhJLLnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634038879; x=1665574879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1WE6/5/aJUTcV6BB/n4Nfkh2cDfIknqMkN9l0AVkzEM=;
  b=bZ5pNpW9HkQlmFUmKxcEqY0jtSK9fPzSpr3XEb1cX0dvueWkiKTQy1cc
   gW6VJyW1wIfkeREBx2GN8t3TSmB0V9u0Kx1rx6n0awBfp1h9eDDG90ryH
   k9Oha1uNHi6qutjPc5Ea04J9ygoCEX700e561mujMzc5Ndk0hMpbDYBtN
   7XaG+FZ2TjwCYplRTMw5jtlOAhdXWDzs20xhETGZPdoK19vSOUjBZcFQF
   FDWqoBiwrhSKSa4L0uSV4NlRP+OLdX0yCNKS0w4kKrmY6hS27sv+tx1a5
   fSWWbtRVaWX3aimVeAw9zoDMeIcL7jf8DX98p9kWEXrYrQaHKao65DrMr
   g==;
IronPort-SDR: s688RxBiOkkeeMoERwZJ5tkhet3UxEiGz9mt4L8AYk46XtDO32vgDMUF8Fa2ulxcj49GQd/XIA
 11+AocGyerkxxBB+1yjpdQQubH3d5cNpQIDejIHYLsEIvbYyy8QZS2kYdtT5Mp+/RamYOKZcgO
 cCm+e/YfQ4opLO0PkkQ15Z24d/WgbDSs5Y3JG8e7kSpBcRX35FxsZuaBiCMf5GCIN60yAWVGTr
 V2ssgZEk1yXT8cM2ier8+yLWD1Z9AFF150NeRDwTix8BDnC5d5N6XLPfi1ujI0pd/hLOlxUrRM
 NBcPxN/nsJ6pdgQSCD0PUz+O
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="139395342"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2021 04:41:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 12 Oct 2021 04:41:16 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 12 Oct 2021 04:41:14 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: reset: Add lan966x support
Date:   Tue, 12 Oct 2021 13:42:37 +0200
Message-ID: <20211012114238.2060101-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012114238.2060101-1-horatiu.vultur@microchip.com>
References: <20211012114238.2060101-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for lan966x.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../devicetree/bindings/reset/microchip,rst.yaml   | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index 370579aeeca1..622cf3d0455d 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -20,7 +20,11 @@ properties:
     pattern: "^reset-controller@[0-9a-f]+$"
 
   compatible:
-    const: microchip,sparx5-switch-reset
+    oneOf:
+      - items:
+          - const: microchip,sparx5-switch-reset
+      - items:
+          - const: microchip,lan966x-switch-reset
 
   reg:
     items:
@@ -37,6 +41,14 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: syscon used to access CPU reset
 
+  cuphy-syscon:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: syscon used to access CuPHY
+
+  gpios:
+    description: used for release of reset of the external PHY
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.33.0

