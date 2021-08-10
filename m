Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92153E86E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhHKAAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhHKAAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:00:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4BBC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:59:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a5so279339plh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kIwCa145vshm7y/cubjS6uAn6tovnETjzr2YzBV56k=;
        b=Qm3ibv1dXn2KYVJ22i9TDFEeI/4v/Yb8FbsJp4rFTZPNEQ338wK3SAL4iuxsxgpEbe
         L0elOBP5pC/SFLeLusG+r6yIObNHCHSSPNSDffHNFKCflx7nRgnygY6EFhN0NcCNJ++B
         TXJd1uaz1d5pMk8kxKX6oB9RODH71lCf4eA+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kIwCa145vshm7y/cubjS6uAn6tovnETjzr2YzBV56k=;
        b=WPMr1Mu+6u4N7XSXe2Gy+hh9BzGD72CpPW9G9mI/lfbRZmlGucSti7ufsTAwNvS+Bz
         4RcaC5hoY/LQlJ5b1slZ5Yj+IAihTYBn6iV/FpY14AkcG1Q+PtSvte8NkkLs2UvJHE9e
         FM6OvHiY7N3JYGE6ENEGe58vKOFaKY0eT89orGN03D/u6Sfjs4efgfGccnqFbu76Q+xr
         hakGSopEsxXS1QXwFQD57QvsMJQFAp8pH5ZGfDBATgvs1JGMARvyUYWeBJY/OWVRPgrS
         i5lj8hbtYKMlsfquLkyhw4A9c8pG1Mt61YB1cIXfrevlVUVFZslrWjT5pI946Vw4OBkU
         gXuw==
X-Gm-Message-State: AOAM531UwFACVM5KcqdrnlFe8fIfujtRWntvVwjE5OYNggvFGjcW0USU
        yOtNNiZwBwH8aD/fm+KLPOdHnw==
X-Google-Smtp-Source: ABdhPJwk1B6jGAar9rqvlMoQYMCL+kY9aA6kGVcctNttFVeTy7KgOhY/GSuEFb2xCWTasZMNkKdyXA==
X-Received: by 2002:a05:6a00:1a0e:b029:3c2:ee2f:b236 with SMTP id g14-20020a056a001a0eb02903c2ee2fb236mr31294329pfv.80.1628639977191;
        Tue, 10 Aug 2021 16:59:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:cf6d:7a54:584e:cf3d])
        by smtp.gmail.com with ESMTPSA id l2sm24915272pfc.157.2021.08.10.16.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:59:36 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong device ID
Date:   Tue, 10 Aug 2021 16:59:15 -0700
Message-Id: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I booted up on a board that had a slightly different codec
stuffed on it, I got this message at bootup:

  rt5682 9-001a: Device with ID register 6749 is not rt5682

That's normal/expected, but what wasn't normal was the splat that I
got after:

  WARNING: CPU: 7 PID: 176 at drivers/regulator/core.c:2151 _regulator_put+0x150/0x158
  pc : _regulator_put+0x150/0x158
  ...
  Call trace:
   _regulator_put+0x150/0x158
   regulator_bulk_free+0x48/0x70
   devm_regulator_bulk_release+0x20/0x2c
   release_nodes+0x1cc/0x244
   devres_release_all+0x44/0x60
   really_probe+0x17c/0x378
   ...

This is because the error paths don't turn off the regulator. Let's
fix that.

Fixes: 0ddce71c21f0 ("ASoC: rt5682: add rt5682 codec driver")
Fixes: 87b42abae99d ("ASoC: rt5682: Implement remove callback")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 sound/soc/codecs/rt5682-i2c.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 4a56a52adab5..1cc07812b5ac 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -117,6 +117,13 @@ static struct snd_soc_dai_driver rt5682_dai[] = {
 	},
 };
 
+static void rt5682_i2c_disable_regulators(void *data)
+{
+	struct rt5682_priv *rt5682 = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5682->supplies), rt5682->supplies);
+}
+
 static int rt5682_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
@@ -156,6 +163,10 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
 		return ret;
 	}
+	ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
+				       rt5682);
+	if (ret)
+		return ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(rt5682->supplies),
 				    rt5682->supplies);
@@ -285,7 +296,6 @@ static int rt5682_i2c_remove(struct i2c_client *client)
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
 
 	rt5682_i2c_shutdown(client);
-	regulator_bulk_disable(ARRAY_SIZE(rt5682->supplies), rt5682->supplies);
 
 	return 0;
 }
-- 
2.32.0.605.g8dce9f2422-goog

