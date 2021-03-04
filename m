Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD832CB80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhCDEnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:43:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47148 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhCDEmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:42:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1244fxFd052790;
        Wed, 3 Mar 2021 22:41:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614832919;
        bh=vXveexZupiC6EB7Igu2AVCKG9vCvz2WWeVni7gjU5aA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ROsHI0pb0Qo3GryQ+ACuMExOkKthfA5BOANMc/gblPSBSeYP2n4CfatXoIcPJV9G1
         b5vBeNyoesqE7VTZPp6sb7gAemHS1A7FprMNZCMcxQXZzP88c6SxzhhyVqH6sSz93j
         5yGSOObQa9yD/ZrRpU35KPo7jY6CkxJ6ajn9fUaU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1244fxWK016118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 22:41:59 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 22:41:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 22:41:58 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1244fQfp042911;
        Wed, 3 Mar 2021 22:41:55 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 08/13] phy: cadence-torrent: Use a common header file for Cadence SERDES
Date:   Thu, 4 Mar 2021 10:11:17 +0530
Message-ID: <20210304044122.15166-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304044122.15166-1-kishon@ti.com>
References: <20210304044122.15166-1-kishon@ti.com>
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
---
 drivers/phy/cadence/phy-cadence-torrent.c                | 2 +-
 .../phy/{phy-cadence-torrent.h => phy-cadence.h}         | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)
 rename include/dt-bindings/phy/{phy-cadence-torrent.h => phy-cadence.h} (51%)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index b371795e66a2..56083fd0c69f 100644
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

