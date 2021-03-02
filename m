Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBB32A5AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383966AbhCBM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:59:43 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:33523 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446687AbhCBMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:12:56 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7603e2b8ba10-92f5a; Tue, 02 Mar 2021 20:11:56 +0800 (CST)
X-RM-TRANSID: 2ee7603e2b8ba10-92f5a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7603e2b87525-1c240;
        Tue, 02 Mar 2021 20:11:55 +0800 (CST)
X-RM-TRANSID: 2ee7603e2b87525-1c240
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, paul@crapouillou.net, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: codec: Omit superfluous error message in jz4760_codec_probe()
Date:   Tue,  2 Mar 2021 20:11:48 +0800
Message-Id: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_platform_ioremap_resource has already contained error
message, so remove the redundant dev_err here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/jz4760.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
index e8f28ccc145a..c2d8a107f159 100644
--- a/sound/soc/codecs/jz4760.c
+++ b/sound/soc/codecs/jz4760.c
@@ -843,7 +843,6 @@ static int jz4760_codec_probe(struct platform_device *pdev)
 	codec->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(codec->base)) {
 		ret = PTR_ERR(codec->base);
-		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
 		return ret;
 	}
 
-- 
2.18.2



