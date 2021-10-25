Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4727043989A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhJYOdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:33:54 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48718 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231602AbhJYOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:33:53 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PC00Pe012721;
        Mon, 25 Oct 2021 16:31:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=heLJ4yGEfIp904h0KY7xGdKsvRSbeHaJmHrvhlHM+aQ=;
 b=Umesn97DGsSZUS9e3DX+7OyT6OCTEM9aUpyy1PMkI6rYdGWvtbW+5ZKwKfFArdF7tBMY
 cBNe7zV4RtYWoUovQY7mUWtZHcZ5ycwUL+60IYqf3QVnit692kNYDwb+MyzCWo46j17Y
 s7kL6qjCNrq+cY0EdI7DLn0Ium5sm4xwst0FC1EAhceoQRQBhdP9yzGx42hgZb4lLaUD
 Mbx3hizUirY+Vbt707qdG9gfe55FG82PrrO/BNjWtwuj8KX3hP86IspgiivOcep0xiej
 JuqmeCcGrBblSqo8swezWRui7X3bU8LZaDdsP9GS2UTLvyoHl6o7rgGRAKOljQOXLl9Y 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwqpsjjg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 16:31:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F1305100034;
        Mon, 25 Oct 2021 16:31:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E58DF233C77;
        Mon, 25 Oct 2021 16:31:20 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct 2021 16:31:20
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>
CC:     <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <linux-phy@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: stm32: adopt dev_err_probe for regulators
Date:   Mon, 25 Oct 2021 16:31:05 +0200
Message-ID: <1635172265-26219-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change stm32-usbphyc driver to use dev_err_probe(), to benefit of
devices_deferred debugfs in case of probe deferral.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 7df6a63..115be0e 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -672,17 +672,15 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 
 	usbphyc->vdda1v1 = devm_regulator_get(dev, "vdda1v1");
 	if (IS_ERR(usbphyc->vdda1v1)) {
-		ret = PTR_ERR(usbphyc->vdda1v1);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get vdda1v1 supply: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(usbphyc->vdda1v1),
+				    "failed to get vdda1v1 supply\n");
 		goto clk_disable;
 	}
 
 	usbphyc->vdda1v8 = devm_regulator_get(dev, "vdda1v8");
 	if (IS_ERR(usbphyc->vdda1v8)) {
-		ret = PTR_ERR(usbphyc->vdda1v8);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get vdda1v8 supply: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(usbphyc->vdda1v8),
+				    "failed to get vdda1v8 supply\n");
 		goto clk_disable;
 	}
 
-- 
2.7.4

