Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFE3870F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbhEREoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:44:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3004 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbhEREoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:44:17 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fkjvj2rp3zQpH8;
        Tue, 18 May 2021 12:39:29 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 12:42:58 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 12:42:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <broonie@kernel.org>
Subject: [PATCH -next] ASoC: hisilicon: fix missing clk_disable_unprepare() on error in hi6210_i2s_startup()
Date:   Tue, 18 May 2021 12:45:14 +0800
Message-ID: <20210518044514.607010-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling clk_prepare_enable(), clk_disable_unprepare() need
be called when calling clk_set_rate() failed.

Fixes: 0bf750f4cbe1 ("ASoC: hisilicon: Add hi6210 i2s audio driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/hisilicon/hi6210-i2s.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 907f5f1f7b44..ff05b9779e4b 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -102,18 +102,15 @@ static int hi6210_i2s_startup(struct snd_pcm_substream *substream,
 
 	for (n = 0; n < i2s->clocks; n++) {
 		ret = clk_prepare_enable(i2s->clk[n]);
-		if (ret) {
-			while (n--)
-				clk_disable_unprepare(i2s->clk[n]);
-			return ret;
-		}
+		if (ret)
+			goto err_unprepare_clk;
 	}
 
 	ret = clk_set_rate(i2s->clk[CLK_I2S_BASE], 49152000);
 	if (ret) {
 		dev_err(i2s->dev, "%s: setting 49.152MHz base rate failed %d\n",
 			__func__, ret);
-		return ret;
+		goto err_unprepare_clk;
 	}
 
 	/* enable clock before frequency division */
@@ -165,6 +162,11 @@ static int hi6210_i2s_startup(struct snd_pcm_substream *substream,
 	hi6210_write_reg(i2s, HII2S_SW_RST_N, val);
 
 	return 0;
+
+err_unprepare_clk:
+	while (n--)
+		clk_disable_unprepare(i2s->clk[n]);
+	return ret;
 }
 
 static void hi6210_i2s_shutdown(struct snd_pcm_substream *substream,
-- 
2.25.1

