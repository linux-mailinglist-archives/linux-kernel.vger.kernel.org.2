Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD16440300B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbhIGVC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIGVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:02:56 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E904C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:01:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g9so273134ioq.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42/o3XCTvFFMDqQK8f9AfyX4rLgajFefJ/gjs/d1iq8=;
        b=LLEIdYuiZYXgeaNIuDLm0LQWrjYOXmecJ+uVmwTbZET508a7ox7wZKj3OGIfsFoJGS
         P/nUK1hIHoUbEY9L4wagB/KWdU5GPhXGtHDp1ocgJV+ilRKzbfJr4jCDtWwsaX57D6qg
         luWbusBQYyh0YXpWXCHLUq01tzfOhL4VbmBGJjmTEGRdGpDNM+3ztB+Rtjj3oQ+xL5Sj
         1/cD0hkyGDHvSPqhHB4ydL3eRkaQztNodJgAxLqnUyrBohtuvtNMYOUpYB/9eU/zsuvZ
         qKUvaEMxi9MBQzpheVoWeJO/9Pf+s/EPQS09wnmqlL7XiOuUhxKga7x4YMBWtF26IQgY
         fg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42/o3XCTvFFMDqQK8f9AfyX4rLgajFefJ/gjs/d1iq8=;
        b=B29bjuCgIYalWSZOPfMaGuTsijGAjnmJBzWul2ClFL7MrSxboBt3I1F4kk4HeLFTPX
         awPEtnJVqcnAUDZWZQZBu7wxh5R7SKtOZH4QtVWb/nc5iVcL/D6btl/pQ/C09NXY2aNh
         KdtkH4LdaafMLY7RsAodejpeygUjTGbsNB7CX2VDe7bP1l1lOerjmYzgoa0RKXqAY9Af
         9m/FDYDrYqD3YwE+aMcNXIxSZhel/t98n5mOe6nFta/sxd/QFFpydfQNN4OXYg9aVZ+m
         Iv2EvLhAOmsmhRVfysPyVQQBs27qM2BhptY27dzzOE/SoTK8dyFD+5hsaxO9XPIDEuoV
         ssBg==
X-Gm-Message-State: AOAM5310xzCPUXtClMWL6xqJnbk3NgzcfWCJxEyPtRyh967GIGiJeZ37
        yJx3HdZYlFlQ30RALyQp5ts=
X-Google-Smtp-Source: ABdhPJzB9ZDRa7SHDtuzOgMiXk9eN8ynL/UpZ1hFODTFS3ZTujq5wAFtsVY1S9f8cYWOGn8vK8yd7w==
X-Received: by 2002:a02:7f47:: with SMTP id r68mr294215jac.54.1631048509005;
        Tue, 07 Sep 2021 14:01:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:4320:6caf::199])
        by smtp.googlemail.com with ESMTPSA id c11sm22740ioh.50.2021.09.07.14.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:01:47 -0700 (PDT)
From:   gearhead <ys3al35l@gmail.com>
To:     ys3al35l@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: pcm5102a: increase rate from 192k to 384k
Date:   Tue,  7 Sep 2021 16:01:25 -0500
Message-Id: <20210907210130.116769-1-ys3al35l@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the pcm5102a is capable of 384k, but the current code limits it to 192k.
This commit extends to 384k

Signed-off-by: gearhead <ys3al35l@gmail.com>
---
 sound/soc/codecs/pcm5102a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm5102a.c b/sound/soc/codecs/pcm5102a.c
index b8cfc250612c..f39f98bbc97f 100644
--- a/sound/soc/codecs/pcm5102a.c
+++ b/sound/soc/codecs/pcm5102a.c
@@ -17,7 +17,7 @@ static struct snd_soc_dai_driver pcm5102a_dai = {
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = SNDRV_PCM_RATE_8000_384000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			   SNDRV_PCM_FMTBIT_S24_LE |
 			   SNDRV_PCM_FMTBIT_S32_LE
-- 
2.33.0

