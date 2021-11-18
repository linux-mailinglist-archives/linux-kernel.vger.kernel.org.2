Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603DE4557A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbhKRJGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:06:23 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244999AbhKRJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:05:23 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AI7gMBW008365;
        Thu, 18 Nov 2021 10:01:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=cdPo19iAbIaC83Fonb3k8U/daSH+wXTAWbWwLOIFhls=;
 b=ZRiI8D0UivOYUfFBdX5npzKIgoB6ouPBIjwGddKd8rMha9M2BoiSaxp4La10XI3dCLUl
 Dfqcrs2Bu8CSl/9Rc7QzkwFFUkqmZozlbHTxNgYkazEh0cCiYlN/aj+h68vuO+1aeEsF
 yyySjCk+24OqsylEHPm0CGpyxDIgTdOUMdkALI5EqmD7ddBWri4eXjRNqhODzsfo6hnN
 ZeqYHJboW1OyAhc205iBZokKVKJYvTl0zuXn8aEpjXz6WxM+7f8tgM4bW42KPIKDEdq6
 jS5uPF4YI8SwJA9Eu7Oh3q/LMhBpEcbJIYOIZEsijJww+h8Mj2K2KXMCfznJB0JiKiXv ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cdjp68gry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 10:01:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 303C8100038;
        Thu, 18 Nov 2021 10:01:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 263A721A234;
        Thu, 18 Nov 2021 10:01:28 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 18 Nov 2021 10:01:27
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
Subject: [PATCH 2/3] ASoC: stm32: dfsdm: add pm_runtime support for audio
Date:   Thu, 18 Nov 2021 10:00:34 +0100
Message-ID: <20211118090035.5331-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211118090035.5331-1-olivier.moysan@foss.st.com>
References: <20211118090035.5331-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_04,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support of pm_runtime on STM32 DFSDM audio driver
to allow power state monitoring.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index e6078f50e508..534f96af97c5 100644
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
@@ -363,15 +363,20 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 #endif
 
 	ret = snd_soc_add_component(component, NULL, 0);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&pdev->dev, "%s: Failed to register PCM platform\n",
 			__func__);
+		return ret;
+	}
 
-	return ret;
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
 }
 
 static int stm32_adfsdm_remove(struct platform_device *pdev)
 {
+	pm_runtime_disable(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
-- 
2.17.1

