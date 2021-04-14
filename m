Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337D335EDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbhDNGtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:49:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33508 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349356AbhDNGtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:49:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E9FB2028ED;
        Wed, 14 Apr 2021 08:48:40 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5751E2028EF;
        Wed, 14 Apr 2021 08:48:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AE7D5402F0;
        Wed, 14 Apr 2021 08:48:33 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 -next 2/2] ASoC: ak5558: change function name to ak5558_reset
Date:   Wed, 14 Apr 2021 14:33:44 +0800
Message-Id: <1618382024-31725-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618382024-31725-1-git-send-email-shengjiu.wang@nxp.com>
References: <1618382024-31725-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change function name to ak5558_reset to match devicetree property
"reset-gpios".

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- split patches to two patches

 sound/soc/codecs/ak5558.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index f24d91b728dd..34aed80db0eb 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -318,21 +318,12 @@ static struct snd_soc_dai_driver ak5552_dai = {
 	.ops = &ak5558_dai_ops,
 };
 
-static void ak5558_power_off(struct ak5558_priv *ak5558)
+static void ak5558_reset(struct ak5558_priv *ak5558, bool active)
 {
 	if (!ak5558->reset_gpiod)
 		return;
 
-	gpiod_set_value_cansleep(ak5558->reset_gpiod, 1);
-	usleep_range(1000, 2000);
-}
-
-static void ak5558_power_on(struct ak5558_priv *ak5558)
-{
-	if (!ak5558->reset_gpiod)
-		return;
-
-	gpiod_set_value_cansleep(ak5558->reset_gpiod, 0);
+	gpiod_set_value_cansleep(ak5558->reset_gpiod, active);
 	usleep_range(1000, 2000);
 }
 
@@ -340,7 +331,7 @@ static int ak5558_probe(struct snd_soc_component *component)
 {
 	struct ak5558_priv *ak5558 = snd_soc_component_get_drvdata(component);
 
-	ak5558_power_on(ak5558);
+	ak5558_reset(ak5558, false);
 	return ak5558_set_mcki(component);
 }
 
@@ -348,7 +339,7 @@ static void ak5558_remove(struct snd_soc_component *component)
 {
 	struct ak5558_priv *ak5558 = snd_soc_component_get_drvdata(component);
 
-	ak5558_power_off(ak5558);
+	ak5558_reset(ak5558, true);
 }
 
 static int __maybe_unused ak5558_runtime_suspend(struct device *dev)
@@ -356,7 +347,7 @@ static int __maybe_unused ak5558_runtime_suspend(struct device *dev)
 	struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
 
 	regcache_cache_only(ak5558->regmap, true);
-	ak5558_power_off(ak5558);
+	ak5558_reset(ak5558, true);
 
 	regulator_bulk_disable(ARRAY_SIZE(ak5558->supplies),
 			       ak5558->supplies);
@@ -375,8 +366,8 @@ static int __maybe_unused ak5558_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	ak5558_power_off(ak5558);
-	ak5558_power_on(ak5558);
+	ak5558_reset(ak5558, true);
+	ak5558_reset(ak5558, false);
 
 	regcache_cache_only(ak5558->regmap, false);
 	regcache_mark_dirty(ak5558->regmap);
-- 
2.27.0

