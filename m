Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5963A9177
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFPF6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 01:58:01 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35236 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhFPF6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:58:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UcaEjH7_1623822948;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UcaEjH7_1623822948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 13:55:52 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ASoC: hdmi-codec: make hdmi_codec_controls static
Date:   Wed, 16 Jun 2021 13:55:41 +0800
Message-Id: <1623822941-3077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of hdmi-codec.c, so marks it static.

Fix the following sparse warning:

sound/soc/codecs/hdmi-codec.c:750:25: warning: symbol
'hdmi_codec_controls' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index e0460a9..b61f980 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -747,7 +747,7 @@ static int hdmi_codec_mute(struct snd_soc_dai *dai, int mute, int direction)
 			 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |\
 			 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
-struct snd_kcontrol_new hdmi_codec_controls[] = {
+static struct snd_kcontrol_new hdmi_codec_controls[] = {
 	{
 		.access = SNDRV_CTL_ELEM_ACCESS_READ,
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-- 
1.8.3.1

