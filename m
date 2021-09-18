Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6183E4108B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 23:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbhIRVh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 17:37:29 -0400
Received: from www.zeus03.de ([194.117.254.33]:54502 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239576AbhIRVh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 17:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Kwpp0Fj2x26Eg7
        8Ja7Z4hycUKbPpkJLdheziTeB1Zi8=; b=y+DWnL+rlbKwj54YmFiewuQaS11s/E
        +D/GrBAn071zxivs29KhJvwpb+29pXGJ3EIGZZL0KWXmTNVZ2JYXXzt3gGpVBrA2
        /GHF77p+5u4/ZDMJ11BdMS1+bHcTKifbbr6nRBb2c10eqvYmXSLZ7PymDcoUygwk
        Riu67C9lfpUnE=
Received: (qmail 1967036 invoked from network); 18 Sep 2021 23:36:03 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Sep 2021 23:36:03 +0200
X-UD-Smtp-Session: l3s3148p1@BrCw1UvM0JMgAwDPXyF2AO3QmsoMF7XN
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: codecs: max98390: simplify getting the adapter of a client
Date:   Sat, 18 Sep 2021 23:35:52 +0200
Message-Id: <20210918213553.14514-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210918213553.14514-1-wsa+renesas@sang-engineering.com>
References: <20210918213553.14514-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 sound/soc/codecs/max98390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index b392567c2b3e..d1882cbc9381 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -1021,7 +1021,7 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 	int reg = 0;
 
 	struct max98390_priv *max98390 = NULL;
-	struct i2c_adapter *adapter = to_i2c_adapter(i2c->dev.parent);
+	struct i2c_adapter *adapter = i2c->adapter;
 
 	ret = i2c_check_functionality(adapter,
 		I2C_FUNC_SMBUS_BYTE
-- 
2.30.2

