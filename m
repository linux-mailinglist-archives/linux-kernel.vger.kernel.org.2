Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC12321504
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhBVLZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:25:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59004 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhBVLYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:24:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNenB035092;
        Mon, 22 Feb 2021 05:23:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613993020;
        bh=XLr9OoErgvpAWzGsepng7zsPazqJ3thUGn3RfXKhxtc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EzF+ajnuI7gvrcQEyh11UMUusewZPPcDPVf6yXHjlWbNm413Vvz4eXuZxaohdz4sp
         MZWiTnFeZ+kMOKZXa5KduGt6LbAf5X36LninNP5xmfSCFdcbkbGtvDM8r6BXEZO0Bf
         5a4tWfDBULlNl2AF+KCtBUm97cHNUXy5zigVdcDc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBNeWt117536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:23:40 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:23:39 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:23:39 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNFDb088010;
        Mon, 22 Feb 2021 05:23:37 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v2 2/9] dt-bindings: phy: cadence-torrent: Add binding for refclk driver
Date:   Mon, 22 Feb 2021 16:53:07 +0530
Message-ID: <20210222112314.10772-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222112314.10772-1-kishon@ti.com>
References: <20210222112314.10772-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for refclk driver used to route the refclk out of torrent
SERDES.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml     | 20 ++++++++++++++++---
 include/dt-bindings/phy/phy-cadence-torrent.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index e266ade53d87..4608599a31d8 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -28,13 +28,27 @@ properties:
   '#size-cells':
     const: 0
 
+  '#clock-cells':
+    const: 1
+
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
     description:
-      PHY reference clock. Must contain an entry in clock-names.
+      PHY reference clock for 1 item. Must contain an entry in clock-names.
+      Optional Parent to enable output reference clock.
 
   clock-names:
-    const: refclk
+    minItems: 1
+    items:
+      - const: refclk
+      - const: phy_en_refclk
+
+  assigned-clocks:
+    maxItems: 3
+
+  assigned-clock-parents:
+    maxItems: 3
 
   reg:
     minItems: 1
diff --git a/include/dt-bindings/phy/phy-cadence-torrent.h b/include/dt-bindings/phy/phy-cadence-torrent.h
index e387b6a95741..3c92c6192493 100644
--- a/include/dt-bindings/phy/phy-cadence-torrent.h
+++ b/include/dt-bindings/phy/phy-cadence-torrent.h
@@ -10,4 +10,6 @@
 #define TORRENT_SERDES_EXTERNAL_SSC	1
 #define TORRENT_SERDES_INTERNAL_SSC	2
 
+#define CDNS_TORRENT_REFCLK_DRIVER      0
+
 #endif /* _DT_BINDINGS_TORRENT_SERDES_H */
-- 
2.17.1

