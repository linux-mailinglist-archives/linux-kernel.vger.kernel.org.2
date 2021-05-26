Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1136739173A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhEZMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:20:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4013 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhEZMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:20:10 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fqqg418LZzmZJv;
        Wed, 26 May 2021 20:16:16 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 20:18:37 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 20:18:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: core: use DEVICE_ATTR_*() macro
Date:   Wed, 26 May 2021 20:18:28 +0800
Message-ID: <20210526121828.8460-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/core/init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 70114fd26956..228faf9369dc 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -665,17 +665,15 @@ void snd_card_set_id(struct snd_card *card, const char *nid)
 }
 EXPORT_SYMBOL(snd_card_set_id);
 
-static ssize_t
-card_id_show_attr(struct device *dev,
-		  struct device_attribute *attr, char *buf)
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
 	return scnprintf(buf, PAGE_SIZE, "%s\n", card->id);
 }
 
-static ssize_t
-card_id_store_attr(struct device *dev, struct device_attribute *attr,
-		   const char *buf, size_t count)
+static ssize_t id_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
 	char buf1[sizeof(card->id)];
@@ -703,17 +701,16 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(id, 0644, card_id_show_attr, card_id_store_attr);
+static DEVICE_ATTR_RW(id);
 
-static ssize_t
-card_number_show_attr(struct device *dev,
-		     struct device_attribute *attr, char *buf)
+static ssize_t number_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
 	return scnprintf(buf, PAGE_SIZE, "%i\n", card->number);
 }
 
-static DEVICE_ATTR(number, 0444, card_number_show_attr, NULL);
+static DEVICE_ATTR_RO(number);
 
 static struct attribute *card_dev_attrs[] = {
 	&dev_attr_id.attr,
-- 
2.17.1

