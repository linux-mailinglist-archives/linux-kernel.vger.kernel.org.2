Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FBA330F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCHNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:35:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:34962 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhCHNff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:35:35 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A663F1A0BC2;
        Mon,  8 Mar 2021 14:35:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1235F1A0146;
        Mon,  8 Mar 2021 14:35:28 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 725F9402E9;
        Mon,  8 Mar 2021 14:35:19 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/6] ASoC: soc-component: Add snd_soc_pcm_component_ack
Date:   Mon,  8 Mar 2021 21:22:25 +0800
Message-Id: <1615209750-2357-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add snd_soc_pcm_component_ack back, which can be used to get an
updated buffer pointer in the platform driver.
On Asymmetric multiprocessor, this pointer can be sent to Cortex-M
core for audio processing.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/soc-component.h |  3 +++
 sound/soc/soc-component.c     | 14 ++++++++++++++
 sound/soc/soc-pcm.c           |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 7dc75b39287f..722cfab28d29 100644
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
index 8415e9bd2932..3a5e84e16a87 100644
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
index ba8ffbf8a5d3..e75b404a9f36 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2826,6 +2826,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->ops.page		= snd_soc_pcm_component_page;
 		if (drv->mmap)
 			rtd->ops.mmap		= snd_soc_pcm_component_mmap;
+		if (drv->ack)
+			rtd->ops.ack            = snd_soc_pcm_component_ack;
 	}
 
 	if (playback)
-- 
2.27.0

