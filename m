Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497A30A2F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhBAICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:02:22 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54244 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231598AbhBAICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:02:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UNVd3F._1612166482;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNVd3F._1612166482)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 16:01:22 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, broonie@kernel.org, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ASoC: Intel: catpt: remove unneeded semicolon
Date:   Mon,  1 Feb 2021 16:01:21 +0800
Message-Id: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./sound/soc/intel/catpt/pcm.c:355:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/intel/catpt/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index e5d54bb..88a0879 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -352,7 +352,7 @@ static int catpt_dai_apply_usettings(struct snd_soc_dai *dai,
 		break;
 	default:
 		return 0;
-	};
+	}
 
 	list_for_each_entry(pos, &component->card->snd_card->controls, list) {
 		if (pos->private_data == component &&
-- 
1.8.3.1

