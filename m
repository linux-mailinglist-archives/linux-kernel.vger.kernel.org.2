Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634E8454528
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 11:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhKQKsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 05:48:39 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54894 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231777AbhKQKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:48:38 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AH9HK1g024792;
        Wed, 17 Nov 2021 11:44:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=6pg6K8gBh2cerBYz6mBDWC+nZHXKNeCSWupwbJmZ6RQ=;
 b=Is+BCHvc2dH6/lwryIQIMXmbes8Z35xUOTPUWzxzZx6DNH8QUbYaviJACApf+1Hmkulm
 m0Bstjgov1gMU6NIlyYvMf3pvrhsaDOdVLrmHc7PD0ym1Tj9RU2YKUU3YkMtsPMwJ5iJ
 qCPl5HN+2v2mJ3q3LH0tkXGNkos1Le5jqjKXZg4FlJXmnP/FHBcWzZwlLr1cG4RGpT3i
 BvfbNBTQs27QWLodi4BqEnswCO4YY7OJNKnJmfVQKebnKUVON8Ol4NIDRtvq17CDHN1G
 ySdXcqznaAPAN6B8AlmKg3NgfdIgQt+hYFwXJ6PRmqZfgY6sz/Zo/2MXjNRtvwXP9F1/ 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ccxypgkmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 11:44:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CA6610002A;
        Wed, 17 Nov 2021 11:44:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2A51E209300;
        Wed, 17 Nov 2021 11:44:48 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 17 Nov 2021 11:44:47
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
Subject: [PATCH] ASoC: stm32: i2s: fix 32 bits channel length without mclk
Date:   Wed, 17 Nov 2021 11:44:04 +0100
Message-ID: <20211117104404.3832-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_03,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix divider calculation in the case of 32 bits channel
configuration, when no master clock is used.

Fixes: e4e6ec7b127c ("ASoC: stm32: Add I2S driver")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 6254bacad6eb..717f45a83445 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -700,7 +700,7 @@ static int stm32_i2s_configure_clock(struct snd_soc_dai *cpu_dai,
 		if (ret < 0)
 			return ret;
 
-		nb_bits = frame_len * ((cgfr & I2S_CGFR_CHLEN) + 1);
+		nb_bits = frame_len * (FIELD_GET(I2S_CGFR_CHLEN, cgfr) + 1);
 		ret = stm32_i2s_calc_clk_div(i2s, i2s_clock_rate,
 					     (nb_bits * rate));
 		if (ret)
-- 
2.17.1

