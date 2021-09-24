Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF510417E14
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbhIXXOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 19:14:18 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:36368
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhIXXOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 19:14:17 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CAB6540189;
        Fri, 24 Sep 2021 23:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632525162;
        bh=tN3HRU0OzmhV6dgn+LtnaYkAOlXirG8kC8RmA1sdV9Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=N9L52LHKq1rdOqh9YigHzUlVpJItzEVS5nvj7EoDu2CRT79tXWjXSaxFWyr/2Wwt3
         TEziT8Lr/mWxgSY6oNk0t5hw/k2jMTUEWFpiD+AHp5+a7wb/w5CYPPXiRcEDaJGBjM
         PXE7vcEAlbIP463nYQ5diD6lDiR1ZESaKMzni1wSZqJ5pe6JNPePKddYOVV84fSHR4
         ++xyD0y3oxqM9U2U1+J2aOdSAY0PJ4ZpBhoG9CWInRLbKoGalFfk1nqvo6fuo3yRzo
         b6C1Ue/bjfhEy1DefWEEriA07PhVe8GEnIbGVtIPVNyXVijyKrrR3dryJ4d+yMrN07
         3/qII+187lHFQ==
From:   Colin King <colin.king@canonical.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: meson: aiu: Fix spelling mistake "Unsupport" -> "Unsupported"
Date:   Sat, 25 Sep 2021 00:12:42 +0100
Message-Id: <20210924231242.144692-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/meson/aiu-encoder-spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/aiu-encoder-spdif.c b/sound/soc/meson/aiu-encoder-spdif.c
index de850913975f..97da60db2c4d 100644
--- a/sound/soc/meson/aiu-encoder-spdif.c
+++ b/sound/soc/meson/aiu-encoder-spdif.c
@@ -113,7 +113,7 @@ static int aiu_encoder_spdif_hw_params(struct snd_pcm_substream *substream,
 		val |= AIU_958_MISC_MODE_32BITS;
 		break;
 	default:
-		dev_err(dai->dev, "Unsupport physical width\n");
+		dev_err(dai->dev, "Unsupported physical width\n");
 		return -EINVAL;
 	}
 
-- 
2.32.0

