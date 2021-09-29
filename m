Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290B541C1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbhI2Jpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhI2Jpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:45:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33388C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:44:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i4so8250887lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZX5/OLXbcKow/MyLmIvfS7K1Bp5NfiQXOfcHQ+IUkf0=;
        b=hxWleLzbstchpsvQKiG23E8pOaFLMrgrgAAM+Mx+w60M3/i7w1TFE97NBgTs6G+P35
         sTNj4o7HadmWK4hGZwRd27PpdqTBCoPD1cX5Fb3lq85MAZm3PKZu24VrMnHQ4K/jPffM
         yGoOJyLXwvBo8DLZDHNXY0AyzFxgQJeJ7QrOn/DMTu6qGJy7yBda0GAD7A9NLGq+/+Uo
         kxOj4WO6hV8Uh8IzDsM6dIKS6wsTZEy67GHe9e3mPDeLhIw8Udx30Cl42r9f6y+96haJ
         71PoLatMx+pwU8ayBceLAigDl82bIFJPvoR4fQBqhzOO3pjfoX/WxEzZyHli/IDbHYFs
         fFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZX5/OLXbcKow/MyLmIvfS7K1Bp5NfiQXOfcHQ+IUkf0=;
        b=oG2fITCvzjYmHtG9cysYCpIKUQhQq7JBnbhPVbNfnyPJUo5tDK+ZHQKFZALxpMwkSc
         cUQKtOfM4N0TGPgkdGr4uEUMgKy1WWNBs0F1/86a5qHgaMeSEVQ1X88v9giFvPozyd2y
         FmsnhXb859C6qhd81CA4SiQIgJYWf1N0m4ICBNreuAD9O0tI2dceyBfw+EPJQA9pNqzs
         D34DkSuEK9zikxmKfqqa1SMf5co0okvp4jpJ+71JM4COeVrvvu7nmKu52tYQwp631/e/
         kSM+uQ9760Yck7dWGabpqGlHtg2pF6lhS4xPZFIvs9jbidbAq11uGlMQI661PuOYRUSQ
         BDNA==
X-Gm-Message-State: AOAM532wTcUfxXt82XhiQR4eklu9l6rspZS6LxbKcofnTO6/X0skARNy
        y+kCe5EfePAvxEmxZQPjfCQ=
X-Google-Smtp-Source: ABdhPJypimcvGnek+f7kxlDrVFGvtrmISlMN2SmorT7qYa4RlYGeBFFPVI61M5gwhAQCGLDHtWVpTw==
X-Received: by 2002:a05:651c:170e:: with SMTP id be14mr4769283ljb.487.1632908646586;
        Wed, 29 Sep 2021 02:44:06 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id n7sm182717lft.309.2021.09.29.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 02:44:05 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: ux500: mop500: Constify static snd_soc_ops
Date:   Wed, 29 Sep 2021 11:44:01 +0200
Message-Id: <20210929094401.28086-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct mop500_ab8500_ops is only assigned to the ops field in the
snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/ux500/mop500_ab8500.c | 2 +-
 sound/soc/ux500/mop500_ab8500.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index 2c39c7a2fd7d..3e654e708f78 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -348,7 +348,7 @@ static int mop500_ab8500_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-struct snd_soc_ops mop500_ab8500_ops[] = {
+const struct snd_soc_ops mop500_ab8500_ops[] = {
 	{
 		.hw_params = mop500_ab8500_hw_params,
 		.hw_free = mop500_ab8500_hw_free,
diff --git a/sound/soc/ux500/mop500_ab8500.h b/sound/soc/ux500/mop500_ab8500.h
index 8138a4e9aaf5..087ef246d87d 100644
--- a/sound/soc/ux500/mop500_ab8500.h
+++ b/sound/soc/ux500/mop500_ab8500.h
@@ -11,7 +11,7 @@
 #ifndef MOP500_AB8500_H
 #define MOP500_AB8500_H
 
-extern struct snd_soc_ops mop500_ab8500_ops[];
+extern const struct snd_soc_ops mop500_ab8500_ops[];
 
 int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd);
 void mop500_ab8500_remove(struct snd_soc_card *card);
-- 
2.33.0

