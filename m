Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD27E397F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFBDne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 23:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFBDnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:43:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47869C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 20:41:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 29so1108515pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLdktgE0a9sEXZ0/b+s3AebnOjlZIpwVaCTKFoWaY6o=;
        b=PyV8FeSKyEIVaDpLD1OQklsC0+U/xDfysW1/zZXRwfV+KdD6NggGTMgx0BhlkyFcVW
         SuRX+ExKpACmEe4VXNzThsolvdMl99oWRC4cLxxUJxJlxkG0WEAH1BeLWZGowj3e2+g6
         FJO0au3vJfJ7e2KFHuA73+gMVKDUzYq2QluuHh17e5HzHEMzFAru7FLzovFHeQfaJo9T
         vCQqxmaUsbR50lSrCAYy3QdXiuzV+sGsjOpaavnZMj/xQtrfLs+PJJ7/WqjISF4F35zF
         N2NNaZShZivIOJpEWbo8EQErq/+YBkkSsgADbfH0ePpBC4RyEdspM4G+RqHvPec+CQgF
         o7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLdktgE0a9sEXZ0/b+s3AebnOjlZIpwVaCTKFoWaY6o=;
        b=j6oYIJIADqS9dtYLJABEPR5ffyeydZvweOJNeICanp0gIt1pkNpGhwYv+5U1VMljD+
         dE44pIlQtRnvRqEXvZ3ttvebyLxz2Hkbz/t+MOk7pa6AroV9cPArr9EjHLkwsH6XO9Eg
         0K1BvzLuvjy/Hu+dVKIXwliNcDA4JztmhLH23ckUYhqY4qTwVPtBiYkj7ZY/Q4bpC3HQ
         1eC4BRWpPuQpS8Qyeg5v45V6VE/NLe8dNUh1+90em92/XT5wshQuknrghMd//TC1zhZi
         tgPQXCOWvFfW/WBXouKc9fpGeKlWNRHhpukhJIwQyKr23nuvX+/Z/NkdmnyjaylD21L/
         r3KA==
X-Gm-Message-State: AOAM532sXdLuz1kzDWDqeCnVFMHTUQrvXskxHC1v5SC/7oxPzvB1VSKw
        bOsCh6mBR5xEEJydvGdd36A=
X-Google-Smtp-Source: ABdhPJzPeLvDeBppfezgwtWuGF9uxgIOTAtzej3GgkpTc/DSKL2YdMFF0UIb8N/mqAv4ufvrNDH0ew==
X-Received: by 2002:aa7:80d3:0:b029:28e:f117:4961 with SMTP id a19-20020aa780d30000b029028ef1174961mr25291555pfn.37.1622605308627;
        Tue, 01 Jun 2021 20:41:48 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.140])
        by smtp.gmail.com with ESMTPSA id 141sm10746460pgf.20.2021.06.01.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 20:41:48 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, dan.carpenter@oracle.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: [PATCH v2] ALSA: control led: fix memory leak in snd_ctl_led_register
Date:   Wed,  2 Jun 2021 11:41:36 +0800
Message-Id: <20210602034136.2762497-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snd_ctl_led_sysfs_add and snd_ctl_led_sysfs_remove should contain
the refcount operations in pair. However, snd_ctl_led_sysfs_remove fails
to decrease the refcount to zero, which causes device_release never to
be invoked. This leads to memory leak to some resources, like struct
device_private. In addition, we also free some other similar memory
leaks in snd_ctl_led_init/snd_ctl_led_exit.

Fix this by replacing device_del to device_unregister
in snd_ctl_led_sysfs_remove/snd_ctl_led_init/snd_ctl_led_exit.

Note that, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device will
call kobject_release and delay the release of kobject, which will cause
use-after-free when the memory backing the kobject is freed at once.

Reported-by: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Fixes: a135dfb5de1 ("ALSA: led control - add sysfs kcontrol LED marking layer")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: fix other similar memory leaks; move kfree(led_card) to a
release function.
 sound/core/control_led.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 25f57c14f294..a90e31dbde61 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -17,6 +17,9 @@ MODULE_LICENSE("GPL");
 #define MAX_LED (((SNDRV_CTL_ELEM_ACCESS_MIC_LED - SNDRV_CTL_ELEM_ACCESS_SPK_LED) \
 			>> SNDRV_CTL_ELEM_ACCESS_LED_SHIFT) + 1)
 
+#define to_led_card_dev(_dev) \
+	container_of(_dev, struct snd_ctl_led_card, dev)
+
 enum snd_ctl_led_mode {
 	 MODE_FOLLOW_MUTE = 0,
 	 MODE_FOLLOW_ROUTE,
@@ -371,6 +374,21 @@ static void snd_ctl_led_disconnect(struct snd_card *card)
 	snd_ctl_led_refresh();
 }
 
+static void snd_ctl_led_card_release(struct device *dev)
+{
+	struct snd_ctl_led_card *led_card = to_led_card_dev(dev);
+
+	kfree(led_card);
+}
+
+static void snd_ctl_led_release(struct device *dev)
+{
+}
+
+static void snd_ctl_led_dev_release(struct device *dev)
+{
+}
+
 /*
  * sysfs
  */
@@ -663,6 +681,7 @@ static void snd_ctl_led_sysfs_add(struct snd_card *card)
 		led_card->number = card->number;
 		led_card->led = led;
 		device_initialize(&led_card->dev);
+		led_card->dev.release = snd_ctl_led_card_release;
 		if (dev_set_name(&led_card->dev, "card%d", card->number) < 0)
 			goto cerr;
 		led_card->dev.parent = &led->dev;
@@ -681,7 +700,6 @@ static void snd_ctl_led_sysfs_add(struct snd_card *card)
 		put_device(&led_card->dev);
 cerr2:
 		printk(KERN_ERR "snd_ctl_led: unable to add card%d", card->number);
-		kfree(led_card);
 	}
 }
 
@@ -700,8 +718,7 @@ static void snd_ctl_led_sysfs_remove(struct snd_card *card)
 		snprintf(link_name, sizeof(link_name), "led-%s", led->name);
 		sysfs_remove_link(&card->ctl_dev.kobj, link_name);
 		sysfs_remove_link(&led_card->dev.kobj, "card");
-		device_del(&led_card->dev);
-		kfree(led_card);
+		device_unregister(&led_card->dev);
 		led->cards[card->number] = NULL;
 	}
 }
@@ -723,6 +740,7 @@ static int __init snd_ctl_led_init(void)
 
 	device_initialize(&snd_ctl_led_dev);
 	snd_ctl_led_dev.class = sound_class;
+	snd_ctl_led_dev.release = snd_ctl_led_dev_release;
 	dev_set_name(&snd_ctl_led_dev, "ctl-led");
 	if (device_add(&snd_ctl_led_dev)) {
 		put_device(&snd_ctl_led_dev);
@@ -733,15 +751,16 @@ static int __init snd_ctl_led_init(void)
 		INIT_LIST_HEAD(&led->controls);
 		device_initialize(&led->dev);
 		led->dev.parent = &snd_ctl_led_dev;
+		led->dev.release = snd_ctl_led_release;
 		led->dev.groups = snd_ctl_led_dev_attr_groups;
 		dev_set_name(&led->dev, led->name);
 		if (device_add(&led->dev)) {
 			put_device(&led->dev);
 			for (; group > 0; group--) {
 				led = &snd_ctl_leds[group - 1];
-				device_del(&led->dev);
+				device_unregister(&led->dev);
 			}
-			device_del(&snd_ctl_led_dev);
+			device_unregister(&snd_ctl_led_dev);
 			return -ENOMEM;
 		}
 	}
@@ -767,9 +786,9 @@ static void __exit snd_ctl_led_exit(void)
 	}
 	for (group = 0; group < MAX_LED; group++) {
 		led = &snd_ctl_leds[group];
-		device_del(&led->dev);
+		device_unregister(&led->dev);
 	}
-	device_del(&snd_ctl_led_dev);
+	device_unregister(&snd_ctl_led_dev);
 	snd_ctl_led_clean(NULL);
 }
 
-- 
2.25.1

