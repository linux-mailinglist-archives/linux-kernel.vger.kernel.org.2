Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C07374DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhEFCyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:54:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38110 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEFCyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:54:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54BEF20065A;
        Thu,  6 May 2021 04:53:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F71320067D;
        Thu,  6 May 2021 04:53:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C6AE44034D;
        Thu,  6 May 2021 04:46:35 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-pcm-rpmsg: Fix warning of incorrect type in assignment
Date:   Thu,  6 May 2021 10:30:40 +0800
Message-Id: <1620268240-1005-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format in rpmsg is defained as unsigned char, there is warning
when convert snd_pcm_format_t to it.

sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    expected unsigned char format
sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    got restricted snd_pcm_format_t [usertype]
sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    expected unsigned char format
sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    got restricted snd_pcm_format_t [usertype]

Refine the unused RPMSG_DSD_U16_LE and RPMSG_DSD_U32_LE for these
case to fix this sparse warning.

Fixes: 3c00eceb2a53 ("ASoC: imx-pcm-rpmsg: Add platform driver for audio base on rpmsg")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 4 ++--
 sound/soc/fsl/imx-pcm-rpmsg.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 875c0d6df339..3f5913adbfb0 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -161,10 +161,10 @@ static int imx_rpmsg_pcm_hw_params(struct snd_soc_component *component,
 		msg->s_msg.param.format   = RPMSG_S24_LE;
 		break;
 	case SNDRV_PCM_FORMAT_DSD_U16_LE:
-		msg->s_msg.param.format   = SNDRV_PCM_FORMAT_DSD_U16_LE;
+		msg->s_msg.param.format   = RPMSG_DSD_U16_LE;
 		break;
 	case SNDRV_PCM_FORMAT_DSD_U32_LE:
-		msg->s_msg.param.format   = SNDRV_PCM_FORMAT_DSD_U32_LE;
+		msg->s_msg.param.format   = RPMSG_DSD_U32_LE;
 		break;
 	default:
 		msg->s_msg.param.format   = RPMSG_S32_LE;
diff --git a/sound/soc/fsl/imx-pcm-rpmsg.h b/sound/soc/fsl/imx-pcm-rpmsg.h
index 308d153920a3..8286b55f00ae 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.h
+++ b/sound/soc/fsl/imx-pcm-rpmsg.h
@@ -328,9 +328,9 @@
 #define	RPMSG_S16_LE		0x0
 #define	RPMSG_S24_LE		0x1
 #define	RPMSG_S32_LE		0x2
-#define	RPMSG_DSD_U16_LE	0x3
+#define	RPMSG_DSD_U16_LE	49  /* SNDRV_PCM_FORMAT_DSD_U16_LE */
 #define	RPMSG_DSD_U24_LE	0x4
-#define	RPMSG_DSD_U32_LE	0x5
+#define	RPMSG_DSD_U32_LE	50  /* SNDRV_PCM_FORMAT_DSD_U32_LE */
 
 #define	RPMSG_CH_LEFT		0x0
 #define	RPMSG_CH_RIGHT		0x1
-- 
2.17.1

