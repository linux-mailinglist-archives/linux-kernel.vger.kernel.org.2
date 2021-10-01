Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5841E548
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351161AbhJAAGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:06:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60602 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345765AbhJAAGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:06:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F08021A0D89;
        Fri,  1 Oct 2021 02:04:22 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5A2E1A0D85;
        Fri,  1 Oct 2021 02:04:22 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id EBDB640A55;
        Thu, 30 Sep 2021 17:04:21 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 02/16] dt-bindings: i2c: imx: update schema to align with original txt binding
Date:   Thu, 30 Sep 2021 19:04:03 -0500
Message-Id: <20211001000417.15334-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211001000417.15334-1-leoyang.li@nxp.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the binding was converted from txt to yaml, it actually added more
constrains than the original txt binding which was already used in many
in-tree DTSes.  Some of the newly added constrains are either not valid
or not neccessary.

Not all SoCs use ipg as the clock name for i2c.  There is no point in
having SoC integration information defined in i2c binding.  Remove the
clock name requirement in the schema.

The original txt binding didn't require the order of tx and rx for
dmas/dma-names.  Many in tree DTSes are already using the other order.
Both orders should just work fine.  Update the schema to allow both.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
v2:
Updated the patch description

 Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
index 3592d49235e0..da55d37a09a4 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
@@ -54,20 +54,20 @@ properties:
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
+    minItems: 2
+    maxItems: 2
     items:
-      - const: rx
-      - const: tx
+      enum: [ "rx", "tx" ]
 
   sda-gpios:
     maxItems: 1
-- 
2.25.1

