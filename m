Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1549C4557A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbhKRJGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:06:10 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244988AbhKRJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:05:22 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AI7gQtE008637;
        Thu, 18 Nov 2021 10:01:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=zTa6iwAkenfwAXDfT+3BtATdwtbJNpBWdvBtgRjZfxw=;
 b=2EKu3KEJC0AvueQsvwMUobtNS5qEWhKk6H5halib2SgQh+mbyKmeuKR2uSKhidzo4PlZ
 Qspiu3uZ6ctV8osNxT7aopnYKneiU4nacx1kAYAYs5IkZaZOV0+RJNSSVW5evwsvoW2q
 XxrD3KNwRTd1c3Ijx8LuTRUDZnlPdNCQDZ1UjBi/lPXJSQTDqLPP1oaSZNQvr+MTAZUP
 XcKmf36O5ZjWTtMDiDWEi4GimsuyaJuZcvOOFT+qfYOED5z6+Xf/ncxJ7HYCbxGvOsJ/
 AHE8gP9mz+JWRBfQyH6Clyu0S3mscNJrGxYt0xbMbBheLYFoWCB5ec0COHjhQWpak+lH 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cdjp68gs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 10:01:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9EBA10002A;
        Thu, 18 Nov 2021 10:01:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D046721A234;
        Thu, 18 Nov 2021 10:01:28 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 18 Nov 2021 10:01:28
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
Subject: [PATCH 3/3] ASoC: stm32: spdifrx: add pm_runtime support
Date:   Thu, 18 Nov 2021 10:00:35 +0100
Message-ID: <20211118090035.5331-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211118090035.5331-1-olivier.moysan@foss.st.com>
References: <20211118090035.5331-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_04,2021-11-17_01,2020-04-07_01
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
index 48145f553588..e885796ca5f4 100644
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
@@ -1045,6 +1047,8 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 			FIELD_GET(SPDIFRX_VERR_MIN_MASK, ver));
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	return ret;
 
 error:
-- 
2.17.1

