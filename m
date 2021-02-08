Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00579312BA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhBHIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:25:16 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46996 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhBHIYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:24:54 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E7792005A8;
        Mon,  8 Feb 2021 09:24:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A5AB3201083;
        Mon,  8 Feb 2021 09:24:01 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 03F9F402E5;
        Mon,  8 Feb 2021 09:23:57 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-pcm: change error message to debug message
Date:   Mon,  8 Feb 2021 16:12:45 +0800
Message-Id: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This log message should be a debug message, because it
doesn't return directly but continue next loop.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 605acec48971..cd9e919d7b99 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1344,8 +1344,8 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		/* is there a valid BE rtd for this widget */
 		be = dpcm_get_be(card, widget, stream);
 		if (!be) {
-			dev_err(fe->dev, "ASoC: no BE found for %s\n",
-					widget->name);
+			dev_dbg(fe->dev, "ASoC: no BE found for %s\n",
+				widget->name);
 			continue;
 		}
 
-- 
2.27.0

