Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD432A7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839554AbhCBQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:36:47 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:35308 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443708AbhCBOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:11:00 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3603e441a544-909db; Tue, 02 Mar 2021 21:56:44 +0800 (CST)
X-RM-TRANSID: 2ee3603e441a544-909db
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.162])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7603e4418325-20d03;
        Tue, 02 Mar 2021 21:56:44 +0800 (CST)
X-RM-TRANSID: 2ee7603e4418325-20d03
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, paul@crapouillou.net, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2] ASoC: codec: Omit superfluous error message in  jz4760_codec_probe()
Date:   Tue,  2 Mar 2021 21:56:30 +0800
Message-Id: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_platform_ioremap_resource has already contained
error message, so remove the redundant dev_err here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
 - to streamline the code.
---
 sound/soc/codecs/jz4760.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
index e8f28ccc145a..5ae0e312bcfc 100644
--- a/sound/soc/codecs/jz4760.c
+++ b/sound/soc/codecs/jz4760.c
@@ -841,11 +841,8 @@ static int jz4760_codec_probe(struct platform_device *pdev)
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
 					&jz4760_codec_regmap_config);
-- 
2.18.2



