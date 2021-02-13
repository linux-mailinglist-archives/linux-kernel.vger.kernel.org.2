Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3D31AADA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhBMKWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:22:07 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43915
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229475AbhBMKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:20:58 -0500
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; 
   d="scan'208";a="372960480"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2021 11:19:14 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Timur Tabi <timur@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ASoC: fsl: drop unneeded snd_soc_dai_set_drvdata
Date:   Sat, 13 Feb 2021 11:19:07 +0100
Message-Id: <20210213101907.1318496-5-Julia.Lawall@inria.fr>
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
 sound/soc/fsl/fsl_micfil.c |    2 --
 sound/soc/fsl/fsl_sai.c    |    2 --
 sound/soc/fsl/fsl_xcvr.c   |    1 -
 3 files changed, 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 8aedf6590b28..fd21017fa2bd 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -423,8 +423,6 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 		return ret;
 	}
 
-	snd_soc_dai_set_drvdata(cpu_dai, micfil);
-
 	return 0;
 }
 
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5e65b456d3e2..8876d0ed37d9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -727,8 +727,6 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	snd_soc_dai_init_dma_data(cpu_dai, &sai->dma_params_tx,
 				&sai->dma_params_rx);
 
-	snd_soc_dai_set_drvdata(cpu_dai, sai);
-
 	return 0;
 }
 
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index dd228b421e2c..8a3bde718697 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -869,7 +869,6 @@ static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
 
 	snd_soc_dai_init_dma_data(dai, &xcvr->dma_prms_tx, &xcvr->dma_prms_rx);
-	snd_soc_dai_set_drvdata(dai, xcvr);
 
 	snd_soc_add_dai_controls(dai, &fsl_xcvr_mode_kctl, 1);
 	snd_soc_add_dai_controls(dai, &fsl_xcvr_arc_mode_kctl, 1);

