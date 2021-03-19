Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6A341D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCSMoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:44:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37512 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhCSMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:44:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCg6mQ048368;
        Fri, 19 Mar 2021 07:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157726;
        bh=6gVouj1wfT7NmKqwlRzK5EWKNIMHLpD+W/lGt6dO6EE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=S3PmYqTyYsCKgWK1gxJquy2lWghpc+kJBQNH1h34v5EcTrOzpMd7Bl2OBbmbMW6mC
         7zVS6FiTgO7qbTqoH+gna5zOa7KzZ6CTekbMocFz22EjpCiBNlmQfSOrhzR1wEZQlX
         6BEnEE6LxO6w+tBsDDotfNSAjWxdZpqvuFjQfsHc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCg6TH125164
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:42:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:42:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:42:04 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTf9011913;
        Fri, 19 Mar 2021 07:42:01 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 08/13] phy: cadence-torrent: Use a common header file for Cadence SERDES
Date:   Fri, 19 Mar 2021 18:11:23 +0530
Message-ID: <20210319124128.13308-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. In order to have a single header file for all
Cadence SERDES move phy-cadence-torrent.h to phy-cadence.h. This is
in preparation for adding Cadence Sierra SERDES specific macros.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml     | 2 +-
 drivers/phy/cadence/phy-cadence-torrent.c                | 2 +-
 .../phy/{phy-cadence-torrent.h => phy-cadence.h}         | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)
 rename include/dt-bindings/phy/{phy-cadence-torrent.h => phy-cadence.h} (51%)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 4608599a31d8..01dcd14e7b2a 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -184,7 +184,7 @@ examples:
     };
   - |
     #include <dt-bindings/phy/phy.h>
-    #include <dt-bindings/phy/phy-cadence-torrent.h>
+    #include <dt-bindings/phy/phy-cadence.h>
 
     bus {
         #address-cells = <2>;
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 95160da3e667..3fdab0d288c4 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -7,7 +7,7 @@
  */
 
 #include <dt-bindings/phy/phy.h>
-#include <dt-bindings/phy/phy-cadence-torrent.h>
+#include <dt-bindings/phy/phy-cadence.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
diff --git a/include/dt-bindings/phy/phy-cadence-torrent.h b/include/dt-bindings/phy/phy-cadence.h
similarity index 51%
rename from include/dt-bindings/phy/phy-cadence-torrent.h
rename to include/dt-bindings/phy/phy-cadence.h
index 3c92c6192493..4a5ea52a856f 100644
--- a/include/dt-bindings/phy/phy-cadence-torrent.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -1,15 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * This header provides constants for Cadence Torrent SERDES.
+ * This header provides constants for Cadence SERDES.
  */
 
-#ifndef _DT_BINDINGS_TORRENT_SERDES_H
-#define _DT_BINDINGS_TORRENT_SERDES_H
+#ifndef _DT_BINDINGS_CADENCE_SERDES_H
+#define _DT_BINDINGS_CADENCE_SERDES_H
 
+/* Torrent */
 #define TORRENT_SERDES_NO_SSC		0
 #define TORRENT_SERDES_EXTERNAL_SSC	1
 #define TORRENT_SERDES_INTERNAL_SSC	2
 
 #define CDNS_TORRENT_REFCLK_DRIVER      0
 
-#endif /* _DT_BINDINGS_TORRENT_SERDES_H */
+#endif /* _DT_BINDINGS_CADENCE_SERDES_H */
-- 
2.17.1

