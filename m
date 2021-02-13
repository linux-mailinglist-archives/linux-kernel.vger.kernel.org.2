Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77D431AAD4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBMKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:20:52 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43915
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhBMKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:20:34 -0500
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; 
   d="scan'208";a="372960478"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2021 11:19:14 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ASoC: mxs-saif: drop unneeded snd_soc_dai_set_drvdata
Date:   Sat, 13 Feb 2021 11:19:05 +0100
Message-Id: <20210213101907.1318496-3-Julia.Lawall@inria.fr>
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

In this case, the whole probe function then does nothing, so drop it.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/mxs/mxs-saif.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 07f8cf9980e3..6a2d24d48964 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -642,18 +642,8 @@ static const struct snd_soc_dai_ops mxs_saif_dai_ops = {
 	.set_fmt = mxs_saif_set_dai_fmt,
 };
 
-static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
-{
-	struct mxs_saif *saif = dev_get_drvdata(dai->dev);
-
-	snd_soc_dai_set_drvdata(dai, saif);
-
-	return 0;
-}
-
 static struct snd_soc_dai_driver mxs_saif_dai = {
 	.name = "mxs-saif",
-	.probe = mxs_saif_dai_probe,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,

