Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B183456DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhKSKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:53:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40670 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234945AbhKSKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:53:12 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJ9dFv5001984;
        Fri, 19 Nov 2021 11:49:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=xyqfWAf7yUmLO3g8n/gJdqZwt+K7c4XpPoDS7K1AxAE=;
 b=MDPnfFrlCRzeZaJfUUNIOzLrVBW8EGPLLnWtPaapQbMaXAh3i0roy1/LyQ9WGvC5R9B0
 wF0R+TrMcF4xxemcfBncJpZ5p3VvYHyUKvXZMGkp3DZV+Buy+ga2DGYhqfKFjyo6YGAU
 d1FWip6IGOc9jQZrq4HT/XQ15Gtv8ak9JthyvvCqwUN5y7dU6ualmYuwguwfVQqztHBS
 zeaOP49dOKKcNCVq2Y5UCSD35L10/mU9QU5bG23POryZS5xkOaAL8bSHceU+025kHTmM
 0CpymtGiC6N2Eiww3Gh5eY0fokZoKPweBE51dvwQNvq+TdBTw/+yTOEmVXyV57zH/RJX vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce1knb038-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 11:49:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B32C10002A;
        Fri, 19 Nov 2021 11:49:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2F927205B4A;
        Fri, 19 Nov 2021 11:49:48 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 11:49:47
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
Subject: [PATCH v2 3/3] ASoC: stm32: spdifrx: add pm_runtime support
Date:   Fri, 19 Nov 2021 11:47:52 +0100
Message-ID: <20211119104752.13564-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119104752.13564-1-olivier.moysan@foss.st.com>
References: <20211119104752.13564-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support of pm_runtime on STM32 SPDIFRX driver to allow
SPDIFRX power state monitoring.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 48145f553588..a9ccdc2c5867 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -955,6 +956,7 @@ static int stm32_spdifrx_remove(struct platform_device *pdev)
 
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
@@ -1010,6 +1012,8 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	udelay(2);
 	reset_control_deassert(rst);
 
+	pm_runtime_enable(&pdev->dev);
+
 	pcm_config = &stm32_spdifrx_pcm_config;
 	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config, 0);
 	if (ret) {
-- 
2.17.1

