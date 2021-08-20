Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57B23F2CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhHTNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:03:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48692 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240479AbhHTNDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:03:08 -0400
X-UUID: 9206e17dca2047cb948232e055612409-20210820
X-UUID: 9206e17dca2047cb948232e055612409-20210820
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chien-yu.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 188944706; Fri, 20 Aug 2021 21:02:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Aug 2021 21:02:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Aug 2021 21:02:25 +0800
From:   Chien-Yu Lin <chien-yu.lin@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yichin.huang@mediatek.com>,
        <hungjung.hsu@mediatek.com>, <allen-hw.hsu@mediatek.com>,
        <chien-yu.lin@mediatek.com>
Subject: [PATCH] ASoc: fix ASoC driver to support ops to register get_time_info
Date:   Fri, 20 Aug 2021 21:02:10 +0800
Message-ID: <20210820130210.3321-1-chien-yu.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "chien-yu.lin" <chien-yu.lin@mediatek.com>

Because ASoC soc_new_pcm() function didn't register
.get_time_info() ops and cause snd_pcm_update_hw_ptr0() can not find
substream->ops->get_time_info, it will not be called due to ASoC
driver which register in HW device driver.

Add .get_time_info() ops in ASoC soc_new_pcm() and
register by snd_pcm_set_ops() function.
If HW device driver want to implment timestamp by itself,
ASoC should register .get_time_info function.

Signed-off-by: chien-yu.lin <chien-yu.lin@mediatek.com>
---
 include/sound/soc-component.h |  4 ++++
 sound/soc/soc-component.c     | 21 +++++++++++++++++++++
 sound/soc/soc-pcm.c           |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 8c4d6830597f..52b5228b7a8d 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -484,6 +484,10 @@ int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream);
 int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
 				    int channel, unsigned long pos,
 				    void __user *buf, unsigned long bytes);
+int snd_soc_pcm_component_get_time_info(struct snd_pcm_substream *substream,
+					struct timespec64 *system_ts, struct timespec64 *audio_ts,
+					struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
+					struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
 struct page *snd_soc_pcm_component_page(struct snd_pcm_substream *substream,
 					unsigned long offset);
 int snd_soc_pcm_component_mmap(struct snd_pcm_substream *substream,
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 3a5e84e16a87..56caec7ec00b 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -1000,6 +1000,27 @@ int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
 	return -EINVAL;
 }
 
+int snd_soc_pcm_component_get_time_info(struct snd_pcm_substream *substream,
+					struct timespec64 *system_ts, struct timespec64 *audio_ts,
+					struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
+					struct snd_pcm_audio_tstamp_report *audio_tstamp_report)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_component *component;
+	int i;
+
+	/* FIXME. it returns 1st get_time_info now */
+	for_each_rtd_components(rtd, i, component) {
+		if (component->driver->get_time_info)
+			return soc_component_ret(component,
+				component->driver->get_time_info(component,
+				substream, system_ts, audio_ts,
+				audio_tstamp_config, audio_tstamp_report));
+	}
+
+	return -EINVAL;
+}
+
 struct page *snd_soc_pcm_component_page(struct snd_pcm_substream *substream,
 					unsigned long offset)
 {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d1c570ca21ea..cff7025027a6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2786,6 +2786,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->ops.mmap		= snd_soc_pcm_component_mmap;
 		if (drv->ack)
 			rtd->ops.ack            = snd_soc_pcm_component_ack;
+		if (drv->get_time_info)
+			rtd->ops.get_time_info	= snd_soc_pcm_component_get_time_info;
 	}
 
 	if (playback)
-- 
2.18.0

