Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3D3DDFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhHBS4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:56:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D9C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:56:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq29so9940000lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbqGPSW8VOThkKarLLIufkakwj9Fc62iaxbn2qNAotE=;
        b=kSiO1YSZOk7TO0KPkB22ZwpNedL0nwTIEb9zJQHnwDdZsJsKDswNMVN6J1ggep7Q8S
         C8x4WJ8NyDRfKByxmK9Vm9K1VL+7gPi3SrEzWVJfD/HLfMhIIW22BsAuw9ZEPe2HPBsF
         7hsZ/gQIW7m5r3RqFTBmyalUhRbrz04V/Slz6xODQ0w80rEIi/CAufYkCR5q7EacTwEp
         TP/vWSCJLSFbDb7+2WudiwyLXERQuHtkX1p4hPDBpy21USUJd1ZON/IkWXwi6we7gfZ6
         vcTXo9fZpxbhKrfC1q+ona1AalFYFV6gPW1V6Cwl5NIaUH1CrGFjxrA8CKRkUxd7bQsp
         ZXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbqGPSW8VOThkKarLLIufkakwj9Fc62iaxbn2qNAotE=;
        b=ScDgBaNkanw6zMLOw6unPxmqMyozIwetRDUxFJXtOK+vP1FZUHwWW+eMGEmt3ePLp+
         uSx7SS2J25/w1So/W+uXWyutla/NaVR2ux/bk052iFGe/D/9jlx57XI1g2AMM852lH3F
         8y9JJDDhavX117ZYyLyNI3UG1kiqVBJnsWGxEPmwnqRTco6Gxh0fy5D1MXpsjWHZZljA
         2YI2QOHN7fKjrBiVwS/i+S/1WS2FhgZYgucWTgihe5RK9aWW+oXvafHWNXAeheWL93Pw
         nC/1wh7kW6sChGvbRpd0JOcgxKZZfFNFooyQ4ythCos0zmOr4QhFP8cRaAmja4Gbe1/+
         YmLA==
X-Gm-Message-State: AOAM533CPjvybEyup9rE7pFgctAiGiD1QHA9JRbYSJZ/R/nbhEeLp6gm
        3TfyKNvGU+SKJoFBTJx8mI0=
X-Google-Smtp-Source: ABdhPJygQ2hzBnGLJ9Jw0i/SBv5WluES3z3AMhjnXjFEYyrsdJfXmCxBRwWqQy6jIhwOKBrHK5ALZw==
X-Received: by 2002:a05:6512:118c:: with SMTP id g12mr13817379lfr.143.1627930586424;
        Mon, 02 Aug 2021 11:56:26 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id p17sm907269ljc.32.2021.08.02.11.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 11:56:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: rt5640: Silence warning message about missing interrupt
Date:   Mon,  2 Aug 2021 21:52:58 +0300
Message-Id: <20210802185258.1881-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt is optional for the RT5640 codec. Nexus 7 doesn't use interrupt,
this results in a noisy warning message that looks like a error condition.
Make interrupt explicitly optional to silence the message, use modern
IRQF_NO_AUTOEN flag and correct the reg[q]uest typo in the message.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/codecs/rt5640.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 9523f4b5c800..0f5087a7644b 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2836,15 +2836,18 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&i2c->dev, rt5640->irq, rt5640_irq,
-			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-			       | IRQF_ONESHOT, "rt5640", rt5640);
-	if (ret == 0) {
-		/* Gets re-enabled by rt5640_set_jack() */
-		disable_irq(rt5640->irq);
+	if (rt5640->irq) {
+		/* enabled by rt5640_set_jack() */
+		ret = devm_request_irq(&i2c->dev, rt5640->irq, rt5640_irq,
+				       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN |
+				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				       "rt5640", rt5640);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to request IRQ %d: %d\n",
+				rt5640->irq, ret);
+			return ret;
+		}
 	} else {
-		dev_warn(&i2c->dev, "Failed to reguest IRQ %d: %d\n",
-			 rt5640->irq, ret);
 		rt5640->irq = -ENXIO;
 	}
 
-- 
2.32.0

