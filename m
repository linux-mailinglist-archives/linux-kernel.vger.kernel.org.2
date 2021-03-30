Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE56F34E5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhC3LCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:02:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhC3LCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:02:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UB1xNs058344;
        Tue, 30 Mar 2021 06:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617102119;
        bh=dyOe3pqXIdf8j+8HvSMwBv/J0i5wdpG3jbV9aLdsIZ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dpclOnoD9zx3RN8v4H9CDxycMI+napWi9w1izugPIuLVBtcUcq0uOtc3oYgHpo4d+
         H78oySkiebWh98uX060DO1yEVvGGwwqMNZIzslEwGfCWk8p9yUIHo2eFyxad9pQFjk
         Pv1jfoiZSetmOzzACiHdgQaTu72J7AFvEDD/v2eQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UB1xkL023018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 06:01:59 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 06:01:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 06:01:59 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UB1dcn094447;
        Tue, 30 Mar 2021 06:01:56 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 5/5] phy: cadence-torrent: Add delay for PIPE clock to be stable
Date:   Tue, 30 Mar 2021 16:31:38 +0530
Message-ID: <20210330110138.24356-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330110138.24356-1-kishon@ti.com>
References: <20210330110138.24356-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Torrent spec specifies delay of 660.5us after phy_reset is
asserted by the controller. To be on the safe side provide a delay
of 5ms to 10ms in ->phy_on() callback where the SERDES is already
configured in bootloader.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ff8bb4b724c0..0477e7beebbf 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -371,7 +371,16 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int cdns_torrent_noop_phy_on(struct phy *phy)
+{
+	/* Give 5ms to 10ms delay for the PIPE clock to be stable */
+	usleep_range(5000, 10000);
+
+	return 0;
+}
+
 static const struct phy_ops noop_ops = {
+	.power_on	= cdns_torrent_noop_phy_on,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.17.1

