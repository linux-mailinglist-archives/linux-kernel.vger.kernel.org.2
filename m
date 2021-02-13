Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D807131AAD7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBMKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:21:33 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43958
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhBMKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:20:38 -0500
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; 
   d="scan'208";a="372960479"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2021 11:19:14 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ASoC: sun4i-i2s: drop unneeded snd_soc_dai_set_drvdata
Date:   Sat, 13 Feb 2021 11:19:06 +0100
Message-Id: <20210213101907.1318496-4-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
References: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_dai_set_drvdata is not needed when the set data comes from
snd_soc_dai_get_drvdata or dev_get_drvdata.  The problem was fixed
usingthe following semantic patch: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y,e;
@@
	x = dev_get_drvdata(y->dev)
	... when != x = e
-	snd_soc_dai_set_drvdata(y,x);

@@
expression x,y,e;
@@
	x = snd_soc_dai_get_drvdata(y)
	... when != x = e
-	snd_soc_dai_set_drvdata(y,x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/sunxi/sun4i-i2s.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 78506c3811dc..c57feae3396e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1079,8 +1079,6 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 				  &i2s->playback_dma_data,
 				  &i2s->capture_dma_data);
 
-	snd_soc_dai_set_drvdata(dai, i2s);
-
 	return 0;
 }
 

