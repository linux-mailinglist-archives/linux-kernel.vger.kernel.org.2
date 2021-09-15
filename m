Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959A440C3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhIOKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:51:51 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41594
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhIOKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:51:48 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6468A3F10B;
        Wed, 15 Sep 2021 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631703027;
        bh=xn+5nToJ2orf+Up6k7sn+oX06VsYAXKMy44e0Mtdtig=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=nqkapOaphl4IBekkRVekUgd37nzYvqKGinzjKir5PmQxIcAmKmOtaLHBg6jHzKAAt
         n8i8+chi6FUvQXNlm40v+uCxQww727wSAFEEmzlLV7vw21OEgTvGU8cNw+eHfTINOc
         yBfSQIaNtaIIPWyLiMXQvLNK2dU7h9u1J9/xrMoL3gIkmhI5yKbLe5nR9R71c9JSzI
         bCggbYOi5eBMBwrtv5mmIVacvScO6Omkg0xllNLklR4HfvH+snXTU8veF9LaotvP/7
         4duE7N1fALbqsEgNT+thVhYnL5iF957CHuieXykK9PzgXxnyDGJZUvLQOF7MJaLICm
         sqca0K7RMdZPg==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8195: make array adda_dai_list static const
Date:   Wed, 15 Sep 2021 11:50:27 +0100
Message-Id: <20210915105027.10805-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array adda_dai_list on the stack but instead it
static const. Also makes the object code smaller by 33 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  28271	  11640	      0	  39911	   9be7	mt8195/mt8195-dai-adda.o

After:
   text	   data	    bss	    dec	    hex	filename
  28142	  11736	      0	  39878	   9bc6	mt8195/mt8195-dai-adda.o

(gcc version 11.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-adda.c b/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
index 878dec0b69ed..f04bd1781356 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
@@ -788,9 +788,11 @@ static int init_adda_priv_data(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_dai_adda_priv *adda_priv;
-	int adda_dai_list[] = { MT8195_AFE_IO_DL_SRC,
-				MT8195_AFE_IO_UL_SRC1,
-				MT8195_AFE_IO_UL_SRC2};
+	static const int adda_dai_list[] = {
+		MT8195_AFE_IO_DL_SRC,
+		MT8195_AFE_IO_UL_SRC1,
+		MT8195_AFE_IO_UL_SRC2
+	};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(adda_dai_list); i++) {
-- 
2.32.0

