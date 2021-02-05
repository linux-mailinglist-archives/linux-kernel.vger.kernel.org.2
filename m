Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62D311B26
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhBFEvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:51:46 -0500
Received: from inva020.nxp.com ([92.121.34.13]:58666 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhBFD2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:28:33 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 994841A0BED;
        Sat,  6 Feb 2021 00:50:50 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 529E61A025F;
        Sat,  6 Feb 2021 00:50:50 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2D82540BCF;
        Fri,  5 Feb 2021 16:50:46 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 02/15] dt-bindings: i2c: imx: update schema to align with original binding
Date:   Fri,  5 Feb 2021 17:47:21 -0600
Message-Id: <20210205234734.3397-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20210205234734.3397-1-leoyang.li@nxp.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Layerscape SoCs doesn't use ipg as clock name.  Remove the clock name
requirement in the schema.  Also the original binding doesn't enforce
the order of "tx" and "rx" in dma-names.  Both orders are used
extensively in existing dtses, update the schema to allow both.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
index f23966b0d6c6..57237b0b7d89 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
@@ -54,20 +54,19 @@ properties:
     maxItems: 1
 
   clock-names:
-    const: ipg
+    maxItems: 1
 
   clock-frequency:
     enum: [ 100000, 400000 ]
 
   dmas:
-    items:
-      - description: DMA controller phandle and request line for RX
-      - description: DMA controller phandle and request line for TX
+    minItems: 2
+    maxItems: 2
 
   dma-names:
     items:
-      - const: rx
-      - const: tx
+      - enum: [ "rx", "tx" ]
+      - enum: [ "tx", "rx" ]
 
   sda-gpios:
     maxItems: 1
-- 
2.17.1

