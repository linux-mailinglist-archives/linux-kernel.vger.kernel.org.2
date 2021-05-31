Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8573954F1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 07:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEaFP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 01:15:29 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:49384 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEaFP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 01:15:27 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 14V5CNfp012497; Mon, 31 May 2021 14:12:23 +0900
X-Iguazu-Qid: 34tKJKyADe5GNT5trE
X-Iguazu-QSIG: v=2; s=0; t=1622437943; q=34tKJKyADe5GNT5trE; m=2lw/G/MlYKmz8Fq4yFf0SvbqNLZ2UQr61H/jynzRH28=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1513) id 14V5CKBE005985
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 May 2021 14:12:21 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 6EFB01000B6;
        Mon, 31 May 2021 14:12:20 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 14V5CJkV024472;
        Mon, 31 May 2021 14:12:19 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Argus Lin <argus.lin@mediatek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] ASoC: mediatek: mt6359: convert to use module_platform_driver
Date:   Mon, 31 May 2021 14:12:03 +0900
X-TSB-HOP: ON
Message-Id: <20210531051203.228567-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using module_platform_driver macro for
mt6359-accdet.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 sound/soc/codecs/mt6359-accdet.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 4222aed013f106..b2354a613b1587 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -1057,22 +1057,7 @@ static struct platform_driver mt6359_accdet_driver = {
 	.probe = mt6359_accdet_probe,
 };
 
-static int __init mt6359_accdet_driver_init(void)
-{
-	int ret = 0;
-
-	ret = platform_driver_register(&mt6359_accdet_driver);
-	if (ret)
-		return -ENODEV;
-	return 0;
-}
-
-static void __exit mt6359_accdet_driver_exit(void)
-{
-	platform_driver_unregister(&mt6359_accdet_driver);
-}
-module_init(mt6359_accdet_driver_init);
-module_exit(mt6359_accdet_driver_exit);
+module_platform_driver(mt6359_accdet_driver)
 
 /* Module information */
 MODULE_DESCRIPTION("MT6359 ALSA SoC codec jack driver");
-- 
2.30.0

