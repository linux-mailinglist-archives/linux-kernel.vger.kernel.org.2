Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5873F9F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhH0Su4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:50:56 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59828
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230059AbhH0Su4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:50:56 -0400
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net [80.193.200.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CF9CF3F232;
        Fri, 27 Aug 2021 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630090204;
        bh=6DS/6l+5PcmW6BogA40VziIkdEr3BoKs9rilBqjn/18=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=PrLIcK+K9UeZcMGIqjktvzJIbSAHNDa7GA4fSxO/7p5AebXiIUbDu7eKogM8n7Vuq
         h0OmDyUCgW6+v5c7EwLqxOkZTnnBGlN57uRefivwfNBr0uY0XHbcL5DN/J4vYOfCyo
         1jLkHghf0ODx+D0njodSiydSq8PBvKvVMEolUoF2n5bFvWeLesQHEv/Ru9ZLZpdUTj
         7NSxWc6P3sq4HnKwlr/bZtMf2ks7dH3DXLuBmJTNF0HFMPg8juIoQIdnABIZx8Uavs
         y5CEgdjuuL9UCTzRdv5OQiMn9IVT/nSnVcuhhmivqOMjNlH1sVeo/nx/a7jUscQDf7
         wAyJ7WdhfxfNg==
From:   Colin King <colin.king@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: samsung: s3c24xx_simtec: fix spelling mistake "devicec" -> "device"
Date:   Fri, 27 Aug 2021 19:50:03 +0100
Message-Id: <20210827185003.507006-1-colin.king@canonical.com>
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
 sound/soc/samsung/s3c24xx_simtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 81a29d12c57d..0cc66774b85d 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -327,7 +327,7 @@ int simtec_audio_core_probe(struct platform_device *pdev,
 
 	snd_dev = platform_device_alloc("soc-audio", -1);
 	if (!snd_dev) {
-		dev_err(&pdev->dev, "failed to alloc soc-audio devicec\n");
+		dev_err(&pdev->dev, "failed to alloc soc-audio device\n");
 		ret = -ENOMEM;
 		goto err_gpio;
 	}
-- 
2.32.0

