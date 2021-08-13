Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FFF3EB6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbhHMOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbhHMOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:34:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AFCC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:34:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so20911332pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFkAP9X+bq/zMMDamtqclNUNcl2vhKVeQXYPNowjSN4=;
        b=JGIFBLhz4diYF+b2lpf1akN6Tbbks53mHqUfLDE6f6U2x5rqflQ60OGajgeg4z1c1t
         7C/6/z/gN/Aqf5ZpbghpbvifQcJzdJzuxAwWuSZ7XTiWhoWTzyawiiuzGx5zVVP7FwiZ
         TGjT7dT+zUqt06ttpRsDczXkjrD6srypuZfDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFkAP9X+bq/zMMDamtqclNUNcl2vhKVeQXYPNowjSN4=;
        b=h1E3X/1eIz/XmsApO9l4Ys59hlppzBgLp22xBfTlzS2F4Onu8WDM8ZqTp4/zhAIlEB
         XVHc/UiXYc9lzhrOQ6DqrAKKFvyUsw6XUmfeFSmKIQLjvwsfK67ebVmPNChsofO1iCEe
         tDiU0yU9kxAU3SPnZS+hRvNzFMvbpdG0m7NgqFZScrwVwZPpQ03nKm0hbc629SBWTmX/
         gdqiEFReEhvU381fmMutL3cmhynqrCbY6dce1tk2MngqOEgG6SCCo819JoZn+5VrS9eI
         qywNLeW3pEU7/ZFNbFUmPGgnHQ+8+GeccwywLcZeatcsfogMKtCWZDMlskRstijNplLW
         lGLw==
X-Gm-Message-State: AOAM530LTzLa67mfUm8jbPWCQgqP8LUu0Q9a3OJqWDoxC/bENCL0B1r7
        /N5JTB2DPhHPF/j3Dtoeq1nGjg==
X-Google-Smtp-Source: ABdhPJxhLQKy3pT6OP/4d7pO0DABK6nLFB13CK6zL1eahKK/CiKS5doSOkWJeDGTy8+0GBP7EoXy1A==
X-Received: by 2002:a05:6a00:15cf:b029:3c2:7a3c:1758 with SMTP id o15-20020a056a0015cfb02903c27a3c1758mr2756140pfu.41.1628865266591;
        Fri, 13 Aug 2021 07:34:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:12ec:9590:9106:e9bf])
        by smtp.gmail.com with ESMTPSA id z16sm2817001pgu.21.2021.08.13.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 07:34:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Douglas Anderson <dianders@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5682: Remove unused variable in rt5682_i2c_remove()
Date:   Fri, 13 Aug 2021 07:34:05 -0700
Message-Id: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if
wrong device ID") I deleted code but forgot to delete a variable
that's now unused. Delete it.

Fixes: 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if wrong device ID")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 sound/soc/codecs/rt5682-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index e559b965a0a6..b9d5d7a0975b 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -294,8 +294,6 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 
 static int rt5682_i2c_remove(struct i2c_client *client)
 {
-	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
-
 	rt5682_i2c_shutdown(client);
 
 	return 0;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

