Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29765324926
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhBYDGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:06:24 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40434 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234664AbhBYDGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:06:09 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E1B1A2006F6;
        Thu, 25 Feb 2021 04:05:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 498142006EC;
        Thu, 25 Feb 2021 04:05:15 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8806540319;
        Thu, 25 Feb 2021 04:05:07 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/7] ASoC: soc-component: Add snd_soc_pcm_component_ack
Date:   Thu, 25 Feb 2021 10:52:37 +0800
Message-Id: <1614221563-26822-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add snd_soc_pcm_component_ack back, which can be used to get updated
buffer pointer in platform driver.
On Asymmetric multiprocessor, this pointer can be sent to Cortex-M
core for audio processing.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/soc-component.h |  3 +++
 sound/soc/soc-component.c     | 14 ++++++++++++++
 sound/soc/soc-pcm.c           |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 5b47768222b7..2dc8c7e3d1a6 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -146,6 +146,8 @@ struct snd_soc_component_driver {
 	int (*mmap)(struct snd_soc_component *component,
 		    struct snd_pcm_substream *substream,
 		    struct vm_area_struct *vma);
+	int (*ack)(struct snd_soc_component *component,
+		   struct snd_pcm_substream *substream);
 
 	const struct snd_compress_ops *compress_ops;
 
@@ -498,5 +500,6 @@ int snd_soc_pcm_component_pm_runtime_get(struct snd_soc_pcm_runtime *rtd,
 					 void *stream);
 void snd_soc_pcm_component_pm_runtime_put(struct snd_soc_pcm_runtime *rtd,
 					  void *stream, int rollback);
+int snd_soc_pcm_component_ack(struct snd_pcm_substream *substream);
 
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 159bf88b9f8c..a9fbb2d26412 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -1212,3 +1212,17 @@ void snd_soc_pcm_component_pm_runtime_put(struct snd_soc_pcm_runtime *rtd,
 		soc_component_mark_pop(component, stream, pm);
 	}
 }
+
+int snd_soc_pcm_component_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_component *component;
+	int i;
+
+	/* FIXME: use 1st pointer */
+	for_each_rtd_components(rtd, i, component)
+		if (component->driver->ack)
+			return component->driver->ack(component, substream);
+
+	return 0;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 14d85ca1e435..a1b81d4d678c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2833,6 +2833,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->ops.page		= snd_soc_pcm_component_page;
 		if (drv->mmap)
 			rtd->ops.mmap		= snd_soc_pcm_component_mmap;
+		if (drv->ack)
+			rtd->ops.ack            = snd_soc_pcm_component_ack;
 	}
 
 	if (playback)
-- 
2.27.0

