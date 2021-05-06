Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3563752B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhEFLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:00:07 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48051 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234508AbhEFLAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:00:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UXyJL8X_1620298736;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UXyJL8X_1620298736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 May 2021 18:59:02 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ASoC: rt286: Remove redundant assignment to d_len_code
Date:   Thu,  6 May 2021 18:58:55 +0800
Message-Id: <1620298735-31708-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable d_len_code is set to zero, but this value is never read as
it is overwritten or not used later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

sound/soc/codecs/rt286.c:728:2: warning: Value stored to 'd_len_code' is
never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/rt286.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 802f485..caa7208 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -725,7 +725,6 @@ static int rt286_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	d_len_code = 0;
 	switch (params_width(params)) {
 	/* bit 6:4 Bits per Sample */
 	case 16:
-- 
1.8.3.1

