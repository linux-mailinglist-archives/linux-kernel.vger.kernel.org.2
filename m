Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3191A36C45D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhD0Kuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:50:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51900 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhD0Kui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:50:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B56251A164A;
        Tue, 27 Apr 2021 12:49:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DDC51A0A59;
        Tue, 27 Apr 2021 12:49:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3F03E4029D;
        Tue, 27 Apr 2021 12:49:49 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: [PATCH 1/2] ALSA: pcm: Add support for 705.6KHz and 768KHz sample rate
Date:   Tue, 27 Apr 2021 18:34:22 +0800
Message-Id: <1619519663-10406-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some high resolution codecs support 705.6KHz and 768KHz rates.
So extend supported sample rate to 768kHz in pcm.h.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/pcm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2e1200d17d0c..88056824ffec 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -121,6 +121,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
 #define SNDRV_PCM_RATE_352800		(1<<13)		/* 352800Hz */
 #define SNDRV_PCM_RATE_384000		(1<<14)		/* 384000Hz */
+#define SNDRV_PCM_RATE_705600		(1<<15)		/* 705600Hz */
+#define SNDRV_PCM_RATE_768000		(1<<16)		/* 768000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
@@ -136,6 +138,9 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_8000_384000	(SNDRV_PCM_RATE_8000_192000|\
 					 SNDRV_PCM_RATE_352800|\
 					 SNDRV_PCM_RATE_384000)
+#define SNDRV_PCM_RATE_8000_768000	(SNDRV_PCM_RATE_8000_768000|\
+					 SNDRV_PCM_RATE_705600|\
+					 SNDRV_PCM_RATE_768000)
 #define _SNDRV_PCM_FMTBIT(fmt)		(1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
 #define SNDRV_PCM_FMTBIT_S8		_SNDRV_PCM_FMTBIT(S8)
 #define SNDRV_PCM_FMTBIT_U8		_SNDRV_PCM_FMTBIT(U8)
-- 
2.27.0

