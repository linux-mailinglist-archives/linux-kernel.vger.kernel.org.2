Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFED3F8671
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbhHZL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:27:14 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36474
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242303AbhHZL1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:27:01 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D9AA03F044;
        Thu, 26 Aug 2021 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629977171;
        bh=BOfv1mWZucvdeO+2RiG1GUgsxmx8e5VDjoBIMqK5l0s=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Y3YjSEgvmcKuAagE7kzuOI8dH/Zix7iP2PU0sh6qgONNmsEdBJY0lJmJo8iNaY527
         nJJ4FHc0piCHPZBSJLbOkBLg4/AkeOwHhvH/wULTDCxudSlTPZGx2OyeZKjp3pmSP9
         bwjmTfXDCZZfz0+rxshp0Ek9M6P9LiDJXq9TtFjb4BKvvMrmi51PDGtzVYTMwpgkww
         q5FMPrpFVndd79wZl9bX/Yq+oJNNV5YfxAl+7A7yoBzFqc+pjcmKKyKb/OP1CILvDT
         wSow8pCjCiDmZRNBOdweVr63wcw+JPri8f25906su2+9l71kBVNbQJJskxWBWxSd1F
         2XNXn4B36Qd9g==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: mediatek: mt8195: Fix spelling mistake "bitwiedh" -> "bitwidth"
Date:   Thu, 26 Aug 2021 12:26:11 +0100
Message-Id: <20210826112611.10356-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
index bd9876cf02c8..7378e42f2766 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
@@ -1909,7 +1909,7 @@ static int mtk_dai_etdm_configure(struct mtk_base_afe *afe,
 		__func__, etdm_data->format, etdm_data->data_mode,
 		etdm_data->lrck_inv, etdm_data->lrck_width, etdm_data->bck_inv,
 		etdm_data->clock_mode, etdm_data->slave_mode);
-	dev_dbg(afe->dev, "%s rate %u channels %u bitwiedh %u, id %d\n",
+	dev_dbg(afe->dev, "%s rate %u channels %u bitwidth %u, id %d\n",
 		__func__, rate, channels, bit_width, dai_id);
 
 	etdm_channels = (etdm_data->data_mode == MTK_DAI_ETDM_DATA_ONE_PIN) ?
-- 
2.32.0

