Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96240BE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhIODsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:48:23 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53456 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232517AbhIODsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:48:22 -0400
X-UUID: fb921b549e374c8faf3ea61a70d66d17-20210915
X-UUID: fb921b549e374c8faf3ea61a70d66d17-20210915
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 734492139; Wed, 15 Sep 2021 11:47:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 15 Sep 2021 11:47:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 11:47:00 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <shane.chien@mediatek.com>,
        <chipeng.chang@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <tzungbi@google.com>
Subject: [PATCH] ASoC: mediatek: mt6359: Fix unexpected error in bind/unbind flow
Date:   Wed, 15 Sep 2021 11:46:59 +0800
Message-ID: <20210915034659.25044-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt6359-sound is a MFD driver. Because its regmap is retrieved from its
parent, it shouldn't be freed in mt6359-sound driver.

snd_soc_component_exit_regmap() will do regmap_exit(), this results in
unexpected results if sound card unregister flow is invoked when users
try to bind/unbind audio codec.

Remove the usage of snd_soc_component_exit_regmap(). Instead, set
component->regmap = NULL in the component remove function.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/codecs/mt6359.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 2d6a4a29b850..f8532aa7e4aa 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -2697,7 +2697,7 @@ static int mt6359_codec_probe(struct snd_soc_component *cmpnt)
 
 static void mt6359_codec_remove(struct snd_soc_component *cmpnt)
 {
-	snd_soc_component_exit_regmap(cmpnt);
+	cmpnt->regmap = NULL;
 }
 
 static const DECLARE_TLV_DB_SCALE(hp_playback_tlv, -2200, 100, 0);
-- 
2.18.0

