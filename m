Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B660A4571AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhKSPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:37:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45242 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:37:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 25BC31F4755B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637336060; bh=9XqSTagR5ExPPePSbBL0T2BqW5kApWtcD8Y31LNkaTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpB3U0fXGBozlqYxFhNLwLtWIfPD73ktf21EPrFi6F3w+PfGdtsGxtHTOcMIsNAHE
         k0daMvma/2lHybzPuCGBfyfqvOgqHG1xa8SN0mL6gf0V7E3iCPce18zI2DGRZF/4qF
         b762aPPck9y+CeQ7MyadQlgkcUl/vj28PyvILPzSSU+Y3+Ey+e/WdSBOyEy09KYmCq
         yjoX0TzuOyvfduHLHCdA3R65xESeEbre8pqaF/DmlIq+VyTqMOxzqmeKeyLSquxG8r
         rPFRXkxtMGl5Q1Fm6qJtEnt9h0IVhk1zcg/CESDUzK4Q0hkTiFPuujDIb7ZxJRqmde
         i9fioWtLlS7Qg==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bkylerussell@gmail.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com
Subject: [RFC patch 3/5] ASoC: tlv320aic31xx: Add divs for bclk as clk_in
Date:   Fri, 19 Nov 2021 12:32:46 -0300
Message-Id: <20211119153248.419802-4-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add divisors for rates needed when the clk_in is set to BCLK.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 1aec03d834d0..e8307f0737f2 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -195,46 +195,66 @@ struct aic31xx_rate_divs {
 static const struct aic31xx_rate_divs aic31xx_divs[] = {
 	/* mclk/p    rate  pll: r  j     d     dosr ndac mdac  aors nadc madc */
 	/* 8k rate */
+	{  512000,   8000,	4, 48,   0,	128,  48,  2,   128,  48,  2},
 	{12000000,   8000,	1, 8, 1920,	128,  48,  2,	128,  48,  2},
 	{12000000,   8000,	1, 8, 1920,	128,  32,  3,	128,  32,  3},
 	{12500000,   8000,	1, 7, 8643,	128,  48,  2,	128,  48,  2},
 	/* 11.025k rate */
+	{  705600,  11025,	3, 48,   0,	128,  24,  3,	128,  24,  3},
 	{12000000,  11025,	1, 7, 5264,	128,  32,  2,	128,  32,  2},
 	{12000000,  11025,	1, 8, 4672,	128,  24,  3,	128,  24,  3},
 	{12500000,  11025,	1, 7, 2253,	128,  32,  2,	128,  32,  2},
 	/* 16k rate */
+	{  512000,  16000,	4, 48,   0,	128,  16,  3,	128,  16,  3},
+	{ 1024000,  16000,	2, 48,   0,	128,  16,  3,	128,  16,  3},
 	{12000000,  16000,	1, 8, 1920,	128,  24,  2,	128,  24,  2},
 	{12000000,  16000,	1, 8, 1920,	128,  16,  3,	128,  16,  3},
 	{12500000,  16000,	1, 7, 8643,	128,  24,  2,	128,  24,  2},
 	/* 22.05k rate */
+	{  705600,  22050,	4, 36,   0,	128,  12,  3,	128,  12,  3},
+	{ 1411200,  22050,	2, 36,   0,	128,  12,  3,	128,  12,  3},
 	{12000000,  22050,	1, 7, 5264,	128,  16,  2,	128,  16,  2},
 	{12000000,  22050,	1, 8, 4672,	128,  12,  3,	128,  12,  3},
 	{12500000,  22050,	1, 7, 2253,	128,  16,  2,	128,  16,  2},
 	/* 32k rate */
+	{ 1024000,  32000,      2, 48,   0,	128,  12,  2,	128,  12,  2},
+	{ 2048000,  32000,      1, 48,   0,	128,  12,  2,	128,  12,  2},
 	{12000000,  32000,	1, 8, 1920,	128,  12,  2,	128,  12,  2},
 	{12000000,  32000,	1, 8, 1920,	128,   8,  3,	128,   8,  3},
 	{12500000,  32000,	1, 7, 8643,	128,  12,  2,	128,  12,  2},
 	/* 44.1k rate */
+	{ 1411200,  44100,	2, 32,   0,	128,   8,  2,	128,   8,  2},
+	{ 2822400,  44100,	1, 32,   0,	128,   8,  2,	128,   8,  2},
 	{12000000,  44100,	1, 7, 5264,	128,   8,  2,	128,   8,  2},
 	{12000000,  44100,	1, 8, 4672,	128,   6,  3,	128,   6,  3},
 	{12500000,  44100,	1, 7, 2253,	128,   8,  2,	128,   8,  2},
 	/* 48k rate */
+	{ 1536000,  48000,	2, 32,   0,	128,   8,  2,	128,   8,  2},
+	{ 3072000,  48000,	1, 32,   0,	128,   8,  2,	128,   8,  2},
 	{12000000,  48000,	1, 8, 1920,	128,   8,  2,	128,   8,  2},
 	{12000000,  48000,	1, 7, 6800,	 96,   5,  4,	 96,   5,  4},
 	{12500000,  48000,	1, 7, 8643,	128,   8,  2,	128,   8,  2},
 	/* 88.2k rate */
+	{ 2822400,  88200,	2, 16,   0,	 64,   8,  2,	 64,   8,  2},
+	{ 5644800,  88200,	1, 16,   0,	 64,   8,  2,	 64,   8,  2},
 	{12000000,  88200,	1, 7, 5264,	 64,   8,  2,	 64,   8,  2},
 	{12000000,  88200,	1, 8, 4672,	 64,   6,  3,	 64,   6,  3},
 	{12500000,  88200,	1, 7, 2253,	 64,   8,  2,	 64,   8,  2},
 	/* 96k rate */
+	{ 3072000,  96000,	2, 16,   0,	 64,   8,  2,	 64,   8,  2},
+	{ 6144000,  96000,	1, 16,   0,	 64,   8,  2,	 64,   8,  2},
 	{12000000,  96000,	1, 8, 1920,	 64,   8,  2,	 64,   8,  2},
 	{12000000,  96000,	1, 7, 6800,	 48,   5,  4,	 48,   5,  4},
 	{12500000,  96000,	1, 7, 8643,	 64,   8,  2,	 64,   8,  2},
 	/* 176.4k rate */
+	{ 5644800, 176400,	2, 8,    0,	 32,   8,  2,	 32,   8,  2},
+	{11289600, 176400,	1, 8,    0,	 32,   8,  2,	 32,   8,  2},
 	{12000000, 176400,	1, 7, 5264,	 32,   8,  2,	 32,   8,  2},
 	{12000000, 176400,	1, 8, 4672,	 32,   6,  3,	 32,   6,  3},
 	{12500000, 176400,	1, 7, 2253,	 32,   8,  2,	 32,   8,  2},
 	/* 192k rate */
+	{ 6144000, 192000,	2, 8,	 0,	 32,   8,  2,	 32,   8,  2},
+	{12288000, 192000,	1, 8,	 0,	 32,   8,  2,	 32,   8,  2},
 	{12000000, 192000,	1, 8, 1920,	 32,   8,  2,	 32,   8,  2},
 	{12000000, 192000,	1, 7, 6800,	 24,   5,  4,	 24,   5,  4},
 	{12500000, 192000,	1, 7, 8643,	 32,   8,  2,	 32,   8,  2},
-- 
2.30.2

