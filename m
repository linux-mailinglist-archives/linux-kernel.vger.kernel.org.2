Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9873D58FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhGZLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:18:44 -0400
Received: from forward102o.mail.yandex.net ([37.140.190.182]:40754 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233606AbhGZLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:18:43 -0400
Received: from iva8-34fb5df223d4.qloud-c.yandex.net (iva8-34fb5df223d4.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:b999:0:640:34fb:5df2])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id F23336681AC5;
        Mon, 26 Jul 2021 14:52:12 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva8-34fb5df223d4.qloud-c.yandex.net (mxback/Yandex) with ESMTP id iUqqxXqB0d-qCHe0deu;
        Mon, 26 Jul 2021 14:52:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627300332;
        bh=wrYpi7Lb3bPjDh2wgnPPsmcJxdCvpxYqsSBC4dQvxwE=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=Kg0Rp1ZB8LHBIQKvqXdI+108oirKG5Yjb+IXuAulSRKCtVgd/0B6WGsA113q9sB4I
         wVqNk4mT04s11eG1/x2ypfxY4ii4jdy/I4i0X7yz0WI/QNDVOFpRw2Gd53DGk2Ncbk
         rzc055RNydjPC8FjTNPtwQr3+FLdbaKvArAOdDXs=
Authentication-Results: iva8-34fb5df223d4.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PIKatQa27D-qB2S8kdK;
        Mon, 26 Jul 2021 14:52:11 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/8] ASoC: cirrus: i2s: Prepare clock before using it
Date:   Mon, 26 Jul 2021 14:50:50 +0300
Message-Id: <20210726115058.23729-7-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726115058.23729-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 97 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared mclk
...
Hardware name: Cirrus Logic EDB9302 Evaluation Board
...
clk_core_enable
clk_core_enable_lock
ep93xx_i2s_hw_params
snd_soc_dai_hw_params
soc_pcm_hw_params
snd_pcm_hw_params
snd_pcm_ioctl
...

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 0d26550d0df8..4d3179f03202 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -111,9 +111,9 @@ static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 	if ((ep93xx_i2s_read_reg(info, EP93XX_I2S_TX0EN) & 0x1) == 0 &&
 	    (ep93xx_i2s_read_reg(info, EP93XX_I2S_RX0EN) & 0x1) == 0) {
 		/* Enable clocks */
-		clk_enable(info->mclk);
-		clk_enable(info->sclk);
-		clk_enable(info->lrclk);
+		clk_prepare_enable(info->mclk);
+		clk_prepare_enable(info->sclk);
+		clk_prepare_enable(info->lrclk);
 
 		/* Enable i2s */
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 1);
@@ -156,9 +156,9 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 0);
 
 		/* Disable clocks */
-		clk_disable(info->lrclk);
-		clk_disable(info->sclk);
-		clk_disable(info->mclk);
+		clk_disable_unprepare(info->lrclk);
+		clk_disable_unprepare(info->sclk);
+		clk_disable_unprepare(info->mclk);
 	}
 }
 
-- 
2.26.2

