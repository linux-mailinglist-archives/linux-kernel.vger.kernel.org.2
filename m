Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094F38E59F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhEXLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:44:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3648 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhEXLoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:44:13 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZx81gr0zNyZG;
        Mon, 24 May 2021 19:39:08 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:42:43 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 19:42:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cs42l52: use DEVICE_ATTR_WO macro
Date:   Mon, 24 May 2021 19:42:39 +0800
Message-ID: <20210524114239.7960-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cs42l52.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 88547e2cd53d..80161151b3f2 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -957,9 +957,8 @@ static int cs42l52_beep_event(struct input_dev *dev, unsigned int type,
 	return 0;
 }
 
-static ssize_t cs42l52_beep_set(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t beep_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct cs42l52_private *cs42l52 = dev_get_drvdata(dev);
 	long int time;
@@ -974,7 +973,7 @@ static ssize_t cs42l52_beep_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(beep, 0200, NULL, cs42l52_beep_set);
+static DEVICE_ATTR_WO(beep);
 
 static void cs42l52_init_beep(struct snd_soc_component *component)
 {
-- 
2.17.1

