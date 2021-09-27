Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7224191DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhI0J4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhI0J4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:56:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C0CF60F70;
        Mon, 27 Sep 2021 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632736494;
        bh=i8ymyzqgvI3wLotGeaYebjXlqYY+zZQePxuRiKJ8yDI=;
        h=From:To:Cc:Subject:Date:From;
        b=cAhI7i4/kvjjIQ8w6lFk9uJKpSBk49kmUx+eOhilqKcrDvvWOCZP4vxNPLALMVnK4
         2WsbCOyVsrkqDV6Z2AJ2DMxHpEDoP5asyOCKZmtHPY12LPsZpqZzWGwWC2NTl7oCkI
         XR1b7RoT46auZGQEnXZkOAa/J5tN1icDYh0fU/IvPzYWE1gcrroTu3j82+Mct9Tv/U
         n2I7OAoa7f1JVogt2FlEqAPhI6eS8mC85XugcNe1T5zUZKehWz/99mcV+KXZxS+FGZ
         uI8OgL37A88pA2rYMjnfFVlDd8urJ4PMr/1HCjtYrhnT1QPk44qpGBwyTeHMrp0tNy
         nYC8AhBL5k6Gg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: samsung: add missing "fallthrough;"
Date:   Mon, 27 Sep 2021 11:54:34 +0200
Message-Id: <20210927095449.1070639-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With gcc, we get a warning in this file:

In file included from include/linux/io.h:13,
                 from sound/soc/samsung/s3c-i2s-v2.c:16:
sound/soc/samsung/s3c-i2s-v2.c: In function 's3c2412_i2s_trigger':
arch/arm/include/asm/io.h:92:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
 #define __raw_writel __raw_writel
                      ^
arch/arm/include/asm/io.h:299:29: note: in expansion of macro '__raw_writel'
 #define writel_relaxed(v,c) __raw_writel((__force u32) cpu_to_le32(v),c)
                             ^~~~~~~~~~~~
arch/arm/include/asm/io.h:307:36: note: in expansion of macro 'writel_relaxed'
 #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
                                    ^~~~~~~~~~~~~~
sound/soc/samsung/s3c-i2s-v2.c:398:3: note: in expansion of macro 'writel'
   writel(0x0, i2s->regs + S3C2412_IISFIC);
   ^~~~~~
sound/soc/samsung/s3c-i2s-v2.c:400:2: note: here
  case SNDRV_PCM_TRIGGER_RESUME:
  ^~~~

From all I can tell, this was indeed meant to fall through, so
add "fallthrough;" statement to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index e9481187a08c..de66cc422e6e 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -397,6 +397,8 @@ static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		/* clear again, just in case */
 		writel(0x0, i2s->regs + S3C2412_IISFIC);
 
+		fallthrough;
+
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!i2s->master) {
-- 
2.29.2

