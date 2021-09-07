Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828940263A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhIGJfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:35:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48172 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233059AbhIGJfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:35:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B22D81A2AFA;
        Tue,  7 Sep 2021 11:34:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A88E1A165D;
        Tue,  7 Sep 2021 11:34:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1DE30183AC4C;
        Tue,  7 Sep 2021 17:33:59 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8960: Fix clock configuration on slave mode
Date:   Tue,  7 Sep 2021 17:11:09 +0800
Message-Id: <1631005869-7308-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a noise issue for 8kHz sample rate on slave mode.
Compared with master mode, the difference is the DACDIV
setting, after correcting the DACDIV, the noise is gone.

There is no noise issue for 48kHz sample rate, because
the default value of DACDIV is correct for 48kHz.

So wm8960_configure_clocking() should be functional for
ADC and DAC function even if it is slave mode.

In order to be compatible for old use case, just add
condition for checking that sysclk is zero with
slave mode.

Fixes: 0e50b51aa22f ("ASoC: wm8960: Let wm8960 driver configure its bit clock and frame clock")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 9e621a254392..9c6af76a60fd 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -742,7 +742,7 @@ static int wm8960_configure_clocking(struct snd_soc_component *component)
 	int i, j, k;
 	int ret;
 
-	if (!(iface1 & (1<<6))) {
+	if (!(iface1 & (1 << 6)) && !wm8960->sysclk) {
 		dev_dbg(component->dev,
 			"Codec is slave mode, no need to configure clock\n");
 		return 0;
-- 
2.17.1

