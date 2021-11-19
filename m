Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45498456F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhKSNS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:18:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36740 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:18:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDFIkS071598;
        Fri, 19 Nov 2021 07:15:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637327718;
        bh=OQdHDUo660q7Aohvj5WkiapbfIyteSHrslxoP6SHJk4=;
        h=From:To:CC:Subject:Date;
        b=TVek3r/LCAS95nU8y/q6ie1i+t4tldpYCO72MgruqMRRs71/jKJEMunfyjFyUlK5I
         TQahA4JQ4WRVbLxBrceyRen4U1XQtBPt70ZClV4UeQt8J5MhyZePA/r6Jz4Jyhh/pX
         /TyX2OmYZAyyITu7rg/hAGzVnE6qYrM2Xutb6f7w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AJDFIEk031305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Nov 2021 07:15:18 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 19
 Nov 2021 07:15:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 19 Nov 2021 07:15:17 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDFFYD095309;
        Fri, 19 Nov 2021 07:15:16 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc: ti: k3-socinfo: Add entry for J721S2 SoC family
Date:   Fri, 19 Nov 2021 18:45:10 +0530
Message-ID: <20211119131510.14350-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's JTAG PARTNO is 0xBB75.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index fd91129de6e5..83e5a40824f1 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -40,7 +40,8 @@ static const struct k3_soc_id {
 	{ 0xBB5A, "AM65X" },
 	{ 0xBB64, "J721E" },
 	{ 0xBB6D, "J7200" },
-	{ 0xBB38, "AM64X" }
+	{ 0xBB38, "AM64X" },
+	{ 0xBB75, "J721S2"}
 };
 
 static int
-- 
2.17.1

