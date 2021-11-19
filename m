Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF98456DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhKSKxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:53:49 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:55946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhKSKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:53:44 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJ97MEg009666;
        Fri, 19 Nov 2021 11:49:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Rn+nixVXrJENhhS1yQ7TEnBa0u4Alg+yZJy2C2jbfTY=;
 b=Ab56P/v6VNNDRVMwryyyI+ShPmAlhdMNIUucoSDMN+bBSnC713IlwEU5dWhEiNC6nTYz
 yDrvV4UUY840Hw4uefEVNWEc9Iz6i0QV2uzOvALCAcOitELR3uzi6hax29zjjyuzY/a6
 D4GX6nMoDWmNjosj7GruDW0kDslHRshROvHonOFmiHdhj0l7RJqr9KOQuzyCrpXQ7/4a
 yXP25EG3sQjSTvMuOPIG2/GlGnqy2BXoY6AxhavBwcEh3WA8++jyBdD/UPsIsLuz21vO
 jfMef7OBgtJWDa635JhYxtkD08bU3nzDfzKEOzhvPcMRcCUltzjYBj2OfIMv/uyyFMxz FQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce910rnp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 11:49:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 516A310002A;
        Fri, 19 Nov 2021 11:49:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 48B612248C2;
        Fri, 19 Nov 2021 11:49:47 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 11:49:46
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/3] ASoC: stm32: dfsdm: add pm_runtime support for audio
Date:   Fri, 19 Nov 2021 11:47:51 +0100
Message-ID: <20211119104752.13564-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119104752.13564-1-olivier.moysan@foss.st.com>
References: <20211119104752.13564-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support of pm_runtime on STM32 DFSDM audio driver
to allow power state monitoring.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index e6078f50e508..6ee714542b84 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -12,7 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
+#include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/adc/stm32-dfsdm-adc.h>
@@ -334,6 +334,8 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, priv);
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &stm32_adfsdm_dai_component,
 					      &priv->dai_drv, 1);
@@ -373,6 +375,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 static int stm32_adfsdm_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.17.1

