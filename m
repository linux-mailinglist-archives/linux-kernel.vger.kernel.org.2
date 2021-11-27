Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8428F45FDA2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353442AbhK0JhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbhK0JfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:35:07 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB048C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:31:53 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id n12so30232792lfe.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HK/UIXBF2kOpn5IjdhG/KrI+jx7IUToPR1d6+HQopis=;
        b=WNAzxL+wbayZqi4bbW+2BQjcp6XE05F7ahvBbVc3J8P9LK+PZH4LtMKXX3qJOK6+Vs
         Qkh3FTvDTWYQcAd/3aZDl/MszdOGh9J9ZY74STWpPBGgupcCVEETZtt1ak8wf0IuLYef
         BNjWVyJRlQbr8zL6LtwXoJ6EVPLYWqFK1PF63obGOyh1hA5R1cmoC3jtg/LvzBYg8EK1
         TOttJ1MeJPqE7mUVDAqhKZbPiTjU4r3UMpQx5PFb7X6qAHS5InPvY1iid3WTGOt3/e+X
         KyzZasGBAstZr6LLlD6zP+425qW+deIfZOOhYtQYNyC8RklEtPhQeD3R+Hvtrrd7c5YH
         bU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HK/UIXBF2kOpn5IjdhG/KrI+jx7IUToPR1d6+HQopis=;
        b=kAi/Pm3VQcRk2+eTjGUTZXZARA7Eh4RQ4n9RrXAUFS08MldcaVD+lkKhruP+tl76Cx
         y93AEjiT6jNHXTZLyPWfbZSchNeOwzZd+I88HMaSqD6nfEJiiokV8OD2ZysPxLxLnTV1
         k/1ArkjodqADrCksFpt5SOIsZS23NSx+5cZRthLMRTOLBaGiN43p67zVLYM2/TxFon4f
         kwgHuqleMtukVdYcDiPvage1kZ7IBv2y1PJS7oktHy4RGqrTakNYJOeECd5CiZVUv63X
         wP9fRfj++7yNPSzWi0LnBpbQ6iCBafk7NPJ5Zdl50/1IcmpVSgMnwNI7AnBhKr/Mgy5h
         jd2g==
X-Gm-Message-State: AOAM531gFvJ7nUymKwr2ZN3D8zJRU1s8F9HOIri+YYJrkH1srWkCp6eP
        BbLvkFf/qO2lwEEn+NqJH9Q=
X-Google-Smtp-Source: ABdhPJyoQLwsRHQuuIRIzM8HLrG5e6b/oBLwUOnb8ih5rVHuodC6f3qZ4pTMksx4IaDda54BPbE+YQ==
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr33702170lfu.51.1638005511997;
        Sat, 27 Nov 2021 01:31:51 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id x17sm757851ljp.95.2021.11.27.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 01:31:51 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: mediatek: mt8195: Constify static snd_soc_ops
Date:   Sat, 27 Nov 2021 10:31:47 +0100
Message-Id: <20211127093147.17368-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only assigned to the ops field in the snd_soc_dai_link which
is a pointer to const struct snd_soc_ops. Make them const to allow the
compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c | 2 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
index e103102d7ef6..9e6b54e19c23 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
@@ -421,7 +421,7 @@ static int mt8195_dptx_hw_params(struct snd_pcm_substream *substream,
 				      SND_SOC_CLOCK_OUT);
 }
 
-static struct snd_soc_ops mt8195_dptx_ops = {
+static const struct snd_soc_ops mt8195_dptx_ops = {
 	.hw_params = mt8195_dptx_hw_params,
 };
 
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index 95abaadcd842..e22e5fd40984 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -391,7 +391,7 @@ static int mt8195_dptx_hw_params(struct snd_pcm_substream *substream,
 				      SND_SOC_CLOCK_OUT);
 }
 
-static struct snd_soc_ops mt8195_dptx_ops = {
+static const struct snd_soc_ops mt8195_dptx_ops = {
 	.hw_params = mt8195_dptx_hw_params,
 };
 
-- 
2.34.1

