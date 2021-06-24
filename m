Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B279A3B35EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhFXSnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:43:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41470 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhFXSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:43:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15OIfHt4028658;
        Thu, 24 Jun 2021 13:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624560077;
        bh=tiiN7makazoom7pCtyD0iCir4iR2Oy+IqqShZdnezTE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XWi+kxIfbc2x+/VTAe/EvDhYIgN3KxtzhqzxfWRCyinzqEjiXWJEmNqOAb7SsY3zT
         22mjnB0SN/X1qJ4vime1ROqUguqwqjcC3tj13Hwqa7og1qod8K0Yg0p8snrXOI+Npw
         ewC91zFirszBgG9dBR/Fprb8E2+W+aoEtY8kbiG0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15OIfHiE034227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 13:41:17 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 13:41:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 24 Jun 2021 13:41:16 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15OIf9Hw041395;
        Thu, 24 Jun 2021 13:41:14 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v3 1/7] phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes
Date:   Fri, 25 Jun 2021 00:11:02 +0530
Message-ID: <20210624184108.21312-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210624184108.21312-1-p.yadav@ti.com>
References: <20210624184108.21312-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

As some D-PHY controllers support both Rx and Tx mode, we need a way for
users to explicitly request one or the other. For instance, Rx mode can
be used along with MIPI CSI-2 while Tx mode can be used with MIPI DSI.

Introduce new MIPI D-PHY PHY submodes to use with PHY_MODE_MIPI_DPHY.
The default (zero value) is kept to Tx so only the rkisp1 driver, which
uses D-PHY in Rx mode, needs to be adapted.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

 include/linux/phy/phy-mipi-dphy.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/phy/phy-mipi-dphy.h b/include/linux/phy/phy-mipi-dphy.h
index a877ffee845d..0f57ef46a8b5 100644
--- a/include/linux/phy/phy-mipi-dphy.h
+++ b/include/linux/phy/phy-mipi-dphy.h
@@ -6,6 +6,19 @@
 #ifndef __PHY_MIPI_DPHY_H_
 #define __PHY_MIPI_DPHY_H_
 
+/**
+ * enum phy_mipi_dphy_submode - MIPI D-PHY sub-mode
+ *
+ * A MIPI D-PHY can be used to transmit or receive data.
+ * Since some controllers can support both, the direction to enable is specified
+ * with the PHY sub-mode. Transmit is assumed by default with phy_set_mode.
+ */
+
+enum phy_mipi_dphy_submode {
+	PHY_MIPI_DPHY_SUBMODE_TX = 0,
+	PHY_MIPI_DPHY_SUBMODE_RX,
+};
+
 /**
  * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
  *
-- 
2.30.0

