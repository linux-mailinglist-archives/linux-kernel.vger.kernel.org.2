Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0832BB31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443802AbhCCMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:15:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12680 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbhCCGcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:32:33 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dr3xw2XjXzlRtl;
        Wed,  3 Mar 2021 14:29:40 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Mar 2021 14:31:42 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuming Fan <shumingf@realtek.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: rt1316: Fix return value check in rt1316_sdw_probe()
Date:   Wed, 3 Mar 2021 06:40:41 +0000
Message-ID: <20210303064041.898281-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_regmap_init_sdw() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: a262057df513 ("ASoC: rt1316: Add RT1316 SDCA vendor-specific driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/rt1316-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index a6fb34a48f33..3b029c56467d 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -669,8 +669,8 @@ static int rt1316_sdw_probe(struct sdw_slave *slave,
 
 	/* Regmap Initialization */
 	regmap = devm_regmap_init_sdw(slave, &rt1316_sdw_regmap);
-	if (!regmap)
-		return -EINVAL;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	return rt1316_sdw_init(&slave->dev, regmap, slave);
 }

