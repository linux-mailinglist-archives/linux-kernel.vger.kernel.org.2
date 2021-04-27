Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179F036C45E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhD0Kun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:50:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51934 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235593AbhD0Kum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:50:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA02F1A0A59;
        Tue, 27 Apr 2021 12:49:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 72C7E1A0A89;
        Tue, 27 Apr 2021 12:49:56 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0468140287;
        Tue, 27 Apr 2021 12:49:52 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: [PATCH 2/2] ALSA: pcm: Extend the constraint table for 705.6kHz and 768KHz rate
Date:   Tue, 27 Apr 2021 18:34:23 +0800
Message-Id: <1619519663-10406-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619519663-10406-1-git-send-email-shengjiu.wang@nxp.com>
References: <1619519663-10406-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some high resolution codecs support 705.6KHz and 768KHz rates
so extend the constraint table for 705.6kHz and 768KHz rate

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 17a85f4815d5..3e03f34cf3e2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2370,7 +2370,8 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 
 static const unsigned int rates[] = {
 	5512, 8000, 11025, 16000, 22050, 32000, 44100,
-	48000, 64000, 88200, 96000, 176400, 192000, 352800, 384000
+	48000, 64000, 88200, 96000, 176400, 192000, 352800, 384000,
+	705600, 768000
 };
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
-- 
2.27.0

