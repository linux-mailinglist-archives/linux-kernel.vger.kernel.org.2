Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953BF3AFF62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFVIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:39:50 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39338 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhFVIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:39:48 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2021 04:39:48 EDT
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3A432FB03;
        Tue, 22 Jun 2021 10:27:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fPibtmydCwzb; Tue, 22 Jun 2021 10:27:11 +0200 (CEST)
Date:   Tue, 22 Jun 2021 10:27:09 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-card: Fill in driver name
Message-ID: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alsa-ucm groups by driver name so fill that in as well. Otherwise the
presented information is redundant and doesn't reflect the used
driver. We can't just use 'asoc-simple-card' since the driver name is
restricted to 15 characters.

Before:

 # cat /proc/asound/cards
 0 [Devkit         ]: Librem_5_Devkit - Librem 5 Devkit
                      Librem 5 Devkit
After:

 0 [Devkit         ]: simple-card - Librem 5 Devkit
                      Librem 5 Devkit

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
This came out of a discussion about adding alsa-ucm profiles for the
Librem 5 Devkit at https://github.com/alsa-project/alsa-ucm-conf/pull/102

 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 0015f534d42d..a3a7990b5cb6 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -621,6 +621,7 @@ static int asoc_simple_probe(struct platform_device *pdev)
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
 	card->probe		= simple_soc_probe;
+	card->driver_name       = "simple-card";
 
 	li = devm_kzalloc(dev, sizeof(*li), GFP_KERNEL);
 	if (!li)
-- 
2.30.2
