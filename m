Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7272A4327E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhJRTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:46:37 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:63603 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhJRTqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:46:36 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id cYYUmZVOg1UGBcYYUmpEyj; Mon, 18 Oct 2021 21:44:22 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 18 Oct 2021 21:44:22 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        mikhail_durnev@mentor.com, joe@perches.com,
        pierre-louis.bossart@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: rsnd: Fix an error handling path in 'rsnd_node_count()'
Date:   Mon, 18 Oct 2021 21:44:16 +0200
Message-Id: <4c0e893cbfa21dc76c1ede0b6f4f8cff42209299.1634586167.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we return before the end of the 'for_each_child_of_node()' iterator, the
reference taken on 'np' must be released.

Add the missing 'of_node_put()' call.

Fixes: c413983eb66a ("ASoC: rsnd: adjust disabled module")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/sh/rcar/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 978bd0406729..6a8fe0da7670 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1225,6 +1225,7 @@ int rsnd_node_count(struct rsnd_priv *priv, struct device_node *node, char *name
 		if (i < 0) {
 			dev_err(dev, "strange node numbering (%s)",
 				of_node_full_name(node));
+			of_node_put(np);
 			return 0;
 		}
 		i++;
-- 
2.30.2

