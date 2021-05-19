Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E121F388C01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhESKvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61318 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhESKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621421381; x=1652957381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFvbkt+QgKqh1RR/T8GvsLtgxKyaio8KFYLcVIRZ/9s=;
  b=gFBgMPDvkUqIEfr5lLvm+U20h86hP8VMhliYkh9ymXEMP/5R32dP+QHG
   djIcqnJmh1U5J8xcWUmMl3tNpXnMNahYXXsEHz9Jr8yjHIiflWAP/imY+
   nt/KThEQURidFEsjNJa7DIG77HK/M8Yv5JVufoJOLd9A2O1iewwEyQHHP
   x92GR+sPqb6DIoKuLwRXeN9FRDkWrwHvMgYm6+MSF68g4FRhNtbhzej14
   1Eg4QvuK8lC6q+kQwHbsfJhJ+Fpxp3zjpgH/ZQB0AxRf/0pR/pB72UAZx
   5FPicYA/5AEX3kYaKrLmVLLRqN3L2L46UMAj3NH6x7wa8dXPI+A//x2XX
   w==;
IronPort-SDR: RSbC8ILc3hFXkjAJorW2jJyxxKJEdarEEa7D2fyBRufLeadke1cTeP3zQcddcdlA5IUBkZt8bq
 oNqznPgk5IHSNfPTLpzEz35S57wP+X3l7EyuMESD8Okma33vAWC/DB/NaO3LP+ubeAds4Ka3y3
 vrEJ0vM1SpdglEZDf33GjUPMwiJxC0KnljZRqAKUOW4QPFk7M6bq8bcXMVC9ZHcMx5WGFz4y6L
 1HpUTQNe9x4I6nsTOovFi5H1+KhliYenQ7HyFXmW4Iw5hGztZP+M7NEtbetJUBMpvtJHuWkyBw
 cDw=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; 
   d="scan'208";a="118456735"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 03:49:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:49:38 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:34 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        <joe@perches.com>, <lgirdwood@gmail.com>, <lars@metafoo.de>,
        <kuninori.morimoto.gx@renesas.com>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 1/6] ALSA: core: pcm: Create helpers to allocate/free struct snd_pcm_runtime
Date:   Wed, 19 May 2021 13:48:37 +0300
Message-ID: <20210519104842.977895-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
References: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create helpers to be able to reuse code for allocation and freeing of
struct snd_pcm_runtime.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 include/sound/pcm.h |  2 ++
 sound/core/pcm.c    | 82 +++++++++++++++++++++++++++------------------
 2 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2e1200d17d0c..025b4d2ba0fe 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -574,6 +574,8 @@ static inline int snd_pcm_suspend_all(struct snd_pcm *pcm)
 }
 #endif
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg);
+struct snd_pcm_runtime *snd_pcm_runtime_alloc(void);
+void snd_pcm_runtime_free(struct snd_pcm_runtime *runtime);
 int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
 			   struct snd_pcm_substream **rsubstream);
 void snd_pcm_release_substream(struct snd_pcm_substream *substream);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index b163164a83ec..8ecb14b27460 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -876,6 +876,53 @@ static int snd_pcm_dev_free(struct snd_device *device)
 	return snd_pcm_free(pcm);
 }
 
+struct snd_pcm_runtime *snd_pcm_runtime_alloc(void)
+{
+	struct snd_pcm_runtime *runtime;
+	size_t size;
+
+	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
+	if (!runtime)
+		return NULL;
+
+	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status));
+	runtime->status = alloc_pages_exact(size, GFP_KERNEL);
+	if (!runtime->status) {
+		kfree(runtime);
+		return NULL;
+	}
+	memset(runtime->status, 0, size);
+
+	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control));
+	runtime->control = alloc_pages_exact(size, GFP_KERNEL);
+	if (!runtime->control) {
+		free_pages_exact(runtime->status,
+				 PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
+		kfree(runtime);
+		return NULL;
+	}
+	memset(runtime->control, 0, size);
+
+	init_waitqueue_head(&runtime->sleep);
+	init_waitqueue_head(&runtime->tsleep);
+
+	runtime->status->state = SNDRV_PCM_STATE_OPEN;
+
+	return runtime;
+}
+EXPORT_SYMBOL_GPL(snd_pcm_runtime_alloc);
+
+void snd_pcm_runtime_free(struct snd_pcm_runtime *runtime)
+{
+	free_pages_exact(runtime->status,
+			 PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
+	free_pages_exact(runtime->control,
+			 PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control)));
+	kfree(runtime->hw_constraints.rules);
+	kfree(runtime);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_runtime_free);
+
 int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 			     struct file *file,
 			     struct snd_pcm_substream **rsubstream)
@@ -885,7 +932,6 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	struct snd_pcm_runtime *runtime;
 	struct snd_card *card;
 	int prefer_subdevice;
-	size_t size;
 
 	if (snd_BUG_ON(!pcm || !rsubstream))
 		return -ENXIO;
@@ -939,33 +985,10 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	if (substream == NULL)
 		return -EAGAIN;
 
-	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
-	if (runtime == NULL)
+	runtime = snd_pcm_runtime_alloc();
+	if (!runtime)
 		return -ENOMEM;
 
-	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status));
-	runtime->status = alloc_pages_exact(size, GFP_KERNEL);
-	if (runtime->status == NULL) {
-		kfree(runtime);
-		return -ENOMEM;
-	}
-	memset(runtime->status, 0, size);
-
-	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control));
-	runtime->control = alloc_pages_exact(size, GFP_KERNEL);
-	if (runtime->control == NULL) {
-		free_pages_exact(runtime->status,
-			       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
-		kfree(runtime);
-		return -ENOMEM;
-	}
-	memset(runtime->control, 0, size);
-
-	init_waitqueue_head(&runtime->sleep);
-	init_waitqueue_head(&runtime->tsleep);
-
-	runtime->status->state = SNDRV_PCM_STATE_OPEN;
-
 	substream->runtime = runtime;
 	substream->private_data = pcm->private_data;
 	substream->ref_count = 1;
@@ -985,11 +1008,6 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	if (runtime->private_free != NULL)
 		runtime->private_free(runtime);
-	free_pages_exact(runtime->status,
-		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
-	free_pages_exact(runtime->control,
-		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control)));
-	kfree(runtime->hw_constraints.rules);
 	/* Avoid concurrent access to runtime via PCM timer interface */
 	if (substream->timer) {
 		spin_lock_irq(&substream->timer->lock);
@@ -998,7 +1016,7 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	} else {
 		substream->runtime = NULL;
 	}
-	kfree(runtime);
+	snd_pcm_runtime_free(runtime);
 	put_pid(substream->pid);
 	substream->pid = NULL;
 	substream->pstr->substream_opened--;
-- 
2.27.0

