Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7105335EDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349366AbhDNGtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:49:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42824 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349338AbhDNGs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:48:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B0801A3EA1;
        Wed, 14 Apr 2021 08:48:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C9CDC1A41FA;
        Wed, 14 Apr 2021 08:48:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2B4EE4031C;
        Wed, 14 Apr 2021 08:48:31 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 -next 1/2] ASoC: ak5558: correct reset polarity
Date:   Wed, 14 Apr 2021 14:33:43 +0800
Message-Id: <1618382024-31725-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset (aka power off) happens when the reset gpio is made active.
The reset gpio is GPIO_ACTIVE_LOW

Fixes: 920884777480 ("ASoC: ak5558: Add support for AK5558 ADC driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- split the patch to two patches.

 sound/soc/codecs/ak5558.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 8e4dca753f0b..f24d91b728dd 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -323,7 +323,7 @@ static void ak5558_power_off(struct ak5558_priv *ak5558)
 	if (!ak5558->reset_gpiod)
 		return;
 
-	gpiod_set_value_cansleep(ak5558->reset_gpiod, 0);
+	gpiod_set_value_cansleep(ak5558->reset_gpiod, 1);
 	usleep_range(1000, 2000);
 }
 
@@ -332,7 +332,7 @@ static void ak5558_power_on(struct ak5558_priv *ak5558)
 	if (!ak5558->reset_gpiod)
 		return;
 
-	gpiod_set_value_cansleep(ak5558->reset_gpiod, 1);
+	gpiod_set_value_cansleep(ak5558->reset_gpiod, 0);
 	usleep_range(1000, 2000);
 }
 
-- 
2.27.0

