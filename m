Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1E382BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhEQMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:10:51 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236859AbhEQMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:10:46 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HC5Z7f008635;
        Mon, 17 May 2021 14:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=pjdn0iPLZsVnMrs5LhG4TkO0pVvE9Vj+yQMAhrHcFD4=;
 b=385JZpGwsRXOH0R+XqYOdRc0bj1NCZlTWKhWt55LKQXMHPfEAvt8xwUJjPznPKpw1DCo
 OQYaTXOTbEsudLNusDajGSk9RLmtd5hn2s4IiYqlE0FOR99KWxl9baQS1WrgfC/OP/h5
 US/pPr/olOAJ4966qbG2ug/glogb0CD0CkzKKx19nyuTnvz57zCpLENjD3JA6JZCPMwd
 jnEqMgv8Jz7g0cJaRje1OMRyjuTH78g4LtKQAabj8OROB36O239AGujrIBIPEAC7uDuy
 zUq1HdIMtVQNM01SIvIHA5qfMsCZBnwiHKSu0euputTpf8ENMUPqalNT0x5QVWzxHBbz Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38k5dq4p4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 14:08:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9708710002A;
        Mon, 17 May 2021 14:08:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C4C922D636;
        Mon, 17 May 2021 14:08:27 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May 2021 14:08:27
 +0200
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
Subject: [RESEND PATCH v2 2/2] phy: stm32: manage optional vbus regulator on phy_power_on/off
Date:   Mon, 17 May 2021 14:08:21 +0200
Message-ID: <20210517120821.26466-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517120821.26466-1-amelie.delaunay@foss.st.com>
References: <20210517120821.26466-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_04:2021-05-17,2021-05-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for optional vbus regulator.
It is managed on phy_power_on/off calls and may be needed for host mode.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
No changes in v2.
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

