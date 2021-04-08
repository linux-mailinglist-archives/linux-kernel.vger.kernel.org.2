Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF08357C61
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhDHGTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:19:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16399 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhDHGSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:18:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FG9yR6vz6zkjMl;
        Thu,  8 Apr 2021 14:16:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 14:18:27 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] ASoC: rt715-sdca: Constify static struct snd_soc_dai_ops
Date:   Thu, 8 Apr 2021 14:26:54 +0800
Message-ID: <20210408062654.803538-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snd_soc_dai_ops structures is only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
const to allow the compiler to put it in read-only memory.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 sound/soc/codecs/rt715-sdca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index 20528afbdc57..7db76c19e048 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -935,7 +935,7 @@ static int rt715_sdca_pcm_hw_free(struct snd_pcm_substream *substream,
 #define RT715_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt715_sdca_ops = {
+static const struct snd_soc_dai_ops rt715_sdca_ops = {
 	.hw_params	= rt715_sdca_pcm_hw_params,
 	.hw_free	= rt715_sdca_pcm_hw_free,
 	.set_sdw_stream	= rt715_sdca_set_sdw_stream,

