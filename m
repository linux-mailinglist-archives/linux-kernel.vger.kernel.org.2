Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10E42F7CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhJOQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:16:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48628 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237230AbhJOQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:16:55 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FDksMV016875;
        Fri, 15 Oct 2021 18:14:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=AZCLz9Qu7aCsRJuQKx+MRmvklKYmjkNGSFeQSH6HK7E=;
 b=V7QElrLBUwQPTbuoMIapayW59vQ5g7AC+5zqrySEBWPlux5L1NfY26cMoBiP4hiMCMPK
 kkdDgqe1hI3OtQGxnXy2n3xI+ijoLFVcGzAoLnWeWRpH8PlEoCnHRrsigL7Tv/WoUo7L
 IX1bY/0cXvax1Cx2Jtvs946Mz8oXa6ebK3+hTTcDlpMzn5x0NwiM05Kno94FggOQWp05
 9e39diEaOySNaJxby1fFACLenP8w7ue+zrCozl5Ka8IukLXeSGsVs9kuf5Xj9j2SHNk4
 OS6pqiGv/5m6hBVECKYGyLfii5GqrMO3p7d995nI0fRdq0dtKV5r0a/LrAfserY0Tx/1 tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bqau2ru9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 18:14:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7982100034;
        Fri, 15 Oct 2021 18:14:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A095B231513;
        Fri, 15 Oct 2021 18:14:37 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 15 Oct 2021 18:14:37
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
Subject: [PATCH v3 1/3] phy: stm32: restore utmi switch on resume
Date:   Fri, 15 Oct 2021 18:14:25 +0200
Message-ID: <20211015161427.220784-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015161427.220784-1-amelie.delaunay@foss.st.com>
References: <20211015161427.220784-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_05,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UTMI switch value can be lost during suspend/resume, depending on the power
state reached.
This patch adds resume function to usbphyc, to reconfigure utmi switch
after suspend.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 937a14fa7448..083593aea53a 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -598,6 +598,18 @@ static int stm32_usbphyc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused stm32_usbphyc_resume(struct device *dev)
+{
+	struct stm32_usbphyc *usbphyc = dev_get_drvdata(dev);
+
+	if (usbphyc->switch_setup >= 0)
+		stm32_usbphyc_switch_setup(usbphyc, usbphyc->switch_setup);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_usbphyc_pm_ops, NULL, stm32_usbphyc_resume);
+
 static const struct of_device_id stm32_usbphyc_of_match[] = {
 	{ .compatible = "st,stm32mp1-usbphyc", },
 	{ },
@@ -610,6 +622,7 @@ static struct platform_driver stm32_usbphyc_driver = {
 	.driver = {
 		.of_match_table = stm32_usbphyc_of_match,
 		.name = "stm32-usbphyc",
+		.pm = &stm32_usbphyc_pm_ops,
 	}
 };
 module_platform_driver(stm32_usbphyc_driver);
-- 
2.25.1

