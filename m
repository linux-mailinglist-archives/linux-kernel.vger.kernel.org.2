Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FD038FD74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhEYJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:10:40 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:27088 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231490AbhEYJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:10:38 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P97IsG008620;
        Tue, 25 May 2021 04:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=CuPkBOU+Sw4zKXqljYp7hETUN1j+lmbdzK/X2BMYo7Q=;
 b=I1ZDJXrkXRuV0HwyIHJF1BYwt7pnvovBuswgABGmuO7wjulzks/kXZbP+lbEb7rNJ/HG
 htvoz6Vpw1/jaSc3oiceJoTYbwL/YJA/oSlzAi7CLBBYQicWYIAgQuuxddexUMWPhu+/
 f2ZceUPq3Pvfz9eN1WGpOkXuj2yzhymmF/c9iHzhnX3B5HXnbw41dUW+EtTAOgTGyNGC
 tv8/fyISXHEj+EEI5jb9NnBV4pcx1Db8K8b77KUuEbju/v/D3eVoO8LOSXlstXivM9Os
 /bJnycuKsrB+YyvGOvOeMksI5eUzfgsYYWfXDB291BiqweqeK8o2AhlzAovPNhfguCNe nA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38r28v1khx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 04:08:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 10:08:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 10:08:25 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 62E7E11CD;
        Tue, 25 May 2021 09:08:25 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 4/4] ASoC: cs42l42: Check jack status before reporting button events
Date:   Tue, 25 May 2021 10:08:22 +0100
Message-ID: <20210525090822.64577-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525090822.64577-1-tanureal@opensource.cirrus.com>
References: <20210525090822.64577-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -5_N_XhPBkuNFOW2NNfTXC4lHYpQ4LRP
X-Proofpoint-GUID: -5_N_XhPBkuNFOW2NNfTXC4lHYpQ4LRP
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jack must be connected before reporting button events and
if the jack is disconnected button release must be reported

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 8260de81b56c..eff013f295be 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1478,6 +1478,10 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 				default:
 					break;
 				}
+				snd_soc_jack_report(cs42l42->jack, 0,
+						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
+
 				dev_dbg(component->dev, "Unplug event\n");
 			}
 			break;
@@ -1489,7 +1493,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	}
 
 	/* Check button detect status */
-	if ((~masks[7]) & irq_params_table[7].mask) {
+	if (cs42l42->plug_state == CS42L42_TS_PLUG && ((~masks[7]) & irq_params_table[7].mask)) {
 		if (!(current_button_status &
 			CS42L42_M_HSBIAS_HIZ_MASK)) {
 
-- 
2.31.1

