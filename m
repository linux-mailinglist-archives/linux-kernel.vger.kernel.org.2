Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B757833F52F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhCQQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:10:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22056 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232332AbhCQQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:10:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HFlrRv010043;
        Wed, 17 Mar 2021 17:10:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=xgpzGC4wdyQX7DWrBZkXr6BWb3iEnXnND5XfVReNl8c=;
 b=n7qV4iFaKwMjmk5V+qYigLrv88LW+LziE7pfYzJ5OksDpkA+KSuu7G5mBIHFkSY5qxAG
 UMizZf74A1pN81Pyc+gNMi913ObEWmEgTNe2FgVNeKoQgm9pPY4Jj9yUDowT7A0lWpNg
 KjFk66AyoHbpr37BmwyJbyY0vteXC21OFLR35yC7GXBJE6OBP78VqfaqADawviKrhpAq
 doZPh5wQYL5TABK4opzrPkQuwWGxVmOrEboBHP5aD8Bz/8XHZx08p7md7yT+K555TQe6
 +7vFvlrUMK6d3Vo/X8cJ1im5+XnKWQpeeTYnPP0pJPZxwhG/RERZOIC/6lI+S+5MUIBF AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37a8pr67jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 17:10:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 311F910002A;
        Wed, 17 Mar 2021 17:10:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2173B23E915;
        Wed, 17 Mar 2021 17:10:08 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Mar 2021 17:10:07
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/2] phy: stm32: manage optional vbus regulator on phy_power_on/off
Date:   Wed, 17 Mar 2021 17:09:54 +0100
Message-ID: <20210317160954.15487-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317160954.15487-1-amelie.delaunay@foss.st.com>
References: <20210317160954.15487-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_10:2021-03-17,2021-03-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for optional vbus regulator.
It is managed on phy_power_on/off calls and may be needed for host mode.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index c184f4e34584..3e491dfb2525 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -57,6 +57,7 @@ struct pll_params {
 struct stm32_usbphyc_phy {
 	struct phy *phy;
 	struct stm32_usbphyc *usbphyc;
+	struct regulator *vbus;
 	u32 index;
 	bool active;
 };
@@ -291,9 +292,31 @@ static int stm32_usbphyc_phy_exit(struct phy *phy)
 	return stm32_usbphyc_pll_disable(usbphyc);
 }
 
+static int stm32_usbphyc_phy_power_on(struct phy *phy)
+{
+	struct stm32_usbphyc_phy *usbphyc_phy = phy_get_drvdata(phy);
+
+	if (usbphyc_phy->vbus)
+		return regulator_enable(usbphyc_phy->vbus);
+
+	return 0;
+}
+
+static int stm32_usbphyc_phy_power_off(struct phy *phy)
+{
+	struct stm32_usbphyc_phy *usbphyc_phy = phy_get_drvdata(phy);
+
+	if (usbphyc_phy->vbus)
+		return regulator_disable(usbphyc_phy->vbus);
+
+	return 0;
+}
+
 static const struct phy_ops stm32_usbphyc_phy_ops = {
 	.init = stm32_usbphyc_phy_init,
 	.exit = stm32_usbphyc_phy_exit,
+	.power_on = stm32_usbphyc_phy_power_on,
+	.power_off = stm32_usbphyc_phy_power_off,
 	.owner = THIS_MODULE,
 };
 
@@ -519,6 +542,14 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		usbphyc->phys[port]->index = index;
 		usbphyc->phys[port]->active = false;
 
+		usbphyc->phys[port]->vbus = devm_regulator_get_optional(&phy->dev, "vbus");
+		if (IS_ERR(usbphyc->phys[port]->vbus)) {
+			ret = PTR_ERR(usbphyc->phys[port]->vbus);
+			if (ret == -EPROBE_DEFER)
+				goto put_child;
+			usbphyc->phys[port]->vbus = NULL;
+		}
+
 		port++;
 	}
 
-- 
2.17.1

