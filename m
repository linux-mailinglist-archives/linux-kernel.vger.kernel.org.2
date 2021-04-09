Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F19359529
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhDIGIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:08:49 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50476 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231280AbhDIGIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:08:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UUyCm9A_1617948507;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUyCm9A_1617948507)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Apr 2021 14:08:33 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     cezary.rojewski@intel.com
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ASoC: Intel: bytcr_wm5102: remove useless variable
Date:   Fri,  9 Apr 2021 14:08:26 +0800
Message-Id: <1617948506-84638-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

sound/soc/intel/boards/bytcr_wm5102.c:216:40: warning:
‘byt_wm5102_dai_params’ defined but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/intel/boards/bytcr_wm5102.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index f38850e..fd584e3 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -213,14 +213,6 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 	return 0;
 }
 
-static const struct snd_soc_pcm_stream byt_wm5102_dai_params = {
-	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	.rate_min = 48000,
-	.rate_max = 48000,
-	.channels_min = 2,
-	.channels_max = 2,
-};
-
 static int byt_wm5102_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 				  struct snd_pcm_hw_params *params)
 {
-- 
1.8.3.1

