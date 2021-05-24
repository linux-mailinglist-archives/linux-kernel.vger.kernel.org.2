Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9494938E5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhEXLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:49:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3927 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhEXLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:49:32 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fpb4573dczBvm6;
        Mon, 24 May 2021 19:45:09 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:48:00 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 19:48:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: wm8962: Use DEVICE_ATTR_WO macro
Date:   Mon, 24 May 2021 19:47:53 +0800
Message-ID: <20210524114753.39544-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/wm8962.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 34080f497584..ba16bdf9e478 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3219,9 +3219,8 @@ static int wm8962_beep_event(struct input_dev *dev, unsigned int type,
 	return 0;
 }
 
-static ssize_t wm8962_beep_set(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t beep_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
 	long int time;
@@ -3236,7 +3235,7 @@ static ssize_t wm8962_beep_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(beep, 0200, NULL, wm8962_beep_set);
+static DEVICE_ATTR_WO(beep);
 
 static void wm8962_init_beep(struct snd_soc_component *component)
 {
-- 
2.17.1

