Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CEE3BC8F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhGFKFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhGFKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:05:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98310C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 03:02:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f17so7466744pfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4rKZfdDnc7YY0gd/5c6T/3ONyRHjXIiu4ZMdkzyvos=;
        b=Ax297GMl8rmbuGv33BOvflvBUn3j7OVNCabAWeYnuuJcvp4ziR5WPhxZo6KkQZIDZN
         BVpo+rHjPG/6O9wAD4Qg1HiVxrN+l+L5D6NBlJ1gxcj0DAuogKfy/s8E6G/wwg40nPGI
         EULPsmR44CvUaa+6oSY4kNDQBJevDVBLWYZbIksyovGf38u/aaXa8mH1+0eW12i0l50T
         eNE6yDcmFn9367UX9lEgOHP3TWJFhDodKDlFfj90g8PpbqdxKm6e+LqHgENrkqtxoxor
         PveMNZtvrFkjmV5hdawmjWJCE/l/twr4N//YIyrCC9xzhwmI6Z3c7dG48PpkUyq+g5qa
         mM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4rKZfdDnc7YY0gd/5c6T/3ONyRHjXIiu4ZMdkzyvos=;
        b=Ko3jxxC0uSfKhVw/Zkz+o4ylSXhsnRfz1VXU+fUHWdI553GbFAAivvP0u9h6sDt1E9
         +OJ+CgWuMUWgUS0nkLRNgGpycV5FU40ToMsBTbOacgAe1aP76I0YneTCAjyQU4tqHWrz
         SwDpRitq82sUehPKw2s2y2pS6Vdn1SC1JNKovm+yiMEZgAhd7yHZD6zTGaMGLdcKTqkd
         mbfBdCcieHdueAlX1TRcKLwFsyn3Q+pJGaeOhHkowWO9R1kGpj5EOamqYZUMmiCMqI0N
         iY0u6u8urPGTkZJYXuAZilf59Haz9M2jMpX+RrG1Vri8oqMb5EaVq4a8ayxrZFY82Spm
         xYYg==
X-Gm-Message-State: AOAM5330rq+f7R0BdlxCGOCs1w2bjHoo4m+a5W5I5U6WRrUByuvygrMx
        Ygargy97qZAgKNbFHQKIZxFD+KLkhc8XKQ==
X-Google-Smtp-Source: ABdhPJzyYjNshBa+VElbGVPNrzc/bWtJ8+1lWlxZ9E1I+Qw0C4GeKRDHILi96YGmTOQLVGmKnzqXww==
X-Received: by 2002:a63:471b:: with SMTP id u27mr20594343pga.301.1625565756160;
        Tue, 06 Jul 2021 03:02:36 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id j19sm17413088pgm.44.2021.07.06.03.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 03:02:35 -0700 (PDT)
From:   Gu Shengxian <gushengxian507419@gmail.com>
To:     codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, peda@axentia.se
Cc:     linux-kernel@vger.kernel.org, Gu Shengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: atmel: fix spelling mistakes
Date:   Tue,  6 Jul 2021 18:02:30 +0800
Message-Id: <20210706100230.32633-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gu Shengxian <gushengxian@yulong.com>

Fix some spelling mistakes as follows:
regaedles ==> regardless
prezent ==> present
underrrun ==> underrun
controlls ==> controls

Signed-off-by: Gu Shengxian <gushengxian@yulong.com>
---
 sound/soc/atmel/mchp-spdifrx.c   | 6 +++---
 sound/soc/atmel/mchp-spdiftx.c   | 2 +-
 sound/soc/atmel/tse850-pcm5142.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index e6ded6f8453f..bcd4f3e4fb0f 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -56,7 +56,7 @@
 /* Validity Bit Mode */
 #define SPDIFRX_MR_VBMODE_MASK		GENAMSK(1, 1)
 #define SPDIFRX_MR_VBMODE_ALWAYS_LOAD \
-	(0 << 1)	/* Load sample regardles of validity bit value */
+	(0 << 1)	/* Load sample regardless of validity bit value */
 #define SPDIFRX_MR_VBMODE_DISCARD_IF_VB1 \
 	(1 << 1)	/* Load sample only if validity bit is 0 */
 
@@ -519,7 +519,7 @@ static int mchp_spdifrx_cs_get(struct mchp_spdifrx_dev *dev,
 	/* check for new data available */
 	ret = wait_for_completion_interruptible_timeout(&ch_stat->done,
 							msecs_to_jiffies(100));
-	/* IP might not be started or valid stream might not be prezent */
+	/* IP might not be started or valid stream might not be present */
 	if (ret < 0) {
 		dev_dbg(dev->dev, "channel status for channel %d timeout\n",
 			channel);
@@ -571,7 +571,7 @@ static int mchp_spdifrx_subcode_ch_get(struct mchp_spdifrx_dev *dev,
 	mchp_spdifrx_isr_blockend_en(dev);
 	ret = wait_for_completion_interruptible_timeout(&user_data->done,
 							msecs_to_jiffies(100));
-	/* IP might not be started or valid stream might not be prezent */
+	/* IP might not be started or valid stream might not be present */
 	if (ret <= 0) {
 		dev_dbg(dev->dev, "user data for channel %d timeout\n",
 			channel);
diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 3bd350afb743..d24380046435 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -80,7 +80,7 @@
 #define SPDIFTX_MR_VALID1			BIT(24)
 #define SPDIFTX_MR_VALID2			BIT(25)
 
-/* Disable Null Frame on underrrun */
+/* Disable Null Frame on underrun */
 #define SPDIFTX_MR_DNFR_MASK		GENMASK(27, 27)
 #define SPDIFTX_MR_DNFR_INVALID		(0 << 27)
 #define SPDIFTX_MR_DNFR_VALID		(1 << 27)
diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 59e2edb22b3a..50c3dc6936f9 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -23,7 +23,7 @@
 //   IN2 +---o--+------------+--o---+ OUT2
 //               loop2 relays
 //
-// The 'loop1' gpio pin controlls two relays, which are either in loop
+// The 'loop1' gpio pin controls two relays, which are either in loop
 // position, meaning that input and output are directly connected, or
 // they are in mixer position, meaning that the signal is passed through
 // the 'Sum' mixer. Similarly for 'loop2'.
-- 
2.25.1

