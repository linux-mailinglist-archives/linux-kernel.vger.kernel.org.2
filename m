Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21D3E9469
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhHKPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhHKPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:18:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD52C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:18:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a5so3136297plh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ygxUpyRX9wOtF8ZOqKu/KuzaLXR5hL1hZ6xZFoZuCD4=;
        b=CpiIzIOhMYLbVZHyvo6F+/4fLJHxng97OOxY6LZyn8+rJFWiHXYtRIt1jYgPz3yXcy
         5u3a7v/iHytl5YWjA+3VnvTejeZEGumLYoT5g250NMttmMUFe+dVQ9NQowYJlR8q3O/+
         U3TYeQsC+9f8eOPweI4vaw0LoPWeCNXIZlpq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ygxUpyRX9wOtF8ZOqKu/KuzaLXR5hL1hZ6xZFoZuCD4=;
        b=pLcL5xpKO5VGtow1URU6ug4kiw/qNx0rVL3CdUeze12V3ek6N5i1U7gnOtpAyQm0eT
         txrPjLchlD1by18cuNhWPzMKerOdMSLECWiDlsNZ8r7XGF7l76n2FASYLteiE4WeNBQ/
         HFY7A9HRLIntCqd1fR4ZqmR64I3IkSOl/fbgFl+dPMBjqR734yzahjkootLUAtDGvYvQ
         jbunuLmBBuD4lRunl8Q3Y9rcR3rPBTrDtjluoUHFJhaYuix85Up1Ovn+g/5VlHsbyZ6L
         Q0GaVnuCKdiLPGqcQ0l+arcwaGtkvaKOrXmfDFfD2CLJwW+t4sKeQ7q6161stqhJqNUJ
         NX0g==
X-Gm-Message-State: AOAM531oVzu5brG93VRpDDqeo6IeGZ5kZBTREv7yPoLtNUajifnu7lg8
        KWIIRIDZHN98p+q9YH2SXJlhBA==
X-Google-Smtp-Source: ABdhPJxuQ9F1OGZdSAD5Ml4b3eKOeX4HHmdbExxTwfq7eiGklUYibxeF6HOax62CXeDESYQJwvVEkQ==
X-Received: by 2002:a17:902:8c83:b029:11b:3f49:f88c with SMTP id t3-20020a1709028c83b029011b3f49f88cmr4563235plo.63.1628695099936;
        Wed, 11 Aug 2021 08:18:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:2800:b98b:b4d4:10f9])
        by smtp.gmail.com with ESMTPSA id 22sm30083544pgn.88.2021.08.11.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:18:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: rt5682: Properly turn off regulators if wrong device ID
Date:   Wed, 11 Aug 2021 08:17:56 -0700
Message-Id: <20210811081751.v2.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2:
- Add a blank line.

 sound/soc/codecs/rt5682-i2c.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 4a56a52adab5..e559b965a0a6 100644
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
@@ -157,6 +164,11 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
+				       rt5682);
+	if (ret)
+		return ret;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(rt5682->supplies),
 				    rt5682->supplies);
 	if (ret) {
@@ -285,7 +297,6 @@ static int rt5682_i2c_remove(struct i2c_client *client)
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
 
 	rt5682_i2c_shutdown(client);
-	regulator_bulk_disable(ARRAY_SIZE(rt5682->supplies), rt5682->supplies);
 
 	return 0;
 }
-- 
2.32.0.605.g8dce9f2422-goog

