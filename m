Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0D35B466
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhDKM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:57:33 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:58021 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhDKM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:57:32 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d63 with ME
        id rQxE240053g7mfN03QxEy7; Sun, 11 Apr 2021 14:57:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Apr 2021 14:57:14 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: cs35l36: Fix an error handling path in 'cs35l36_i2c_probe()'
Date:   Sun, 11 Apr 2021 14:57:13 +0200
Message-Id: <9fec48e75bc1d3c92626e6f6aca2344bda223379.1618145790.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
return directly as already done by the surrounding error handling paths.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/cs35l36.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index 4451ca9f4916..a038bcec2d17 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -1721,7 +1721,7 @@ static int cs35l36_i2c_probe(struct i2c_client *i2c_client,
 	if (IS_ERR(cs35l36->regmap)) {
 		ret = PTR_ERR(cs35l36->regmap);
 		dev_err(dev, "regmap_init() failed: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	cs35l36->num_supplies = ARRAY_SIZE(cs35l36_supplies);
-- 
2.27.0

