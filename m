Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B813B4349
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFYMfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:35:47 -0400
Received: from m12-11.163.com ([220.181.12.11]:44702 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhFYMf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HtJQV
        9EtAC2qyxvZO+JK0dUGs8ISgYjR0FsgXeb14II=; b=NBKTKxrOaj3cM5Ybk9mQv
        L9SkpVHGptvT7aUj7LA3w+RFNO0+P/pQm5/1aofwGpx+sI53fGb9ZopKsSiLf4nY
        E/76LCiU/CUaecPUzkWwk+J+kSwcPILvQv5jh1BQwkhOo3cVbScy4IwzK2KP910H
        4v17BtDs59A93b/2YGao44=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowAA3R3_AzNVgSHY2jw--.55453S2;
        Fri, 25 Jun 2021 20:32:01 +0800 (CST)
From:   13145886936@163.com
To:     perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: mediatek: mt8192: Simplify if else codes
Date:   Fri, 25 Jun 2021 05:31:59 -0700
Message-Id: <20210625123159.490218-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAA3R3_AzNVgSHY2jw--.55453S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1rKw18XF1kAw1kAryrWFg_yoWftFg_G3
        4kGwn3ZFW7JrWxCa9rtrn7urnrXFy8CryIvF4Yqr13t347XF4rZwnFqF47ur4DZw4vv34f
        A34Svw4fXr1qyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5JMa5UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiGgG8g1aD+PMCbAAAsU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Simplify if else codes.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
index f040dce85da5..f8c73e8624df 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
@@ -413,8 +413,6 @@ static int mtk_adda_pad_top_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2)
 			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x38);
-		else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)
-			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x30);
 		else
 			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x30);
 		break;
-- 
2.25.1

