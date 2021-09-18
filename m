Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1017341054A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbhIRJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:04:18 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54566 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233888AbhIRJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:04:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UomJtwg_1631955766;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UomJtwg_1631955766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Sep 2021 17:02:49 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ASoC: rt5682s: make rt5682s_aif2_dai_ops and rt5682s_soc_component_dev
Date:   Sat, 18 Sep 2021 17:02:06 +0800
Message-Id: <1631955726-77693-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of rt5682s.c, so marks it static.

Fix the following sparse warning:

sound/soc/codecs/rt5682s.c:2848:39: warning: symbol
'rt5682s_soc_component_dev' was not declared. Should it be static?

sound/soc/codecs/rt5682s.c:2842:30: warning: symbol
'rt5682s_aif2_dai_ops' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/rt5682s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index d878a20..d3e965b 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2839,13 +2839,13 @@ static int rt5682s_resume(struct snd_soc_component *component)
 	.set_bclk_ratio = rt5682s_set_bclk1_ratio,
 };
 
-const struct snd_soc_dai_ops rt5682s_aif2_dai_ops = {
+static const struct snd_soc_dai_ops rt5682s_aif2_dai_ops = {
 	.hw_params = rt5682s_hw_params,
 	.set_fmt = rt5682s_set_dai_fmt,
 	.set_bclk_ratio = rt5682s_set_bclk2_ratio,
 };
 
-const struct snd_soc_component_driver rt5682s_soc_component_dev = {
+static const struct snd_soc_component_driver rt5682s_soc_component_dev = {
 	.probe = rt5682s_probe,
 	.remove = rt5682s_remove,
 	.suspend = rt5682s_suspend,
-- 
1.8.3.1

