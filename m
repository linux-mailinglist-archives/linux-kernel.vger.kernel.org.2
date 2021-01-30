Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F733092D1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhA3JBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:01:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50368 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhA3FGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 00:06:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10U548sb113856;
        Fri, 29 Jan 2021 23:04:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611983048;
        bh=7cFyoVmCdSbdeJkpym0xMSAIO2LdbRoL+6TOp1iLAlE=;
        h=From:To:CC:Subject:Date;
        b=Y6yTZAPHKJK1c7VmpnD4ODYY/QMg1GE2nVvafAJlaAYMPLoJmCCKyGEQchAKQyE6p
         9v9eujJX8pSnkwKDjDYiHaH1dXIdYT/1LnUqYRLWhvvG/GHiisBtYgsiVzltHQ13I4
         fFmtCAjB8Gq0P0Lka0oo+E2OSK/rSvYS2d914iRM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10U548OE106076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jan 2021 23:04:08 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 29
 Jan 2021 23:04:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 29 Jan 2021 23:04:08 -0600
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10U547Ot119521;
        Fri, 29 Jan 2021 23:04:07 -0600
Received: from localhost ([10.250.41.234])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 10U547lI004299;
        Fri, 29 Jan 2021 23:04:07 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH] soc: ti: k3-ringacc: Use of_device_get_match_data()
Date:   Fri, 29 Jan 2021 23:04:00 -0600
Message-ID: <20210130050400.28085-1-s-anna@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the retrieval of getting the match data in the probe
function by directly using of_device_get_match_data() instead
of using of_match_node() and getting data.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index b495b0d5d0fa..312ba0f98ad7 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sys_soc.h>
 #include <linux/dma/ti-cppi5.h>
@@ -1517,15 +1518,13 @@ EXPORT_SYMBOL_GPL(k3_ringacc_dmarings_init);
 static int k3_ringacc_probe(struct platform_device *pdev)
 {
 	const struct ringacc_match_data *match_data;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct k3_ringacc *ringacc;
 	int ret;
 
-	match = of_match_node(k3_ringacc_of_match, dev->of_node);
-	if (!match)
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data)
 		return -ENODEV;
-	match_data = match->data;
 
 	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
 	if (!ringacc)
-- 
2.29.2

