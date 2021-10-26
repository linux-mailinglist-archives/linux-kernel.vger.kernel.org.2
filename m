Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14B43ADCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhJZINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJZINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:13:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D357C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:10:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 66FD11F4367C
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] ASoC: rt5682-i2c: Use devm_clk_get_optional for optional clock
Date:   Tue, 26 Oct 2021 10:10:30 +0200
Message-Id: <20211026081030.422481-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mclk clock is optional, but it's currently using devm_clk_get:
simplify the handling by using devm_clk_get_optional instead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/codecs/rt5682-i2c.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index a30e42932cf7..983347b65127 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -280,14 +280,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 #ifdef CONFIG_COMMON_CLK
 	/* Check if MCLK provided */
-	rt5682->mclk = devm_clk_get(&i2c->dev, "mclk");
-	if (IS_ERR(rt5682->mclk)) {
-		if (PTR_ERR(rt5682->mclk) != -ENOENT) {
-			ret = PTR_ERR(rt5682->mclk);
-			return ret;
-		}
-		rt5682->mclk = NULL;
-	}
+	rt5682->mclk = devm_clk_get_optional(&i2c->dev, "mclk");
+	if (IS_ERR(rt5682->mclk))
+		return PTR_ERR(rt5682->mclk);
 
 	/* Register CCF DAI clock control */
 	ret = rt5682_register_dai_clks(rt5682);
-- 
2.33.0

