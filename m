Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4760E357C65
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhDHGTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:19:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16077 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhDHGSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:18:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FG9y76RRKz1BGB4;
        Thu,  8 Apr 2021 14:16:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 14:18:33 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] ASoC: codecs: wsa881x: constify static struct snd_soc_dai_ops
Date:   Thu, 8 Apr 2021 14:27:00 +0800
Message-ID: <20210408062700.803792-1-yebin10@huawei.com>
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
 sound/soc/codecs/wsa881x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index db87e07b11c9..2da4a5fa7a18 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1014,7 +1014,7 @@ static int wsa881x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
-static struct snd_soc_dai_ops wsa881x_dai_ops = {
+static const struct snd_soc_dai_ops wsa881x_dai_ops = {
 	.hw_params = wsa881x_hw_params,
 	.hw_free = wsa881x_hw_free,
 	.mute_stream = wsa881x_digital_mute,

