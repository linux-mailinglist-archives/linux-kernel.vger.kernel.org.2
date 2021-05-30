Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C063952DF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 22:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhE3UpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 16:45:10 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:46196 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhE3UpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 16:45:09 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 May 2021 16:45:09 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id B3CFA1817A0CB;
        Sun, 30 May 2021 22:35:01 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 55jQULQnARog; Sun, 30 May 2021 22:35:01 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lB1rIV5dxa9A; Sun, 30 May 2021 22:35:01 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, grandmaster@al2klimov.de,
        robh@kernel.org, dmurphy@ti.com, tiwai@suse.com, perex@perex.cz,
        broonie@kernel.org, lgirdwood@gmail.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values
Date:   Sun, 30 May 2021 22:34:46 +0200
Message-Id: <20210530203446.19022-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TAS2562_TDM_CFG0_SAMPRATE_MASK starts at bit 1, not 0.
So all values need to be left shifted by 1.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 sound/soc/codecs/tas2562.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 81866aeb3fbf..55b2a1f52ca3 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -57,13 +57,13 @@
 #define TAS2562_TDM_CFG0_RAMPRATE_MASK		BIT(5)
 #define TAS2562_TDM_CFG0_RAMPRATE_44_1		BIT(5)
 #define TAS2562_TDM_CFG0_SAMPRATE_MASK		GENMASK(3, 1)
-#define TAS2562_TDM_CFG0_SAMPRATE_7305_8KHZ	0x0
-#define TAS2562_TDM_CFG0_SAMPRATE_14_7_16KHZ	0x1
-#define TAS2562_TDM_CFG0_SAMPRATE_22_05_24KHZ	0x2
-#define TAS2562_TDM_CFG0_SAMPRATE_29_4_32KHZ	0x3
-#define TAS2562_TDM_CFG0_SAMPRATE_44_1_48KHZ	0x4
-#define TAS2562_TDM_CFG0_SAMPRATE_88_2_96KHZ	0x5
-#define TAS2562_TDM_CFG0_SAMPRATE_176_4_192KHZ	0x6
+#define TAS2562_TDM_CFG0_SAMPRATE_7305_8KHZ	(0x0 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_14_7_16KHZ	(0x1 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_22_05_24KHZ	(0x2 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_29_4_32KHZ	(0x3 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_44_1_48KHZ	(0x4 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_88_2_96KHZ	(0x5 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_176_4_192KHZ	(0x6 << 1)
=20
 #define TAS2562_TDM_CFG2_RIGHT_JUSTIFY	BIT(6)
=20
--=20
2.26.2

