Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9932FF77
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 08:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhCGHXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 02:23:21 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2855 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhCGHXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 02:23:01 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee660447f31d43-f11d2; Sun, 07 Mar 2021 15:22:26 +0800 (CST)
X-RM-TRANSID: 2ee660447f31d43-f11d2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.162])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee960447f2e720-83653;
        Sun, 07 Mar 2021 15:22:26 +0800 (CST)
X-RM-TRANSID: 2ee960447f2e720-83653
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, paul@crapouillou.net, lgirdwood@gmail.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: codecs/jz4770: Remove superfluous error message
Date:   Sun,  7 Mar 2021 15:21:33 +0800
Message-Id: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_platform_ioremap_resource has already contained
error message if failed, so remove superfluous dev_err here.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/jz4770.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 298689a07..5a24471a5 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -900,11 +900,8 @@ static int jz4770_codec_probe(struct platform_device *pdev)
 	codec->dev = dev;
 
 	codec->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(codec->base)) {
-		ret = PTR_ERR(codec->base);
-		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(codec->base))
+		return PTR_ERR(codec->base);
 
 	codec->regmap = devm_regmap_init(dev, NULL, codec,
 					&jz4770_codec_regmap_config);
-- 
2.20.1.windows.1



