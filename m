Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E637714F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhEHLEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 07:04:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60528 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhEHLD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 07:03:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 86A80201F1A;
        Sat,  8 May 2021 13:02:55 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE47D201F1E;
        Sat,  8 May 2021 13:02:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F90B4030B;
        Sat,  8 May 2021 13:02:49 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ak5558: Correct the dai name for ak5552
Date:   Sat,  8 May 2021 18:46:47 +0800
Message-Id: <1620470807-12056-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the dai name for ak5552. The name should be "ak5552-aif".

Fixes: d8c5c82e4e5b ("ASoC: ak5558: Add support for ak5552")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak5558.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 34aed80db0eb..37d4600b6f2c 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -307,7 +307,7 @@ static struct snd_soc_dai_driver ak5558_dai = {
 };
 
 static struct snd_soc_dai_driver ak5552_dai = {
-	.name = "ak5558-aif",
+	.name = "ak5552-aif",
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
-- 
2.27.0

