Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D110945454E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhKQLEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:04:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38582 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231307AbhKQLEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:04:54 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AH7M65Y014827;
        Wed, 17 Nov 2021 12:01:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=1/Q21ux/FGI1kNRl1aPygtxOq6sHNR7PApw2cIasDJk=;
 b=cvoCf88sQ1fE7S+lU40DR7GmGIKEecZoHhIn+2hvhGTXeanJQ5K22JP6xVi3F2aWHeZg
 jJG0BQHz6bLC/ElfBdNr2uhAxEgLJrqORtrlPCjClDXDxIzBFpZ0x/ZIY4lRb4BL1AF5
 7ztA2b5qy14O5dpkL2i4tI6rxl6hCLBmieNgudP6+iTbqKqk9+hzR9q8BQtTyFMifTXO
 eq0QXW6e+h/5FqUKyCoOptBuhRoAedJ22bW16RZXQJjuR/8CJLIK7lKKmN5i5DwvZc6C
 kdj9NHMwjgJyCieFlGH3tOSgmaU9anSMQ7se8rg8frUA0gLQiQZIH1YY8D5INcdUMbEP yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ccq6auuhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 12:01:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12A78100038;
        Wed, 17 Nov 2021 12:01:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2063B21B05F;
        Wed, 17 Nov 2021 12:01:04 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 17 Nov 2021 12:01:03
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH] ASoC: stm32: sai: increase channels_max limit
Date:   Wed, 17 Nov 2021 12:00:31 +0100
Message-ID: <20211117110031.19345-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_04,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

The SAI peripheral supports up to 16 channels in TDM mode (8L+8R).
The driver currently supports TDM over two channels.
Increase SAI DAI playback/record channels_max,
to also allow up to 16 channels in TDM mode.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 9c3b8e209656..95cd38a502bb 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1294,7 +1294,7 @@ static struct snd_soc_dai_driver stm32_sai_playback_dai = {
 		.id = 1, /* avoid call to fmt_single_name() */
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 16,
 			.rate_min = 8000,
 			.rate_max = 192000,
 			.rates = SNDRV_PCM_RATE_CONTINUOUS,
@@ -1312,7 +1312,7 @@ static struct snd_soc_dai_driver stm32_sai_capture_dai = {
 		.id = 1, /* avoid call to fmt_single_name() */
 		.capture = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 16,
 			.rate_min = 8000,
 			.rate_max = 192000,
 			.rates = SNDRV_PCM_RATE_CONTINUOUS,
-- 
2.17.1

