Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA964357C64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhDHGTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:19:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15173 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhDHGSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:18:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FG9xS0Q1QzpVj9;
        Thu,  8 Apr 2021 14:15:56 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 14:18:35 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] ASoC: rt1019: constify static struct snd_soc_dai_ops
Date:   Thu, 8 Apr 2021 14:27:01 +0800
Message-ID: <20210408062701.803865-1-yebin10@huawei.com>
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
 sound/soc/codecs/rt1019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1019.c b/sound/soc/codecs/rt1019.c
index 5138f028d9f2..f64bb7302720 100644
--- a/sound/soc/codecs/rt1019.c
+++ b/sound/soc/codecs/rt1019.c
@@ -823,7 +823,7 @@ static int rt1019_probe(struct snd_soc_component *component)
 #define RT1019_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt1019_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt1019_aif_dai_ops = {
 	.hw_params = rt1019_hw_params,
 	.set_fmt = rt1019_set_dai_fmt,
 	.set_sysclk = rt1019_set_dai_sysclk,

