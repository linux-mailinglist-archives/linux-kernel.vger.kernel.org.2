Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4323238E5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhEXLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:53:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5538 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhEXLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:53:02 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fpb8B3V35zwSqY;
        Mon, 24 May 2021 19:48:42 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:51:32 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 19:51:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: tlv320aic26: use DEVICE_ATTR_RW macro
Date:   Mon, 24 May 2021 19:51:31 +0800
Message-ID: <20210524115131.46288-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RW() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/tlv320aic26.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index c7baef8948d4..077415a57225 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -261,8 +261,8 @@ static const struct snd_kcontrol_new aic26_snd_controls[] = {
  * SPI device portion of driver: sysfs files for debugging
  */
 
-static ssize_t aic26_keyclick_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t keyclick_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 	int val, amp, freq, len;
@@ -276,9 +276,9 @@ static ssize_t aic26_keyclick_show(struct device *dev,
 }
 
 /* Any write to the keyclick attribute will trigger the keyclick event */
-static ssize_t aic26_keyclick_set(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t keyclick_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 
@@ -288,7 +288,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
+static DEVICE_ATTR_RW(keyclick);
 
 /* ---------------------------------------------------------------------
  * SoC CODEC portion of driver: probe and release routines
-- 
2.17.1

