Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8193831AAC8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBMKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:19:58 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43915
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhBMKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:19:56 -0500
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; 
   d="scan'208";a="372960477"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2021 11:19:14 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Daniel Mack <daniel@zonque.org>
Cc:     kernel-janitors@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ASoC: mmp-sspa: drop unneeded snd_soc_dai_set_drvdata
Date:   Sat, 13 Feb 2021 11:19:04 +0100
Message-Id: <20210213101907.1318496-2-Julia.Lawall@inria.fr>
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
 sound/soc/pxa/mmp-sspa.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 4803972ee655..7e39210a0b38 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -330,7 +330,6 @@ static int mmp_sspa_probe(struct snd_soc_dai *dai)
 				&sspa->playback_dma_data,
 				&sspa->capture_dma_data);
 
-	snd_soc_dai_set_drvdata(dai, sspa);
 	return 0;
 }
 

