Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC638D968
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhEWHMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:12:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3659 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhEWHMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:12:51 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fns014hV2zmXf4;
        Sun, 23 May 2021 15:09:05 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 15:11:24 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 23
 May 2021 15:11:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: control_led - use DEVICE_ATTR_*() macro
Date:   Sun, 23 May 2021 15:11:09 +0800
Message-ID: <20210523071109.28940-1-yuehaibing@huawei.com>
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

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/core/control_led.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 25f57c14f294..a5e751f26d46 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -375,7 +375,7 @@ static void snd_ctl_led_disconnect(struct snd_card *card)
  * sysfs
  */
 
-static ssize_t show_mode(struct device *dev,
+static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct snd_ctl_led *led = container_of(dev, struct snd_ctl_led, dev);
@@ -390,7 +390,8 @@ static ssize_t show_mode(struct device *dev,
 	return sprintf(buf, "%s\n", str);
 }
 
-static ssize_t store_mode(struct device *dev, struct device_attribute *attr,
+static ssize_t mode_store(struct device *dev,
+			  struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct snd_ctl_led *led = container_of(dev, struct snd_ctl_led, dev);
@@ -419,7 +420,7 @@ static ssize_t store_mode(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_brightness(struct device *dev,
+static ssize_t brightness_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct snd_ctl_led *led = container_of(dev, struct snd_ctl_led, dev);
@@ -427,8 +428,8 @@ static ssize_t show_brightness(struct device *dev,
 	return sprintf(buf, "%u\n", ledtrig_audio_get(led->trigger_type));
 }
 
-static DEVICE_ATTR(mode, 0644, show_mode, store_mode);
-static DEVICE_ATTR(brightness, 0444, show_brightness, NULL);
+static DEVICE_ATTR_RW(mode);
+static DEVICE_ATTR_RO(brightness);
 
 static struct attribute *snd_ctl_led_dev_attrs[] = {
 	&dev_attr_mode.attr,
@@ -562,22 +563,25 @@ static ssize_t set_led_id(struct snd_ctl_led_card *led_card, const char *buf, si
 	return count;
 }
 
-static ssize_t parse_attach(struct device *dev, struct device_attribute *attr,
+static ssize_t attach_store(struct device *dev,
+			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	struct snd_ctl_led_card *led_card = container_of(dev, struct snd_ctl_led_card, dev);
 	return set_led_id(led_card, buf, count, true);
 }
 
-static ssize_t parse_detach(struct device *dev, struct device_attribute *attr,
+static ssize_t detach_store(struct device *dev,
+			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	struct snd_ctl_led_card *led_card = container_of(dev, struct snd_ctl_led_card, dev);
 	return set_led_id(led_card, buf, count, false);
 }
 
-static ssize_t ctl_reset(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
+static ssize_t reset_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct snd_ctl_led_card *led_card = container_of(dev, struct snd_ctl_led_card, dev);
 	int err;
@@ -590,8 +594,8 @@ static ssize_t ctl_reset(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t ctl_list(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t list_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct snd_ctl_led_card *led_card = container_of(dev, struct snd_ctl_led_card, dev);
 	struct snd_card *card;
@@ -624,10 +628,10 @@ static ssize_t ctl_list(struct device *dev,
 	return buf2 - buf;
 }
 
-static DEVICE_ATTR(attach, 0200, NULL, parse_attach);
-static DEVICE_ATTR(detach, 0200, NULL, parse_detach);
-static DEVICE_ATTR(reset, 0200, NULL, ctl_reset);
-static DEVICE_ATTR(list, 0444, ctl_list, NULL);
+static DEVICE_ATTR_WO(attach);
+static DEVICE_ATTR_WO(detach);
+static DEVICE_ATTR_WO(reset);
+static DEVICE_ATTR_RO(list);
 
 static struct attribute *snd_ctl_led_card_attrs[] = {
 	&dev_attr_attach.attr,
-- 
2.17.1

