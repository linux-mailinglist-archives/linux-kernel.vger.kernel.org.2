Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F244B3ECE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 07:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhHPFZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 01:25:59 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:56808 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhHPFZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 01:25:53 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d03 with ME
        id i5RM250033riaq2035RMY1; Mon, 16 Aug 2021 07:25:21 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 16 Aug 2021 07:25:21 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] ASoC: wcd9335: Fix a memory leak in the error handling path of the probe function
Date:   Mon, 16 Aug 2021 07:25:20 +0200
Message-Id: <6dc12372f09fabb70bf05941dbe6a1382dc93e43.1629091028.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1629091028.git.christophe.jaillet@wanadoo.fr>
References: <cover.1629091028.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'wcd9335_setup_irqs()' fails, me must release the memory allocated in
'wcd_clsh_ctrl_alloc()', as already done in the remove function.

Add an error handling path and the missing 'wcd_clsh_ctrl_free()' call.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/wcd9335.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 933f59e4e56f..47fe68edea3a 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4844,6 +4844,7 @@ static void wcd9335_codec_init(struct snd_soc_component *component)
 static int wcd9335_codec_probe(struct snd_soc_component *component)
 {
 	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int ret;
 	int i;
 
 	snd_soc_component_init_regmap(component, wcd->regmap);
@@ -4861,7 +4862,15 @@ static int wcd9335_codec_probe(struct snd_soc_component *component)
 	for (i = 0; i < NUM_CODEC_DAIS; i++)
 		INIT_LIST_HEAD(&wcd->dai[i].slim_ch_list);
 
-	return wcd9335_setup_irqs(wcd);
+	ret = wcd9335_setup_irqs(wcd);
+	if (ret)
+		goto free_clsh_ctrl;
+
+	return 0;
+
+free_clsh_ctrl:
+	wcd_clsh_ctrl_free(wcd->clsh_ctrl);
+	return ret;
 }
 
 static void wcd9335_codec_remove(struct snd_soc_component *comp)
-- 
2.30.2

