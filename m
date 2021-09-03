Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF13FFF6F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349334AbhICLub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:50:31 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56864
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349321AbhICLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:50:29 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9DD213F09E;
        Fri,  3 Sep 2021 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630669768;
        bh=cY308Ok8pbsAlAgAmdVbKjTzNIY9q0Cqnz5SkkmxGdk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=j+2I4zP+/n4UObG3A2xBnhb7ei1OJ24PTYqJUHMCJv22TbfMRULUIjhZVU8hPuUg1
         158qWcex1GrdacaaHpcPkRIsjo7u/YC4QrKcE2O4FJ5WFEyhIVVf9yITKhJIaCDxty
         xdE2MHyxeodC1uBA9Xo6hEOMZCRo4L7Nh88oYmXi512jWw1ukgjy2sFdOYkciqeNUH
         vP/A/qANY5AT2WitK1R/pinLDOAzw0xtFso7hn6CfBc7al1F3mJPdAujnKKBO1pEST
         6dWsOTWN9/VzR1+ynXuSxRxqSpFp7cU5SVkrVh5tdVTsO1NrBso5NX2/Xk7DxlLaAl
         QfHdOAxyfKAZQ==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8195: Fix unused initialization of pointer etdm_data
Date:   Fri,  3 Sep 2021 12:49:28 +0100
Message-Id: <20210903114928.11743-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer etdm_data is being inintialized with a value that is never
read, it is later being re-assigned a new value. Remove the redundant
initialization.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
index 7378e42f2766..ac591d453e1e 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
@@ -2094,7 +2094,7 @@ static int mtk_dai_etdm_set_sysclk(struct snd_soc_dai *dai,
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	int dai_id;
 
 	dev_dbg(dai->dev, "%s id %d freq %u, dir %d\n",
-- 
2.32.0

