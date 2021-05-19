Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3154388C06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbhESKvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22982 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345051AbhESKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621421395; x=1652957395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHk0TRGCIe8ah9IbWKNOCz5WNUTu7v3xCZwfWNzTb/w=;
  b=xcf3F3rxtRMMBI1NxwQ1Pjog6f4rzOS2IdavuPZcUGT9ZURztOjnpY/P
   FuSC9M/V6xfO+vzwiKsxov+83Ldm5RlvQaXA9g0/878X1eIfU81m79acW
   eSdnPA8A6IhAfT9gleWBBC0rz6ENXyER/Sqke+lHAtwLneJnNBJHln8EO
   UZq13vyH+fczRQj5R7C+RRgj94ygUmSo3hiqlphqwdIYGLx3vNEy8S2bV
   MQ8043F8sStYO34NkqmaL+1FGhn0TKLDdA1wE+vFARLnSzYoumo5ZlSdd
   r107gPRMyq1UCvrI4WH92AuRfTRyk8hcCYHk21GLnUwzp5c2aj60ykRJF
   w==;
IronPort-SDR: cljuQcxyhS5vwA61XVnvbHMXU8VmFpRkdEknuqUwJ3cH8c/IsPYCiRB8o1Lz9DL2UsnoEzQaMT
 i/+j1+nBmI/UVRuqtBpWROZu5hGXt0nPXIG3GaD82IYk6doSMosskjSrU7Jv3IT520xm2f/0OL
 +JHYAtfslAKvzB1LPuGx3mds5o3vLIMv8C1lJ1K5mNDHZbdbZI4uS3/Bz8XKQlBTyrFpamWvNC
 EGSzky41De+g2YrQikYvCoJvGDEaLg9fj2c5h+ZUYJ2cMUBRYsBeOfMNw70fzMWgJ3dEQ3U3/H
 FVQ=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; 
   d="scan'208";a="128651266"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 03:49:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:49:52 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:48 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        <joe@perches.com>, <lgirdwood@gmail.com>, <lars@metafoo.de>,
        <kuninori.morimoto.gx@renesas.com>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 4/6] ALSA: pcm: Create function for snd_pcm_runtime initialization
Date:   Wed, 19 May 2021 13:48:40 +0300
Message-ID: <20210519104842.977895-5-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
References: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group the setting of snd_pcm_runtime members in a separate function. This
allows for code reutilization. Also, check for substream->ops before
substream->ops->copy_user .

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 include/sound/pcm.h     |   2 +
 sound/core/pcm_native.c | 108 ++++++++++++++++++++++------------------
 2 files changed, 61 insertions(+), 49 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2907ed2b937f..8e6bd4525c02 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -576,6 +576,8 @@ static inline int snd_pcm_suspend_all(struct snd_pcm *pcm)
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg);
 struct snd_pcm_runtime *snd_pcm_runtime_alloc(void);
 void snd_pcm_runtime_free(struct snd_pcm_runtime *runtime);
+void snd_pcm_runtime_set(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params);
 int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
 			   struct snd_pcm_substream **rsubstream);
 void snd_pcm_release_substream(struct snd_pcm_substream *substream);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index cb0164d55593..5b0e7ae2b1e7 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -658,13 +658,69 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 	return 0;
 }
 
+void snd_pcm_runtime_set(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int bits;
+	snd_pcm_uframes_t frames;
+
+	runtime->access = params_access(params);
+	runtime->format = params_format(params);
+	runtime->subformat = params_subformat(params);
+	runtime->channels = params_channels(params);
+	runtime->rate = params_rate(params);
+	runtime->period_size = params_period_size(params);
+	runtime->periods = params_periods(params);
+	runtime->buffer_size = params_buffer_size(params);
+	runtime->info = params->info;
+	runtime->rate_num = params->rate_num;
+	runtime->rate_den = params->rate_den;
+	runtime->no_period_wakeup =
+			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
+			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
+
+	bits = snd_pcm_format_physical_width(runtime->format);
+	runtime->sample_bits = bits;
+	bits *= runtime->channels;
+	runtime->frame_bits = bits;
+	frames = 1;
+	while (bits % 8 != 0) {
+		bits *= 2;
+		frames *= 2;
+	}
+	runtime->byte_align = bits / 8;
+	runtime->min_align = frames;
+
+	/* Default sw params */
+	runtime->tstamp_mode = SNDRV_PCM_TSTAMP_NONE;
+	runtime->period_step = 1;
+	runtime->control->avail_min = runtime->period_size;
+	runtime->start_threshold = 1;
+	runtime->stop_threshold = runtime->buffer_size;
+	runtime->silence_threshold = 0;
+	runtime->silence_size = 0;
+	runtime->boundary = runtime->buffer_size;
+	while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
+		runtime->boundary *= 2;
+
+	/* clear the buffer for avoiding possible kernel info leaks */
+	if (runtime->dma_area &&
+	    !(substream->ops && substream->ops->copy_user)) {
+		size_t size = runtime->dma_bytes;
+
+		if (runtime->info & SNDRV_PCM_INFO_MMAP)
+			size = PAGE_ALIGN(size);
+		memset(runtime->dma_area, 0, size);
+	}
+}
+EXPORT_SYMBOL(snd_pcm_runtime_set);
+
 static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime;
 	int err, usecs;
-	unsigned int bits;
-	snd_pcm_uframes_t frames;
 
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
@@ -715,53 +771,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 			goto _error;
 	}
 
-	runtime->access = params_access(params);
-	runtime->format = params_format(params);
-	runtime->subformat = params_subformat(params);
-	runtime->channels = params_channels(params);
-	runtime->rate = params_rate(params);
-	runtime->period_size = params_period_size(params);
-	runtime->periods = params_periods(params);
-	runtime->buffer_size = params_buffer_size(params);
-	runtime->info = params->info;
-	runtime->rate_num = params->rate_num;
-	runtime->rate_den = params->rate_den;
-	runtime->no_period_wakeup =
-			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
-			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
-
-	bits = snd_pcm_format_physical_width(runtime->format);
-	runtime->sample_bits = bits;
-	bits *= runtime->channels;
-	runtime->frame_bits = bits;
-	frames = 1;
-	while (bits % 8 != 0) {
-		bits *= 2;
-		frames *= 2;
-	}
-	runtime->byte_align = bits / 8;
-	runtime->min_align = frames;
-
-	/* Default sw params */
-	runtime->tstamp_mode = SNDRV_PCM_TSTAMP_NONE;
-	runtime->period_step = 1;
-	runtime->control->avail_min = runtime->period_size;
-	runtime->start_threshold = 1;
-	runtime->stop_threshold = runtime->buffer_size;
-	runtime->silence_threshold = 0;
-	runtime->silence_size = 0;
-	runtime->boundary = runtime->buffer_size;
-	while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
-		runtime->boundary *= 2;
-
-	/* clear the buffer for avoiding possible kernel info leaks */
-	if (runtime->dma_area && !substream->ops->copy_user) {
-		size_t size = runtime->dma_bytes;
-
-		if (runtime->info & SNDRV_PCM_INFO_MMAP)
-			size = PAGE_ALIGN(size);
-		memset(runtime->dma_area, 0, size);
-	}
+	snd_pcm_runtime_set(substream, params);
 
 	snd_pcm_timer_resolution_change(substream);
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
-- 
2.27.0

