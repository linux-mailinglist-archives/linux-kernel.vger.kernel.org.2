Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D249239ECBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFHDJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:09:01 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:10704 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFHDI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:08:59 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id EA1F4AC0247;
        Tue,  8 Jun 2021 11:07:05 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ASoC: remove unneeded semicolons in wcd934x.c
Date:   Tue,  8 Jun 2021 11:06:55 +0800
Message-Id: <20210608030656.24052-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhoaQ1ZJTUIdGRpPHk1NSxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6Hyo5Qz8VPw5MTjM3DTMO
        FU4KCRlVSlVKTUlISklKTUlNT0xKVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJT01ONwY+
X-HM-Tid: 0a79e996840cb039kuuuea1f4ac0247
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./sound/soc/codecs/wcd934x.c:5136:2-3: Unneeded semicolon
./sound/soc/codecs/wcd934x.c:2466:2-3: Unneeded semicolon
./sound/soc/codecs/wcd934x.c:2527:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/soc/codecs/wcd934x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 16fd1ab62609..c496b359f2f4 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2463,7 +2463,7 @@ static int wcd934x_micbias_control(struct snd_soc_component *component,
 		dev_err(component->dev, "%s: Invalid micbias number: %d\n",
 			__func__, micb_num);
 		return -EINVAL;
-	};
+	}
 	mutex_lock(&wcd934x->micb_lock);
 
 	switch (req) {
@@ -2524,7 +2524,7 @@ static int wcd934x_micbias_control(struct snd_soc_component *component,
 			wcd_mbhc_event_notify(wcd934x->mbhc,
 					      WCD_EVENT_POST_DAPM_MICBIAS_2_OFF);
 		break;
-	};
+	}
 
 	mutex_unlock(&wcd934x->micb_lock);
 
@@ -5133,7 +5133,7 @@ static int wcd934x_codec_enable_micbias(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMD:
 		wcd934x_micbias_control(component, micb_num, MICB_DISABLE, true);
 		break;
-	};
+	}
 
 	return 0;
 }
-- 
2.20.1

