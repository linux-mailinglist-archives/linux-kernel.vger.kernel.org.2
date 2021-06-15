Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6A3A8738
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFORNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:13:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4923 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhFORNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:13:42 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4FBy1bdcz705q;
        Wed, 16 Jun 2021 01:08:26 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 01:11:34 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] ASoC: hdmi-codec: Make symbol 'hdmi_codec_controls' static
Date:   Tue, 15 Jun 2021 17:21:56 +0000
Message-ID: <20210615172156.2840576-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

sound/soc/codecs/hdmi-codec.c:750:25: warning:
 symbol 'hdmi_codec_controls' was not declared. Should it be static?

This symbol is not used outside of hdmi-codec.c, so marks it static.

Fixes: 366b45b97448 ("ASoC: hdmi-codec: Rework to support more controls")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index e0460a9bd17a..b61f980cabdc 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -747,7 +747,7 @@ static const struct snd_soc_dai_ops hdmi_codec_spdif_dai_ops = {
 			 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |\
 			 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
-struct snd_kcontrol_new hdmi_codec_controls[] = {
+static struct snd_kcontrol_new hdmi_codec_controls[] = {
 	{
 		.access = SNDRV_CTL_ELEM_ACCESS_READ,
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,

